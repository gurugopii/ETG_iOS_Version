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
#import "ETGFilters.h"

@interface ETGScorecardModelController ()

@property (nonatomic, strong) ETGWebService* webService;
@property (nonatomic, strong) RKManagedObjectStore* managedObjectStore;

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

- (void)getScorecardTableSummaryForReportingMonth:(NSString*)reportingMonth withUserId:(NSString*)userId success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure {
    
    // Create web service with mapping to model
    ETGScoreCardTableSummary* card = [[ETGScoreCardTableSummary alloc] init];

    // Get stored data and create JSON
    [card fetchOfflineDataWithReportingMonth:reportingMonth success:^(NSString* scorecard) {
        success(scorecard);
    } failure: ^(NSError * error) {
        failure(error);
    }];
    
    // Check if timestamp is more than a day
    BOOL isTimeStampMoreThanADay = [[ETGUserDefaultManipulation sharedUserDefaultManipulation]
                                    isTimeStampMoreThanADayForModule:@"Scorecard"];
    
    if (isTimeStampMoreThanADay) {
        // Create request
        [card sendRequestWithReportingMonthAndReturnJson:reportingMonth userId:userId success:^(NSString* scorecard) {
            success(scorecard);
            [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeTimeStampInNSUserDefaults:[NSDate date] forModule:@"Scorecard"];
        } failure: ^(NSError * error) {
            failure(error);
        }];
    }
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

-(void)getProjectBackgroundTableSummaryForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSString *)projectKey success:(void (^)(void))success failure:(void (^)(NSError *))failure {
    // Create web service with mapping to model
    ETGScoreCardAboutProject* card = [[ETGScoreCardAboutProject alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"ReportingMonth"];
    [params setObject:projectKey forKey:@"ProjectKey"];
    [card sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] success:^(void) {
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
    }];

}

-(void)getBaseFiltersSummaryForReportingMonth:(NSString *)reportingMonth withUserId:(NSString *)userId success:(void (^)(void))success failure:(void (^)(NSError *))failure {
    
    // Create web service with mapping to model
    ETGFilters* filters = [[ETGFilters alloc] init];
    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"ReportingMonth"];
    [params setObject:userId forKey:@"PetronasUsrId"];
    [filters sendRequestWithReportingMonth:reportingMonth userId:userId success:^(void) {
    } failure: ^(NSError * error) {
        failure(error);
    }];

}

-(NSString *)getProjectPopover {
    NSError *error;
    NSDictionary *popoverList = @{@"chartview":@"Chart View",@"keyhighlight":@"Key Highlights",@"projectBackground":@"Project Background"};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:popoverList options:0 error:&error];
    NSString *projectPopover;
    
    if (!jsonData) {
        
        NSLog(@"Got an error: %@", error);
    } else {
        projectPopover = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return projectPopover;
}

@end
