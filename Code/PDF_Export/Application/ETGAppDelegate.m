//
//  PDFEAppDelegate.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGAppDelegate.h"
#import "ETGWebService.h"
// CocoaLumberJack Imports
#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"
#import "ELCUIApplication.h"


@implementation ETGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configureDDLog];
    [self configureAppAppearance];
    
    return YES;
}
 
- (void)configureDDLog
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    // Initialize File Logger
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    [fileLogger setMaximumFileSize:(100 * 1024 * 1024)];    //100 MB
    [fileLogger setRollingFrequency:(3600.0 * 24.0 * 7 * 26)]; //26 weeks
    [[fileLogger logFileManager] setMaximumNumberOfLogFiles:7];
    [DDLog addLogger:fileLogger];
}

- (void)configureAppAppearance
{
    UINavigationBar *navigationAppearance = [UINavigationBar appearance];
    UIBarButtonItem *barButtonAppearance = [UIBarButtonItem appearance];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        //NavigationBar
        UIImage *defaultBarImage = [navigationAppearance backgroundImageForBarMetrics:UIBarMetricsDefault];
        [navigationAppearance setBackgroundImage:[UIImage imageNamed:@"navigationBarBackground"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearanceWhenContainedIn:[UIPopoverController class], nil] setBackgroundImage:defaultBarImage forBarMetrics:UIBarMetricsDefault];
        
        [barButtonAppearance setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [barButtonAppearance setTitleTextAttributes:@{UITextAttributeFont: [UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
        [barButtonAppearance setTitleTextAttributes:@{UITextAttributeFont: [UIFont systemFontOfSize:15], UITextAttributeTextColor: [UIColor lightGrayColor]} forState:UIControlStateHighlighted];
        
        NSDictionary *whiteTitleTextAttributes = @{UITextAttributeFont: [UIFont systemFontOfSize:13], UITextAttributeTextColor: [UIColor whiteColor], UITextAttributeTextShadowColor: [UIColor clearColor]};
        NSDictionary *greenTitleTextAttributes = @{UITextAttributeFont: [UIFont systemFontOfSize:13], UITextAttributeTextColor: kPetronasGreenColor, UITextAttributeTextShadowColor: [UIColor clearColor]};
        
        //SegmentedControl in navigation bar
        UISegmentedControl *segmentedAppearance = [UISegmentedControl appearanceWhenContainedIn:[UINavigationBar class], nil];
        [segmentedAppearance setBackgroundImage:[UIImage imageNamed:@"segmentedControlBackground"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [segmentedAppearance setBackgroundImage:[UIImage imageNamed:@"segmentedControlSelected"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [segmentedAppearance setDividerImage:[UIImage imageNamed:@"segmentedControlDivider"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [segmentedAppearance setTitleTextAttributes:whiteTitleTextAttributes forState:UIControlStateNormal];
        [segmentedAppearance setTitleTextAttributes:greenTitleTextAttributes forState:UIControlStateSelected];
        
        //SegmentedControl in view
        UISegmentedControl *segmentedControlAppearance = [UISegmentedControl appearance];
        UIImage *backgroundGreenImage = [UIImage imageNamed:@"segmentedControlBackgroundGreen"];
        [segmentedControlAppearance setBackgroundImage:backgroundGreenImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [segmentedControlAppearance setBackgroundImage:[UIImage imageNamed:@"segmentedControlSelectedGreen"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [segmentedControlAppearance setDividerImage:[UIImage imageNamed:@"segmentedControlDividerGreen"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [segmentedControlAppearance setTitleTextAttributes:greenTitleTextAttributes forState:UIControlStateNormal];
        [segmentedControlAppearance setTitleTextAttributes:whiteTitleTextAttributes forState:UIControlStateSelected];
         
        //UISearchBar
        UISearchBar *searchBarAppearance = [UISearchBar appearance];
        [searchBarAppearance setBackgroundImage:[UIImage new]];
        [searchBarAppearance setSearchFieldBackgroundImage:backgroundGreenImage forState:UIControlStateNormal];

    } else {
        [navigationAppearance setBarTintColor:kPetronasGreenColor];
        [navigationAppearance setTintColor:[UIColor whiteColor]];
        [navigationAppearance setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor]}];
        [[UINavigationBar appearanceWhenContainedIn:[UIPopoverController class], nil] setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor blackColor]}];
        [barButtonAppearance setTintColor:[UIColor whiteColor]];
        [[UIBarButtonItem appearanceWhenContainedIn:[UIPopoverController class], nil] setTintColor:kPetronasGreenColor];
        UISegmentedControl *segmentedAppearance = [UISegmentedControl appearanceWhenContainedIn:[UINavigationBar class], nil];
        [segmentedAppearance setTintColor:[UIColor whiteColor]];
    }
    
    UIPageControl *pageControlAppearance = [UIPageControl appearance];
    [pageControlAppearance setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [pageControlAppearance setCurrentPageIndicatorTintColor:kPetronasGreenColor];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    dateCheck = [NSDate date];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationDidTimeout" object:nil];
//    [(ELCUIApplication *)[UIApplication sharedApplication] resetIdleTimer];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self checkTimeOut];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)checkTimeOut
{
    if (dateCheck == nil) {
        return;
    }
    NSDate *now = [NSDate date];
    
    NSDate *date = [now laterDate:[NSDate dateWithTimeInterval:kApplicationTimeoutInMinutes * 60 sinceDate:dateCheck]];
    
    if ([date isEqualToDate:now]) {
        [(ELCUIApplication *)[UIApplication sharedApplication] idleTimerExceeded];
    }
}

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext defaultContext];
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges]) {
            NSError* error;
            [managedObjectContext saveToPersistentStore:&error];
            if (error) {
                DDLogWarn(@"%@%@",logWarnPrefix,saveCoreDataError);
            }
        }
    }
}

- (void)startActivityIndicatorSmallGrey {
    UIView *v = [_window viewWithTag:998];
    if(v) return;
    
    CGRect frame = CGRectMake(325, 490, 50, 50);
    UIActivityIndicatorView *progressInd = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    [progressInd startAnimating];
    progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;

    UIView *theView = [[UIView alloc] init];
    theView.tag = 998;
    [theView addSubview:progressInd];
    
    [_window addSubview:theView];
    [_window bringSubviewToFront:theView];
    
}

- (void)stopActivityIndicatorSmall {
    UIView *v = [_window viewWithTag:998];
    if(v) [v removeFromSuperview];
}

@end
