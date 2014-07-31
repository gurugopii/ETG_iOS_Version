//
//  ETGMapKeyMilestone.m
//  ETG
//
//  Created by Tan Aik Keong on 1/7/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGMapKeyMilestone.h"
#import "ETGNetworkConnection.h"
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ETGReportingMonth.h"
#import "ETGCoreDataUtilities.h"
#import "ETGKeyMilestone.h"
#import "ETGRevision.h"
#import "ETGBaselineType.h"
#import "ETGProjectSummaryForMap.h"
#import "ETGProject.h"
#import "ETGFirstHydrocarbon.h"
#import "NSDate+ETGDateFormatter.h"
#import "ETGMapsPEM.h"
#import "ETGMapsPGD.h"
#import "ETGJsonHelper.h"
#import "UICKeyChainStore.h"
#import "ETGExpiredTokenCheck.h"
#import "ETGKeyMilestoneProjectPhase.h"

//#define kPageSize 10

@interface ETGMapKeyMilestone()
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic) int currentPage;
@end

@implementation ETGMapKeyMilestone

-(id)init
{
    self = [super init];
    if(self)
    {
        self.currentPage = 1;
    }
    return self;
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
{
    self.appDelegate = [UIApplication sharedApplication].delegate;
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (_appDelegate.isNetworkServerAvailable == YES) {
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kMapService, ETG_MAP_KEY_MILESTONE_BATCH];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
        
        NSDictionary *inputDict = @{kInputReportingMonth: reportingMonth, kInputPageSize: @(kPageSize), kInputPageNumber: @(self.currentPage)};
        NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:inputData];
        
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        requestOperation.SSLPinningMode = AFSSLPinningModeCertificate;
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if([[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:nil])
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadMapFilterDataForGivenReportingMonthFailed object:nil];
                 return;
             }
             if(responseObject != nil)
             {
                 self.currentPage++;
                 NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                 if(json == nil)
                 {
                     self.currentPage = 1;
                     return;
                 }
                 [self convertJsonToCoreData:json withReportingMonth:reportingMonth];
                 NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
                 [context saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                     if(error)
                     {
                         DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                     }
                 }];
                 [self sendRequestWithReportingMonth:reportingMonth];
             }
             else
             {
                 NSDictionary *responseHeadersDict = [operation.response allHeaderFields];
                 NSString *strXStatus = [responseHeadersDict valueForKey:@"X-Status"];
                 NSString *strXMessage = [responseHeadersDict valueForKey:@"X-Message"];
                 BOOL isSuccess = ([strXStatus rangeOfString:@"success" options:NSCaseInsensitiveSearch].location != NSNotFound);
                 if(!isSuccess)
                 {
                     DDLogWarn(@"%@ - %@: %@", logWarnPrefix, webServiceFetchError, strXMessage);
                     DDLogError(@"%@%@", logErrorPrefix,responseHeadersDict);
                 }
                 self.currentPage = 1;
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(error.code == kNoConnectionErrorCode)
             {
                 DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
             }
             else
             {
                 [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:error];
                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadMapFilterDataForGivenReportingMonthFailed object:nil];
                 self.currentPage = 1;
             }
         }];
        
        [[NSOperationQueue mainQueue] addOperation:requestOperation];
    }
    else {
        DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
    }
}

-(NSString *)getOfflineData:(NSString *)reportingMonth withProjectKey:(int)projectKey
{
    //TODO: Verify date conversion
    NSPredicate *projectSummaryPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"reportMonth == '%@' AND projectKey = %d", reportingMonth, projectKey]];
    ETGProjectSummaryForMap *projectSummary = [ETGProjectSummaryForMap findFirstWithPredicate:projectSummaryPredicate];
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectKey == %@ AND reportMonth == %@", [NSNumber numberWithInt:projectKey], [reportingMonth toDate]];
    //    ETGProjectSummary *projectSummary = [ETGProjectSummary findFirstWithPredicate:predicate];
    ETGBaselineType *targetBaselineType = nil;
    ETGRevision *targetRevision = nil;
    NSArray *targetKeyMilestones = nil;
    if (projectSummary != nil)
    {
        NSSet *baselineTypes = projectSummary.baselineTypes;
        NSArray *baselineTypeArray = [baselineTypes allObjects];
        NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"createdTime" ascending:NO];
        NSArray *filterBaselineTypeArray = [baselineTypeArray sortedArrayUsingDescriptors:@[sortDesc]];
        if([filterBaselineTypeArray count] > 0)
        {
            targetBaselineType = filterBaselineTypeArray[0];
            NSArray *allRevisions = [targetBaselineType.revisions allObjects];
            if([allRevisions count] > 0)
            {
                NSSortDescriptor *maxSortDesc = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:NO];
                NSArray *filteredRevisions = [allRevisions sortedArrayUsingDescriptors:@[maxSortDesc]];
                if([filteredRevisions count] > 0)
                {
                    targetRevision = filteredRevisions[0];
                }
            }
        }
    }
    
    if(nil != targetRevision)
    {
        targetKeyMilestones = [targetRevision.keyMilestones allObjects];
    }
    
    NSArray *firstHydroCarbons = [projectSummary.etgFirstHydrocarbon_Projects allObjects];
    
    NSDictionary *results = [self convertCoreDataToKeyMilestoneJson:targetKeyMilestones withFirstHydroCarbons:firstHydroCarbons andReportingMonth:reportingMonth andProjectKey:projectKey];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:results
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //NSLog(@"json string for keymilestone %@", jsonString);
    return jsonString;
}

-(NSDictionary *)convertCoreDataToKeyMilestoneJson:(NSArray *)keyMilestones withFirstHydroCarbons:(NSArray *)firstHydroCarbons andReportingMonth:(NSString *)reportingMonth andProjectKey:(int)projectKey
{
    NSMutableDictionary *results = [NSMutableDictionary new];
    results[@"reportingMonth"] = reportingMonth;
    ETGProjectSummaryForMap *projectSummary = [self findOrCreateProjectSummary:projectKey withReportingMonth:reportingMonth];
    results[@"projectName"] = [ETGJsonHelper resetToEmptyStringIfRequired:projectSummary.project.name];
    
    NSMutableDictionary *chartResults = [NSMutableDictionary new];
    chartResults[@"chartTitle"] = @"Key Milestone";
    chartResults[@"chartSubtitle"] = [ETGJsonHelper resetToEmptyStringIfRequired:projectSummary.etgKeyMilestone_ProjectPhase.projectPhase];
    chartResults[@"chartContents"] = [self formatChartContents:keyMilestones];
    results[@"chartdata"] = chartResults;
    
    NSMutableArray *firstHydroCarbonsArray = [NSMutableArray new];
    for(ETGFirstHydrocarbon *hc in firstHydroCarbons)
    {
        NSMutableDictionary *hcd = [NSMutableDictionary new];
        
        if (hc.field) {
            hcd[@"field"] = [ETGJsonHelper resetToEmptyStringIfRequired:hc.field];
        }
        
        if (hc.plannedDt) {
            hcd[@"plan"] = [self convertDateToJson:hc.plannedDt];
        }
        
        if (hc.actualDt) {
            hcd[@"forecast"] = [self convertDateToJson:hc.actualDt];
        }
        
        [firstHydroCarbonsArray addObject:hcd];
    }
    results[@"firstHydrocarbon"] = firstHydroCarbonsArray;
    
    NSMutableArray *keyMilestonesArray = [NSMutableArray new];
    for(ETGKeyMilestone *kms in keyMilestones)
    {
        NSMutableDictionary *km  = [NSMutableDictionary new];
        km[@"milestone"] = kms.mileStone;
        km[@"baseline"] = [ETGJsonHelper resetToEmptyStringIfRequired:[self convertDateToJson:kms.plannedDate]];
        km[@"outlook"] = [ETGJsonHelper resetToEmptyStringIfRequired:[self convertDateToJson:kms.actualDate]];
        km[@"indicator"] = kms.indicator;
        [keyMilestonesArray addObject:km];
    }
    results[@"tabledata"] = keyMilestonesArray;
    
    return @{@"keymilestone": results};
}

-(NSString *)convertDateToJson:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd MMM yyyy"];
    
    return [formatter stringFromDate:date];
}

-(NSArray *)formatChartContents:(NSArray *)keyMilestones {
    NSMutableArray *outlookBehind = [NSMutableArray array]; // Outlook Behind Schedule
    NSMutableArray *outlookOn = [NSMutableArray array];      // Outlook On Schedule
    NSMutableArray *baseline = [NSMutableArray array];       // Baseline
    
    for (ETGKeyMilestone *rec in keyMilestones) {
        //Define the date and mutable dictionary
        //        NSDate *plannedDt;
        //        NSDate *actualDt;
        NSString *plannedDt;
        NSString *actualDt;
        NSMutableDictionary *planData;
        NSMutableDictionary *actualData;
        
        if (rec.plannedDate != nil) {
            //Define the planned date in Date format
            //Date data type change - JAMQ
            //plannedDt = rec.plannedDate;
            //            plannedDt = [rec.plannedDate toDate];
//            plannedDt = [NSString stringWithFormat:@"%@", rec.plannedDate];
            plannedDt = [rec.plannedDate toRfc3339DateString];
            //Prepopulate the plannedDt into dictionary
            planData = [NSMutableDictionary dictionary];
            //            NSString *plannedDtStr = [NSString stringWithFormat:@"%@%@",  [ETGJsonHelper truncateString:rec.plannedDate withLength:10], @"T00:00:00"];
            NSString *plannedDtStr = [NSString stringWithFormat:@"%@%@",  [ETGJsonHelper truncateString:plannedDt withLength:10], @"T00:00:00"];
            [planData setValue:rec.mileStone forKey:@"name"];
            [planData setValue:plannedDtStr forKey:@"x"];
            [planData setValue:rec.baselineNum forKey:@"y"];
        }
        if (rec.actualDate != nil) {
            //Define the actual date in Date format
            //Date data type change - JAMQ
            //actualDt = rec.actualDate;
            //            actualDt = [rec.actualDate toDate];
            //            actualDt = rec.actualDate;
//            actualDt = [NSString stringWithFormat:@"%@", rec.actualDate];
            actualDt = [rec.actualDate toRfc3339DateString];
            //Prepopulate the actualDt into dictionary
            actualData = [NSMutableDictionary dictionary];
            //            NSString *actualDtStr = [NSString stringWithFormat:@"%@%@",  [ETGJsonHelper truncateString:rec.actualDate withLength:10], @"T00:00:00"];
            NSString *actualDtStr = [NSString stringWithFormat:@"%@%@",  [ETGJsonHelper truncateString:actualDt withLength:10], @"T00:00:00"];
            [actualData setValue:rec.mileStone forKey:@"name"];
            [actualData setValue:actualDtStr forKey:@"x"];
            [actualData setValue:rec.baselineNum forKey:@"y"];
        }
        
        //If plannedDt not null
        if (rec.plannedDate != nil) {
            //Can store the plannedDt in planned array to show for Original Baseline
            [baseline addObject:planData];
            
            //If actualDt is not null
            if (rec.actualDate != nil) {
                //Depending on whether actual date before or after planned Date
                if ([actualDt compare:plannedDt] == NSOrderedDescending) {
                    //IF actualDt > plannedDt, put the actualDt in actualProgress array
                    [outlookBehind addObject:actualData];
                } else {
                    //If actualDt <= plannedDt, put the it in original array
                    [outlookOn addObject:actualData];
                }
            }
            //If actualDt is null
            else {
                //Dont do anything
            }
        }
        //If plannedDt is null
        else {
            //If actualDt is not null
            if (rec.actualDate != nil) {
                //Put the actualDt in actual array
                [outlookBehind addObject:actualData];
            }
            //If actualDt is null
            else {
                //Dont do anything
            }
        }
    }
    
    NSArray *chartContents = @[@{@"name": @"Actual Progress", @"data": outlookBehind}, @{@"name": @"Original Baseline", @"data": baseline}, @{@"name": @"Plan", @"data": outlookOn}];
    
    return chartContents;
}

-(void)convertJsonToCoreData:(NSDictionary *)json withReportingMonth:(NSString *)reportingMonth
{
    for(NSDictionary *data in json)
    {
        @try {
            int projectKey = [data[@"projectKey"] intValue];
            NSString *projectName = data[@"projectName"];
            int projectPhaseKey = [[ETGJsonHelper resetToZeroIfRequired:data[@"projectPhaseKey"]] integerValue];
            NSString *projectPhaseName = [ETGJsonHelper resetToEmptyStringIfRequired:data[@"projectPhaseName"]];
            ETGProjectSummaryForMap *projectSummary = [self findOrCreateProjectSummary:projectKey withReportingMonth:reportingMonth];
            ETGProject *project = [self findOrCreateProject:projectKey withProjectName:projectName];
            projectSummary.project = project;
            ETGKeyMilestoneProjectPhase *projectPhase = [self findOrCreateProjectPhase:projectPhaseKey withName:projectPhaseName];
            [projectPhase addProjectSummaryForMapObject:projectSummary];
            projectSummary.etgKeyMilestone_ProjectPhase = projectPhase;
            
            NSArray *firstHydroCarbonJson = data[@"FirstHydroCarbon"];
            NSArray *keyMilestoneSummaryJson = data[@"KeyMileStoneSummary"];
            [self upsertFirstHydroCarbonWithJson:firstHydroCarbonJson withReportingMonth:reportingMonth andProjectKey:projectKey andProjectSummary:projectSummary];
            [self upsertKeyMilestoneSummaryWithJson:keyMilestoneSummaryJson withReportingMonth:reportingMonth andProjectKey:projectKey andProjectSummary:projectSummary];
        }
        @catch (NSException *exception) {
            //NSLog(@"Error: check null values of json key");
        }
    }
}

-(void)upsertKeyMilestoneSummaryWithJson:(NSArray *)json withReportingMonth:(NSString *)reportingMonth andProjectKey:(int)projectKey andProjectSummary:(ETGProjectSummaryForMap *)projectSummary
{
    if(json == (id)[NSNull null])
    {
        return;
    }
    for(NSDictionary *keyMilestoneSummary in json)
    {
        ETGBaselineType *baselineType = [self alwaysCreateBaselineType:keyMilestoneSummary andProjectKey:projectKey andReportingMonth:reportingMonth];
        [projectSummary addBaselineTypesObject:baselineType];
        baselineType.projectSummaryForMap = projectSummary;
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        
        NSArray *revisions = keyMilestoneSummary[@"revisions"];
        for(NSDictionary *revisionDict in revisions)
        {
            ETGRevision *revision = [self alwaysCreateRevision:revisionDict];
            [baselineType addRevisionsObject:revision];
            revision.baselinetype = baselineType;
            
            NSArray *keyMilestoneProperties = revisionDict[@"KeyMilestones"];
            
            for(NSDictionary *keyMilestoneProperty in keyMilestoneProperties)
            {
                ETGKeyMilestone *keyMilestone = [ETGKeyMilestone createInContext:[NSManagedObjectContext contextForCurrentThread]];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
                
                keyMilestone.actualDate = [dateFormatter dateFromString:[ETGJsonHelper resetToNilIfRequired:keyMilestoneProperty[@"actualDate"]]];
                keyMilestone.baselineNum = keyMilestoneProperty[@"baseLineNum"];
                keyMilestone.indicator = keyMilestoneProperty[@"indicator"];
                keyMilestone.mileStone = keyMilestoneProperty[@"mileStone"];
                keyMilestone.plannedDate = [dateFormatter dateFromString:[ETGJsonHelper resetToNilIfRequired:keyMilestoneProperty[@"plannedDate"]]];
                
                keyMilestone.revisions = revision;
                [revision addKeyMilestonesObject:keyMilestone];
                [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                    if(error)
                    {
                        DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                    }
                }];
            }
        }
    }
}

-(ETGBaselineType *)alwaysCreateBaselineType:(NSDictionary *)json andProjectKey:(int)projectKey andReportingMonth:(NSString *)reportingMonth
{
    NSString *baselineType = json[@"baselineType"];
    NSNumber *baselineTypeKey = json[@"baselineTypeKey"];
    NSString *dateTime = json[@"createdTime"];
    
    ETGBaselineType *baselineTypeCoreData = [ETGBaselineType createInContext:[NSManagedObjectContext contextForCurrentThread]];
    baselineTypeCoreData.key = baselineTypeKey;
    baselineTypeCoreData.projectKey = @(projectKey);
    
    baselineTypeCoreData.name = baselineType;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    NSString *dateTimeInString = [ETGJsonHelper truncateString:[ETGJsonHelper resetToNilIfRequired:dateTime] withLength:10];
    baselineTypeCoreData.createdTime = [formatter dateFromString:dateTimeInString];
    
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    
    return baselineTypeCoreData;
}

-(ETGRevision *)alwaysCreateRevision:(NSDictionary *)json
{
    NSNumber *revisionNumber = json[@"revisionNo"];
    ETGRevision *revisionCoreData = [ETGRevision createInContext:[NSManagedObjectContext contextForCurrentThread]];
    revisionCoreData.number = revisionNumber;
    
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    
    return revisionCoreData;
}


-(void)upsertFirstHydroCarbonWithJson:(NSArray *)json withReportingMonth:(NSString *)reportingMonth andProjectKey:(int)projectKey andProjectSummary:(ETGProjectSummaryForMap *)summary
{
    if(json == (id)[NSNull null])
    {
        return;
    }
    
    // Now clear the data
    [summary.etgFirstHydrocarbon_ProjectsSet removeAllObjects];
    
    for(NSDictionary *hydroCarbon in json)
    {
        ETGFirstHydrocarbon *firstHydrocarbon = [ETGFirstHydrocarbon createInContext:[NSManagedObjectContext contextForCurrentThread]];
        firstHydrocarbon.projectSummaryForMap = summary;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        firstHydrocarbon.actualDt = [dateFormatter dateFromString:[ETGJsonHelper resetToNilIfRequired:hydroCarbon[@"estimateDate"]]];
        firstHydrocarbon.field = hydroCarbon[@"facilityName"];
        firstHydrocarbon.fieldKey = hydroCarbon[@"facilityKey"];
        firstHydrocarbon.plannedDt = [dateFormatter dateFromString:[ETGJsonHelper resetToNilIfRequired:hydroCarbon[@"planDate"]]];
        [summary addEtgFirstHydrocarbon_ProjectsObject:firstHydrocarbon];
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    }
}

-(ETGProjectSummaryForMap *)findOrCreateProjectSummary:(int)projectKey withReportingMonth:(NSString *)reportingMonth
{
    //TODO: Verify date conversion
    NSPredicate *projectSummaryPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"projectKey == %d AND reportMonth == '%@'", projectKey, reportingMonth]];
    ETGProjectSummaryForMap *projectSummary = [ETGProjectSummaryForMap findFirstWithPredicate:projectSummaryPredicate];
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectKey == %@ AND reportMonth == %@", [NSNumber numberWithInt:projectKey], [reportingMonth toDate]];
    //    ETGProjectSummary *projectSummary = [ETGProjectSummary findFirstWithPredicate:predicate];
    if (projectSummary == nil)
    {
        projectSummary = [ETGProjectSummaryForMap createInContext:[NSManagedObjectContext contextForCurrentThread]];
        projectSummary.projectKey = @(projectKey);
        //TODO: Verify date conversion
        projectSummary.reportMonth = reportingMonth;
        //projectSummary.reportMonth = [reportingMonth toDate];
    }
    
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    return projectSummary;
}

-(ETGProject *)findOrCreateProject:(int)projectKey withProjectName:projectName
{
    NSPredicate *projectPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"key == %d", projectKey]];
    ETGProject *project = [ETGProject findFirstWithPredicate:projectPredicate];
    if (project == nil)
    {
        project = [ETGProject createInContext:[NSManagedObjectContext contextForCurrentThread]];
        project.key = @(projectKey);
    }
    if(0 != [projectName length])
    {
        project.name = projectName;
    }
    project.isUsedByMap = @(YES);
    
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    return project;
}

-(ETGKeyMilestoneProjectPhase *)findOrCreateProjectPhase:(int)key withName:name
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"projectPhaseKey == %d", key]];
    ETGKeyMilestoneProjectPhase *phase = [ETGKeyMilestoneProjectPhase findFirstWithPredicate:predicate];
    if (phase == nil)
    {
        phase = [ETGKeyMilestoneProjectPhase createInContext:[NSManagedObjectContext contextForCurrentThread]];
        phase.projectPhaseKey = @(key);
    }
    phase.projectPhase = name;
    //NSLog(@"Project phase name is %@", name);
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    return phase;
}


-(NSDate *)convertToDateFromJson:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"yyyy-mm-dd hh:MM"];
    return [formatter dateFromString:dateString];
}

@end
