//
//  ETGEccrCpbWebService.m
//  ETG
//
//  Created by Tan Aik Keong on 1/28/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGEccrCpbWebService.h"
#import "ETGNetworkConnection.h"
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ETGReportingMonth.h"
#import "ETGCoreDataUtilities.h"
#import "ETGJsonHelper.h"
#import "ETGJSONKeyReplaceManipulation.h"
#import "ETGReportingMonth.h"
#import "ETGEccrCpb.h"
#import "ETGCostAllocation.h"
#import "ETGCostCategory.h"
#import "ETGProject.h"
#import "ETGRegion.h"

@interface ETGEccrCpbWebService()
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@end

@implementation ETGEccrCpbWebService

-(BOOL)needRefreshDataWithReportingMonth:(NSString *)reportingMonth
{
    NSString *firstBudgetKey = self.budgetHolderKeys[0];
    NSString *projects = [[self.filteredProjects valueForKey:@"key"] componentsJoinedByString:@"_"];
    
    NSString *projectIdentifiers = [NSString stringWithFormat:@"ECCR_CPB_%@_%@_%@", firstBudgetKey, reportingMonth, projects];
    return [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:projectIdentifiers reportingMonth:reportingMonth];
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString *jsonString))success
                              failure:(void (^)(NSError *error))failure
{
    // AK TODO
    //reportingMonth = @"20130201";
    //self.budgetHolderKeys = @[@(1)];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (_appDelegate.isNetworkServerAvailable == YES)
    {
        __block int totalDownloaded = 0;
        if([self.budgetHolderKeys count] == 0)
        {
            success([self getOfflineData:reportingMonth]);
            return;
        }
        
        NSString *firstBudgetKey = self.budgetHolderKeys[0];
        NSString *projects = [[self.filteredProjects valueForKey:@"key"] componentsJoinedByString:@"_"];
        
        NSString *projectIdentifiers = [NSString stringWithFormat:@"ECCR_CPB_%@_%@_%@", firstBudgetKey, reportingMonth, projects];
        BOOL timestamp = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:projectIdentifiers reportingMonth:reportingMonth];
        if(!timestamp && !isManual)
        {
            success([self getOfflineData:reportingMonth]);
            return;
        }
        
        for(NSString *budgetKey in self.budgetHolderKeys)
        {
            NSString *identifier = [NSString stringWithFormat:@"ECCR_CPB_%@_%@", budgetKey, reportingMonth];
            BOOL timestamp = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:identifier reportingMonth:reportingMonth];
            if(timestamp || isManual || ![self hasData:reportingMonth budgetKey:budgetKey])
            {
                NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kEccrService, ETG_ECCR_CPB];
                NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
                // changed to 3 mins
                [request setTimeoutInterval:180];
                
                NSMutableArray *filteredProjectKeys = [NSMutableArray new];
                if(0 != [self.filteredProjects count])
                {
                    for(ETGProject *project in self.filteredProjects)
                    {
                        [filteredProjectKeys addObject:project.key];
                    }
                }
                // AK TODO
                //filteredProjectKeys = [@[@(72),@(82),@(83),@(89),@(150),@(191),@(279),@(280),@(117),@(279)] mutableCopy];
                //filteredProjectKeys = [@[@(82),@(85),@(110),@(191)] mutableCopy];
                NSDictionary *inputDict = @{kInputReportingMonth: reportingMonth, kInputPEccrDivisionKey: budgetKey, kInputEccrProjectKeys:filteredProjectKeys};
                NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:nil];
                [request setHTTPBody:inputData];
                
                AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                requestOperation.SSLPinningMode = AFSSLPinningModeCertificate;
                [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                     totalDownloaded++;
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
                     [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:reportingMonth moduleName:identifier];
                     NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                     NSDictionary *cpbs = json[@"cpbOverall"];
                     ETGReportingMonth *targetReportingMonth = [self findOrCreateReportingMonth:reportingMonth];
                     // Remove old data
                     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"budgetHolderKey == %@", budgetKey];
                     NSSet *targetOldData = [targetReportingMonth.cpbs filteredSetUsingPredicate:predicate];
                     for(ETGEccrCpb *cpb in targetOldData)
                     {
                         [targetReportingMonth.cpbsSet removeObject:cpb];
                     }
                     
                     [self convertJsonToCoreData:cpbs withReportingMonth:targetReportingMonth];
                     
                     if(totalDownloaded == [self.budgetHolderKeys count])
                     {
                         NSString *identifier2 = [NSString stringWithFormat:@"ECCR_CPB_%@", reportingMonth];
                         [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:reportingMonth moduleName:projectIdentifiers];
                         [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:reportingMonth moduleName:identifier2];
                         NSString *jsonResult = [self getOfflineData:reportingMonth];
                         success(jsonResult);
                     }
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
                totalDownloaded++;
                if(totalDownloaded == [self.budgetHolderKeys count])
                {
                    NSString *identifier2 = [NSString stringWithFormat:@"ECCR_CPB_%@", reportingMonth];
                    [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:reportingMonth moduleName:identifier2];
                    NSString *jsonResult = [self getOfflineData:reportingMonth];
                    success(jsonResult);
                }
            }
        }
    }
    else
    {
        DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadEccrShouldAutoRefresh object:nil];
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
        ETGEccrCpb *cpb = [ETGEccrCpb createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in json)
        {
            @try
            {
                if([key isEqualToString:@"lastestCPBAmt"])
                {
                    cpb.latestCPBAmt = [ETGJsonHelper resetToNilIfRequired:json[key]];
                }
                else if([key isEqualToString:@"btOutofBudgetHolder"])
                {
                    cpb.btOutofBudgetHolder = [ETGJsonHelper resetToNilIfRequired:json[key]];
                }
                else if([key isEqualToString:@"yep"])
                {
                    cpb.yep = [ETGJsonHelper resetToNilIfRequired:json[key]];
                }
                else if([key isEqualToString:@"yepwithRisk"])
                {
                    cpb.yepWithRisk = [ETGJsonHelper resetToNilIfRequired:json[key]];
                }
                else
                {
                    [cpb setValue:[ETGJsonHelper resetToNilIfRequired:json[key]] forKey:key];
                }
            }
            @catch (NSException *exception)
            {
                NSLog(@"Exception is %@", exception);
            }
        }
        cpb.reportingMonth = reportingMonth;
        [reportingMonth addCpbsObject:cpb];
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
}

-(BOOL)hasData:(NSString *)reportingMonth budgetKey:(NSString *)budgetKey
{
    ETGReportingMonth *targetReportingMonth = [self findOrCreateReportingMonth:reportingMonth];
    if(targetReportingMonth == nil || [targetReportingMonth.cpbs count] == 0)
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
    //reportingMonth = @"20130301";
    ETGReportingMonth *targetReportingMonth = [self findOrCreateReportingMonth:reportingMonth];

    NSSet *filteredSets = targetReportingMonth.cpbs;
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
    
    if(0 != [self.budgetHolderKeys count])
    {
        NSMutableArray *filteredCostCategoryKeys = [NSMutableArray new];
        for(NSString *budgetHolderKey in self.budgetHolderKeys)
        {
            [filteredCostCategoryKeys addObject:budgetHolderKey];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"budgetHolderKey IN %@ ", filteredCostCategoryKeys];
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
    
    // AK TODO, remove the line below
    //filteredSets = targetReportingMonth.cpbs;
    NSMutableDictionary *tempJson = [NSMutableDictionary new];
    NSMutableDictionary *topInformation = [NSMutableDictionary new];
    topInformation[@"currency"] = @"MYR '000,000";
    NSString *identifier = [NSString stringWithFormat:@"ECCR_CPB_%@", reportingMonth];
    if(nil != [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:identifier])
    {
        topInformation[@"update"] = [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:identifier];
    }
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:reportingMonth];
    [formatter setDateFormat:@"MMM-yyyy"];
    topInformation[@"reportingMonth"] = [formatter stringFromDate:date];
    
    tempJson[@"topInformation"] = topInformation;
    tempJson[@"chartdata"] = [self buildChartData:filteredSets];
    tempJson[@"tabledata"] = [self buildTableData:filteredSets];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempJson
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(NSNumber *)getDivideByOneKNumber:(NSNumber *)input
{
    return @([input doubleValue]);
}

-(NSDictionary *)buildChartData:(NSSet *)inputData
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"categories"] = @[@"Latest CPB", @"Budget Transfer", @"Original CPB", @"Potential Underspending", @"Anticipated CPB", @"Additional CAPEX", @"Newly Sanction", @"YEP", @"Potential Risk", @"YEP (Including Risk)"];
    if([inputData count] == 0)
    {
        temp[@"series"] = @[];
    }
    else
    {
        // Calculation here
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isInternational == 'n'"];
        NSSet *malaysiaData = [inputData filteredSetUsingPredicate:predicate];
        predicate = [NSPredicate predicateWithFormat:@"isInternational == 'y'"];
        NSSet *internationalData = [inputData filteredSetUsingPredicate:predicate];
        
        NSNumber *latestCpbMalaysia = [self getDivideByOneKNumber:[malaysiaData valueForKeyPath:@"@sum.latestCPBAmt"]];
        NSNumber *latestCpbInternational = [self getDivideByOneKNumber:[internationalData valueForKeyPath:@"@sum.latestCPBAmt"]];
        NSNumber *budgetTransferMalaysia = [self getDivideByOneKNumber:[malaysiaData valueForKeyPath:@"@sum.btOutofBudgetHolder"]];
        NSNumber *budgetTransferInternational = [self getDivideByOneKNumber:[internationalData valueForKeyPath:@"@sum.btOutofBudgetHolder"]];
        NSNumber *originalCpbMalaysia = [self getDivideByOneKNumber:[malaysiaData valueForKeyPath:@"@sum.originalCPBAmt"]];
        NSNumber *originalCpbInternational = [self getDivideByOneKNumber:[internationalData valueForKeyPath:@"@sum.originalCPBAmt"]];
        NSNumber *potentialUnderspendingMalaysia = [self getDivideByOneKNumber:[malaysiaData valueForKeyPath:@"@sum.potentialUnderSpending"]];
        NSNumber *potentialUnderspendingInternational = [self getDivideByOneKNumber:[internationalData valueForKeyPath:@"@sum.potentialUnderSpending"]];
        NSNumber *anticipatedCPBMalaysia = [self getDivideByOneKNumber:[malaysiaData valueForKeyPath:@"@sum.anticipatedCPB"]];
        NSNumber *anticipatedCPBInternational = [self getDivideByOneKNumber:[internationalData valueForKeyPath:@"@sum.anticipatedCPB"]];
        NSNumber *additionalCAPEXMalaysia = [self getDivideByOneKNumber:[malaysiaData valueForKeyPath:@"@sum.additionalCAPEX"]];
        NSNumber *additionalCAPEXInternational = [self getDivideByOneKNumber:[internationalData valueForKeyPath:@"@sum.additionalCAPEX"]];
        NSNumber *newlySanctionMalaysia = [self getDivideByOneKNumber:[malaysiaData valueForKeyPath:@"@sum.newlySanctionAmt"]];
        NSNumber *newlySactionInternational = [self getDivideByOneKNumber:[internationalData valueForKeyPath:@"@sum.newlySanctionAmt"]];
        NSNumber *yepMalaysia = [self getDivideByOneKNumber:[malaysiaData valueForKeyPath:@"@sum.yep"]];
        NSNumber *yepInternational = [self getDivideByOneKNumber:[internationalData valueForKeyPath:@"@sum.yep"]];
        NSNumber *potentialRiskMalaysia = [self getDivideByOneKNumber:[malaysiaData valueForKeyPath:@"@sum.potentialRisk"]];
        NSNumber *potentialRiskInternational = [self getDivideByOneKNumber:[internationalData valueForKeyPath:@"@sum.potentialRisk"]];
        NSNumber *yepWithRiskMalaysia = [self getDivideByOneKNumber:[malaysiaData valueForKeyPath:@"@sum.yepWithRisk"]];
        NSNumber *yepWithRiskInternational = [self getDivideByOneKNumber:[internationalData valueForKeyPath:@"@sum.yepWithRisk"]];
        
        NSMutableArray *tempSeries = [NSMutableArray new];
        NSMutableArray *tempMalaysiaSeries = [NSMutableArray new];
        [tempMalaysiaSeries addObjectsFromArray:@[latestCpbMalaysia, budgetTransferMalaysia, originalCpbMalaysia, potentialUnderspendingMalaysia, anticipatedCPBMalaysia, additionalCAPEXMalaysia, newlySanctionMalaysia, yepMalaysia, @(0), yepWithRiskMalaysia]];
        
        NSMutableArray *tempInternationalSeries = [NSMutableArray new];
        [tempInternationalSeries addObjectsFromArray:@[latestCpbInternational, budgetTransferInternational, originalCpbInternational, potentialUnderspendingInternational, anticipatedCPBInternational, additionalCAPEXInternational, newlySactionInternational, yepInternational, @(0), yepWithRiskInternational]];
        
        double totalPotentialRisk = [potentialRiskMalaysia doubleValue] + [potentialRiskInternational doubleValue];
        NSArray *tempTotalSeries = @[@(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), [self getDivideByOneKNumber:@(totalPotentialRisk)], @(0)];
        
        NSMutableArray *tempGapSeries = [NSMutableArray new];
        double totalLatestCpb = [latestCpbInternational doubleValue] + [latestCpbMalaysia doubleValue];
        double totalOriginalCpb = [originalCpbInternational doubleValue] + [originalCpbMalaysia doubleValue];
        double totalAnticipatedCpb = [anticipatedCPBInternational doubleValue] + [anticipatedCPBMalaysia doubleValue];
        double totalAdditionalCapex = [additionalCAPEXInternational doubleValue] + [additionalCAPEXMalaysia doubleValue];
        double totalYep = [yepInternational doubleValue] + [yepMalaysia doubleValue];
        
        double totalBudgetTransfer = [budgetTransferInternational doubleValue] + [budgetTransferMalaysia doubleValue];
        double cpbBudgetTransferDiff = totalLatestCpb - totalBudgetTransfer;
        double cpbGap = 0;
        if(cpbBudgetTransferDiff > totalLatestCpb)
        {
            cpbGap = totalLatestCpb;
        }
        else
        {
            cpbGap = cpbBudgetTransferDiff;
        }
        
        double totalPotentialUnderspending = [potentialUnderspendingInternational doubleValue] + [potentialUnderspendingMalaysia doubleValue];
        double potentialUnderspendingGap = totalOriginalCpb - fabs(totalPotentialUnderspending);
        
        double potentialRiskGap = 0;
        if(totalPotentialRisk > 0)
        {
            potentialRiskGap = totalYep;
        }
        else
        {
            potentialRiskGap = totalYep - fabs(totalPotentialRisk);
        }
        
        [tempGapSeries addObjectsFromArray:@[@(0), [self getDivideByOneKNumber:@(cpbGap)], @(0), @(potentialUnderspendingGap), @(0), [self getDivideByOneKNumber:@(totalAnticipatedCpb)], [self getDivideByOneKNumber:@(totalAdditionalCapex + totalAnticipatedCpb)], @(0), @(totalYep), @(0)]];
        
        [tempSeries addObject:[self buildSeriesDictionary:@"gap" array:tempGapSeries]];
        [tempSeries addObject:[self buildSeriesDictionary:@"Malaysia" array:tempMalaysiaSeries]];
        [tempSeries addObject:[self buildSeriesDictionary:@"International" array:tempInternationalSeries]];
        [tempSeries addObject:[self buildSeriesDictionary:@"Total" array:tempTotalSeries]];
        temp[@"series"] = tempSeries;
    }
    return temp;
}

-(NSDictionary *)buildSeriesDictionary:(NSString *)name array:(NSArray *)array
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"name"] = name;
    temp[@"data"] = array;
    return temp;
}

-(NSDictionary *)buildTableData:(NSSet *)inputData
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"header"] = @[@"Latest CPB", @"Budget Transfer", @"Original CPB", @"Potential Underspending", @"Anticipated CPB", @"Additional CAPEX", @"Newly Sanction", @"YEP", @"Potential Risk", @"YEP (Including Risk)"];
    if([inputData count] == 0)
    {
        temp[@"body"] = @[];
    }
    else
    {
        NSMutableArray *temp2 = [NSMutableArray new];
        for(ETGEccrCpb *cpb in inputData)
        {
            [temp2 addObject:[self convertCpbToTableBody:cpb]];
        }
        temp[@"body"] = temp2;
    }
    return temp;
}

-(NSArray *)convertCpbToTableBody:(ETGEccrCpb *)cpb
{
    NSMutableArray *temp = [NSMutableArray new];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", cpb.projectKey];
    ETGProject *project = [ETGProject findFirstWithPredicate:predicate];
    
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"key == %@", cpb.regionKey];
    ETGRegion *region = [ETGRegion findFirstWithPredicate:predicate2];
    
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:region.name]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:project.name]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.latestCPBAmt]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.btOutofBudgetHolder]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.originalCPBAmt]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.potentialUnderSpending]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.anticipatedCPB]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.additionalCAPEX]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.newlySanctionAmt]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.yep]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.potentialRisk]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.yepWithRisk]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:cpb.projectKey]];
    [temp addObject:[ETGJsonHelper resetToEmptyStringIfRequired:region.key]];
    return temp;
}

@end
