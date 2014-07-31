//
//  ETGEccrCpsWebService.h
//  ETG
//
//  Created by Tan Aik Keong on 1/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGEccrCpsWebService : NSObject
- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth projectKey:(NSString *)projectKey
                    isNavigateFromWpb:(NSString *)isWpb
                    isManualRefresh:(BOOL)isManual
                    success:(void (^)(NSString *jsonString))success
                    failure:(void (^)(NSError *error))failure;
-(BOOL)needRefreshDataWithReportingMonth:(NSString *)reportingMonth projectKey:(NSString *)projectKey;
-(NSString *)getOfflineDataTopInformation:(NSString *)reportingMonth projectKey:(NSString *)projectKey isNavigateFromWpb:(NSString *)isWpb;
-(NSString *)getOfflineData:(NSString *)reportingMonth projectKey:(NSString *)projectKey isNavigateFromWpb:(NSString *)isWpb;
-(NSString *)getJustification:(NSString *)inputType inputValue:(NSString *)inputValue reportingMonth:(NSString *)reportingMonth projectKey:(NSString *)projectKey;
@end
