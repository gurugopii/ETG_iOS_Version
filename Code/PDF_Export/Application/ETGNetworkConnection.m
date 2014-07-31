//
//  PDFNetworkConnection.m
//  PDF_Export
//
//  Created by mobilitySF on 7/14/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "ETGNetworkConnection.h"
#import "ETGAppDelegate.h"
#import "Reachability.h"
#import "SimplePingHelper.h"
#import "ETGUserDefaultManipulation.h"

@implementation ETGNetworkConnection

+(void)checkAvailability {
    
    // Please do not delete, this code will be removed upon confirmation of ID 272 as resolved.
    ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *serverAddress = [[NSURL URLWithString:kBaseURL] host];
    Reachability *reachability = [Reachability reachabilityWithHostName:serverAddress];

    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        //my web-dependent code
        appDelegate.isNetworkServerAvailable = YES;
    }
    else {
        //there-is-no-connection warning
        appDelegate.isNetworkServerAvailable = NO;
        [appDelegate performSelector:@selector(stopActivityIndicatorSmall) withObject:self afterDelay:0];
        
        /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:serverCannotBeReachedAlert delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];*/
        NSString *alertPrompt = [[ETGUserDefaultManipulation sharedUserDefaultManipulation] retrieveShowNoServerConnectionFromNSUserDefaults];
        if ([alertPrompt isEqualToString:@"Y"]){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Offline" message:serverCannotBeReachedAlert delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
        }
//        else if ([alertPrompt isEqualToString:@"P"]){
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:serverCannotBeReachedAlert delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [alertView show];
//        }
    }
}

@end
