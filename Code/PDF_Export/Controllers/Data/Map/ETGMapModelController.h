//
//  ETGMapModelController.h
//  ETG
//
//  Created by Tan Aik Keong on 1/7/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGMapModelController : NSObject

#pragma mark - Model Controller Class methods
+ (instancetype)sharedModel;

- (void)getPgdAndPemForReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString* jsonString))success
                              failure:(void (^)(NSError *error))failure;
-(NSString *)getKeyMilestonesOfflineData:(NSString *)reportingMonth withProjectKey:(int)projectKey;

@end
