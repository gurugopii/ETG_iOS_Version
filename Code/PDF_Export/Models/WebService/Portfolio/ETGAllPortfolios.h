//
//  ETGAllPortfolios.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGAllPortfolios : NSObject

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
                              success:(void (^)(NSString *inputData))success
                              failure:(void (^)(NSError *error))failure;
- (void)removeDuplicatesForReportingMonth:(NSString *)reportingMonth
                               withUserId:(NSString *)userId
                                  success:(void (^)(bool removed))success
                                  failure:(void (^)(NSError *))failure;

@end
