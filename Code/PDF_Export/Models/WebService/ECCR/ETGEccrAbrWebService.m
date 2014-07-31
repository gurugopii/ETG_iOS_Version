//
//  ETGEccrAbrWebService.m
//  ETG
//
//  Created by Tan Aik Keong on 1/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGEccrAbrWebService.h"
#import "ETGNetworkConnection.h"
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ETGReportingMonth.h"
#import "ETGEccrAbr.h"
#import "ETGCoreDataUtilities.h"
#import "ETGJsonHelper.h"
#import "ETGJSONKeyReplaceManipulation.h"
#import "NSSet+ETGMonthCompare.h"
#import "ETGProject.h"
#import "ETGRegion.h"
#import "ETGCostCategory.h"
#import "NSDate+ETGDateFormatter.h"

@interface ETGEccrAbrWebService()
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@end

@implementation ETGEccrAbrWebService

-(BOOL)needRefreshDataForReportingMonth:(NSString *)reportingMonth
{
    return [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:@"ECCRABR" reportingMonth:reportingMonth];
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString *jsonString))success
                              failure:(void (^)(NSError *error))failure
{
    // AK TODO
    //reportingMonth = @"20130801";
    BOOL timestamp = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:@"ECCRABR" reportingMonth:reportingMonth];
    if(timestamp || isManual || ![self hasData:reportingMonth])
    {
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        if (_appDelegate.isNetworkServerAvailable == YES) {
            NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kEccrService, ETG_ECCR_ABR];
            NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
            
            NSMutableArray *filteredProjectKeys = [NSMutableArray new];
            if(0 != [self.filteredProjects count])
            {
                for(ETGProject *project in self.filteredProjects)
                {
                    [filteredProjectKeys addObject:project.key];
                }
            }
            // AK TODO
            //filteredProjectKeys = [@[@(110), @(85)] mutableCopy];
            NSDictionary *inputDict = @{kInputReportingMonth: reportingMonth, kInputEccrProjectKeys: filteredProjectKeys};
            NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:nil];
            [request setHTTPBody:inputData];
            
            AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            requestOperation.SSLPinningMode = AFSSLPinningModeCertificate;
            [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 if([[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:nil])
                 {
                     [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadEccrShouldAutoRefresh object:nil];
                     success([self getOfflineData:reportingMonth]);
                     return;
                 }
                 if(nil == responseObject)
                 {
                     success([self getOfflineData:reportingMonth]);
                     return;
                 }
                 
                 [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:reportingMonth moduleName:@"ECCRABR"];
                 NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                 
                 ETGReportingMonth* targetReportingMonth = [self findOrCreateReportingMonth:reportingMonth];
                 [targetReportingMonth.abrsSet removeAllObjects];
                 [self convertJsonToCoreData:json[@"abrDetails"] withReportingMonth:targetReportingMonth];
                 
                 NSString *jsonResult = [self getOfflineData:reportingMonth];
                 success(jsonResult);
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if(error.code == kNoConnectionErrorCode)
                 {
                     [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadEccrShouldAutoRefresh object:nil];
                     DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
                 }
                 else
                 {
                     [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:error];
                 }
                 success([self getOfflineData:reportingMonth]);
             }];
            
            [[NSOperationQueue mainQueue] addOperation:requestOperation];
        }
        else
        {
            DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
            [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadEccrShouldAutoRefresh object:nil];
            success([self getOfflineData:reportingMonth]);
        }
    }
    else
    {
        // Fetch from core data
        success([self getOfflineData:reportingMonth]);
    }
}

-(void)convertJsonToCoreData:(NSDictionary *)jsonArray withReportingMonth:(ETGReportingMonth *)reportingMonth
{
    if(jsonArray == (id)[NSNull null])
    {
        return;
    }
    
    for(NSDictionary *json in jsonArray)
    {
        ETGEccrAbr *abr = [ETGEccrAbr createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in json)
        {
            [abr setValue:[ETGJsonHelper resetToNilIfRequired:json[key]] forKey:key];
        }
        abr.reportingMonth = reportingMonth;
        [reportingMonth.abrsSet addObject:abr];
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
}

-(BOOL)hasData:(NSString *)reportingMonth
{
    ETGReportingMonth *targetReportingMonth = [self findOrCreateReportingMonth:reportingMonth];
    if(targetReportingMonth == nil)
    {
        return NO;
    }
    if([targetReportingMonth.abrs count] == 0)
    {
        return NO;
    }
    return YES;
}

-(ETGReportingMonth *)findOrCreateReportingMonth:(NSString *)reportingMonthString
{
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@", [reportingMonthString toDate]];
    ETGReportingMonth* targetReportingMonth = [ETGReportingMonth findFirstWithPredicate:predicate inContext:context];
    if (targetReportingMonth == nil)
    {
        targetReportingMonth = [ETGReportingMonth createInContext:context];
        targetReportingMonth.name = [reportingMonthString toDate];
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    return targetReportingMonth;
}

-(NSString *)getOfflineData:(NSString *)reportingMonth
{
    // AK TODO
    //reportingMonth = @"20130801";
    ETGReportingMonth *targetReportingMonth = [self findOrCreateReportingMonth:reportingMonth];
    
    if(targetReportingMonth == nil)
    {
        return @"no data";
    }
    if([targetReportingMonth.abrs count] == 0)
    {
        return @"no data";
    }
    
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSMutableDictionary *topInformation = [NSMutableDictionary new];
    topInformation[@"currency"] = @"MYR '000";
    if(nil != [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:@"ECCRABR"])
    {
        topInformation[@"update"] = [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:@"ECCRABR"];
    }
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:reportingMonth];
    [formatter setDateFormat:@"MMM-yyyy"];
    topInformation[@"reportingMonth"] = [formatter stringFromDate:date];
    
    NSSet *filteredSets = targetReportingMonth.abrs;
    if(0 != [self.filteredCostCategories count])
    {
        NSMutableArray *filteredCostCategoryKeys = [NSMutableArray new];
        for(ETGCostCategory *costCategory in self.filteredCostCategories)
        {
            [filteredCostCategoryKeys addObject:costCategory.key];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectCostCategoryKey IN %@ ", filteredCostCategoryKeys];
        filteredSets = [filteredSets filteredSetUsingPredicate:predicate];
    }
    
    if(0 != [self.filteredProjects count])
    {
        NSMutableArray *filteredProjectKeys = [NSMutableArray new];
        for(ETGProject *project in self.filteredProjects)
        {
            [filteredProjectKeys addObject:project.key];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectKey IN %@", filteredProjectKeys];
        filteredSets = [filteredSets filteredSetUsingPredicate:predicate];
    }
    
    //NSLog(@"Filtered cost is %d and project is %d", [self.filteredCostCategories count], [self.filteredProjects count]);
    
    temp[@"topInformation"] = topInformation;
    temp[@"tabledata"] = [self aggregateDataForTableFrom:filteredSets reportingMonth:[targetReportingMonth.name toEccrString]];
    temp[@"chartdata"] = [self aggregateDataForChartFrom:filteredSets reportingMonth:[targetReportingMonth.name toEccrString]];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:temp
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

- (NSArray *)aggregateDataForTableFrom:(NSSet *)abrs reportingMonth:(NSString *)reportingMonth {
    
    NSMutableArray *matchedRecords = [NSMutableArray array];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateReportingMonth = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@", reportingMonth]];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MMM yyyy"];
    
    for(ETGEccrAbr *abr in abrs)
    {
        NSDate *abrDate = [dateFormatter2 dateFromString:abr.dataTimeNm];
        if ([[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] isMonthOfDate:abrDate equalToDate:dateReportingMonth]) {
            NSDictionary *temp = [self convertAbrCoreDataToJson:abr];
            [matchedRecords addObject:temp];
        }
    }
    
    NSArray *results = [[NSArray alloc] initWithArray:matchedRecords];
    return results;
}

-(NSDictionary *)convertAbrCoreDataToJson:(ETGEccrAbr *)abr
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", abr.projectKey];
    ETGProject *project = [ETGProject findFirstWithPredicate:predicate];
    
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"key == %@", abr.regionKey];
    ETGRegion *region = [ETGRegion findFirstWithPredicate:predicate2];
    
    temp[@"name"] = [ETGJsonHelper resetToEmptyStringIfRequired:project.name];
    temp[@"region"] = [ETGJsonHelper resetToEmptyStringIfRequired:region.name];
    temp[@"submittedABR"] = [NSString stringWithFormat:@"%d", abr.submittedABRValue];
    temp[@"approvedABR"] = [NSString stringWithFormat:@"%d", abr.approvedABRValue];
    temp[@"indicator"] = abr.indicator;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MMM yyyy"];
    NSDate *date = [formatter dateFromString:abr.dataTimeNm];
    [formatter setDateFormat:@"dd MMM yyyy"];
    temp[@"reportingdate"] = [formatter stringFromDate:date];
    
    return temp;
}

- (NSArray *)aggregateDataForChartFrom:(NSSet *)cachedData reportingMonth:(NSString *)reportingMonth
{
    NSArray *dataArray = [[NSArray alloc] initWithArray:cachedData.allObjects];
    NSArray *uniqueMonths = [[NSArray alloc] initWithArray:[dataArray valueForKeyPath:@"@distinctUnionOfObjects.dataTimeNm"]];
    NSMutableArray *aggregatedTotal = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    
    for (int i = 0; i < [uniqueMonths count]; i++)
    {
        NSMutableArray *results = [NSMutableArray array];
        NSMutableDictionary *aggregatedDict = [[NSMutableDictionary alloc] init];
        
        for (int j = 0; j < dataArray.count; j++)
        {
            NSString *dateUniqueMonthString = [uniqueMonths objectAtIndex:i];
            NSString *dateReportingDateString = [[dataArray objectAtIndex:j] valueForKey:@"dataTimeNm"];
            
            if ([[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] isMonthOfDate:[dateFormatter dateFromString:dateReportingDateString] equalToDate:[dateFormatter dateFromString:dateUniqueMonthString]])
            {
                [results addObject:[dataArray objectAtIndex:j]];
            }
        }
        
        if ([results count] > 0)
        {
            // ABR Approved - Check if all values are nil
            NSPredicate *nullPredicate = [NSPredicate predicateWithFormat:@"approvedABR == %@", nil];
            NSArray *nullObjectsApproved = [results filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalAbrApproved;
            
            if ([results count] == [nullObjectsApproved count])
            {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalABRApproved"];
            }
            else
            {
                totalAbrApproved = [NSNumber numberWithFloat:[[results valueForKeyPath:@"@sum.approvedABR"] floatValue]];
                [aggregatedDict setValue:totalAbrApproved forKey:@"totalABRApproved"];
            }
            
            // ABR Submitted - Check if all values are nil
            nullPredicate = [NSPredicate predicateWithFormat:@"submittedABR == %@", nil];
            NSArray *nullObjectsSubmitted = [results filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalAbrSubmitted;
            
            if ([results count] == [nullObjectsSubmitted count])
            {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalABRSubmitted"];
            }
            else
            {
                totalAbrSubmitted = [NSNumber numberWithFloat:[[results valueForKeyPath:@"@sum.submittedABR"] floatValue]];
                [aggregatedDict setValue:totalAbrSubmitted forKey:@"totalABRSubmitted"];
            }
            NSString *dateUniqueMonthString = [uniqueMonths objectAtIndex:i];
            [aggregatedDict setValue:[dateFormatter dateFromString:dateUniqueMonthString] forKey:@"month"];
            [aggregatedTotal addObject:aggregatedDict];
        }
        else
        {
            NSNumber *totalAbrApproved = NULL;
            NSNumber *totalAbrSubmitted = NULL;
            
            [aggregatedDict setValue:totalAbrApproved forKey:@"totalABRApproved"];
            [aggregatedDict setValue:totalAbrSubmitted forKey:@"totalABRSubmitted"];
            NSString *dateUniqueMonthString = [uniqueMonths objectAtIndex:i];
            [aggregatedDict setValue:[dateFormatter dateFromString:dateUniqueMonthString] forKey:@"month"];
            [aggregatedTotal addObject:aggregatedDict];
        }
    }
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormatter2 dateFromString:reportingMonth];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    aggregatedTotal = [aggregatedTotal toConsecutiveMonthsForWpb:[dateFormatter2 stringFromDate:date]];
    
    NSMutableDictionary *processedAbrApproved = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                                @"name":@"ABRApproved",
                                                                                                @"data":[aggregatedTotal valueForKey:@"totalABRApproved"]}];
    NSMutableDictionary *processedAbrSubmitted = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                                 @"name":@"ABRSubmitted",
                                                                                                 @"data":[aggregatedTotal valueForKey:@"totalABRSubmitted"]}];
    
    NSArray *processedJSON = [NSArray arrayWithObjects:processedAbrApproved, processedAbrSubmitted, nil];    
    return processedJSON;
}


@end
