//
//  ETGExpiredTokenCheck.h
//  PDF_Export
//
//  Created by Chiz on 11/28/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

@interface ETGExpiredTokenCheck : NSObject

+ (instancetype)sharedAlert;

-(void) checkExpiredToken :(NSDictionary *) dictionary;
-(BOOL)checkExpiredTokenWithRequestOperation:(AFHTTPRequestOperation *)operation error:(NSError *)error;
-(void)checkExpiredTokenWithUrlResponse:(NSHTTPURLResponse *)response error:(NSError *)error;

@end
