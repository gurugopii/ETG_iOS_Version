//
//  ETGProjectScheduleProgressCoreInfo.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/20/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGProjectSchedProgressCoreInfo : NSObject

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
                           projectKey:(NSNumber *)projectKey
                              success:(void (^)(NSString *scheduleData))success
                              failure:(void (^)(NSError *error))failure;

@end
