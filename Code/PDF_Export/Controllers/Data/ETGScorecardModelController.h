//
//  ETGModelController.h
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGScorecardModelController : NSObject

#pragma mark - Model Controller Class methods
+ (instancetype)sharedModel;

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

- (void)getProjectBackgroundTableSummaryForReportingMonth:(NSString*)reportingMonth
                                  withProjectKey:(NSString*)projectKey
                                         success:(void (^)(void))success
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
                                         success:(void (^)(NSMutableArray* keyHighlights))success
                                         failure:(void (^)(NSError *error))failure;

- (void)getBaseFiltersSummaryForReportingMonth:(NSString*)reportingMonth
                                    withUserId:(NSString*)userId
                                       success:(void (^)(void))success
                                          failure:(void (^)(NSError *error))failure;

- (NSString *)getProjectPopover;


@end
