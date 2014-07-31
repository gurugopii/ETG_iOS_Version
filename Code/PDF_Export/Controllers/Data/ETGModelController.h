//
//  ETGModelController.h
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETGScoreCardProduction.h"
#import "ETGScoreCardTableSummary.h"

@interface ETGModelController : NSObject

#pragma mark - Model Controller Class methods
+ (instancetype)sharedModel;

// Temp method
- (void)syncScoreCardTableSummary;
- (void)syncScoreCardProduction;

#pragma mark - Web service accessors
- (void)getScorecardTableSummaryForReportingMonth:(NSString*)reportingMonth
                                       withUserId:(NSString*)userId
                                          success:(void (^)(NSString* jsonString))success
                                          failure:(void (^)(NSError *error))failure;

- (void)getProductionTableSummaryForReportingMonth:(NSString*)reportingMonth
                                    withProjectKey:(NSString*)projectKey
                                           success:(void (^)(NSString* jsonString))success
                                           failure:(void (^)(NSError *error))failure;

- (void)getHseTableSummaryForReportingMonth:(NSString*)reportingMonth
                             withProjectKey:(NSString*)projectKey
                                    success:(void (^)(NSString* jsonString))success
                                    failure:(void (^)(NSError *error))failure;

- (void)getScheduleTableSummaryForReportingMonth:(NSString*)reportingMonth
                                  withProjectKey:(NSString*)projectKey
                                         success:(void (^)(NSString* jsonString))success
                                         failure:(void (^)(NSError *error))failure;

- (void)getAboutProjectForProjectKey:(NSString*)projectKey
                             success:(void (^)(NSString* jsonString))success
                             failure:(void (^)(NSError *error))failure;

- (void)getCostPcsbTableSummaryForReportingMonth:(NSString*)reportingMonth
                                  withProjectKey:(NSString*)projectKey
                                         success:(void (^)(NSString* jsonString))success
                                         failure:(void (^)(NSError *error))failure;

- (void)getCostPmuTableSummaryForReportingMonth:(NSString*)reportingMonth
                                 withProjectKey:(NSString*)projectKey
                                        success:(void (^)(NSString* jsonString))success
                                        failure:(void (^)(NSError *error))failure;

- (void)getKeyHighlightsSummaryForReportingMonth:(NSString*)reportingMonth
                                  withProjectKey:(NSString*)projectKey
                                         success:(void (^)(NSString* jsonString))success
                                         failure:(void (^)(NSError *error))failure;

@end
