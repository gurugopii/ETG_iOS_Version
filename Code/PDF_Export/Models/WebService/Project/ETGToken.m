//
//  ETGToken.m
//  PDF_Export
//
//  Created by Accenture Mobility Services on 10/9/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGToken.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGProjectTestOutput.h"
#import "ETGAppDelegate.h"
#import "ETGWebService.h"
#import <AdSupport/ASIdentifierManager.h>
#import "ETGUserDefaultManipulation.h"
#import "NSData+Base64.h"
#import "UICKeyChainStore.h"


@interface ETGToken ()

@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGToken

+ (instancetype)sharedToken {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            self.isMapped = YES;
            _deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        }
    }
    return self;
}

- (void)getToken:(NSString *)loginName andPassword:loginPassword success:(void (^)(NSString *token, NSString *key))success failure:(void (^)(NSError * error))failure {
    
    ETGAppDelegate *appDelegate =  [[UIApplication sharedApplication] delegate];
    NSString *key = [self generateAESKeyFromPassword:loginPassword];
    NSString *credential = [NSString stringWithFormat:@"%@#ETG#%@#ETG#%@", loginName, self.deviceId, key];
    //DDLogInfo(@"Send credential: %@", credential);
    
    NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, kAuthenticateEtgUser];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:credential forHTTPHeaderField:@"X-ETG-Credential"];
    [request setValue:loginPassword forHTTPHeaderField:@"X-ETG-UserCode"];
    [request setHTTPMethod:@"GET"];
    
    // changed to 3mins
    [request setTimeoutInterval:30];

    AFHTTPRequestOperation *operation = [_managedObject.HTTPClient HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *responseHeadersDict = [operation.response allHeaderFields];
        NSString *strXStatus = [responseHeadersDict valueForKey:@"X-Status"];
        if ([strXStatus rangeOfString:@"success" options:NSCaseInsensitiveSearch].location != NSNotFound) {

            NSString *token = [responseHeadersDict valueForKey:@"X-Token"];
            
            if ( _willGetNewMetadata) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"callCategories" object:self];
                _willGetNewMetadata = NO;
            }
            
            success (token, key);
            
        } else {
            NSDictionary *responseHeadersDict = [operation.response allHeaderFields];
            NSString *strXErrorMsg = [responseHeadersDict valueForKey:@"X-Message"];
            
            [self.delegate setErrorLoginMessage:strXErrorMsg];
            [appDelegate performSelector:@selector(stopActivityIndicatorSmall) withObject:self afterDelay:0];

            NSError *error = [CommonMethods createAnErrorWithMessage:strXErrorMsg];
            failure (error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSDictionary *responseHeadersDict = [operation.response allHeaderFields];
        NSString *strXErrorMsg = [responseHeadersDict valueForKey:@"X-Message"];
        //DDLogInfo(@"X-Message: %@", strXErrorMsg);

        appDelegate.isNetworkServerAvailable = NO;
        [self.delegate setErrorLoginMessage:error.localizedDescription];
        
        [appDelegate performSelector:@selector(stopActivityIndicatorSmall) withObject:self afterDelay:0];
        
        failure (error);
    }];
    
    operation.SSLPinningMode = AFSSLPinningModeCertificate;
    [_managedObject.HTTPClient enqueueHTTPRequestOperation:operation];
}


- (NSString *)generateAESKeyFromPassword:(NSString *)password
{
    NSData *salt = [CommonMethods randomDataOfLength:8];
    NSData *keyData = [CommonMethods AESKeyForPassword:password salt:salt];
    NSString *key = [keyData base64EncodedString];
    
    return key;
}

@end
