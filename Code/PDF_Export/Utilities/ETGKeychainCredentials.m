//
//  ETGKeychainCredentials.m
//  ETG
//
//  Created by Chiz on 12/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGKeychainCredentials.h"

@implementation ETGKeychainCredentials

+ (instancetype)sharedAlert {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)saveUserAccountWithName:(NSString *)userName andPassword:password {
    
    NSURL* url = [NSURL URLWithString:kBaseURL];
    NSString* serviceName = [NSString stringWithFormat:@"%@(%@)", url.host, userName];
    
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"ETG" accessGroup:nil];
    [keychain setObject:userName forKey:(__bridge id)kSecAttrAccount];
    [keychain setObject:password forKey:(__bridge id)kSecValueData];
    [keychain setObject:serviceName forKey:(__bridge id)kSecAttrService];
    
    //NSLog(@"%@, %@", [keychain objectForKey:(__bridge id)kSecAttrAccount], [keychain objectForKey:(__bridge id)kSecValueData]);
}




@end
