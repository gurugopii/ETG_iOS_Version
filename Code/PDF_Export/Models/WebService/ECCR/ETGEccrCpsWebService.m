//
//  ETGEccrCpsWebService.m
//  ETG
//
//  Created by Tan Aik Keong on 1/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGEccrCpsWebService.h"
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
#import "ETGEccrCps.h"
#import "ETGProjectSummary.h"
#import "ETGEccrCpsAfe.h"
#import "ETGEccrCpsAfeDetail.h"
#import "ETGEccrCpsStatusCurrency.h"
#import "ETGEccrCpsApc.h"
#import "ETGEccrCpsApcDetail.h"
#import "ETGEccrCpsJustification.h"
#import "ETGEccrCpsCpb.h"
#import "ETGEccrCpsCpbDetail.h"
#import "ETGEccrCpsFdp.h"
#import "ETGEccrCpsFdpDetail.h"
#import "ETGEccrCpsWpb.h"
#import "ETGEccrCpsWpbDetail.h"
#import "ETGEccrCpsStatusCurrency.h"

@interface ETGEccrCpsWebService()
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@end

@implementation ETGEccrCpsWebService

-(BOOL)needRefreshDataWithReportingMonth:(NSString *)reportingMonth projectKey:(NSString *)projectKey
{
    NSString *identifier = [NSString stringWithFormat:@"ECCR_CPS_%@_%@", projectKey, reportingMonth];
    return [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:identifier reportingMonth:reportingMonth];
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth projectKey:(NSString *)projectKey
                    isNavigateFromWpb:(NSString *)isWpb
                      isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString *jsonString))success
                              failure:(void (^)(NSError *error))failure
{
    // AK TODO
    //reportingMonth = @"20130801";
    //projectKey = @"110";
    NSString *identifier = [NSString stringWithFormat:@"ECCR_CPS_%@_%@", projectKey, reportingMonth];
    BOOL timestamp = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:identifier reportingMonth:reportingMonth];
    if(timestamp || isManual || ![self hasData:reportingMonth projectKey:projectKey])
    {
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        if (_appDelegate.isNetworkServerAvailable == YES) {
            NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kEccrService, ETG_ECCR_CPS];
            NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
            
            NSDictionary *inputDict = @{kInputReportingMonth: reportingMonth, kInputPllProjectKey: projectKey};
            NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:nil];
            [request setHTTPBody:inputData];
            
            AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            requestOperation.SSLPinningMode = AFSSLPinningModeCertificate;
            [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 if([[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:nil])
                 {
                     [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadEccrShouldAutoRefresh object:nil];
                     success([self getOfflineData:reportingMonth projectKey:projectKey isNavigateFromWpb:isWpb]);
                     return;
                 }
                 if(nil == responseObject)
                 {
                     success([self getOfflineData:reportingMonth projectKey:projectKey isNavigateFromWpb:isWpb]);
                     return;
                 }
                 [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:reportingMonth moduleName:identifier];
                 NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                 ETGProjectSummary *summary = [self findOrCreateProjectSummary:reportingMonth projectKey:projectKey];
                 [self convertJsonToCoreData:json summary:summary];
                 
                 NSString *jsonResult = [self getOfflineData:reportingMonth projectKey:projectKey isNavigateFromWpb:isWpb];
                 success(jsonResult);
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if(error.code == kNoConnectionErrorCode)
                 {
                     [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadEccrShouldAutoRefresh object:nil];
                     DDLogWarn(@"%@%@",kDownloadEccrShouldAutoRefresh,@"There's no internet connection");
                 }
                 else
                 {
                     [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:error];
                 }
                 success([self getOfflineData:reportingMonth projectKey:projectKey isNavigateFromWpb:isWpb]);
             }];
            [requestOperation setQueuePriority:NSOperationQueuePriorityVeryHigh];
            [[NSOperationQueue mainQueue] addOperation:requestOperation];
        }
        else
        {
            DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
            [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadEccrShouldAutoRefresh object:nil];
            success([self getOfflineData:reportingMonth projectKey:projectKey isNavigateFromWpb:isWpb]);
        }
    }
    else
    {
        // Fetch from core data
        success([self getOfflineData:reportingMonth projectKey:projectKey isNavigateFromWpb:isWpb]);
    }
}

-(void)convertJsonToCoreData:(NSDictionary *)json summary:(ETGProjectSummary *)summary
{
    ETGEccrCps *cps = [ETGEccrCps insertInManagedObjectContext:[NSManagedObjectContext contextForCurrentThread]];
    NSDictionary *afe = json[@"afe"];
    cps.afe = [self convertAfeJsonToCoreData:afe];
    NSDictionary *apc = json[@"apc"];
    cps.apc = [self convertApcJsonToCoreData:apc];
    NSDictionary *cpb = json[@"cpb"];
    cps.cpb = [self convertCpbJsonToCoreData:cpb];
    NSDictionary *fdp = json[@"fdp"];
    cps.fdp = [self convertFdpJsonToCoreData:fdp];
    NSDictionary *wpb = json[@"wpb"];
    cps.wpb = [self convertWpbJsonToCoreData:wpb];
    
    cps.projectSummary = summary;
    summary.etgEccr_cps = cps;
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
}

-(ETGEccrCpsAfe *)convertAfeJsonToCoreData:(NSDictionary *)json
{
    if(json == (id)[NSNull null])
    {
        return nil;
    }
    
    ETGEccrCpsAfe *afeContainer = [ETGEccrCpsAfe createInContext:[NSManagedObjectContext contextForCurrentThread]];
    
    NSDictionary *capex = [ETGJsonHelper resetToNilIfRequired:json[@"capex"]];
    for(NSDictionary *afe in capex)
    {
        ETGEccrCpsAfeDetail *d = [ETGEccrCpsAfeDetail createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in afe)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:afe[key]] forKey:key];
        }
        [afeContainer.capexSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *opex = [ETGJsonHelper resetToNilIfRequired:json[@"opex"]];
    for(NSDictionary *afe in opex)
    {
        ETGEccrCpsAfeDetail *d = [ETGEccrCpsAfeDetail createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in afe)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:afe[key]] forKey:key];
        }
        [afeContainer.opexSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *statusCurrency = [ETGJsonHelper resetToNilIfRequired:json[@"statusCurrency"]];
    for(NSDictionary *sc in statusCurrency)
    {
        ETGEccrCpsStatusCurrency *d = [ETGEccrCpsStatusCurrency createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in sc)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:sc[key]] forKey:key];
        }
        [afeContainer.statusCurrenciesSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    return afeContainer;
}

-(ETGEccrCpsApc *)convertApcJsonToCoreData:(NSDictionary *)json
{
    if(json == (id)[NSNull null])
    {
        return nil;
    }
    
    ETGEccrCpsApc *apcContainer = [ETGEccrCpsApc createInContext:[NSManagedObjectContext contextForCurrentThread]];
    
    NSDictionary *capex = [ETGJsonHelper resetToNilIfRequired:json[@"capex"]];
    for(NSDictionary *afe in capex)
    {
        ETGEccrCpsApcDetail *d = [ETGEccrCpsApcDetail createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in afe)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:afe[key]] forKey:key];
        }
        [apcContainer.capexSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *opex = [ETGJsonHelper resetToNilIfRequired:json[@"opex"]];
    for(NSDictionary *afe in opex)
    {
        ETGEccrCpsApcDetail *d = [ETGEccrCpsApcDetail createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in afe)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:afe[key]] forKey:key];
        }
        [apcContainer.opexSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *justifications = [ETGJsonHelper resetToNilIfRequired:json[@"justifications"]];
    for(NSDictionary *ju in justifications)
    {
        ETGEccrCpsJustification *d = [ETGEccrCpsJustification createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in ju)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:ju[key]] forKey:key];
        }
        [apcContainer.justificationsSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *statusCurrency = [ETGJsonHelper resetToNilIfRequired:json[@"statusCurrency"]];
    for(NSDictionary *sc in statusCurrency)
    {
        ETGEccrCpsStatusCurrency *d = [ETGEccrCpsStatusCurrency createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in sc)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:sc[key]] forKey:key];
        }
        [apcContainer.statusCurrenciesSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    return apcContainer;
}

-(ETGEccrCpsCpb *)convertCpbJsonToCoreData:(NSDictionary *)json
{
    if(json == (id)[NSNull null])
    {
        return nil;
    }
    
    ETGEccrCpsCpb *cpbContainer = [ETGEccrCpsCpb createInContext:[NSManagedObjectContext contextForCurrentThread]];
    
    NSDictionary *capex = [ETGJsonHelper resetToNilIfRequired:json[@"capex"]];
    for(NSDictionary *afe in capex)
    {
        ETGEccrCpsCpbDetail *d = [ETGEccrCpsCpbDetail createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in afe)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:afe[key]] forKey:key];
        }
        [cpbContainer.capexSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *opex = [ETGJsonHelper resetToNilIfRequired:json[@"opex"]];
    for(NSDictionary *afe in opex)
    {
        ETGEccrCpsCpbDetail *d = [ETGEccrCpsCpbDetail createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in afe)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:afe[key]] forKey:key];
        }
        [cpbContainer.opexSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *justifications = [ETGJsonHelper resetToNilIfRequired:json[@"justifications"]];
    for(NSDictionary *ju in justifications)
    {
        ETGEccrCpsJustification *d = [ETGEccrCpsJustification createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in ju)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:ju[key]] forKey:key];
        }
        [cpbContainer.justificationsSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *statusCurrency = [ETGJsonHelper resetToNilIfRequired:json[@"statusCurrency"]];
    for(NSDictionary *sc in statusCurrency)
    {
        ETGEccrCpsStatusCurrency *d = [ETGEccrCpsStatusCurrency createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in sc)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:sc[key]] forKey:key];
        }
        [cpbContainer.statusCurrenciesSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    return cpbContainer;
}

-(ETGEccrCpsFdp *)convertFdpJsonToCoreData:(NSDictionary *)json
{
    if(json == (id)[NSNull null])
    {
        return nil;
    }
    
    ETGEccrCpsFdp *cpbContainer = [ETGEccrCpsFdp createInContext:[NSManagedObjectContext contextForCurrentThread]];
    
    NSDictionary *capex = [ETGJsonHelper resetToNilIfRequired:json[@"capex"]];
    for(NSDictionary *afe in capex)
    {
        ETGEccrCpsFdpDetail *d = [ETGEccrCpsFdpDetail createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in afe)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:afe[key]] forKey:key];
        }
        [cpbContainer.capexSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *opex = [ETGJsonHelper resetToNilIfRequired:json[@"opex"]];
    for(NSDictionary *afe in opex)
    {
        ETGEccrCpsFdpDetail *d = [ETGEccrCpsFdpDetail createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in afe)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:afe[key]] forKey:key];
        }
        [cpbContainer.opexSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *statusCurrency = [ETGJsonHelper resetToNilIfRequired:json[@"statusCurrency"]];
    for(NSDictionary *sc in statusCurrency)
    {
        ETGEccrCpsStatusCurrency *d = [ETGEccrCpsStatusCurrency createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in sc)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:sc[key]] forKey:key];
        }
        [cpbContainer.statusCurrenciesSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    return cpbContainer;
}

-(ETGEccrCpsWpb *)convertWpbJsonToCoreData:(NSDictionary *)json
{
    if(json == (id)[NSNull null])
    {
        return nil;
    }
    
    ETGEccrCpsWpb *cpbContainer = [ETGEccrCpsWpb createInContext:[NSManagedObjectContext contextForCurrentThread]];
    
    NSDictionary *capex = [ETGJsonHelper resetToNilIfRequired:json[@"capex"]];
    for(NSDictionary *afe in capex)
    {
        ETGEccrCpsWpbDetail *d = [ETGEccrCpsWpbDetail createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in afe)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:afe[key]] forKey:key];
        }
        [cpbContainer.capexSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *opex = [ETGJsonHelper resetToNilIfRequired:json[@"opex"]];
    for(NSDictionary *afe in opex)
    {
        ETGEccrCpsWpbDetail *d = [ETGEccrCpsWpbDetail createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in afe)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:afe[key]] forKey:key];
        }
        [cpbContainer.opexSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *justifications = [ETGJsonHelper resetToNilIfRequired:json[@"justifications"]];
    for(NSDictionary *ju in justifications)
    {
        ETGEccrCpsJustification *d = [ETGEccrCpsJustification createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in ju)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:ju[key]] forKey:key];
        }
        [cpbContainer.justificationsSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    NSDictionary *statusCurrency = [ETGJsonHelper resetToNilIfRequired:json[@"statusCurrency"]];
    for(NSDictionary *sc in statusCurrency)
    {
        ETGEccrCpsStatusCurrency *d = [ETGEccrCpsStatusCurrency createInContext:[NSManagedObjectContext contextForCurrentThread]];
        for(NSString *key in sc)
        {
            [d setValue:[ETGJsonHelper resetToNilIfRequired:sc[key]] forKey:key];
        }
        [cpbContainer.statusCurrenciesSet addObject:d];
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    return cpbContainer;
}

-(NSString *)getOfflineDataTopInformation:(NSString *)reportingMonth projectKey:(NSString *)projectKey isNavigateFromWpb:(NSString *)isWpb
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSMutableDictionary *topInformation = [NSMutableDictionary new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:reportingMonth];
    [formatter setDateFormat:@"MMM-yyyy"];
    topInformation[@"reportingPeriod"] = [formatter stringFromDate:date];
    
    ETGProject *project = [self findProject:projectKey];
    topInformation[@"project"] = [ETGJsonHelper resetToEmptyStringIfRequired:project.name];
    
    NSString *identifier = [NSString stringWithFormat:@"ECCR_CPS_%@_%@", projectKey, reportingMonth];
    if(nil != [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:identifier])
    {
        topInformation[@"update"] = [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:identifier];
    }
    
    temp[@"topInformation"] = topInformation;
    
    if([isWpb length] != 0)
    {
        temp[@"activeTab"] = isWpb;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:temp
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(NSString *)getOfflineData:(NSString *)reportingMonth projectKey:(NSString *)projectKey isNavigateFromWpb:(NSString *)isWpb
{
    // AK TODO
    //reportingMonth = @"20130801";
    //projectKey = @"110";
    ETGProjectSummary *targetSummary = [self findOrCreateProjectSummary:reportingMonth projectKey:projectKey];
    
    if(targetSummary == nil || targetSummary.etgEccr_cps == nil)
    {
        return [self getOfflineDataTopInformation:reportingMonth projectKey:projectKey isNavigateFromWpb:isWpb];
    }
    
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSMutableDictionary *topInformation = [NSMutableDictionary new];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:reportingMonth];
    [formatter setDateFormat:@"MMM-yyyy"];
    topInformation[@"reportingPeriod"] = [formatter stringFromDate:date];
    
    ETGProject *project = [self findProject:projectKey];
    topInformation[@"project"] = [ETGJsonHelper resetToEmptyStringIfRequired:project.name];
    
    NSString *identifier = [NSString stringWithFormat:@"ECCR_CPS_%@_%@", projectKey, reportingMonth];
    if(nil != [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:identifier])
    {
        topInformation[@"update"] = [[ETGCoreDataUtilities sharedCoreDataUtilities] getTimeStampForModule:identifier];
    }
    
    temp[@"topInformation"] = topInformation;
    if([isWpb length] != 0)
    {
        temp[@"activeTab"] = isWpb;
    }
    
    ETGProjectSummary *projectSummary = [self findOrCreateProjectSummary:reportingMonth projectKey:projectKey];
    temp[@"apc"] = [self resetToNoDataIfRequired:[self convertApcIntoJsonDictionary:projectSummary]];
    temp[@"fdp"] = [self resetToNoDataIfRequired:[self convertFdpIntoJsonDictionary:projectSummary]];
    temp[@"cpb"] = [self resetToNoDataIfRequired:[self convertCpbIntoJsonDictionary:projectSummary]];
    temp[@"wpb"] = [self resetToNoDataIfRequired:[self convertWpbIntoJsonDictionary:projectSummary]];
    temp[@"afe"] = [self resetToNoDataIfRequired:[self convertAfeIntoJsonDictionary:projectSummary]];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:temp
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(NSString *)resetToNoDataIfRequired:(id)input
{
    if(input == nil)
    {
        return @"No data";
    }
    return input;
}

-(NSString *)getJustification:(NSString *)inputType inputValue:(NSString *)inputValue reportingMonth:(NSString *)reportingMonth projectKey:(NSString *)projectKey
{
    // AK TODO
    //reportingMonth = @"20130801";
    //projectKey = @"110";
    ETGProjectSummary *projectSummary = [self findOrCreateProjectSummary:reportingMonth projectKey:projectKey];
    NSSet *justifications = nil;
    NSPredicate *predicate;
    if([inputType isEqualToString:@"justificationForAPC"])
    {
        justifications = projectSummary.etgEccr_cps.apc.justifications;
        predicate = [NSPredicate predicateWithFormat:@"activityKey == %d", [inputValue intValue]];
        justifications = [justifications filteredSetUsingPredicate:predicate];
    }
    else if([inputType isEqualToString:@"justificationForCPB"])
    {
        justifications = projectSummary.etgEccr_cps.cpb.justifications;
        predicate = [NSPredicate predicateWithFormat:@"activityKey == %d", [inputValue intValue]];
        justifications = [justifications filteredSetUsingPredicate:predicate];
    }
    else if([inputType isEqualToString:@"justificationForWPB"])
    {
        justifications = projectSummary.etgEccr_cps.wpb.justifications;
        predicate = [NSPredicate predicateWithFormat:@"budgetItemKey == %d", [inputValue intValue]];
        justifications = [justifications filteredSetUsingPredicate:predicate];
    }

    NSMutableArray *temp = [NSMutableArray new];
    for(ETGEccrCpsJustification *j in justifications)
    {
        NSMutableDictionary *tempJson = [[ETGJsonHelper convertCoreDataToDictionaryRepresentation:j] mutableCopy];
        if([inputType isEqualToString:@"justificationForAPC"])
        {
            tempJson[@"key"] = tempJson[@"activityKey"];
            tempJson[@"name"] = tempJson[@"activityName"];
        }
        else if([inputType isEqualToString:@"justificationForCPB"])
        {
            tempJson[@"key"] = tempJson[@"activityKey"];
            tempJson[@"name"] = tempJson[@"activityName"];
        }
        else if([inputType isEqualToString:@"justificationForWPB"])
        {
            tempJson[@"key"] = tempJson[@"structureKey"];
            tempJson[@"name"] = tempJson[@"structureName"];
        }
        
        [temp addObject:tempJson];
    }
    if([temp count] == 0)
    {
        temp = [NSMutableArray new];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:temp
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(NSDictionary *)getTopInformation:(NSSet *)statusCurrencies
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    if([statusCurrencies count] == 0)
    {
        temp[@"status"] = @"";
        temp[@"currency"] = @"";
        return temp;
    }
    ETGEccrCpsStatusCurrency *statusCurrency = [statusCurrencies allObjects][0];
    temp[@"status"] = statusCurrency.cpsStatus;
    temp[@"currency"] = [NSString stringWithFormat:@"%@ '000", statusCurrency.cpsCurrency];
    return temp;
}

-(NSDictionary *)convertApcIntoJsonDictionary:(ETGProjectSummary *)projectSummary
{
    ETGEccrCpsApc *apc = projectSummary.etgEccr_cps.apc;
    if(nil == apc)
    {
        return nil;
    }

    NSMutableArray *capex = [NSMutableArray new];
    for(ETGEccrCpsApcDetail *d in apc.capex)
    {
        NSDictionary *temp = [ETGJsonHelper convertCoreDataToDictionaryRepresentation:d];
        [capex addObject:[self convertApcIntoHtmlJsonFormat:[temp mutableCopy]]];
    }

    NSMutableArray *opex = [NSMutableArray new];
    for(ETGEccrCpsApcDetail *d in apc.opex)
    {
        NSDictionary *temp = [ETGJsonHelper convertCoreDataToDictionaryRepresentation:d];
        [opex addObject:[self convertApcIntoHtmlJsonFormat:[temp mutableCopy]]];
    }
    
    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"apcTopInformation"] = [self getTopInformation:apc.statusCurrencies];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"sequence" ascending:YES];
    temp[@"apcTableDataCapex"] = [capex sortedArrayUsingDescriptors:@[sorter]];
    temp[@"apcTableDataOpex"] = [opex sortedArrayUsingDescriptors:@[sorter]];
    return temp;
}

-(NSDictionary *)convertApcIntoHtmlJsonFormat:(NSMutableDictionary *)inputDictionary
{
    inputDictionary[@"rowSequence"] = inputDictionary[@"sequence"];
    if(inputDictionary[@"activityKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"activity";
        inputDictionary[@"key"] = inputDictionary[@"activityKey"];
        inputDictionary[@"name"] = inputDictionary[@"activityName"];
    }
    else if(inputDictionary[@"facilityKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"facility";
        inputDictionary[@"key"] = inputDictionary[@"facilityKey"];
        inputDictionary[@"name"] = inputDictionary[@"facilityName"];
    }
    else if(inputDictionary[@"structureKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"structure";
        inputDictionary[@"key"] = inputDictionary[@"structureKey"];
        inputDictionary[@"name"] = inputDictionary[@"structureName"];
    }
    else if(inputDictionary[@"costItemKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"costitem";
        inputDictionary[@"key"] = inputDictionary[@"costItemKey"];
        inputDictionary[@"name"] = inputDictionary[@"costItemame"];
    }
    else if(inputDictionary[@"activityName"] != (id)[NSNull null] && [inputDictionary[@"activityName"] isEqualToString:@"Management Reserves"])
    {
        inputDictionary[@"rowName"] = @"activity";
        inputDictionary[@"key"] = @(-1);
        inputDictionary[@"name"] = @"Management Reserves";
    }
    else if(inputDictionary[@"activityName"] != (id)[NSNull null] && [inputDictionary[@"activityName"] isEqualToString:@"Total"])
    {
        inputDictionary[@"rowName"] = @"total";
        inputDictionary[@"key"] = @(-1);
        inputDictionary[@"name"] = @"Total";
    }
    // All keys are null, management reserve, make it as one level collapse
    else
    {
        inputDictionary[@"rowName"] = @"facility";
        inputDictionary[@"key"] = @(-1);
        inputDictionary[@"name"] = @"";
    }
    inputDictionary[@"apcFido"] = inputDictionary[@"apcFID0"];
    inputDictionary[@"cumVowdAmt"] = inputDictionary[@"cumVOWDAmt"];
    return inputDictionary;
}

-(NSDictionary *)convertFdpIntoJsonDictionary:(ETGProjectSummary *)projectSummary
{
    ETGEccrCpsFdp *fdp = projectSummary.etgEccr_cps.fdp;
    if(nil == fdp)
    {
        return nil;
    }
    
    NSMutableArray *capex = [NSMutableArray new];
    for(ETGEccrCpsFdpDetail *d in fdp.capex)
    {
        NSDictionary *temp = [ETGJsonHelper convertCoreDataToDictionaryRepresentation:d];
        [capex addObject:[self convertFdpIntoHtmlJsonFormat:[temp mutableCopy]]];
    }
    
    NSMutableArray *opex = [NSMutableArray new];
    for(ETGEccrCpsFdpDetail *d in fdp.opex)
    {
        NSDictionary *temp = [ETGJsonHelper convertCoreDataToDictionaryRepresentation:d];
        [opex addObject:[self convertFdpIntoHtmlJsonFormat:[temp mutableCopy]]];
    }
    
    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"fdpTopInformation"] = [self getTopInformation:fdp.statusCurrencies];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"sequence" ascending:YES];
    temp[@"fdpTableDataCapex"] = [capex sortedArrayUsingDescriptors:@[sorter]];
    temp[@"fdpTableDataOpex"] = [opex sortedArrayUsingDescriptors:@[sorter]];
    return temp;
}

-(NSDictionary *)convertFdpIntoHtmlJsonFormat:(NSMutableDictionary *)inputDictionary
{
    inputDictionary[@"rowSequence"] = inputDictionary[@"sequence"];
    if(inputDictionary[@"activityKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"activity";
        inputDictionary[@"key"] = inputDictionary[@"activityKey"];
        inputDictionary[@"name"] = inputDictionary[@"activityName"];
    }
    else if(inputDictionary[@"facilityKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"facility";
        inputDictionary[@"key"] = inputDictionary[@"facilityKey"];
        inputDictionary[@"name"] = inputDictionary[@"facilityName"];
    }
    else if(inputDictionary[@"structureKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"structure";
        inputDictionary[@"key"] = inputDictionary[@"structureKey"];
        inputDictionary[@"name"] = inputDictionary[@"structureName"];
    }
    else if(inputDictionary[@"costItemKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"costitem";
        inputDictionary[@"key"] = inputDictionary[@"costItemKey"];
        inputDictionary[@"name"] = inputDictionary[@"costItemame"];
    }
    else
    {
        inputDictionary[@"rowName"] = @"total";
        inputDictionary[@"key"] = @(-1);
        inputDictionary[@"name"] = @"Total";
    }
    inputDictionary[@"cumVowdAmt"] = inputDictionary[@"cumVOWDAmt"];
    return inputDictionary;
}

-(NSDictionary *)convertCpbIntoJsonDictionary:(ETGProjectSummary *)projectSummary
{
    ETGEccrCpsCpb *cpb = projectSummary.etgEccr_cps.cpb;
    if(nil == cpb)
    {
        return nil;
    }
    
    NSMutableArray *capex = [NSMutableArray new];
    for(ETGEccrCpsCpbDetail *d in cpb.capex)
    {
        NSDictionary *temp = [ETGJsonHelper convertCoreDataToDictionaryRepresentation:d];
        [capex addObject:[self convertCpbIntoHtmlJsonFormat:[temp mutableCopy]]];
    }
    
    NSMutableArray *opex = [NSMutableArray new];
    for(ETGEccrCpsCpbDetail *d in cpb.opex)
    {
        NSDictionary *temp = [ETGJsonHelper convertCoreDataToDictionaryRepresentation:d];
        [opex addObject:[self convertCpbIntoHtmlJsonFormat:[temp mutableCopy]]];
    }
    
    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"cpbTopInformation"] = [self getTopInformation:cpb.statusCurrencies];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"sequence" ascending:YES];
    temp[@"cpbTableDataCapex"] = [capex sortedArrayUsingDescriptors:@[sorter]];
    temp[@"cpbTableDataOpex"] = [opex sortedArrayUsingDescriptors:@[sorter]];
    return temp;
}

-(NSDictionary *)convertCpbIntoHtmlJsonFormat:(NSMutableDictionary *)inputDictionary
{
    inputDictionary[@"rowSequence"] = inputDictionary[@"sequence"];
    if(inputDictionary[@"activityKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"activity";
        inputDictionary[@"key"] = inputDictionary[@"activityKey"];
        inputDictionary[@"name"] = inputDictionary[@"activityName"];
    }
    else if(inputDictionary[@"facilityKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"facility";
        inputDictionary[@"key"] = inputDictionary[@"facilityKey"];
        inputDictionary[@"name"] = inputDictionary[@"facilityName"];
    }
    else if(inputDictionary[@"structureKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"structure";
        inputDictionary[@"key"] = inputDictionary[@"structureKey"];
        inputDictionary[@"name"] = inputDictionary[@"structureName"];
    }
    else if(inputDictionary[@"costItemKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"costitem";
        inputDictionary[@"key"] = inputDictionary[@"costItemKey"];
        inputDictionary[@"name"] = inputDictionary[@"costItemame"];
    }
    else
    {
        inputDictionary[@"rowName"] = @"total";
        inputDictionary[@"key"] = @(-1);
        inputDictionary[@"name"] = @"Total";
    }
    inputDictionary[@"latestCpbAmt"] = inputDictionary[@"latestCPBAmt"];
    return inputDictionary;
}

-(NSDictionary *)convertWpbIntoJsonDictionary:(ETGProjectSummary *)projectSummary
{
    ETGEccrCpsWpb *wpb = projectSummary.etgEccr_cps.wpb;
    if(nil == wpb)
    {
        return nil;
    }
    
    NSMutableArray *capex = [NSMutableArray new];
    for(ETGEccrCpsWpbDetail *d in wpb.capex)
    {
        NSDictionary *temp = [ETGJsonHelper convertCoreDataToDictionaryRepresentation:d];
        [capex addObject:[self convertWpbIntoHtmlJsonFormat:[temp mutableCopy]]];
    }
    
    NSMutableArray *opex = [NSMutableArray new];
    for(ETGEccrCpsWpbDetail *d in wpb.opex)
    {
        NSDictionary *temp = [ETGJsonHelper convertCoreDataToDictionaryRepresentation:d];
        [opex addObject:[self convertWpbIntoHtmlJsonFormat:[temp mutableCopy]]];
    }

    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"wpbTopInformation"] = [self getTopInformation:wpb.statusCurrencies];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"sequence" ascending:YES];
    temp[@"wpbTableDataCapex"] = [capex sortedArrayUsingDescriptors:@[sorter]];
    temp[@"wpbTableDataOpex"] = [opex sortedArrayUsingDescriptors:@[sorter]];
    return temp;
}

-(NSDictionary *)convertWpbIntoHtmlJsonFormat:(NSMutableDictionary *)inputDictionary
{
    inputDictionary[@"rowSequence"] = inputDictionary[@"sequence"];
    if(inputDictionary[@"activityKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"activity";
        inputDictionary[@"key"] = inputDictionary[@"activityKey"];
        inputDictionary[@"name"] = inputDictionary[@"activityName"];
    }
    else if(inputDictionary[@"budgetItemKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"budget";
        inputDictionary[@"key"] = inputDictionary[@"budgetItemKey"];
        inputDictionary[@"name"] = inputDictionary[@"budgetItemName"];
    }
    else if(inputDictionary[@"structureKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"structure";
        inputDictionary[@"key"] = inputDictionary[@"structureKey"];
        inputDictionary[@"name"] = inputDictionary[@"structureName"];
    }
    else
    {
        inputDictionary[@"rowName"] = @"total";
        inputDictionary[@"key"] = @(-1);
        inputDictionary[@"name"] = @"Total";
    }
    return inputDictionary;
}

-(NSDictionary *)convertAfeIntoJsonDictionary:(ETGProjectSummary *)projectSummary
{
    ETGEccrCpsAfe *afe = projectSummary.etgEccr_cps.afe;
    if(nil == afe)
    {
        return nil;
    }
    
    NSMutableArray *capex = [NSMutableArray new];
    for(ETGEccrCpsAfeDetail *d in afe.capex)
    {
        NSDictionary *temp = [ETGJsonHelper convertCoreDataToDictionaryRepresentation:d];
        [capex addObject:[self convertAfeIntoHtmlJsonFormat:[temp mutableCopy]]];
    }
    
    NSMutableArray *opex = [NSMutableArray new];
    for(ETGEccrCpsAfeDetail *d in afe.opex)
    {
        NSDictionary *temp = [ETGJsonHelper convertCoreDataToDictionaryRepresentation:d];
        [opex addObject:[self convertAfeIntoHtmlJsonFormat:[temp mutableCopy]]];
    }
    
    NSMutableDictionary *temp = [NSMutableDictionary new];
    temp[@"afeTopInformation"] = [self getTopInformation:afe.statusCurrencies];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"sequence" ascending:YES];
    temp[@"afeTableDataCapex"] = [capex sortedArrayUsingDescriptors:@[sorter]];
    temp[@"afeTableDataOpex"] = [opex sortedArrayUsingDescriptors:@[sorter]];
    return temp;
}

-(NSDictionary *)convertAfeIntoHtmlJsonFormat:(NSMutableDictionary *)inputDictionary
{
    inputDictionary[@"rowSequence"] = inputDictionary[@"sequence"];
    if(inputDictionary[@"afeKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"afe";
        inputDictionary[@"key"] = inputDictionary[@"afeKey"];
        inputDictionary[@"name"] = inputDictionary[@"afeId"];
    }
    else if(inputDictionary[@"wbsKey"] != (id)[NSNull null])
    {
        inputDictionary[@"rowName"] = @"wbs";
        inputDictionary[@"key"] = inputDictionary[@"wbsKey"];
        inputDictionary[@"name"] = inputDictionary[@"wbsId"];
    }
    else
    {
        inputDictionary[@"rowName"] = @"total";
        inputDictionary[@"key"] = @(-1);
        inputDictionary[@"name"] = @"Total";
    }
    inputDictionary[@"latestAfeVar"] = inputDictionary[@"variance"];    
    return inputDictionary;
}

-(BOOL)hasData:(NSString *)reportingMonth projectKey:(NSString *)projectKey
{
    ETGProjectSummary *targetProjectSummary = [self findOrCreateProjectSummary:reportingMonth projectKey:projectKey];
    if(targetProjectSummary == nil || targetProjectSummary.etgEccr_cps == nil)
    {
        return NO;
    }
    return YES;
}

-(ETGProjectSummary *)findOrCreateProjectSummary:(NSString *)reportingMonthString projectKey:(NSString *)projectKey
{
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"reportMonth == %@ AND projectKey == %@", [reportingMonthString toDate], projectKey];
    ETGProjectSummary* targetProjectSummary = [ETGProjectSummary findFirstWithPredicate:predicate inContext:context];
    if (targetProjectSummary == nil)
    {
        targetProjectSummary = [ETGProjectSummary createInContext:context];
        targetProjectSummary.reportMonth = [reportingMonthString toDate];
        targetProjectSummary.projectKey = @([projectKey integerValue]);
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    }
    return targetProjectSummary;
}

-(ETGProject *)findProject:(NSString *)projectKey
{
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"key == %@", projectKey];
    ETGProject* targetProject = [ETGProject findFirstWithPredicate:predicate inContext:context];
    return targetProject;
}

@end
