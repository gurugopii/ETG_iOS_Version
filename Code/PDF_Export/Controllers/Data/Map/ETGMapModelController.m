//
//  ETGMapModelController.m
//  ETG
//
//  Created by Tan Aik Keong on 1/7/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGMapModelController.h"
#import "ETGMapPgdAndPem.h"
#import "ETGMapKeyMilestone.h"

@implementation ETGMapModelController

+ (instancetype)sharedModel {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)getPgdAndPemForReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString* jsonString))success
                              failure:(void (^)(NSError *error))failure
{
    ETGMapPgdAndPem *pgdAndPem = [ETGMapPgdAndPem new];
    [pgdAndPem sendRequestWithReportingMonth:reportingMonth isManualRefresh:isManual success:^(NSString *inputData) {
        success(inputData);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

-(NSString *)getKeyMilestonesOfflineData:(NSString *)reportingMonth withProjectKey:(int)projectKey
{
    ETGMapKeyMilestone *keyMilestone = [ETGMapKeyMilestone new];
    return [keyMilestone getOfflineData:reportingMonth withProjectKey:projectKey];
}

@end
