//
//  ETGPllLessonsCount.h
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETGPllLessonsCountModel.h"

@interface ETGPllLessonsCount : NSObject
- (void)sendRequestWithUserId:(NSString*)userId
                      success:(void (^)(ETGPllLessonsCountModel *))success
                      failure:(void (^)(NSError *error))failure;
@end
