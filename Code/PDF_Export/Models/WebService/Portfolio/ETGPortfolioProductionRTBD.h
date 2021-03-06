//
//  ETGPortfolioProductionRTBD.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGPortfolioProductionRTBD : NSObject

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
                           projectKey:(NSNumber *)projectKey
                              success:(void (^)(NSMutableDictionary *inputData))success
                              failure:(void (^)(NSError *error))failure;

- (BOOL)uacCanSeeReport:(NSString *)reportingMonth;
- (BOOL)entityIsEmpty;
- (void)setBaseFilters;
- (void)setIsReportEnabledFlagTo:(BOOL)yesNo;

- (void)collectReportJSONFrom:(NSSet *)cachedData
                      success:(void (^)(NSMutableDictionary *))success
                      failure:(void (^)(NSError *))failure;

@end
