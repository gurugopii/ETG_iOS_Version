//
//  SlideMenuController.m
//  PlayGround
//
//  Created by Tu Pham on 2/6/13.
//  Copyright (c) 2013 metrixa. All rights reserved.
//

#import "SlideMenuController.h"
#import "UIViewController+JASidePanel.h"
#import "ETGHelpViewController.h"
#import "ETGLoginViewController.h"

@interface SlideMenuController ()

@end

@implementation SlideMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutDueToInactivity) name:@"ApplicationDidTimeout" object:nil];

    UIViewController *centerViewController;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"] == NO) {
        centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:kHelpViewController];
    } else {
        centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:kLoginViewController];
    }
    
    [self setCenterPanel:centerViewController];
}

- (void)logoutDueToInactivity {
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        ETGLoginViewController *loginViewController = [segue destinationViewController];
        loginViewController.loginMessage = @"Log out due to inactivity";
    }
}

- (void)didReceiveMemoryWarning
{   
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
