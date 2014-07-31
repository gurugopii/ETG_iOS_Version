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

#pragma mark - Web service accessors for Level 1

- (void)getPortfolioTableSummaryForReportingMonth:(NSString*)reportingMonth
                                       withUserId:(NSString*)userId
                                          success:(void (^)(NSString* jsonString))success
                                          failure:(void (^)(NSError *error))failure;

- (void)getPortfolioHydrocarbonForReportingMonth:(NSString*)reportingMonth
                                    withProjectKey:(NSString*)projectKey
                                           success:(void (^)(NSString* jsonString))success
                                           failure:(void (^)(NSError *error))failure;

- (void)getPortfolioHseForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSMutableDictionary* jsonString))success
                                 failure:(void (^)(NSError *error))failure;

- (void)getPortfolioProdAndRtbdForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSString* jsonString))success
                                 failure:(void (^)(NSError *error))failure;

- (void)getPortfolioCpbForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSString* jsonString))success
                                 failure:(void (^)(NSError *error))failure;

- (void)getPortfolioApcForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSString* jsonString))success
                                 failure:(void (^)(NSError *error))failure;

- (void)getPortfolioWpbForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSString* jsonString))success
                                 failure:(void (^)(NSError *error))failure;

#pragma mark - Web service accessors for Level 2

-(void) getPortfolioHydrocarbonLevel2ForReportingMonth:(NSString *)reportingMonth
                                        withProjectKey:(NSString *)projectKey
                                               success:(void (^)(NSString *))success
                                               failure:(void (^)(NSError *))failure;

-(void) getPortfolioHseLevel2ForReportingMonth:(NSString *)reportingMonth
                                        withProjectKey:(NSString *)projectKey
                                               success:(void (^)(NSString *))success
                                               failure:(void (^)(NSError *))failure;

-(void) getPortfolioProdAndRtbdLevel2ForReportingMonth:(NSString *)reportingMonth
                          withProjectKey:(NSString *)projectKey
                                 success:(void (^)(NSString *))success
                                 failure:(void (^)(NSError *))failure;

-(void) getPortfolioCpbLevel2ForReportingMonth:(NSString *)reportingMonth
                                        withProjectKey:(NSString *)projectKey
                                               success:(void (^)(NSString *))success
                                               failure:(void (^)(NSError *))failure;

-(void) getPortfolioApcLevel2ForReportingMonth:(NSString *)reportingMonth
                                withProjectKey:(NSString *)projectKey
                                       success:(void (^)(NSString *))success
                                       failure:(void (^)(NSError *))failure;

- (void)getPortfolioWpbLevel2ForReportingMonth:(NSString*)reportingMonth
                          withProjectKey:(NSString*)projectKey
                                 success:(void (^)(NSString* jsonString))success
                                 failure:(void (^)(NSError *error))failure;

@end
