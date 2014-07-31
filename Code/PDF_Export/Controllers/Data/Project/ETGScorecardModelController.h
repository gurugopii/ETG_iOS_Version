//
//  ETGModelController.h
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETGScorecardModelController;

@protocol ETGScorecardModelControllerDelegate <NSObject>

- (void)appendJSONToViewController:(NSSet *)jsonStringFromInterface;
- (void)appendJSONOfLastPageToViewController:(NSSet *)jsonStringFromInterface;
- (void)appendJSONOfCurrentPageToViewController:(NSSet *)jsonStringFromInterface withError:(NSError *)error;

@end

@interface ETGScorecardModelController : NSObject

#pragma mark - Model Controller Class methods
+ (instancetype)sharedModel;

#pragma mark - Web service accessors
- (void)getScorecardTableSummaryForReportingMonth:(NSString*)reportingMonth
                                          success:(void (^)(NSString* jsonString))success
                                          failure:(void (^)(NSError *error))failure;

//- (void)getProductionTableSummaryForReportingMonth:(NSString*)reportingMonth
//                                    withProjectKey:(NSString*)projectKey
//                                           success:(void (^)(NSString* jsonString))success
//                                           failure:(void (^)(NSError *error))failure;
- (void)getProductionTableSummaryForReportingMonth:(NSString*)reportingMonth
                                    withProjectKey:(NSNumber*)projectKey
                                           success:(void (^)(NSString* jsonString))success
                                           failure:(void (^)(NSError *error))failure;

//- (void)getHseTableSummaryForReportingMonth:(NSString*)reportingMonth
//                             withProjectKey:(NSString*)projectKey
//                                    success:(void (^)(NSString* jsonString))success
//                                    failure:(void (^)(NSError *error))failure;
- (void)getHseTableSummaryForReportingMonth:(NSString*)reportingMonth withProjectKey:(NSNumber*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure;

//- (void)getScheduleTableSummaryForReportingMonth:(NSString*)reportingMonth
//                                  withProjectKey:(NSString*)projectKey
//                                         success:(void (^)(NSString* jsonString))success
//                                         failure:(void (^)(NSError *error))failure;
- (void)getScheduleTableSummaryForReportingMonth:(NSString*)reportingMonth
                                  withProjectKey:(NSNumber*)projectKey
                                         success:(void (^)(NSString* jsonString))success
                                         failure:(void (^)(NSError *error))failure;

- (void)getProjectBackgroundTableSummaryForReportingMonth:(NSString*)reportingMonth
                                  withProjectKey:(NSString*)projectKey
                                         success:(void (^)(NSMutableArray *projectBackground))success
                                         failure:(void (^)(NSError *error))failure;

- (void)getManpowerTableSummaryForReportingMonth:(NSString*)reportingMonth withProjectKey:(NSNumber*)projectKey success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure;

//- (void)getCostPcsbTableSummaryForReportingMonth:(NSString*)reportingMonth
//                                  withProjectKey:(NSString*)projectKey
//                                         success:(void (^)(NSString* jsonString))success
//                                         failure:(void (^)(NSError *error))failure;
- (void)getCostPcsbTableSummaryForReportingMonth:(NSString*)reportingMonth
                                  withProjectKey:(NSNumber*)projectKey
                                         success:(void (^)(NSString* jsonString))success
                                         failure:(void (^)(NSError *error))failure;

//- (void)getCostPmuTableSummaryForReportingMonth:(NSString*)reportingMonth
//                                 withProjectKey:(NSString*)projectKey
//                                        success:(void (^)(NSString* jsonString))success
//                                        failure:(void (^)(NSError *error))failure;
- (void)getCostPmuTableSummaryForReportingMonth:(NSString*)reportingMonth
                                 withProjectKey:(NSNumber*)projectKey
                                        success:(void (^)(NSString* jsonString))success
                                        failure:(void (^)(NSError *error))failure;

- (void)getScorecardTableSummaryForReportingMonth:(NSString*)reportingMonth
                                        pageSize:(int)pageSize
                                      pageNumber:(int)pageNumber
                        isSelectedReportingMonth:(BOOL)isSelectedReportingMonth
                               filteredDictionary:(NSMutableDictionary*)filteredDictionary
                                         success:(void (^)(NSString* scorecards))success
                                         failure:(void (^)(NSError *error))failure;

-(void)getKeyHighlightsSummaryForReportingMonth:(NSString *)reportingMonth
                                 withProjectKey:(NSString *)projectKey
                                        success:(void (^)(NSMutableArray *))success
                                        failure:(void (^)(NSError *))failure;

#pragma mark - Web service accessors for Offline
- (void)getScorecardTableSummaryOfflineForReportingMonth:(NSString*)reportingMonth withProjectKeys:(NSDictionary *)projectKeys success:(void (^)(NSString* jsonString))success failure:(void (^)(NSError *error))failure;

-(void)getKeyHighlightsSummaryOfflineForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSString *)projectKey success:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure;

-(void)getProjectBackgroundTableSummaryOfflineForReportingMonth:(NSString *)reportingMonth withProjectKey:(NSString *)projectKey success:(void (^)(NSMutableArray *projectBackground))success failure:(void (^)(NSError *))failure;

- (NSString *)getProjectPopover;


//- (void)getScorecardTableSummaryForReportingMonth:(NSString*)reportingMonth
//                                          success:(void (^)(NSString* jsonString))success
//                                          failure:(void (^)(NSError *error))failure;

@property (nonatomic, strong) NSDictionary *enableReportFromScorecard;
@property (nonatomic, strong) id<ETGScorecardModelControllerDelegate> delegate;

@end
