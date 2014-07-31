//
//  ETGPllLesson.h
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETGPllLessonModel.h"

@interface ETGPllLesson : NSObject
- (void)sendRequestWithUserId:(NSString*)userId
                     andProjectKey:(int)key
                      success:(void (^)(ETGPllLessonModel *))success
                      failure:(void (^)(NSError *error))failure;
@end
