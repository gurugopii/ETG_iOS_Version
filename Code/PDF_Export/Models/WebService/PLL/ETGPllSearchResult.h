//
//  ETGPllSearchResult.h
//  ETG
//
//  Created by Tan Aik Keong on 1/3/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETGPllSearchResultModel.h"

@interface ETGPllSearchResult : NSObject
- (void)sendRequestWithUserId:(NSString*)userId
             andInputJsonData:(NSData *)input
                      success:(void (^)(NSArray *))success
                      failure:(void (^)(NSError *error))failure;
@end
