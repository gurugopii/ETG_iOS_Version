//
//  ETGPortfolioModelController.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
#import "ETGPortfolioModelController.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGPortfolioData.h"
//Models
#import "ETGAllPortfolios.h"
#import "ETGPortfolioHydrocarbon.h"
#import "ETGPortfolioHSE.h"
#import "ETGPortfolioProductionRTBD.h"
#import "ETGPortfolioCpb.h"
#import "ETGPortfolioApc.h"
#import "ETGPortfolioWpb.h"
#import "ETGPortfolioMLH.h"

@interface ETGPortfolioModelController ()

@property (nonatomic, strong) ETGWebService* webService;
@property (nonatomic, strong) RKManagedObjectStore* managedObjectStore;
@property (nonatomic, strong) NSMutableArray *enableReports;
@property (nonatomic, strong) NSString *reportName;
@property (nonatomic) BOOL timestampAgeMoreThanOneDay;

@end

@implementation ETGPortfolioModelController

+ (instancetype)sharedModel {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(id)init {
    self = [super init];
    if (self) {
        // Set web service
        self.webService = [ETGWebService sharedWebService];
    }
    return self;
}

#pragma mark - Portfolio Online Data Request
/** Portfolio Methods**/
//UAC
- (void)populateEnableReportsArray:(NSDictionary *)enablePortfolioReports {
    
    _enableReports = [NSMutableArray array];
    for(NSDictionary *rec in enablePortfolioReports) {
        [_enableReports addObject:rec];
    }
}

//- (void)getPortfolioReportNameForReport:(NSString *)reportName {
//    _reportName = reportName;
//}

- (BOOL)isPortfolioReportEnabledForReportName:(NSString *)reportName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", reportName];
    NSArray *foundReport = [_enableReports filteredArrayUsingPredicate:predicate];
    
    if ([foundReport count]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isPortfolioTableReportEnabledForReportName:(NSString *)reportName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", reportName];
    NSArray *foundReport = [_enableReports filteredArrayUsingPredicate:predicate];
    
    BOOL isEnabled = NO;
    if ([foundReport count]) {
        NSString *tableReportStatus = [NSString stringWithFormat:@"%@", [[foundReport objectAtIndex:0] valueForKeyPath:@"popup.status"]];
        if ([tableReportStatus isEqualToString:@"I"]) {
            isEnabled = NO;
        } else {
            isEnabled = YES;
        }
        return isEnabled;
    } else {
        return isEnabled;
    }
}

- (void)getPortfolioTableSummaryForReportingMonth:(NSString *)reportingMonth
                                       withUserId:(NSString *)userId
                                          success:(void (^)(NSString * ))success
                                          failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGAllPortfolios *portfolio = [[ETGAllPortfolios alloc] init];
    
    [portfolio sendRequestWithReportingMonth:reportingMonth success:^(NSString *portfolioData) {
        success(portfolioData);
    } failure: ^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
}

- (void)deletePortfolioTableSummaryForReportingMonth:(NSString *)reportingMonth
                                       withUserId:(NSString *)userId
                                          success:(void (^)(bool))success
                                          failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGAllPortfolios *portfolio = [[ETGAllPortfolios alloc] init];
    
    [portfolio removeDuplicatesForReportingMonth:reportingMonth withUserId:userId success:^(bool removed) {
        success(removed);
    } failure:^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
}

/** End Portfolio Methods**/

/** Portfolio Hydrocarbon Methods**/
-(void) getPortfolioHydrocarbonForReportingMonth:(NSString *)reportingMonth
                                  withProjectKey:(NSString *)projectKey
                                         success:(void (^)(NSMutableArray *))success
                                         failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioHydrocarbon *hydrocarbon = [[ETGPortfolioHydrocarbon alloc] init];
    // Create request
    // Data download prerequisites check
//    BOOL dataDownloadErrorOccured = NO;
//    if([hydrocarbon uacCanSeeReport:reportingMonth] == YES){
//        if ([hydrocarbon entityIsEmpty] == NO){
//            if(_timestampAgeMoreThanOneDay == YES){
//                [hydrocarbon setBaseFilters];
//            }
//            dataDownloadErrorOccured = NO;
//        }
//    } else {
//        dataDownloadErrorOccured = YES;
//    }
//    
//    // Data download execution
//    if (dataDownloadErrorOccured == NO) {

    //UAC for Report
//    [hydrocarbon setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];

    // Create request
    [hydrocarbon sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSMutableArray *hydrocarbonData) {
        success(hydrocarbonData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
        //    }
//    } else {
//        DDLogError(@"%@%@", logErrorPrefix, noDataFoundError);
//    }
    //    }
}
/** End Portfolio Hydrocarbon Methods**/

/** Portfolio HSE Methods**/
- (void)getPortfolioHseForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSMutableDictionary *))success
                                 failure:(void (^)(NSError *))failure  {
    
    // Create web service with mapping to model
    ETGPortfolioHSE *hse = [[ETGPortfolioHSE alloc] init];
    
    // Data download prerequisites check
//    BOOL dataDownloadErrorOccured = NO;
//    if([hse uacCanSeeReport:reportingMonth] == YES){
//        if ([hse entityIsEmpty] == NO){
//            if(_timestampAgeMoreThanOneDay == YES){
//                [hse setBaseFilters];
//            }
//            dataDownloadErrorOccured = NO;
//        }
//    } else {
//        dataDownloadErrorOccured = YES;
//    }
//    
//    // Data download execution
//    if (dataDownloadErrorOccured == NO) {
    
    //UAC for Report
//    [hse setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];

    [hse sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSMutableDictionary *hseData) {
        success(hseData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
//    } else {
//        DDLogError(@"%@%@", logErrorPrefix, noDataFoundError);
//    }
    
}

/** End Portfolio Hydrocarbon Methods**/


/** Portfolio MLH Methods**/
- (void)getPortfolioMlhForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSMutableDictionary *))success
                                 failure:(void (^)(NSError *))failure  {
    
    // Create web service with mapping to model
    ETGPortfolioMLH *mlh = [[ETGPortfolioMLH alloc] init];
    
    [mlh sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSMutableDictionary *hseData) {
        success(hseData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
    
}
/** End Portfolio MLH Methods**/

/** Portfolio Production and RTBD Methods**/
- (void)getPortfolioProdAndRtbdForReportingMonth:(NSString *)reportingMonth
                                  withProjectKey:(NSString *)projectKey
                                         success:(void (^)(NSMutableDictionary *))success
                                         failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioProductionRTBD *prodAndRtbd = [[ETGPortfolioProductionRTBD alloc] init];
    
    // Data download prerequisites check
//    BOOL dataDownloadErrorOccured = NO;
//    if([prodAndRtbd uacCanSeeReport:reportingMonth] == YES){
//        if ([prodAndRtbd entityIsEmpty] == NO){
//            if(_timestampAgeMoreThanOneDay == YES){
//                [prodAndRtbd setBaseFilters];
//            }
//            dataDownloadErrorOccured = NO;
//        }
//    } else {
//        dataDownloadErrorOccured = YES;
//    }
//    
//    // Data download execution
//    if (dataDownloadErrorOccured == NO) {
    
    //UAC for Report
//    [prodAndRtbd setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];

    [prodAndRtbd sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSMutableDictionary *prodAndRtbdData) {
        success(prodAndRtbdData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
//    } else {
//        DDLogError(@"%@%@", logErrorPrefix, noDataFoundError);
//    }
    
}

/** End Portfolio Production and RTBD Methods**/

/** Portfolio CPB Methods**/
- (void)getPortfolioCpbForReportingMonth:(NSString *)reportingMonth
                          withProjectKey:(NSString *)projectKey
                                 success:(void (^)(NSMutableDictionary *))success
                                 failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioCpb *cpb = [[ETGPortfolioCpb alloc] init];
    
    // Data download prerequisites check
//    BOOL dataDownloadErrorOccured = NO;
//    if([cpb uacCanSeeReport:reportingMonth] == YES){
//        if ([cpb entityIsEmpty] == NO){
//            // Put timestamp checking here...
//            if(_timestampAgeMoreThanOneDay == YES){
//                [cpb setBaseFilters];
//            }
//            dataDownloadErrorOccured = NO;
//        }
//    } else {
//        dataDownloadErrorOccured = YES;
//    }
//    
//    // Data download execution
//    if (dataDownloadErrorOccured == NO) {
    
    //UAC for Report
//    [cpb setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];
//    [cpb setIsTableReportEnabledFlagTo:[self isPortfolioTableReportEnabledForReportName:_reportName]];

    [cpb sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSMutableDictionary *cpbData) {
        success(cpbData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
//    } else {
//        DDLogError(@"%@%@", logErrorPrefix, noDataFoundError);
//    }
    
}
/** End Portfolio CPB Methods**/

/** Portfolio APC Methods**/
- (void)getPortfolioApcForReportingMonth:(NSString *)reportingMonth
                          withProjectKey:(NSString *)projectKey
                                 success:(void (^)(NSMutableDictionary *))success
                                 failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioApc *apc = [[ETGPortfolioApc alloc] init];
    
    // Data download prerequisites check
//    BOOL dataDownloadErrorOccured = NO;
//    if([apc uacCanSeeReport:reportingMonth] == YES){
//        if ([apc entityIsEmpty] == NO){
//            if(_timestampAgeMoreThanOneDay == YES){
//                [apc setBaseFilters];
//            }
//            dataDownloadErrorOccured = NO;
//        }
//    } else {
//        dataDownloadErrorOccured = YES;
//    }
//    
//    // Data download execution
//    if (dataDownloadErrorOccured == NO) {

    //UAC for Report
//    [apc setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];
//    [apc setIsTableReportEnabledFlagTo:[self isPortfolioTableReportEnabledForReportName:_reportName]];

    [apc sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSMutableDictionary *apcData) {
        success(apcData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
//    } else {
//        DDLogError(@"%@%@", logErrorPrefix, noDataFoundError);
//    }
    
}
/** End Portfolio APC Methods**/

/** Portfolio WPB Methods**/
- (void)getPortfolioWpbForReportingMonth:(NSString *)reportingMonth
                          withProjectKey:(NSString *)projectKey
                                 success:(void (^)(NSMutableDictionary *))success
                                 failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioWpb *wpb = [[ETGPortfolioWpb alloc] init];
    
    // Data download prerequisites check
//    BOOL dataDownloadErrorOccured = NO;
//    if([wpb uacCanSeeReport:reportingMonth] == YES){
//        if ([wpb entityIsEmpty] == NO){
//            if(_timestampAgeMoreThanOneDay == YES){
//                [wpb setBaseFilters];
//            }
//            dataDownloadErrorOccured = NO;
//        }
//    } else {
//        dataDownloadErrorOccured = YES;
//    }
//    
//    // Data download execution
//    if (dataDownloadErrorOccured == NO) {

    //UAC for Report
//    [wpb setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];
//    [wpb setIsTableReportEnabledFlagTo:[self isPortfolioTableReportEnabledForReportName:_reportName]];

    [wpb sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSMutableDictionary *apcData) {
        success(apcData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
//    } else {
//        DDLogError(@"%@%@", logErrorPrefix, noDataFoundError);
//    }
    
}
/** End Portfolio WPB Methods**/

- (void)setTimestampAgeMoreThanOneDay:(BOOL)boolValue{
    _timestampAgeMoreThanOneDay = boolValue;
}

// Collect JSON Methods

- (void)collectPortfolioProdAndRtbdForReportingMonth:(NSSet *)cachedData
                                             success:(void (^)(NSMutableDictionary *))success
                                             failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioProductionRTBD *prodAndRtbd = [[ETGPortfolioProductionRTBD alloc] init];
    
    //UAC for Report
//    [prodAndRtbd setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];

    [prodAndRtbd collectReportJSONFrom:cachedData success:^(NSMutableDictionary *prodAndRtbdData) {
        success(prodAndRtbdData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
}

- (void)collectPortfolioApcForReportingMonth:(NSSet *)cachedData
                             withTableReport:(BOOL)yesNo
                                     success:(void (^)(NSMutableDictionary *))success
                                     failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioApc *apc = [[ETGPortfolioApc alloc] init];
    
//    //UAC for Report
//    [apc setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];
//
//    //UAC for Table Report
//    [apc setIsTableReportEnabledFlagTo:[self isPortfolioTableReportEnabledForReportName:_reportName]];

    [apc collectReportJSONFrom:cachedData withTableReport:yesNo success:^(NSMutableDictionary *apcData) {
        success(apcData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
}

- (void)collectPortfolioCpbForReportingMonth:(NSSet *)cachedData
                              reportingMonth:(NSString *)reportingMonth
                             withTableReport:(BOOL)yesNo
                                     success:(void (^)(NSMutableDictionary *))success
                                     failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioCpb *cpb = [[ETGPortfolioCpb alloc] init];
   
//    //UAC for Report
//    [cpb setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];
//
//    //UAC for Table Report
//    [cpb setIsTableReportEnabledFlagTo:[self isPortfolioTableReportEnabledForReportName:_reportName]];

    [cpb collectReportJSONFrom:cachedData reportingMonth:reportingMonth withTableReport:yesNo success:^(NSMutableDictionary *cpbData) {
        success(cpbData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
}

- (void)collectPortfolioHseForReportingMonth:(NSSet *)cachedData
                                     success:(void (^)(NSMutableDictionary *))success
                                     failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioHSE *hse = [[ETGPortfolioHSE alloc] init];
    
    //UAC for Report
//    [hse setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];

    [hse collectReportJSONFrom:cachedData success:^(NSMutableDictionary *hseData) {
        success(hseData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
}

- (void)collectPortfolioMlhForReportingMonth:(NSSet *)cachedData
                              reportingMonth:(NSString*)reportingMonth
                                     success:(void (^)(NSMutableDictionary *))success
                                     failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioMLH *mlh = [[ETGPortfolioMLH alloc] init];
    
    //UAC for Report
    //    [hse setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];
    
    [mlh collectReportJSONFrom:cachedData reportingMonth:reportingMonth success:^(NSMutableDictionary *hseData) {
        success(hseData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
}

-(void) collectPortfolioHydrocarbonForReportingMonth:(NSSet *)cachedData
                                             success:(void (^)(NSMutableArray *))success
                                             failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioHydrocarbon *hydrocarbon = [[ETGPortfolioHydrocarbon alloc] init];
    
    //UAC for Report
//    [hydrocarbon setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];

    [hydrocarbon collectReportJSONFrom:cachedData success:^(NSMutableArray *hydrocarbonData) {
        success(hydrocarbonData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
    
}

- (void)collectPortfolioWpbForReportingMonth:(NSSet *)cachedData
                              reportingMonth:(NSString *)reportingMonth
                             withTableReport:(BOOL)yesNo
                                     success:(void (^)(NSMutableDictionary *))success
                                     failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioWpb *wpb = [[ETGPortfolioWpb alloc] init];
    
//    //UAC for Report
//    [wpb setIsReportEnabledFlagTo:[self isPortfolioReportEnabledForReportName:_reportName]];
//
//    //UAC for Table Report
//    [wpb setIsTableReportEnabledFlagTo:[self isPortfolioTableReportEnabledForReportName:_reportName]];

    [wpb collectReportJSONFrom:cachedData reportingMonth:reportingMonth withTableReport:yesNo success:^(NSMutableDictionary *apcData) {
        success(apcData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
    
}


- (void)setQueuepriorityForScorecard:(NSString *)reportingMonth
{
    
    @try{
        // NSLog(@"Setting normal priority background download for reporting month(Portfolio Dashboard) %@", reportingMonth);
        // Set normal priority for background download
        
        for (RKObjectRequestOperation* operation in [[RKObjectManager sharedManager].operationQueue operations]) {
            
            if(![operation isKindOfClass:[NSBlockOperation class]]){
                
                if ([operation.HTTPRequestOperation.request.URL.path rangeOfString:@"ScoreCardBatchSummary"].location == NSNotFound) {
                    [operation setQueuePriority:NSOperationQueuePriorityNormal];
                } else {
                    
                    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
                }
            }else{
                
                NSOperation *convertedOperation = (NSOperation*)operation;
                [convertedOperation setQueuePriority:NSOperationQueuePriorityVeryHigh];
            }
        }
    }
    @catch (NSException *ex) {
        NSLog(@"%@", ex.description);
    }
}

- (void)setQueuepriorityForPortfolioGraph:(NSString*)reportingMonth
{
    @try{
        //NSLog(@"Setting low priority background download for reporting month(Portfolio Dashboard) %@", reportingMonth);
        // Set normal priority for background download
        
        NSDictionary *dict = [[RKObjectManager sharedManager].operationQueue operations];
        
        for (RKObjectRequestOperation* operation in [[RKObjectManager sharedManager].operationQueue operations]) {
            
            if(![operation isKindOfClass:[NSBlockOperation class]]){
                
                if ([operation.HTTPRequestOperation.request.URL.path rangeOfString:@"ScoreCardBatchSummary"].location == NSNotFound) {
                    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
                    
                } else {
                    [operation setQueuePriority:NSOperationQueuePriorityNormal];
                    
                }
            }else{
                
                NSOperation *convertedOperation = (NSOperation*)operation;
                [convertedOperation setQueuePriority:NSOperationQueuePriorityVeryHigh];
            }
            
        }
    }
    @catch (NSException *ex) {
        NSLog(@"%@", ex.description);
    }
}

@end
