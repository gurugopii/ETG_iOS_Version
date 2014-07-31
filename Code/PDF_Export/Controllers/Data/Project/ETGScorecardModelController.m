//
//  PDFEModelController.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGWebServiceCommonImports.h"
#import "ETGScorecardModelController.h"
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
#import "ETGScoreCardManpower.h"
@class  ETGScoreCardTableSummary;

@interface ETGScorecardModelController () <ETGScoreCardTableSummaryDelegate>

@property (nonatomic, strong) ETGWebService* webService;
@property (nonatomic, strong) RKManagedObjectStore* managedObjectStore;
@property (nonatomic, strong) ETGScoreCardTableSummary* scorecardTable;
@property (nonatomic, strong) NSSet* jsonStringFromWebService;

@end

@implementation ETGScorecardModelController

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

- (void)getScorecardTableSummaryForReportingMonth:(NSString*)reportingMonth success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {
    
    // Create web service with mapping to model
    //ETGScoreCardTableSummary* card = [[ETGScoreCardTableSummary alloc] init];
    
    // Create request
    /*[card sendRequestWithReportingMonth:reportingMonth success:^(NSString* scorecard) {
        success(scorecard);
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeTimeStampInNSUserDefaults:[NSDate date] forModule:@"Scorecard"];
    } failure: ^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];*/
}

- (void)getScorecardTableSummaryOfflineForReportingMonth:(NSString*)reportingMonth withProjectKeys:(NSDictionary *)projectKeys success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {
    
    // Create web service with mapping to model
    ETGScoreCardTableSummary* card = [[ETGScoreCardTableSummary alloc] init];
    
    // Get stored data and create JSON
    [card fetchOfflineDataWithReportingMonth:reportingMonth withProjectKeys:projectKeys success:^(NSString* scorecard) {
        success(scorecard);
    } failure: ^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
}

#pragma mark - Production

- (void)getProductionTableSummaryForReportingMonth:(NSString*)reportingMonth withProjectKey:(NSNumber*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {

    // Create web service with mapping to model
    ETGScoreCardProduction* card = [[ETGScoreCardProduction alloc] init];
    
    // Create request
    [card fetchOfflineDataWithReportingMonth:reportingMonth withProjectKeys:projectKey success:^(NSString* scorecard) {
        success(scorecard);
    } failure:^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
    
}

#pragma mark - HSE

- (void)getHseTableSummaryForReportingMonth:(NSString*)reportingMonth withProjectKey:(NSNumber*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {
    
    // Create web service with mapping to model
    ETGScoreCardHSE* card = [[ETGScoreCardHSE alloc] init];
    
    // Create request
    [card fetchOfflineDataWithReportingMonth:reportingMonth withProjectKeys:projectKey success:^(NSString* scorecard) {
        success(scorecard);
    } failure:^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
    
}

#pragma mark - Manpower

- (void)getManpowerTableSummaryForReportingMonth:(NSString*)reportingMonth withProjectKey:(NSNumber*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {
    
    // Create web service with mapping to model
    ETGScoreCardManpower* card = [[ETGScoreCardManpower alloc] init];
    
    // Create request
    [card fetchOfflineDataWithReportingMonth:reportingMonth withProjectKeys:projectKey success:^(NSString* scorecard) {
        success(scorecard);
    } failure:^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
    
}

#pragma mark - Schedule

- (void)getScheduleTableSummaryForReportingMonth:(NSString*)reportingMonth withProjectKey:(NSNumber*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {
    
    // Create web service with mapping to model
    ETGScoreCardSchedule* card = [[ETGScoreCardSchedule alloc] init];
    
    // Create request
    [card fetchOfflineDataWithReportingMonth:reportingMonth withProjectKeys:projectKey success:^(NSString* scorecard) {
        success(scorecard);
    } failure:^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
    
}

#pragma mark - Cost PMU

- (void)getCostPmuTableSummaryForReportingMonth:(NSString*)reportingMonth withProjectKey:(NSNumber*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {
    
    // Create web service with mapping to model
    ETGScoreCardCostPMU* card = [[ETGScoreCardCostPMU alloc] init];
    
    // Create request
    [card fetchOfflineDataWithReportingMonth:reportingMonth withProjectKeys:projectKey success:^(NSString* scorecard) {
        success(scorecard);
    } failure:^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
    
}

#pragma mark - Cost PCSB

- (void)getCostPcsbTableSummaryForReportingMonth:(NSString*)reportingMonth withProjectKey:(NSNumber*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {
    
    // Create web service with mapping to model
    ETGScoreCardCostPCSB* card = [[ETGScoreCardCostPCSB alloc] init];
    
    // Create request
    [card fetchOfflineDataWithReportingMonth:reportingMonth withProjectKeys:projectKey success:^(NSString* scorecard) {
        success(scorecard);
    } failure:^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
    
}

-(void)getProjectBackgroundTableSummaryForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSString *)projectKey success:(void (^)(NSMutableArray *projectBackground))success failure:(void (^)(NSError *))failure {
    // Create web service with mapping to model
    ETGScoreCardAboutProject* card = [[ETGScoreCardAboutProject alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"ReportingMonth"];
    [params setObject:projectKey forKey:@"ProjectKey"];
    [card sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSMutableArray *projectBackground) {
        success(projectBackground);
    } failure: ^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
}

-(void)getKeyHighlightsSummaryForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSString *)projectKey success:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPSCKeyHighLights* keyHighlights = [[ETGPSCKeyHighLights alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:projectKey forKey:@"ProjectKey"];
    [params setObject:reportingMonth forKey:@"ReportingMonth"];
    [keyHighlights sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSMutableArray *keyHighlights) {
        success(keyHighlights);
    } failure: ^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
    
}

//Offline
-(void)getKeyHighlightsSummaryOfflineForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSDictionary *)projectKey success:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGPSCKeyHighLights* keyHighlights = [[ETGPSCKeyHighLights alloc] init];
    
    // Create request
    [keyHighlights fetchOfflineDataWithReportingMonth:reportingMonth projectKey:projectKey success:^(NSMutableArray *keyHighlights) {
        success(keyHighlights);
    } failure: ^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
    
}

-(void)getProjectBackgroundTableSummaryOfflineForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSString *)projectKey success:(void (^)(NSMutableArray *projectBackground))success failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGScoreCardAboutProject* card = [[ETGScoreCardAboutProject alloc] init];
    
    // Create request
    [card fetchOfflineDataWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(NSMutableArray *projectBackground) {
        success(projectBackground);
    } failure: ^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
}

-(NSString *)getProjectPopover {
    NSError *error;
    NSDictionary *popoverList;
    
    if (_enableReportFromScorecard == nil) {
        popoverList = @{@"chartview":@"Chart View",@"keyhighlight":@"Key Highlights",@"projectBackground":@"Project Background",@"disableproject":@"DisabledProject"};
        
    }else{
        popoverList = @{@"chartview":@"Chart View",@"keyhighlight":@"Key Highlights",@"projectBackground":@"Project Background"};
        
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:popoverList options:0 error:&error];
    NSString *projectPopover;
    
    if (!jsonData) {
        DDLogWarn(@"%@%@", logWarnPrefix, [NSString stringWithFormat:gotError, error]);
    } else {
        projectPopover = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return projectPopover;
}

- (void)getScorecardTableSummaryForReportingMonth:(NSString*)reportingMonth
                                         pageSize:(int)pageSize
                                       pageNumber:(int)pageNumber
                         isSelectedReportingMonth:(BOOL)isSelectedReportingMonth
                               filteredDictionary:(NSMutableDictionary*)filteredDictionary
                                          success:(void (^)(NSString* scorecards))success
                                          failure:(void (^)(NSError *error))failure{
    ETGScoreCardTableSummary* card = [[ETGScoreCardTableSummary alloc] init];
    card.delegate = self;
    [card sendRequestWithReportingMonth:reportingMonth pageSize:pageSize pageNumber:pageNumber isSelectedReportingMonth:isSelectedReportingMonth filteredDictionary:filteredDictionary success:^(NSString* scorecard) {
        success(scorecard);
        
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeTimeStampInNSUserDefaults:[NSDate date] forModule:@"Scorecard"];
    } failure: ^(NSError * error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix, error.description);
    }];
}

#pragma mark - ScorecardTableSummary

- (void)appendJSONToInterface:(NSSet *)jsonString {
    _jsonStringFromWebService = jsonString;
//    if ([self.delegate respondsToSelector:@selector(appendJSONToViewController:)]) {
        [self.delegate appendJSONToViewController:_jsonStringFromWebService];
//    }
}

- (void)appendJSONOfLastPageToInterface:(NSSet *)jsonString {
    _jsonStringFromWebService = jsonString;
//    if ([self.delegate respondsToSelector:@selector(appendJSONOfLastPageToViewController:)]) {
        [self.delegate appendJSONOfLastPageToViewController:_jsonStringFromWebService];
//    }
}

- (void)appendJSONOfCurrentPageToInterface:(NSSet *)jsonString withError:(NSError *)error {
    _jsonStringFromWebService = jsonString;
//    if ([self.delegate respondsToSelector:@selector(appendJSONOfCurrentPageToViewController:)]) {
        [self.delegate appendJSONOfCurrentPageToViewController:_jsonStringFromWebService withError:error];
//    }
}

@end
