//
//  ETGScoreCardCostPMU.h
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGScoreCardCostPMU : NSObject

//- (void)sendRequestWithReportingMonth:(NSString*)reportingMonth projectKey:(NSNumber*)projectKey success:(void (^)(NSString* costPmu))success failure:(void (^)(NSError *error))failure;
- (void)fetchOfflineDataWithReportingMonth:(NSString *)reportingMonth
                           withProjectKeys:(NSNumber *) projectKey
                                   success:(void (^)(NSString* scorecards))success
                                   failure:(void (^)(NSError *error))failure;
@end
