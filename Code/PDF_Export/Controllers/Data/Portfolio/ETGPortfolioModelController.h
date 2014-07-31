//
//  ETGPortfolioModelController.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
//CATH 09.18.2013
#import <Foundation/Foundation.h>

@interface ETGPortfolioModelController : NSObject

#pragma mark - Model Controller Class methods
+ (instancetype)sharedModel;

#pragma mark - UAC
- (void)populateEnableReportsArray:(NSDictionary *)enablePortfolioReports;
//- (void)getPortfolioReportNameForReport:(NSString *)reportName;
- (BOOL)isPortfolioReportEnabledForReportName:(NSString *)reportName;
- (BOOL)isPortfolioTableReportEnabledForReportName:(NSString *)reportName;

#pragma mark - Web service accessors for Level 1

- (void)getPortfolioTableSummaryForReportingMonth:(NSMutableDictionary*)reportingMonth
                                       withUserId:(NSString*)userId
                                          success:(void (^)(NSString* jsonString))success
                                          failure:(void (^)(NSError *error))failure;

- (void)deletePortfolioTableSummaryForReportingMonth:(NSString *)reportingMonth
                                          withUserId:(NSString *)userId
                                             success:(void (^)(bool))success
                                             failure:(void (^)(NSError *))failure;

- (void)getPortfolioHydrocarbonForReportingMonth:(NSString*)reportingMonth
                                  withProjectKey:(NSString*)projectKey
                                         success:(void (^)(NSMutableArray* jsonString))success
                                         failure:(void (^)(NSError *error))failure;

- (void)getPortfolioHseForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSMutableDictionary* jsonString))success
                                 failure:(void (^)(NSError *error))failure;

- (void)getPortfolioProdAndRtbdForReportingMonth:(NSString*)reportingMonth
                                  withProjectKey:(NSString*)projectKey
                                         success:(void (^)(NSMutableDictionary* jsonString))success
                                         failure:(void (^)(NSError *error))failure;

- (void)getPortfolioCpbForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSMutableDictionary* jsonString))success
                                 failure:(void (^)(NSError *error))failure;

- (void)getPortfolioApcForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSMutableDictionary* jsonString))success
                                 failure:(void (^)(NSError *error))failure;

- (void)getPortfolioWpbForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSMutableDictionary* jsonString))success
                                 failure:(void (^)(NSError *error))failure;

- (void)getPortfolioMlhForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSMutableDictionary *))success
                                 failure:(void (^)(NSError *))failure;

#pragma mark - Web service accessors for Level 2

- (void)setTimestampAgeMoreThanOneDay:(BOOL)boolValue;

- (void)collectPortfolioProdAndRtbdForReportingMonth:(NSSet *)cachedData
                                             success:(void (^)(NSMutableDictionary *))success
                                             failure:(void (^)(NSError *))failure;

- (void)collectPortfolioApcForReportingMonth:(NSSet *)cachedData
                             withTableReport:(BOOL)yesNo
                                     success:(void (^)(NSMutableDictionary *))success
                                     failure:(void (^)(NSError *))failure;

- (void)collectPortfolioCpbForReportingMonth:(NSSet *)cachedData
                              reportingMonth:(NSString *)reportingMonth
                             withTableReport:(BOOL)yesNo
                                     success:(void (^)(NSMutableDictionary *))success
                                     failure:(void (^)(NSError *))failure;

- (void)collectPortfolioHseForReportingMonth:(NSSet *)cachedData
                                     success:(void (^)(NSMutableDictionary *))success
                                     failure:(void (^)(NSError *))failure;

-(void) collectPortfolioHydrocarbonForReportingMonth:(NSSet *)cachedData
                                             success:(void (^)(NSMutableArray *))success
                                             failure:(void (^)(NSError *))failure;

- (void)collectPortfolioWpbForReportingMonth:(NSSet *)cachedData
                              reportingMonth:(NSString *)reportingMonth
                             withTableReport:(BOOL)yesNo
                                     success:(void (^)(NSMutableDictionary *))success
                                     failure:(void (^)(NSError *))failure;

- (void)collectPortfolioMlhForReportingMonth:(NSSet *)cachedData
                              reportingMonth:(NSString*)reportingMonth
                                     success:(void (^)(NSMutableDictionary *))success
                                     failure:(void (^)(NSError *))failure;

- (void)setQueuepriorityForScorecard:(NSString*)reportingMonth;
- (void)setQueuepriorityForPortfolioGraph:(NSString*)reportingMonth;

@end
