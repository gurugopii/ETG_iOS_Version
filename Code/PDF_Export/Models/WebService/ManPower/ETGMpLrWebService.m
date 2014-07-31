//
//  ETGMpLrWebService.m
//  ETG
//
//  Created by Helmi Hasan on 3/6/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGMpLrWebService.h"
#import "ETGNetworkConnection.h"
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ETGReportingMonth.h"
#import "ETGCoreDataUtilities.h"
#import "ETGJsonHelper.h"
#import "ETGJSONKeyReplaceManipulation.h"
#import "NSSet+ETGMonthCompare.h"
#import "NSDate+ETGDateFormatter.h"
#import "ETGYear.h"
#import "ETGDepartment.h"
#import "ETGSection.h"
#import "ETGMpPlr.h"
#import "ETGMpCluster.h"
#import "ETGMpRegion.h"
#import "ETGMpProject.h"
#import "ETGProjectPosition.h"

@interface ETGMpLrWebService()
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (strong, nonatomic) NSArray *monthlyArray;
@end

@implementation ETGMpLrWebService

-(BOOL)needRefreshDataForReportingMonth:(NSString *)reportingMonth
{
    return [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampForModule:@"PLR" hasMoreThanNumberOfDays:kNumberOfExpiryDaysCoreData inReportingMonth:reportingMonth];
}

-(BOOL)isUncachedDataFilteredChange
{
    if((self.filteredClusters.count != 0 && self.filteredClusters != nil) || (self.filteredProjectPositions.count != 0  && self.filteredProjectPositions != nil) || (self.filteredProjects.count != 0  && self.filteredProjects != nil) || (self.filteredRegions.count != 0 && self.filteredRegions != nil) || (self.filteredSections.count != 0  && self.filteredSections != nil))
    {
        return YES;
    }
    return NO;
}

-(NSMutableDictionary *)getUncachedDataInputDictionary
{
    NSMutableDictionary *inputDictionary = [NSMutableDictionary new];
    
    if(self.filteredYears.count != 0)
    {
        NSMutableArray *yearKeys = [NSMutableArray new];
        for(ETGYear *year in self.filteredYears)
        {
            [yearKeys addObject:year.key];
        }
        [inputDictionary setObject:yearKeys forKey:kInputManpowerYears];
    }
    
    if(self.filteredDepartments.count != 0)
    {
        NSMutableArray *departmentKeys = [NSMutableArray new];
        for(ETGDepartment *department in self.filteredDepartments)
        {
            [departmentKeys addObject:department.key];
        }
        [inputDictionary setObject:departmentKeys forKey:kInputManpowerDepartmentKeys];
    }
    
    if(self.filteredClusters.count != 0)
    {
        NSMutableArray *clusterKeys = [NSMutableArray new];
        for(ETGMpCluster *cluster in self.filteredClusters)
        {
            [clusterKeys addObject:cluster.key];
        }
        [inputDictionary setObject:clusterKeys forKey:kInputManpowerClusterKeys];
    }
    
    if(self.filteredProjectPositions.count != 0)
    {
        NSMutableArray *positionKeys = [NSMutableArray new];
        for(ETGProjectPosition *position in self.filteredProjectPositions)
        {
            [positionKeys addObject:position.key];
        }
        [inputDictionary setObject:positionKeys forKey:kInputManpowerProjectPositionKeys];
    }
    
    if(self.filteredProjects.count != 0)
    {
        NSMutableArray *projectKeys = [NSMutableArray new];
        for(ETGMpProject *project in self.filteredProjects)
        {
            [projectKeys addObject:project.key];
        }
        [inputDictionary setObject:projectKeys forKey:kInputManpowerProjectKeys];
    }
    
    if(self.filteredRegions.count != 0)
    {
        NSMutableArray *regionKeys = [NSMutableArray new];
        for(ETGMpRegion *region in self.filteredRegions)
        {
            [regionKeys addObject:region.key];
        }
        [inputDictionary setObject:regionKeys forKey:kInputManpowerRegionKeys];
    }
    
    if(self.filteredSections.count != 0)
    {
        NSMutableArray *sectionKeys = [NSMutableArray new];
        for(ETGSection *section in self.filteredSections)
        {
            [sectionKeys addObject:section.key];
        }
        [inputDictionary setObject:sectionKeys forKey:kInputManpowerSectionKeys];
    }
    
    return inputDictionary;
}

-(NSArray *)uncachedMonthlyCategories:(NSArray *)inputData
{
    NSMutableArray *filteredYearNames = [NSMutableArray new];
    NSPredicate *predicateYear;
    NSMutableArray *tempMonthlyArray = [NSMutableArray new];
    NSMutableArray *tempMonthlyStringArray = [NSMutableArray new];
    
    for(ETGYear *year in self.filteredYears)
    {
        [filteredYearNames addObject:year.name];
    }
    
    for (NSString *yearName in filteredYearNames)
    {
        predicateYear = [NSPredicate predicateWithFormat:@"timeKey contains %@", yearName];
        NSArray *years = [inputData filteredArrayUsingPredicate:predicateYear];
        for (NSDictionary *plr in years)
        {
            if([plr[@"timeKey"] length] == 0)
            {
                continue;
            }
            [tempMonthlyArray addObject:plr[@"timeKey"]];
        }
    }
    NSMutableArray *uniqueMonthlyArray = [NSMutableArray array];
    
    //to remove redundant month
    for (id obj in tempMonthlyArray) {
        if (![uniqueMonthlyArray containsObject:obj]) {
            [uniqueMonthlyArray addObject:obj];
        }
    }
    //sort the monthly in ascending order
    NSArray *tempMonthSortArray;
    NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    NSArray *descriptors=[NSArray arrayWithObject: descriptor];
    tempMonthSortArray = [uniqueMonthlyArray sortedArrayUsingDescriptors:descriptors];
    
    self.monthlyArray = tempMonthSortArray; // to be use to calculate the sum of vaccant in the build chart
    
    for(NSString *month in tempMonthSortArray) {
        [tempMonthlyStringArray addObject:[self monthlyDateToString:[month toDate]]];
    }
    
    return tempMonthlyStringArray;
}

-(NSDictionary *)buildUncachedChartData:(NSArray *)resultJson
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    
    temp[@"title"] = @"Monthly Project Manpower Loading Requirements";
    temp[@"yLabel"] = @"Loading";
    temp[@"categories"] = [self uncachedMonthlyCategories:resultJson];
    
    if([resultJson count] == 0)
    {
        temp[@"series"] = @[];
    }
    else
    {
        // Calculation here
        NSMutableArray *tempVacantSeries = [NSMutableArray new];
        NSMutableArray *tempFilledSeries = [NSMutableArray new];
        NSPredicate *predicateMonth;
        
        if([self.monthlyArray count] == 0)
        {
            temp[@"series"] = @[];
        }
        else
        {
            for (NSDate *monthlyDate in self.monthlyArray)
            {
                predicateMonth = [NSPredicate predicateWithFormat:@"timeKey = %@",monthlyDate];
                NSArray *month = [resultJson filteredArrayUsingPredicate:predicateMonth];
                [tempVacantSeries addObject:[self getDivideByOneKNumber:[month valueForKeyPath:@"@sum.vacantFTELoading"]]];
                [tempFilledSeries addObject:[self getDivideByOneKNumber:[month valueForKeyPath:@"@sum.filledFTELoading"]]];
            }
            NSMutableArray *tempSeries = [NSMutableArray new];
            
            [tempSeries addObject:[self buildSeriesDictionary:@"Vacant" array:tempVacantSeries]];
            [tempSeries addObject:[self buildSeriesDictionary:@"Filled" array:tempFilledSeries]];
            
            temp[@"series"] = tempSeries;
        }
    }
    return temp;
}

-(NSString *)getUncachedData:(NSArray *)resultJson reportingMonth:(NSString *)reportingMonth
{
    if(resultJson == (id)[NSNull null] || resultJson == nil || [resultJson count] == 0)
    {
        return [self getNoData:reportingMonth];
    }
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSMutableDictionary *topInformation = [NSMutableDictionary new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd MMM yyyy"];
    topInformation[@"updated"] = [formatter stringFromDate:[NSDate date]];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:reportingMonth];
    [formatter setDateFormat:@"MMM-yyyy"];
    topInformation[@"reportingPeriod"] = [formatter stringFromDate:date];
    
    temp[@"topInformation"] = topInformation;
    temp[@"chartdata"] = [self buildUncachedChartData:resultJson];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:temp
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

-(NSString *)getNoData:(NSString *)reportingMonth
{
    NSMutableDictionary *noData = [NSMutableDictionary new];
    
    NSMutableDictionary *topInformation = [NSMutableDictionary new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd MMM yyyy"];
    topInformation[@"updated"] = [formatter stringFromDate:[NSDate date]];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:reportingMonth];
    [formatter setDateFormat:@"MMM-yyyy"];
    topInformation[@"reportingPeriod"] = [formatter stringFromDate:date];
    
    noData[@"topInformation"] = topInformation;
    
    noData[@"tabledata"] = @{@"header":@"Year", @"body":[NSNull null]};
    NSMutableDictionary *chartData = [NSMutableDictionary new];
    chartData[@"categories"] = @[];
    NSMutableArray *seriesData = [NSMutableArray new];
//    [seriesData addObject:@{@"name":@"Filled",@"data":[NSNull null]}];
//    [seriesData addObject:@{@"name":@"Vacant",@"data":[NSNull null]}];
    chartData[@"series"] = seriesData;
    noData[@"chartdata"] = chartData;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:noData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString *jsonString))success
                              failure:(void (^)(NSError *error))failure
{
    if([self isUncachedDataFilteredChange])
    {
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        if (_appDelegate.isNetworkServerAvailable == YES) {
            NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kManPowerService, ETG_MANPOWER_PLR];
            NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
            
            NSMutableDictionary *inputDict = [self getUncachedDataInputDictionary];
            inputDict[kInputReportingMonth] = reportingMonth;
            inputDict[kInputRequestType] = @(AKLrRequestTypeFilter);
            NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:nil];
            [request setHTTPBody:inputData];
            [request setTimeoutInterval:600];
            
            AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            requestOperation.SSLPinningMode = AFSSLPinningModeCertificate;
            [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 if([[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:nil])
                 {
                     success([self getNoData:reportingMonth]);
                     return;
                 }
                 if(nil == responseObject)
                 {
                     success([self getNoData:reportingMonth]);
                     return;
                 }
                 
                 NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                 NSString *jsonResult = [self getUncachedData:json[@"projectLoadingMonthly"] reportingMonth:reportingMonth];
                 success(jsonResult);
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if(error.code == kNoConnectionErrorCode)
                 {
                     DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
                 }
                 else
                 {
                     [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:error];
                 }
                 success([self getNoData:reportingMonth]);
             }];
            
            [[NSOperationQueue mainQueue] addOperation:requestOperation];
        }
        else
        {
            DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
            success([self getNoData:reportingMonth]);
        }
    }
    else
    {
        // AK TODO
        //reportingMonth = @"20130801";
        BOOL timestamp = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampForModule:@"PLR" hasMoreThanNumberOfDays:kNumberOfExpiryDaysCoreData inReportingMonth:reportingMonth];
        timestamp = NO;
        
        if(timestamp || isManual || ![self hasData:reportingMonth])
        {
            _appDelegate = [[UIApplication sharedApplication] delegate];
            [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
            [ETGNetworkConnection checkAvailability];
            if (_appDelegate.isNetworkServerAvailable == YES) {
                NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kManPowerService, ETG_MANPOWER_PLR];
                NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
                
                // AK TODO
                //filteredProjectKeys = [@[@(110), @(85)] mutableCopy];
                NSDictionary *inputDict = @{kInputReportingMonth: reportingMonth, kInputRequestType: @(AKLrRequestTypeDepartmentLevel)};
                NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:nil];
                [request setHTTPBody:inputData];
                [request setTimeoutInterval:600];
                
                AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                requestOperation.SSLPinningMode = AFSSLPinningModeCertificate;
                [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                     if([[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:nil])
                     {
                         [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadManPowerShouldAutoRefresh object:nil];
                         success([self getOfflineData:reportingMonth]);
                         return;
                     }
                     if(nil == responseObject)
                     {
                         success([self getOfflineData:reportingMonth]);
                         return;
                     }
                     
                     [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:reportingMonth moduleName:@"PLR"];
                     NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                     
                     ETGReportingMonth* targetReportingMonth = [self findOrCreateReportingMonth:reportingMonth];
                     [targetReportingMonth.plrsSet removeAllObjects];
                     [self convertJsonToCoreData:json[@"projectLoadingMonthly"] withReportingMonth:targetReportingMonth];
                     
                     NSString *jsonResult = [self getOfflineData:reportingMonth];
                     success(jsonResult);
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     if(error.code == kNoConnectionErrorCode)
                     {
                         [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadManpowerShouldAutoRefresh object:nil];
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
                [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadManpowerShouldAutoRefresh object:nil];
                success([self getOfflineData:reportingMonth]);
            }
        }
        else
        {
            // Fetch from core data
            success([self getOfflineData:reportingMonth]);
        }
    }
}

-(BOOL)hasData:(NSString *)reportingMonth
{
    ETGReportingMonth *targetReportingMonth = [self findOrCreateReportingMonth:reportingMonth];
    if(targetReportingMonth == nil)
    {
        return NO;
    }
    if([targetReportingMonth.plrs count] == 0)
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
        return [self getNoData:reportingMonth];
    }
    if([targetReportingMonth.plrs count] == 0)
    {
        return [self getNoData:reportingMonth];
    }
    
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSMutableDictionary *topInformation = [NSMutableDictionary new];
    //    topInformation[@"headcount"] = @"Headcount";
    if(nil != [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:@"PLR"])
    {
        topInformation[@"updated"] = [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:@"PLR"];
    }
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:reportingMonth];
    [formatter setDateFormat:@"MMM-yyyy"];
    topInformation[@"reportingPeriod"] = [formatter stringFromDate:date];
    
    NSSet *filteredSets = targetReportingMonth.plrs;
    if(0 != [self.filteredDepartments count])
    {
        NSMutableArray *filteredDepartMentKeys = [NSMutableArray new];
        for(ETGDepartment *department in self.filteredDepartments)
        {
            [filteredDepartMentKeys addObject:department.key];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"departmentKey IN %@ ", filteredDepartMentKeys]; // -> Assume that the return here is the key
        filteredSets = [filteredSets filteredSetUsingPredicate:predicate];
    }
    
    if(0 != [self.filteredYears count])
    {
        NSMutableArray *filteredYearKeys = [NSMutableArray new];
        for(ETGYear *year in self.filteredYears)
        {
            [filteredYearKeys addObject:year.key];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year IN %@", filteredYearKeys];
        filteredSets = [filteredSets filteredSetUsingPredicate:predicate];
    }
    
    
    temp[@"topInformation"] = topInformation;
    temp[@"chartdata"] = [self buildChartData:filteredSets];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:temp
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

-(NSDictionary *)buildSeriesDictionary:(NSString *)name array:(NSArray *)array
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"name"] = name;
    temp[@"data"] = array;
    return temp;
}

-(NSNumber *)getDivideByOneKNumber:(NSDecimalNumber *)input
{
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:2];
    [nf setMaximumFractionDigits:2];
    NSString *ns  = [nf stringFromNumber:input];
    return [NSNumber numberWithDouble:[ns doubleValue]];
}

-(NSDictionary *)buildChartData:(NSSet *)inputData
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    
    temp[@"title"] = @"Monthly Project Manpower Loading Requirements";
    temp[@"yLabel"] = @"Loading";
    temp[@"categories"] = [self monthlyCategories:inputData];
    
    if([inputData count] == 0 || [self.monthlyArray count] == 0)
    {
        temp[@"series"] = @[];
    }
    else
    {
        // Calculation here
        NSMutableArray *tempVacantSeries = [NSMutableArray new];
        NSMutableArray *tempFilledSeries = [NSMutableArray new];
        NSPredicate *predicateMonth;
        
        for (NSDate *monthlyDate in self.monthlyArray){
            predicateMonth = [NSPredicate predicateWithFormat:@"timeKey = %@",monthlyDate];
            NSSet *month = [inputData filteredSetUsingPredicate:predicateMonth];
            [tempVacantSeries addObject:[self getDivideByOneKNumber:[month valueForKeyPath:@"@sum.vacantFTELoading"]]];
            [tempFilledSeries addObject:[self getDivideByOneKNumber:[month valueForKeyPath:@"@sum.filledFTELoading"]]];
            
        }
        NSMutableArray *tempSeries = [NSMutableArray new];
        
        [tempSeries addObject:[self buildSeriesDictionary:@"Vacant" array:tempVacantSeries]];
        [tempSeries addObject:[self buildSeriesDictionary:@"Filled" array:tempFilledSeries]];
        
        temp[@"series"] = tempSeries;
    }
    return temp;
}

-(NSArray *)monthlyCategories:(NSSet*)inputData {
    
    NSMutableArray *filteredYearNames = [NSMutableArray new];
    NSPredicate *predicateYear;
    NSMutableArray *tempMonthlyArray = [NSMutableArray new];
    NSMutableArray *tempMonthlyStringArray = [NSMutableArray new];
    

    for(ETGYear *year in self.filteredYears)
    {
        [filteredYearNames addObject:year.name];
    }
    
    for (NSString *yearName in filteredYearNames){
        predicateYear = [NSPredicate predicateWithFormat:@"year = %d",[yearName integerValue]];
        NSSet *years = [inputData filteredSetUsingPredicate:predicateYear];
        for (ETGMpPlr *plr in years) {
            [tempMonthlyArray addObject:plr.timeKey];
        }
        
    }
    NSMutableArray *uniqueMonthlyArray = [NSMutableArray array];
    
    //to remove redundant month
    for (id obj in tempMonthlyArray) {
        if (![uniqueMonthlyArray containsObject:obj]) {
            [uniqueMonthlyArray addObject:obj];
        }
    }
    //sort the monthly in ascending order
    NSArray *tempMonthSortArray;
    NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    NSArray *descriptors=[NSArray arrayWithObject: descriptor];
    tempMonthSortArray = [uniqueMonthlyArray sortedArrayUsingDescriptors:descriptors];
    
    self.monthlyArray = tempMonthSortArray; // to be use to calculate the sum of vaccant in the build chart
    
    for(NSDate *month in tempMonthSortArray) {
        [tempMonthlyStringArray addObject:[self monthlyDateToString:month]];
    }

    return tempMonthlyStringArray;
}

-(NSString *)monthlyDateToString:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM yyyy"];
    return[formatter stringFromDate:date];
}

-(void)convertJsonToCoreData:(NSDictionary *)jsonArray withReportingMonth:(ETGReportingMonth *)reportingMonth
{
    if(jsonArray == (id)[NSNull null])
    {
        return;
    }
    
    for(NSDictionary *json in jsonArray)
    {
        ETGMpPlr *lr = [ETGMpPlr createInContext:[NSManagedObjectContext contextForCurrentThread]];
        
        lr.departmentKey = [ETGJsonHelper resetToNilIfRequired:json[@"departmentKey"]];
        lr.filledFTELoading = [ETGJsonHelper resetToNilIfRequired:json[@"filledFTELoading"]];
        lr.timeKey = [json[@"timeKey"] toDate];
        lr.vacantFTELoading = [ETGJsonHelper resetToNilIfRequired:json[@"vacantFTELoading"]];
        lr.year = [ETGJsonHelper resetToNilIfRequired:json[@"year"]];
        
        lr.reportingMonth = reportingMonth;
        [reportingMonth.plrsSet addObject:lr];
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
}

@end
