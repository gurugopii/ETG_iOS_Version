//
//  ETGMpAhcWebService.m
//  ETG
//
//  Created by Ahmad on 2/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGMpAhcWebService.h"
#import "ETGNetworkConnection.h"
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ETGReportingMonth.h"
#import "ETGMpAhc.h"
#import "ETGCoreDataUtilities.h"
#import "ETGJsonHelper.h"
#import "ETGJSONKeyReplaceManipulation.h"
#import "NSSet+ETGMonthCompare.h"
#import "NSDate+ETGDateFormatter.h"
#import "ETGYear.h"
#import "ETGDivision.h"
#import "ETGDepartment.h"
#import "ETGSection.h"

@interface ETGMpAhcWebService()
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@end

@implementation ETGMpAhcWebService

-(BOOL)needRefreshDataForReportingMonth:(NSString *)reportingMonth
{
    return [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampForModule:@"AHC" hasMoreThanNumberOfDays:kNumberOfExpiryDaysCoreData inReportingMonth:reportingMonth];
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString *jsonString))success
                              failure:(void (^)(NSError *error))failure
{
    if([reportingMonth length] == 0)
    {
        return;
    }
    // AK TODO
    //reportingMonth = @"20130801";
    BOOL timestamp = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampForModule:@"AHC" hasMoreThanNumberOfDays:kNumberOfExpiryDaysCoreData inReportingMonth:reportingMonth];
    
    if(timestamp || isManual || ![self hasData:reportingMonth])
    {
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        if (_appDelegate.isNetworkServerAvailable == YES) {
            NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kManPowerService, ETG_MANPOWER_AHC];
            NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
            
 
            // AK TODO
            //filteredProjectKeys = [@[@(110), @(85)] mutableCopy];
            NSDictionary *inputDict = @{kInputReportingMonth: reportingMonth};
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
                 
                 [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:reportingMonth moduleName:@"AHC"];
                 NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                 
                 ETGReportingMonth* targetReportingMonth = [self findOrCreateReportingMonth:reportingMonth];
                 [targetReportingMonth.ahcsSet removeAllObjects];
                 [self convertJsonToCoreData:json[@"yearlyHeadCountRequirement"] withReportingMonth:targetReportingMonth];
                 
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

-(BOOL)hasData:(NSString *)reportingMonth
{
    ETGReportingMonth *targetReportingMonth = [self findOrCreateReportingMonth:reportingMonth];
    if(targetReportingMonth == nil)
    {
        return NO;
    }
    if([targetReportingMonth.ahcs count] == 0)
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
    if([targetReportingMonth.ahcs count] == 0)
    {
        return @"no data";
    }
    
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSMutableDictionary *topInformation = [NSMutableDictionary new];
//    topInformation[@"headcount"] = @"Headcount";
    if(nil != [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:@"AHC"])
    {
        topInformation[@"updated"] = [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:@"AHC"];
    }
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:reportingMonth];
    [formatter setDateFormat:@"MMM-yyyy"];
    topInformation[@"reportingPeriod"] = [formatter stringFromDate:date];
    
    NSSet *filteredSets = targetReportingMonth.ahcs;
    if(0 != [self.filteredDivisions count])
    {
        NSMutableArray *filteredDivisionKeys = [NSMutableArray new];
        for(ETGDivision *division in self.filteredDivisions)
        {
            [filteredDivisionKeys addObject:division.key];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"divisionKey IN %@ ", filteredDivisionKeys];
        filteredSets = [filteredSets filteredSetUsingPredicate:predicate];
    }
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
    
    if(0 != [self.filteredSections count])
    {
        NSMutableArray *filteredSectionKeys = [NSMutableArray new];
        for(ETGSection *section in self.filteredSections)
        {
            [filteredSectionKeys addObject:section.key];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sectionKey IN %@", filteredSectionKeys];
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
//    NSLog(@"Filtered department is %d and section is %d", [self.filteredDepartments count], [self.filteredSections count]);
    
    temp[@"topInformation"] = topInformation;
//    temp[@"tabledata"] = [self aggregateDataForTableFrom:filteredSets reportingMonth:[targetReportingMonth.name toEccrString]];
//    temp[@"chartdata"] = [self aggregateDataForChartFrom:filteredSets reportingMonth:[targetReportingMonth.name toEccrString]];
//
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

-(NSNumber *)getDivideByOneKNumber:(NSNumber *)input
{
    return @([input doubleValue]);
}


-(NSDictionary *)buildChartData:(NSSet *)inputData
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    
    temp[@"title"] = @"Yearly Headcount Manpower Headcount Requirement";
    temp[@"yLabel"] = @"Headcount";
    
    NSMutableArray *filteredYearNames = [NSMutableArray new];
    for(ETGYear *year in self.filteredYears)
    {
        [filteredYearNames addObject:year.name];
    }

    temp[@"categories"] = filteredYearNames;
    
    if([inputData count] == 0)
    {
        temp[@"series"] = @[];
    }
    else
    {
        // Calculation here
        NSMutableArray *tempVacantSeries = [NSMutableArray new];
        NSMutableArray *tempFilledSeries = [NSMutableArray new];
        NSPredicate *predicateYear;
        
        for (NSString *yearName in filteredYearNames){
            predicateYear = [NSPredicate predicateWithFormat:@"year = %d",[yearName integerValue]];
            NSSet *year = [inputData filteredSetUsingPredicate:predicateYear];
            [tempVacantSeries addObject:[self getDivideByOneKNumber:[year valueForKeyPath:@"@sum.vacantHeadcount"]]];
            [tempFilledSeries addObject:[self getDivideByOneKNumber:[year valueForKeyPath:@"@sum.filledHeadcount"]]];
            
        }
        NSMutableArray *tempSeries = [NSMutableArray new];
        
        [tempSeries addObject:[self buildSeriesDictionary:@"Vacant" array:tempVacantSeries]];
        [tempSeries addObject:[self buildSeriesDictionary:@"Filled" array:tempFilledSeries]];

        
        NSMutableArray *sortedVacant = [NSMutableArray new];
        NSMutableArray *sortedFilled = [NSMutableArray new];
        NSMutableArray *sortedYear = [NSMutableArray new];
        
        for (int i =0; i<[filteredYearNames count]; i++)
        {
            NSString *year = [filteredYearNames objectAtIndex:i];
            NSString *vacant = [[[tempSeries objectAtIndex:0] objectForKey:@"data"] objectAtIndex:i];
            NSString *filled = [[[tempSeries objectAtIndex:1] objectForKey:@"data"] objectAtIndex:i];
            
            if ([sortedYear count]==0)
            {
                [sortedYear addObject:year];
                [sortedVacant addObject:vacant];
                [sortedFilled addObject:filled];
            }
            else{
                //check date one by one
                BOOL isNewer =NO;
                BOOL isOlder = NO;
                
                for (int j =0; j< [sortedYear count]; j++)
                {
                    NSString *year2 = [sortedYear objectAtIndex:j];
                    
                    if ([year  compare:year2] == NSOrderedDescending)
                    {
                        isNewer=YES;
                        
                        //last array
                        //just add on top
                        if (j == [sortedYear count]-1)
                        {
                            [sortedYear addObject:year];
                            [sortedFilled addObject:filled];
                            [sortedVacant addObject:vacant];
                            
                            break;
                            
                        }
                        
                    }
                    else{
                        isOlder = YES;
                        
                        if (isNewer)
                        {
                            [sortedYear insertObject:year atIndex:j];
                            [sortedFilled insertObject:filled atIndex:j];
                            [sortedVacant insertObject:vacant atIndex:j];
                            
                            break;
                        }
                        //add at last array
                        else{
                            [sortedYear insertObject:year atIndex:0];
                            [sortedFilled insertObject:filled atIndex:0];
                            [sortedVacant insertObject:vacant atIndex:0];
                            
                            break;
                        }
                    }
                }
            }
            
        }
        temp[@"categories"] = sortedYear;
        temp[@"series"] = @[ @{@"data": sortedVacant,@"name":@"Vacant"}, @{@"data": sortedFilled,@"name":@"Filled"} ];
    }
    
    return temp;
}


-(void)convertJsonToCoreData:(NSDictionary *)jsonArray withReportingMonth:(ETGReportingMonth *)reportingMonth
{
    if(jsonArray == (id)[NSNull null])
    {
        return;
    }
    
    for(NSDictionary *json in jsonArray)
    {
        ETGMpAhc *ahc = [ETGMpAhc createInContext:[NSManagedObjectContext contextForCurrentThread]];

        ahc.departmentKey = [ETGJsonHelper resetToNilIfRequired:json[@"departmentKey"]];
        ahc.departmentName = [ETGJsonHelper resetToNilIfRequired:json[@"departmentName"]];
        ahc.divisionKey = [ETGJsonHelper resetToNilIfRequired:json[@"divisionKey"]];
        ahc.divisionName = [ETGJsonHelper resetToNilIfRequired:json[@"divisionName"]];
        ahc.filledHeadcount = [ETGJsonHelper resetToNilIfRequired:json[@"filledHeadcount"]];
        ahc.sectionKey = [ETGJsonHelper resetToNilIfRequired:json[@"sectionKey"]];
        ahc.sectionName = [ETGJsonHelper resetToNilIfRequired:json[@"sectionName"]];
        ahc.vacantHeadcount = [ETGJsonHelper resetToNilIfRequired:json[@"vacantHeadcount"]];
        ahc.year = [ETGJsonHelper resetToNilIfRequired:json[@"year"]];
        ahc.reportingMonth = reportingMonth;
        [reportingMonth.ahcsSet addObject:ahc];
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
}

@end
