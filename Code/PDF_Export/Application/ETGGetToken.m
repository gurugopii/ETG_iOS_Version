//
//  ETGGetToken.m
//  PDF_Export
//
//  Created by Chiz on 10/4/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGGetToken.h"
#import "ETGLoginViewController.h"
#import "SFHFKeychainUtils.h"
#import "ETGAppDelegate.h"

@interface ETGGetToken ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (strong, nonatomic) ETGLoginViewController *loginViewController;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSString *strMessage;
@property (strong, nonatomic) ETGPDFModelController *pdfModelController;


@end

@implementation ETGGetToken

-(void)getToken {
    
    _responseData = [NSMutableData data];
    NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, kAuthenticateIpadUser];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:_userId forHTTPHeaderField:@"user_id"];
    [request setValue:_password forHTTPHeaderField:@"password"];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [_connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_connection start];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    _appDelegate = [[UIApplication sharedApplication] delegate];
   
    DDLogWarn(@"%@%@", logWarnPrefix, [NSString stringWithFormat:connectionFailedError, [error description]]);
    
    _strMessage = noTokenAlert;
    [self showAlertView:_strMessage];
    [_appDelegate performSelector:@selector(stopActivityIndicatorSmall) withObject:self afterDelay:0];

    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //Getting your response string
    
    _token = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    DDLogInfo(@"%@%@", logInfoPrefix, [NSString stringWithFormat:tokenLog,_token]);
    
    NSError *error = nil;
    _token = [_token stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    _appDelegate =  [[UIApplication sharedApplication] delegate];
    _appDelegate.userId = _userId;
    _appDelegate.passWord = _password;
//    _appDelegate.token = _token;
    NSString *userCredentials = [SFHFKeychainUtils getPasswordForUsername:_userId andServiceName:_password error:&error];
    
    if (userCredentials == nil) {
        [SFHFKeychainUtils storeUsername:_userId andPassword:_password forServiceName:_password updateExisting:NO error:&error];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"IsTokenEmpty" object:self];
    
    if ( _willGetNewMetadata) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"callCategories" object:self];
        _willGetNewMetadata = NO;
    }

}

-(void)showAlertView:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ElevateToGo Application" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alertView show];
    
}

@end
