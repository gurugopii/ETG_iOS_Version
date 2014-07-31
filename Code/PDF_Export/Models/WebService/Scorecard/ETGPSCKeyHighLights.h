//
//  ETGPSCKeyHighLights.h
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGPSCKeyHighLights : NSObject

- (void)sendRequestWithReportingMonth:(NSString*)reportingMonth projectKey:(NSNumber*)projectKey success:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *error))failure;

- (void)fetchOfflineDataWithReportingMonth:(NSString*)reportingMonth projectKey:(NSDictionary*)projectKey success:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *error))failure;
@end
