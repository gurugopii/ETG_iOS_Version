//
//  PDFEModelController.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGWebServiceCommonImports.h"
#import "ETGModelController.h"
// Models
#import "ETGPSCKeyHighLights.h"
#import "ETGScoreCardAboutProject.h"
#import "ETGScoreCardCostPCSB.h"
#import "ETGScoreCardCostPMU.h"
#import "ETGScoreCardHSE.h"
#import "ETGScoreCardSchedule.h"
#import "ETGScoreCardTableSummary.h"
#import "ETGScoreCardProduction.h"
#import "ETGPSCKeyHighLights.h"

@interface ETGModelController ()

@property (nonatomic, strong) ETGWebService* webService;
@property (nonatomic, strong) RKManagedObjectStore* managedObjectStore;

@end

@implementation ETGModelController

@synthesize webService = _webService;
@synthesize managedObjectStore = _managedObjectStore;

+ (instancetype)sharedModel {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        // Set web service
        self.webService = [ETGWebService sharedWebService];
    }
    return self;
}

- (void)getScorecardTableSummaryForReportingMonth:(NSString*)reportingMonth withUserId:(NSString*)userId success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {
    // Create web service with mapping to model
    ETGScoreCardTableSummary* card = [[ETGScoreCardTableSummary alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"ReportingMonth"];
    [params setObject:userId forKey:@"PetronasUsrId"];
    [card sendRequestWithReportingMonth:reportingMonth userId:userId success:^(NSString* scorecard) {
        success(scorecard);
    } failure: ^(NSError * error) {
        failure(error);
    }];
}

- (void)getProductionTableSummaryForReportingMonth:(NSString*)reportingMonth withProjectKey:(NSString*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {
    // Create web service with mapping to model
    ETGScoreCardProduction* card = [[ETGScoreCardProduction alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"ReportingMonth"];
    [params setObject:projectKey forKey:@"ProjectKey"];
    [card sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString* scorecard) {
        success(scorecard);
    } failure: ^(NSError * error) {
        failure(error);
    }];
}

- (void)getHseTableSummaryForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSString *)projectKey success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure
{
    // Create web service with mapping to model
    ETGScoreCardHSE* card = [[ETGScoreCardHSE alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"ReportingMonth"];
    [params setObject:projectKey forKey:@"ProjectKey"];
    [card sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString* scorecard) {
        success(scorecard);
    } failure: ^(NSError * error) {
        failure(error);
    }];
}

- (void)getScheduleTableSummaryForReportingMonth:(NSString*)reportingMonth withProjectKey:(NSString*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure
{
    // Create web service with mapping to model
    ETGScoreCardSchedule* card = [[ETGScoreCardSchedule alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"ReportingMonth"];
    [params setObject:projectKey forKey:@"ProjectKey"];
    [card sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString* scorecard) {
        success(scorecard);
    } failure: ^(NSError * error) {
        failure(error);
    }];
}

- (void)getAboutProjectForProjectKey:(NSString*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure
{
    // Create web service with mapping to model
    ETGScoreCardAboutProject* card = [[ETGScoreCardAboutProject alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:projectKey forKey:@"ProjectKey"];
    [card sendRequestWithProjectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString* scorecard) {
        success(scorecard);
    } failure: ^(NSError * error) {
        failure(error);
    }];
}

- (void)getCostPmuTableSummaryForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSString *)projectKey success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {

    // Create web service with mapping to model
    ETGScoreCardCostPMU* costPmu = [[ETGScoreCardCostPMU alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:projectKey forKey:@"ProjectKey"];
    [costPmu sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString* costPmu) {
        success(costPmu);
    } failure: ^(NSError * error) {
        failure(error);
    }]; 

}

- (void)getCostPcsbTableSummaryForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSString *)projectKey success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {

    // Create web service with mapping to model
    ETGScoreCardCostPCSB* costPcsb = [[ETGScoreCardCostPCSB alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:projectKey forKey:@"ProjectKey"];
    [costPcsb sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString* costPmu) {
        success(costPmu);
    } failure: ^(NSError * error) {
        failure(error);
    }];
}

-(void)getKeyHighlightsSummaryForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSString *)projectKey success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPSCKeyHighLights* keyHighlights = [[ETGPSCKeyHighLights alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:projectKey forKey:@"ProjectKey"];
    [keyHighlights sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSString* keyHighlights) {
        success(keyHighlights);
    } failure: ^(NSError * error) {
        failure(error);
    }];

}

@end
