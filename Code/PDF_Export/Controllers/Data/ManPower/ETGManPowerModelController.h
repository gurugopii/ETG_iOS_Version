//
//  ETGManPowerModelController.h
//  ETG
//
//  Created by Ahmad Alfhajri on 3/3/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGManPowerModelController : NSObject
+ (instancetype)sharedModel;

- (void)getAhcForReportingMonth:(NSString *)reportingMonth
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure;

- (void)getHcrForReportingMonth:(NSString *)reportingMonth
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure;
- (void)getLrForReportingMonth:(NSString *)reportingMonth
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure;

@end
