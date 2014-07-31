//
//  ETGKeychainCredentials.h
//  ETG
//
//  Created by Chiz on 12/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGKeychainCredentials : NSObject

+ (instancetype)sharedAlert;

-(void)saveUserAccountWithName:(NSString *)userName andPassword:password;


@end
