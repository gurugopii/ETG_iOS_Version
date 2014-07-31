//
//  ETGMapPgdAndPem.m
//  ETG
//
//  Created by Tan Aik Keong on 1/7/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGMapPgdAndPem.h"
#import "ETGNetworkConnection.h"
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ETGReportingMonth.h"
#import "ETGMapsPEM.h"
#import "ETGMapsPGD.h"
#import "ETGMap.h"
#import "ETGCoreDataUtilities.h"
#import "ETGMapKeyMilestone.h"
#import "ETGJsonHelper.h"
#import "ETGRegion.h"
#import "ETGProjectSummaryForMap.h"
#import "ETGProject.h"

@interface ETGMapPgdAndPem()
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@end

@implementation ETGMapPgdAndPem

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString *jsonString))success
                              failure:(void (^)(NSError *error))failure
{
    BOOL timestamp = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:@"MAP" reportingMonth:reportingMonth];    
    if(timestamp || isManual || ![self hasData:reportingMonth])
    {
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        if (_appDelegate.isNetworkServerAvailable == YES) {
            NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kMapService, ETG_MAP_PGD_PEM];
            NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
            
            NSDictionary *inputDict = @{kInputReportingMonth: reportingMonth};
            NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:nil];
            [request setHTTPBody:inputData];
            
            AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            requestOperation.SSLPinningMode = AFSSLPinningModeCertificate;
            [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 if([[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:nil])
                 {
                     [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadMapFilterDataForGivenReportingMonthFailed object:nil];
                     [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadMapShouldAutoRefresh object:nil];
                     success([self getOfflineData:reportingMonth]);
                     return;
                 }
                 [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:reportingMonth moduleName:@"MAP"];
                 NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                 NSDictionary *mapsPem = json[@"mapsPEM"];
                 NSDictionary *pemDetails = mapsPem[@"PEMDetails"];
                 NSDictionary *mapsPgd = json[@"mapsPGD"];
                 NSDictionary *pgdDetails = mapsPgd[@"PGDDetails"];
                 
                 // Fetch or insert ETGReportingMonth from paramater
                 NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
                 //TODO: Verify date conversion
//                 NSString* query = [NSString stringWithFormat:@"name == %@", reportingMonth];
//                 NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
                 NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@", [reportingMonth toDate]];
                 ETGReportingMonth* targetReportingMonth = [ETGReportingMonth findFirstWithPredicate:predicate inContext:context];
                 
                 // If reporting month does not exist, set a new one
                 if (!targetReportingMonth.name)
                 {
                     targetReportingMonth = [ETGReportingMonth createInContext:context];
                     //TODO: Verify date conversion
//                     targetReportingMonth.name = reportingMonth;
                     targetReportingMonth.name = [reportingMonth toDate];
                     
                     [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                         if(error)
                         {
                             DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                         }
                     }];
                 }
                 
                 for(ETGMap *map in targetReportingMonth.maps)
                 {
                     [map.etgMapsPemsSet removeAllObjects];
                     [map.etgMapsPgdSet removeAllObjects];
                 }
                 [targetReportingMonth.mapsSet removeAllObjects];
                 
                 ETGMap *map = [self findOrCreateMapWithReportMonth:reportingMonth];
                 map.reportingMonth = targetReportingMonth;
                 [map addEtgMapsPems:[self convertJsonToPemCoreData:pemDetails withMessage:mapsPem[@"message"] withReportingMonth:reportingMonth]];
                 [map addEtgMapsPgd:[self convertJsonToPgdCoreData:pgdDetails withMessage:mapsPgd[@"message"] withReportingMonth:reportingMonth]];
                 [targetReportingMonth addMapsObject:map];
                 
                 [context saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                     if(error)
                     {
                         DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                     }
                 }];
                 
                 NSString *jsonResult = [self getOfflineData:reportingMonth];
                 success(jsonResult);
                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadMapFilterDataForGivenReportingMonthCompleted object:nil];
                 
                 // Now start fetching key milestone data
                 ETGMapKeyMilestone *milestone = [ETGMapKeyMilestone new];
                 [milestone sendRequestWithReportingMonth:reportingMonth];
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if(error.code == kNoConnectionErrorCode)
                 {
                     [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadMapShouldAutoRefresh object:nil];
                     DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
                 }
                 else
                 {
                     [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:error];
                 }
                [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadMapFilterDataForGivenReportingMonthFailed object:nil];                 
                 success([self getOfflineData:reportingMonth]);
             }];
            
            [[NSOperationQueue mainQueue] addOperation:requestOperation];
        }
        else
        {
            DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
            [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadMapFilterDataForGivenReportingMonthFailed object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadMapShouldAutoRefresh object:nil];
            success([self getOfflineData:reportingMonth]);
        }
    }
    else
    {
        // Fetch from core data
        success([self getOfflineData:reportingMonth]);
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


-(ETGMap *)findOrCreateMapWithReportMonth:(NSString *)reportingMonth
{
    ETGMap *map = nil;
    //TODO: Verify date conversion
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reportMonth == %@", reportingMonth];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reportMonth == %@", [reportingMonth toDate]];
    map = [ETGMap findFirstWithPredicate:predicate];
    if(map == nil)
    {
        map = [ETGMap createInContext:[NSManagedObjectContext contextForCurrentThread]];
        map.reportMonth = reportingMonth;
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    }
    return map;
}

-(BOOL)hasData:(NSString *)reportingMonth
{
    //TODO: Verify date conversion
    NSString *query = [NSString stringWithFormat:@"reportMonth == %@", reportingMonth];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reportMonth == %@", [reportingMonth toDate]];
    ETGMap *map = [ETGMap findFirstWithPredicate:predicate];
    if(map == nil)
    {
        return NO;
    }
    if([map.etgMapsPems count] == 0 && [map.etgMapsPgd count] == 0)
    {
        return NO;
    }
    return YES;
}

-(NSString *)getOfflineData:(NSString *)reportingMonth
{
    //TODO: Verify date conversion
    NSString *query = [NSString stringWithFormat:@"reportMonth == '%@'", reportingMonth];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reportMonth == '%@'", [reportingMonth toDate]];
    ETGMap *map = [ETGMap findFirstWithPredicate:predicate];
    
    NSSet *pems = map.etgMapsPems;
    if(self.filteredProjects != nil)
    {
        if([self.filteredProjects count] > 0)
        {
            NSMutableArray *filteredProjectKeys = [NSMutableArray new];
            for(ETGMapSectionProjectModel *project in self.filteredProjects)
            {
                [filteredProjectKeys addObject:project.key];
            }
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectKey IN %@", filteredProjectKeys];
            pems = [pems filteredSetUsingPredicate:predicate];
        }
    }
    
    if(self.filteredSpeeds != nil)
    {
        if([self.filteredSpeeds count] == 0)
        {
            pems = [NSSet new];
        }
        else if([self.filteredSpeeds count] < 4)
        {
            NSMutableArray *temp = [NSMutableArray new];
            for(ETGMapSection *section in self.filteredSpeeds)
            {
                [temp addObject:@(section.value)];
            }
            NSPredicate *speedPredicate = [NSPredicate predicateWithFormat:@"statusKey IN %@", temp];
            pems = [pems filteredSetUsingPredicate:speedPredicate];
        }
    }
    
    NSSet *pgds = map.etgMapsPgd;
    if(self.filteredProjects != nil)
    {
        if([self.filteredProjects count] > 0)
        {
            NSMutableArray *filteredProjectKeys = [NSMutableArray new];
            for(ETGMapSectionProjectModel *project in self.filteredProjects)
            {
                [filteredProjectKeys addObject:project.key];
            }
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectKey IN %@", filteredProjectKeys];
            pgds = [pgds filteredSetUsingPredicate:predicate];
        }
    }
    
    if(self.filteredDurations != nil)
    {
        if([self.filteredDurations count] == 0)
        {
            pgds = [NSSet new];
        }
        else if([self.filteredDurations count] < 3)
        {
            NSMutableSet *tempPgds = [NSMutableSet new];
            for(ETGMapSection *section in self.filteredDurations)
            {
                NSPredicate *predicate = nil;
                
                if(section.value == kMapDurationLessThanOneMonth)
                {
                     predicate = [NSPredicate predicateWithFormat:@"duration < 1.00"];
                }
                else if(section.value == kMapDurationBetweenOneToSixMonth)
                {
                     predicate = [NSPredicate predicateWithFormat:@"duration > 1.00 AND duration < 6.00"];
                }
                else if(section.value == kMapDurationMoreThanSixMonths)
                {
                     predicate = [NSPredicate predicateWithFormat:@"duration > 6.00"];
                }
                NSSet *tempFilteredPgds = [pgds filteredSetUsingPredicate:predicate];
                [tempPgds addObjectsFromArray:[tempFilteredPgds allObjects]];
            }
            pgds = tempPgds;
        }
    }
    
    NSMutableDictionary *pgdPem = [NSMutableDictionary new];
    pgdPem[@"topInformation"] = [self getProjectDetails:reportingMonth];
    pgdPem[@"matrix"] = [self setNoDataIfRequired:[self getPemData:pems]];
    pgdPem[@"gate"] = [self setNoDataIfRequired:[self getPgdData:pgds]];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:pgdPem
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

-(id)setNoDataIfRequired:(id)input
{
    if([input count] == 0)
        return @"no data";
    return input;
}

-(NSDictionary *)getProjectDetails:(NSString *)reportingMonth
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:reportingMonth];
    [formatter setDateFormat:@"MMM yyyy"];
    temp[@"reportPeriod"] = [formatter stringFromDate:date];
    if(nil != [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:@"MAP"])
    {
        temp[@"lastUpdate"] = [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:@"MAP"];        
    }

    return temp;
}

-(NSArray *)getPemData:(NSSet *)pems
{
    NSArray *data = [self convertPemsToMatrixData:pems];
    return data;
}

-(NSArray *)convertPemsToMatrixData:(NSSet *)pems
{
    if([pems count] == 0)
        return nil;
    
    NSMutableArray *array = [NSMutableArray new];
    for(ETGMapsPEM *pem in pems)
    {
        [array addObject:[self convertPemToJson:pem]];
    }
    return array;
}

-(NSDictionary *)convertPemToJson:(ETGMapsPEM *)pem
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"status"] = pem.status;
    temp[@"projectName"] = [ETGJsonHelper resetToEmptyStringIfRequired:pem.projectName];
    temp[@"projectKey"] = pem.projectKey;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %d", [pem.regionKey intValue]];
    ETGRegion *region = [ETGRegion findFirstWithPredicate:predicate];
    temp[@"regionName"]= [ETGJsonHelper resetToEmptyStringIfRequired:region.name];
    temp[@"fdpDifferentMM"] = [ETGJsonHelper resetToZeroIfRequired:pem.fdpdifferentMM];
    temp[@"execDifferentM"] = [ETGJsonHelper resetToZeroIfRequired:pem.exedifferentMM];
    temp[@"riskCategoryName"] = [ETGJsonHelper resetToEmptyStringIfRequired:pem.riskCategory];
    return temp;
}

-(NSDictionary *)getPgdData:(NSSet *)pgds
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSArray *tableData = [self convertPgdsToTableDataJson:pgds];
    NSArray *chartContents = [self convertPgdsToChartContent:pgds];
    if(nil != tableData)
    {
        temp[@"tabledata"] = tableData;
    }
    if(nil != tableData)
    {
        temp[@"chartContents"] = chartContents;
    }
    return temp;
}

-(NSArray *)convertPgdsToTableDataJson:(NSSet *)pgds
{
    if([pgds count] == 0)
        return nil;
    
    NSMutableArray *array = [NSMutableArray new];
    for(ETGMapsPGD *pgd in pgds)
    {
        [array addObject:[self convertPgdToTableDataJson:pgd]];
    }
    return array;
}

-(NSDictionary *)convertPgdToTableDataJson:(ETGMapsPGD *)pgd
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", pgd.regionKey];
    ETGRegion *region = [ETGRegion findFirstWithPredicate:predicate];
    if(region)
    {
        temp[@"region"] = region.name;
    }
    temp[@"projectKey"] = pgd.projectKey;
    temp[@"projectName"] = [ETGJsonHelper resetToEmptyStringIfRequired:pgd.projectName];
    temp[@"phase"]= [ETGJsonHelper resetToEmptyStringIfRequired:pgd.phaseName];
    temp[@"duration"] = [ETGJsonHelper resetToZeroIfRequired:pgd.duration];
    temp[@"milestone"] = [ETGJsonHelper resetToEmptyStringIfRequired:pgd.indicator];
    return temp;
}

-(NSArray *)convertPgdsToChartContent:(NSSet *)pgds
{
    if([pgds count] == 0)
        return nil;
    // Get all the indicators
    NSArray *uniqueIndicators= [[pgds allObjects] valueForKeyPath:@"@distinctUnionOfObjects.indicator"];
    NSArray *uniqueProjectKeys = [[pgds allObjects] valueForKeyPath:@"@distinctUnionOfObjects.projectKey"];
    NSMutableArray *dataArray = [NSMutableArray new];
    for(NSString *indicator in uniqueIndicators)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"indicator == %@ AND projectKey IN %@", indicator, uniqueProjectKeys];
        NSSet *pgds2 = [pgds filteredSetUsingPredicate:predicate];
        if([pgds2 count] > 0)
        {
            [dataArray addObject:[self convertPgdsToChartContentJson:pgds2]];
        }
    }
    return dataArray;
}

-(NSDictionary *)convertPgdsToChartContentJson:(NSSet *)pgds
{
    if([pgds count] == 0)
        return nil;

    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSMutableArray *array = [NSMutableArray new];
   
    for(ETGMapsPGD *pgd in pgds)
    {
         temp[@"name"] = pgd.indicator;
        [array addObject:[self convertPgdToChartContentDataJson:pgd]];
    }
    temp[@"data"] = array;
    return temp;
}

-(NSDictionary *)convertPgdToChartContentDataJson:(ETGMapsPGD *)pgd
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"name"] = pgd.projectName;
    temp[@"x"] = pgd.x;
    temp[@"y"]= pgd.y;
    temp[@"months"] = pgd.duration;
    return temp;
}

-(NSMutableSet *)convertJsonToPemCoreData:(NSDictionary *)jsonArray withMessage:(NSString *)message withReportingMonth:(NSString *)reportingMonth
{
    if(jsonArray == (id)[NSNull null])
    {
        DDLogError(@"%@ PEMDetails are null: %@", logErrorPrefix, message);
        return [NSMutableSet new];
    }
    
    NSMutableSet *temp = [NSMutableSet new];
    for(NSDictionary *json in jsonArray)
    {
        ETGMapsPEM *pem = [ETGMapsPEM createInContext:[NSManagedObjectContext contextForCurrentThread]];
        pem.indicator = json[@"indicator"];
        pem.region = [ETGJsonHelper resetToNilIfRequired:json[@"region"]];
        pem.regionKey = [ETGJsonHelper resetToNilIfRequired:json[@"regionKey"]];
        pem.psc = json[@"psc"];
        pem.pscKey = [ETGJsonHelper resetToNilIfRequired:json[@"pscKey"]];
        pem.projectName = [ETGJsonHelper resetToNilIfRequired:json[@"projectName"]];
        pem.projectKey = [ETGJsonHelper resetToNilIfRequired:json[@"projectKey"]];
        
        ETGProjectSummaryForMap *summary = [self findOrCreateProjectSummary:[pem.projectKey intValue] withReportingMonth:reportingMonth];
        ETGProject *project = [self findOrCreateProject:[pem.projectKey integerValue] withProjectName:pem.projectName];
        summary.project = project;
        pem.fdpdifferentMM = [ETGJsonHelper resetToNilIfRequired:json[@"fdpdifferentMM"]];
        pem.exedifferentMM = [ETGJsonHelper resetToNilIfRequired:json[@"exedifferentMM"]];
        pem.status = json[@"status"];
        pem.statusKey = [ETGJsonHelper resetToNilIfRequired:json[@"statusKey"]];
        pem.riskCategory = [ETGJsonHelper resetToNilIfRequired:json[@"riskCategory"]];
        pem.riskCategoryKey = [ETGJsonHelper resetToNilIfRequired:json[@"riskCategoryKey"]];
        [temp addObject:pem];
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    }
    
    return temp;
}

-(NSMutableSet *)convertJsonToPgdCoreData:(NSDictionary *)jsonArray withMessage:(NSString *)message withReportingMonth:(NSString *)reportingMonth
{
    if(jsonArray == (id)[NSNull null])
    {
        DDLogError(@"%@ PGDDetails are null: %@", logErrorPrefix, message);
        return [NSMutableSet new];
    }
    
    NSMutableSet *temp = [NSMutableSet new];
    for(NSDictionary *json in jsonArray)
    {
        ETGMapsPGD *pgd = [ETGMapsPGD createInContext:[NSManagedObjectContext contextForCurrentThread]];
        pgd.currentPhase = [ETGJsonHelper resetToNilIfRequired:json[@"currentPhase"]];
        pgd.duration = [ETGJsonHelper resetToNilIfRequired:json[@"duration"]];
        pgd.indicator = [ETGJsonHelper resetToNilIfRequired:json[@"indicator"]];
        pgd.phaseName = [ETGJsonHelper resetToNilIfRequired:json[@"phaseName"]];
        pgd.projectKey = [ETGJsonHelper resetToNilIfRequired:json[@"projectKey"]];
        pgd.projectName = [ETGJsonHelper resetToNilIfRequired:json[@"projectName"]];
        
        ETGProjectSummaryForMap *summary = [self findOrCreateProjectSummary:[pgd.projectKey intValue] withReportingMonth:reportingMonth];
        ETGProject *project = [self findOrCreateProject:[pgd.projectKey integerValue] withProjectName:pgd.projectName];
        summary.project = project;
        pgd.psc = [ETGJsonHelper resetToNilIfRequired:json[@"psc"]];
        pgd.pscKey = [ETGJsonHelper resetToNilIfRequired:json[@"pscKey"]];
        pgd.region = json[@"region"];
        pgd.regionKey = [ETGJsonHelper resetToNilIfRequired:json[@"regionKey"]];
        pgd.x = [ETGJsonHelper resetToNilIfRequired:json[@"x"]];
        pgd.y = [ETGJsonHelper resetToNilIfRequired:json[@"y"]];
        [temp addObject:pgd];
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    }
    
    return temp;
}

@end
