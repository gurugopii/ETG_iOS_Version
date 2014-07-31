//
//  ETGScoreCardManpower.h
//  ETG
//
//  Created by Helmi Hasan on 3/10/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGScoreCardManpower : NSObject

- (void)fetchOfflineDataWithReportingMonth:(NSString *)reportingMonth
                           withProjectKeys:(NSNumber *) projectKey
                                   success:(void (^)(NSString* scorecards))success
                                   failure:(void (^)(NSError *error))failure;

@end
