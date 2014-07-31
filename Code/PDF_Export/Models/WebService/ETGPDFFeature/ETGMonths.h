//
//  ETGMonths.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 10/8/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGMonths : NSObject

- (void)sendRequestWithUserId:(NSString*)userId andToken:(NSString*)token success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end
