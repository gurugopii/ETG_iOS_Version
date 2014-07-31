//
//  ETGPortfolioModelController.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
#import "ETGPortfolioModelController.h"
#import "ETGWebServiceCommonImports.h"
//Models
#import "ETGAllPortfolios.h"
#import "ETGPortfolioHydrocarbon.h"
#import "ETGPortfolioHSE.h"
#import "ETGPortfolioProductionRTBD.h"
#import "ETGPortfolioCpb.h"
#import "ETGPortfolioApc.h"
#import "ETGPortfolioWpb.h"

@interface ETGPortfolioModelController ()

@property (nonatomic, strong) ETGWebService* webService;
@property (nonatomic, strong) RKManagedObjectStore* managedObjectStore;

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


/** Portfolio Methods**/
- (void)getPortfolioTableSummaryForReportingMonth:(NSString *)reportingMonth
                                       withUserId:(NSString *)userId
                                          success:(void (^)(NSString * ))success
                                          failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGAllPortfolios *portfolio = [[ETGAllPortfolios alloc] init];
    
    [portfolio sendRequestWithReportingMonth:reportingMonth userId:userId success:^(NSString *portfolioData) {
        success(portfolioData);
    } failure: ^(NSError * error) {
        failure(error);
    }];
}
/** End Portfolio Methods**/

/** Portfolio Hydrocarbon Methods**/
-(void) getPortfolioHydrocarbonLevel2ForReportingMonth:(NSString *)reportingMonth
                                  withProjectKey:(NSString *)projectKey
                                         success:(void (^)(NSString *))success
                                         failure:(void (^)(NSError *))failure {
    
    ETGPortfolioHydrocarbon *hydrocarbonLevel2 = [[ETGPortfolioHydrocarbon alloc] init];
    [hydrocarbonLevel2 getLevel2DataForReportingMonth:reportingMonth
                                           projectKey:[NSNumber numberWithInteger:[projectKey integerValue]]
                                              success:^(NSString *jsonData) {
        success(jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];
}

-(void) getPortfolioHydrocarbonForReportingMonth:(NSString *)reportingMonth
                                  withProjectKey:(NSString *)projectKey
                                         success:(void (^)(NSString *))success
                                         failure:(void (^)(NSError *))failure {

    // Create web service with mapping to model
    ETGPortfolioHydrocarbon *hydrocarbon = [[ETGPortfolioHydrocarbon alloc] init];
    
    [hydrocarbon sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString *hydrocarbonData) {
        success(hydrocarbonData);
    } failure: ^(NSError *error) {
        failure(error);
    }];

}
/** End Portfolio Hydrocarbon Methods**/

/** Portfolio HSE Methods**/
- (void)getPortfolioHseLevel2ForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSString *))success
                                 failure:(void (^)(NSError *))failure  {
    
    ETGPortfolioHSE *hseLevel2 = [[ETGPortfolioHSE alloc] init];
    [hseLevel2 getLevel2DataForReportingMonth:reportingMonth
                                           projectKey:[NSNumber numberWithInteger:[projectKey integerValue]]
                                              success:^(NSString *jsonData) {
        success(jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];
}

- (void)getPortfolioHseForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSString *))success
                                 failure:(void (^)(NSError *))failure  {
    
    // Create web service with mapping to model
    ETGPortfolioHSE *hse = [[ETGPortfolioHSE alloc] init];
    
    [hse sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString *hseData) {
        success(hseData);
    } failure: ^(NSError *error) {
        failure(error);
    }];
    
}
/** End Portfolio HSE Methods**/

/** Portfolio Production and RTBD Methods**/
- (void)getPortfolioProdAndRtbdLevel2ForReportingMonth:(NSString *)reportingMonth
                                  withProjectKey:(NSString *)projectKey
                                         success:(void (^)(NSString *))success
                                         failure:(void (^)(NSError *))failure {
    
    ETGPortfolioProductionRTBD *rtbdLevel2 = [[ETGPortfolioProductionRTBD alloc] init];
    [rtbdLevel2 getLevel2DataForReportingMonth:reportingMonth
                                   projectKey:[NSNumber numberWithInteger:[projectKey integerValue]]
                                      success:^(NSString *jsonData) {
        success(jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];
}

- (void)getPortfolioProdAndRtbdForReportingMonth:(NSString *)reportingMonth
                                  withProjectKey:(NSString *)projectKey
                                         success:(void (^)(NSString *))success
                                         failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioProductionRTBD *prodAndRtbd = [[ETGPortfolioProductionRTBD alloc] init];
    
    [prodAndRtbd sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString *prodAndRtbdData) {
        success(prodAndRtbdData);
    } failure: ^(NSError *error) {
        failure(error);
    }];
    
}
/** End Portfolio Production and RTBD Methods**/

/** Portfolio CPB Methods**/
- (void)getPortfolioCpbLevel2ForReportingMonth:(NSString *)reportingMonth
                          withProjectKey:(NSString *)projectKey
                                 success:(void (^)(NSString *))success
                                 failure:(void (^)(NSError *))failure {
    
    ETGPortfolioCpb *cpbLevel2 = [[ETGPortfolioCpb alloc] init];
    [cpbLevel2 getLevel2DataForReportingMonth:reportingMonth
                                   projectKey:[NSNumber numberWithInteger:[projectKey integerValue]]
                                      success:^(NSString *jsonData) {
        success(jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];
}

- (void)getPortfolioCpbForReportingMonth:(NSString *)reportingMonth
                          withProjectKey:(NSString *)projectKey
                                 success:(void (^)(NSString *))success
                                 failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioCpb *cpb = [[ETGPortfolioCpb alloc] init];
    
    [cpb sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString *cpbData) {
        success(cpbData);
    } failure: ^(NSError *error) {
        failure(error);
    }];
    
}
/** End Portfolio CPB Methods**/

/** Portfolio APC Methods**/
- (void)getPortfolioApcLevel2ForReportingMonth:(NSString *)reportingMonth
                          withProjectKey:(NSString *)projectKey
                                 success:(void (^)(NSString *))success
                                 failure:(void (^)(NSError *))failure {
    
    ETGPortfolioApc *apcLevel2 = [[ETGPortfolioApc alloc] init];
    [apcLevel2 getLevel2DataForReportingMonth:reportingMonth
                                   projectKey:[NSNumber numberWithInteger:[projectKey integerValue]]
                                      success:^(NSString *jsonData) {
        success(jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];
}

- (void)getPortfolioApcForReportingMonth:(NSString *)reportingMonth
                          withProjectKey:(NSString *)projectKey
                                 success:(void (^)(NSString *))success
                                 failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioApc *apc = [[ETGPortfolioApc alloc] init];
    
    [apc sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString *apcData) {
        success(apcData);
    } failure: ^(NSError *error) {
        failure(error);
    }];
    
}
/** End Portfolio APC Methods**/

/** Portfolio WPB Methods**/
- (void)getPortfolioWpbLevel2ForReportingMonth:(NSString *)reportingMonth
                          withProjectKey:(NSString *)projectKey
                                 success:(void (^)(NSString *))success
                                 failure:(void (^)(NSError *))failure {
    
    ETGPortfolioWpb *wpbLevel2 = [[ETGPortfolioWpb alloc] init];
    [wpbLevel2 getLevel2DataForReportingMonth:reportingMonth
                                   projectKey:[NSNumber numberWithInteger:[projectKey integerValue]]
                                      success:^(NSString *jsonData) {
        success(jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];
}

- (void)getPortfolioWpbForReportingMonth:(NSString *)reportingMonth
                          withProjectKey:(NSString *)projectKey
                                 success:(void (^)(NSString *))success
                                 failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPortfolioWpb *wpb = [[ETGPortfolioWpb alloc] init];
    
    [wpb sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString *apcData) {
        success(apcData);
    } failure: ^(NSError *error) {
        failure(error);
    }];
    
}
/** End Portfolio WPB Methods**/

@end
