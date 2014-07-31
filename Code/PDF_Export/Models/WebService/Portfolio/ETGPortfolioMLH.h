//
//  ETGPortfolioMLH.h
//  ETG
//
//  Created by Helmi Hasan on 3/9/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGPortfolioMLH : NSObject

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
                           projectKey:(NSNumber *)projectKey
                              success:(void (^)(NSMutableDictionary *inputData))success
                              failure:(void (^)(NSError *error))failure;

- (BOOL)uacCanSeeReport:(NSString *)reportingMonth;
- (BOOL)entityIsEmpty;
- (void)setBaseFilters;
- (void)setIsReportEnabledFlagTo:(BOOL)yesNo;

- (void)collectReportJSONFrom:(NSSet *)cachedData
               reportingMonth:(NSString *)reportingMonth
                      success:(void (^)(NSMutableDictionary *))success
                      failure:(void (^)(NSError *))failure;

@end
