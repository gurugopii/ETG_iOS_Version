//
//  ETGScoreCardAboutProject.h
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGScoreCardAboutProject : NSObject

- (void)sendRequestWithReportingMonth:(NSString*)reportingMonth
                           projectKey:(NSNumber*)projectKey
                              success:(void (^)(NSMutableArray *projectBackground))success
                              failure:(void (^)(NSError *error))failure;

- (void)fetchOfflineDataWithReportingMonth:(NSString*)reportingMonth projectKey:(NSNumber*)projectKey success:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *error))failure;
@end
