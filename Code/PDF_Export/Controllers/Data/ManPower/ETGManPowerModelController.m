//
//  ETGManPowerModelController.m
//  ETG
//
//  Created by Ahmad Alfhajri on 3/3/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGManPowerModelController.h"
#import "ETGMpAhcWebService.h"
#import "ETGMpLrWebService.h"
#import "ETGMpHcrWebService.h"

@implementation ETGManPowerModelController

+ (instancetype)sharedModel {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (void)getAhcForReportingMonth:(NSString *)reportingMonth
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure
{
    ETGMpAhcWebService *webService = [ETGMpAhcWebService new];
    [webService sendRequestWithReportingMonth:reportingMonth isManualRefresh:isManual success:^(NSString *jsonString) {
        success(jsonString);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

- (void)getHcrForReportingMonth:(NSString *)reportingMonth
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure
{
    ETGMpHcrWebService *webService = [ETGMpHcrWebService new];
    [webService sendRequestWithReportingMonth:reportingMonth isManualRefresh:isManual success:^(NSString *jsonString) {
        success(jsonString);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

- (void)getLrForReportingMonth:(NSString *)reportingMonth
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure
{
    ETGMpLrWebService *webService = [ETGMpLrWebService new];
    [webService sendRequestWithReportingMonth:reportingMonth isManualRefresh:isManual success:^(NSString *jsonString) {
        success(jsonString);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}


@end
