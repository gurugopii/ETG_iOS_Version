//
//  ETGEccrModelController.h
//  ETG
//
//  Created by Tan Aik Keong on 1/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGEccrModelController : NSObject
+ (instancetype)sharedModel;
- (void)getCpbForReportingMonth:(NSString *)reportingMonth
               budgetHolderKeys:(NSArray *)budgetHolderKeys
                    projectKeys:(NSArray *)projectKeys
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure;
- (void)getAbrForReportingMonth:(NSString *)reportingMonth
                    projectKeys:(NSArray *)projectKeys
                isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString* jsonString))success
                              failure:(void (^)(NSError *error))failure;
- (void)getCpsForReportingMonth:(NSString *)reportingMonth
                     projectKey:(NSString *)projectKey
                          isWpb:(NSString *)isWpb
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure;
-(NSString *)getJustififcationForInputType:(NSString *)inputType inputValue:(NSString *)inputValue reportingMonth:(NSString *)reportingMonth projectKey:(NSString *)projectKey;

@end
