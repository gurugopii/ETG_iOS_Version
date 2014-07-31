//
//  ETGExpiredTokenCheck.m
//  PDF_Export
//
//  Created by Chiz on 11/28/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGExpiredTokenCheck.h"


@implementation ETGExpiredTokenCheck

+ (instancetype)sharedAlert {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)checkExpiredToken:(NSDictionary *)dictionary{

    NSString *strXErrorMsg = [dictionary valueForKey:@"X-Message"];
    
    if (strXErrorMsg && (([strXErrorMsg compare:@"TokenExpired" options:NSCaseInsensitiveSearch] == NSOrderedSame) || ([strXErrorMsg compare:@"TokenUnknownException" options:NSCaseInsensitiveSearch] == NSOrderedSame) || ([strXErrorMsg compare:@"TokenGenerationFailed" options:NSCaseInsensitiveSearch] == NSOrderedSame) || ([strXErrorMsg compare:@"BadCredential" options:NSCaseInsensitiveSearch] == NSOrderedSame))) {
        // Present Log in Screen if Token is Expired.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TokenExpired" object:nil];
    }
}

-(BOOL)checkExpiredTokenWithRequestOperation:(AFHTTPRequestOperation *)operation error:(NSError *)error
{
    NSHTTPURLResponse *response = operation.response;
    NSDictionary *responseHeadersDict = [response allHeaderFields];
    
    NSString *strXErrorMsg = [responseHeadersDict valueForKey:@"X-Message"];
    
    if (strXErrorMsg && (([strXErrorMsg compare:@"TokenExpired" options:NSCaseInsensitiveSearch] == NSOrderedSame) || ([strXErrorMsg compare:@"TokenUnknownException" options:NSCaseInsensitiveSearch] == NSOrderedSame) || ([strXErrorMsg compare:@"TokenGenerationFailed" options:NSCaseInsensitiveSearch] == NSOrderedSame) || ([strXErrorMsg compare:@"BadCredential" options:NSCaseInsensitiveSearch] == NSOrderedSame)))
    {
        // Present Log in Screen if Token is Expired.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TokenExpired" object:nil];
        return YES;
    }
    DDLogWarn(@"%@ %@: %@", logWarnPrefix, webServiceFetchError, error.description);
    DDLogError(@"%@%@", logErrorPrefix,responseHeadersDict);
    return NO;
}

-(void)checkExpiredTokenWithUrlResponse:(NSHTTPURLResponse *)response error:(NSError *)error
{
    NSDictionary *responseHeadersDict = [response allHeaderFields];
    
    [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];
    DDLogWarn(@"%@ - %@: %@", logWarnPrefix, webServiceFetchError, error.description);
    DDLogError(@"%@%@", logErrorPrefix,responseHeadersDict);
}

@end
