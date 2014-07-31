//
//  ETGEccrModelController.m
//  ETG
//
//  Created by Tan Aik Keong on 1/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGEccrModelController.h"
#import "ETGEccrAbrWebService.h"
#import "ETGEccrCpsWebService.h"
#import "ETGEccrCpbWebService.h"

@implementation ETGEccrModelController

+ (instancetype)sharedModel {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)getCpbForReportingMonth:(NSString *)reportingMonth
               budgetHolderKeys:(NSArray *)budgetHolderKeys
                    projectKeys:(NSArray *)projectKeys
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure
{
    ETGEccrCpbWebService *webService = [ETGEccrCpbWebService new];
    webService.budgetHolderKeys = budgetHolderKeys;
    webService.filteredProjects = projectKeys;
    [webService sendRequestWithReportingMonth:reportingMonth isManualRefresh:isManual success:^(NSString *jsonString) {
        success(jsonString);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

- (void)getAbrForReportingMonth:(NSString *)reportingMonth
                    projectKeys:(NSArray *)projectKeys
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure
{
    //NSLog(@"Input is %@ and %d", reportingMonth, [projectKeys count]);
    ETGEccrAbrWebService *webService = [ETGEccrAbrWebService new];
    webService.filteredProjects = projectKeys;
    [webService sendRequestWithReportingMonth:reportingMonth isManualRefresh:isManual success:^(NSString *jsonString) {
        success(jsonString);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

- (void)getCpsForReportingMonth:(NSString *)reportingMonth
                     projectKey:(NSString *)projectKey
                          isWpb:(NSString *)isWpb
                isManualRefresh:(BOOL)isManual
                        success:(void (^)(NSString* jsonString))success
                        failure:(void (^)(NSError *error))failure
{
    ETGEccrCpsWebService *webService = [ETGEccrCpsWebService new];
    [webService sendRequestWithReportingMonth:reportingMonth projectKey:projectKey isNavigateFromWpb:isWpb isManualRefresh:isManual success:^(NSString *jsonString) {
        success(jsonString);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(NSString *)getJustififcationForInputType:(NSString *)inputType inputValue:(NSString *)inputValue reportingMonth:(NSString *)reportingMonth projectKey:(NSString *)projectKey
{
    ETGEccrCpsWebService *webService = [ETGEccrCpsWebService new];
    return [webService getJustification:inputType inputValue:inputValue reportingMonth:reportingMonth projectKey:projectKey];
}

@end
