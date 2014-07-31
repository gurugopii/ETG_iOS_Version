//
//  LoginViewController.m
//  PDF_Export
//
//  Created by Chiz on 9/20/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "ETGLoginViewController.h"
#import "ETGAppDelegate.h"
#import "ELCUIApplication.h"
#import <QuartzCore/QuartzCore.h>
#import "ETGNetworkConnection.h"
#import "ETGToken.h"
#import <AFNetworking.h>
#import "Reachability.h"
#import "LeftViewController.h"
#import "ETGUserDefaultManipulation.h"
#import <RestKit/RestKit.h>
#import "ETGProjectViewController.h"
#import "ETGPortfolioScorecardViewController.h"
#import "ETGManpowerViewController.h"
#import "UICKeyChainStore.h"
#import "ETGPllLessons.h"
#import "ETGCoreDataUtilities.h"
#import "ETGUacPermission.h"

@interface ETGLoginViewController () <UITextFieldDelegate,ETGTokenDelegate>

@property (strong, nonatomic) ETGToken *getToken;
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *logInMessagePrompt;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (nonatomic) BOOL isValid;

- (IBAction)loginButtonClicked:(id)sender;

@end

@implementation ETGLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Cancel pending background downloads
    [[RKObjectManager sharedManager].operationQueue cancelAllOperations];
    
    _appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (_loginMessage) {
        _logInMessagePrompt.text = _loginMessage;
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"LOGIN_USERNAME"] != nil) {
        _usernameField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOGIN_USERNAME"];
    }
    [ETGToken sharedToken].delegate = self;
    
#ifdef DEBUG
    // AK TODO
//    [self loginButtonClicked:nil];
//    [self performSelector:@selector(showSlideMenu) withObject:nil afterDelay:1];
#endif

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _usernameField) {
        [_passwordField becomeFirstResponder];
    } else {
        [self loginButtonClicked:textField];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (void)startSigningInAnimation
{
    _logInMessagePrompt.text = nil;
    [_signInButton setTitle:@"Signing In" forState:UIControlStateNormal];
    [_loadingIndicator startAnimating];
}

- (void)stopSigningInAnimation
{
    [_signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [_loadingIndicator stopAnimating];
}


/** Once the user taps on the Sign In button, the method will call shouldPerformSegue to determine if user input for username and password is correct. **/
- (IBAction)loginButtonClicked:(id)sender
{
    if ([self evaluateUserCredentials])
    {
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [self startSigningInAnimation];
        
        NSString *username = _usernameField.text;
        NSString *password = _passwordField.text;
        NSString *usernameInKeychain = [UICKeyChainStore stringForKey:kETGUsername];
        NSString *passwordInKeychain = [UICKeyChainStore stringForKey:kETGPassword];
        
        ETGToken *sharedToken = [ETGToken sharedToken];
        [sharedToken getToken:username andPassword:password success:^(NSString *token, NSString *key)
        {
            [self stopSigningInAnimation];
            
            NSString *ivString = [token substringToIndex:24];
            NSString *encryptedToken = [token substringFromIndex:24];
            NSString *revertUsername = [CommonMethods revertString:[username substringFromIndex:(username.length - 4)]];
            NSString *keyUsername = [key stringByReplacingCharactersInRange:NSMakeRange(key.length - 4, 4) withString:revertUsername];
            //DDLogInfo(@"\niv:%@\nEncryptedToken:%@\nKey:%@", ivString, encryptedToken, keyUsername);
            
            NSError *error = nil;
            NSData *decryptedTokenData = [CommonMethods decryptedDataForData:encryptedToken iv:ivString key:keyUsername error:&error];
            
            if (!error) {
                NSString *rawToken = [[NSString alloc] initWithBytes:decryptedTokenData.bytes length:decryptedTokenData.length encoding:NSUTF8StringEncoding];
                //DDLogInfo(@"Raw token: %@", rawToken);
                
                NSArray *stringComponents = [rawToken componentsSeparatedByString:@"#ETG#"];
                if (stringComponents.count == 3 && [stringComponents[0] isEqualToString:username] && [stringComponents[2] isEqualToString:sharedToken.deviceId]) {
                    //Let user login
                    //DDLogInfo(@"Congrats. Token is correct");
                    
                    sharedToken.username = username;
                    
                    [UICKeyChainStore setString:encryptedToken forKey:kETGToken];
                    
                    //Update username & password in Keychain
                    if ([usernameInKeychain isEqualToString:username]) {
                        //Same username but difference password
                        if (![passwordInKeychain isEqualToString:password]) {
                            [UICKeyChainStore setString:password forKey:kETGPassword];
                        }
                    } else {
                        //Difference username or new username login
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"NewUSerNotif" object:self];

                        [UICKeyChainStore setString:username forKey:kETGUsername];
                        [UICKeyChainStore setString:password forKey:kETGPassword];
                        [[NSNotificationCenter defaultCenter] postNotificationName:kUserChanged object:nil];
                        [self deleteDataBaseAndClearCurrentView];
                    }
                    
                    [self showSlideMenu];

                } else {
                    _logInMessagePrompt.text = @"Authentication Error. Please try again";
                    DDLogError(@"Received a Fake Token");
                }
            } else {
                _logInMessagePrompt.text = @"Authentication Error. Please try again";
                DDLogError(@"Decrypted Token Error");
            }
            
        } failure:^(NSError * error) {
            DDLogError(@"Get token error: %@", error);
            
            //Offline
            if (usernameInKeychain.length == 0 || passwordInKeychain.length == 0 || error.code == 103 || error.code == 104) {

                _logInMessagePrompt.text = serverCannotBeReachedAlert;
                
            } else if ([usernameInKeychain isEqualToString:username] && [passwordInKeychain isEqualToString:password]) {

                [self showSlideMenu];

            } else if ((![usernameInKeychain isEqualToString:username] || ![passwordInKeychain isEqualToString:password] || (![usernameInKeychain isEqualToString:username] && ![passwordInKeychain isEqualToString:password])) && error.code != 102) {
                _logInMessagePrompt.text = @"Cannot verify username and password";
            } else if (error.code == 102) {
                _logInMessagePrompt.text = @"Invalid username and password";
            }
            
            [self stopSigningInAnimation];
        }];
        
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"LOGIN_USERNAME"];
    }
}

- (void)deleteDataBaseAndClearCurrentView
{
    //DDLogInfo(@"New user login(%@), truncate all entities in core data", _usernameField.text);
    for (NSEntityDescription *entity in [NSManagedObjectModel defaultManagedObjectModel].entities) {
        if([entity.name isEqualToString:NSStringFromClass([ETGPllLessons class])] || [entity.name isEqualToString:NSStringFromClass([ETGUacPermission class])])
        {
            continue;
        }
        [NSClassFromString(entity.name) truncateAll];
    }
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
    [[ETGCoreDataUtilities sharedCoreDataUtilities] clearAllTimeStampInUserDefaults];
    [self clearCurrentView];
}

- (void)clearCurrentView {
    //Remove all loaded view controllers
    NSDictionary *loadViewControllers = self.sidePanelController.loadedViewControllers;
    for (NSString *viewControllerClassName in loadViewControllers.allKeys) {
        if ([viewControllerClassName isEqualToString:NSStringFromClass([ETGProjectViewController class])]) {
            ETGProjectViewController *projectVC = loadViewControllers[viewControllerClassName];
            [projectVC clearWebView];
        }
        
        if ([viewControllerClassName isEqualToString:NSStringFromClass([ETGPortfolioScorecardViewController class])]) {
            ETGPortfolioScorecardViewController *portfolioVC = loadViewControllers[viewControllerClassName];
            [portfolioVC clearWebView];
        }
        
        if ([viewControllerClassName isEqualToString:NSStringFromClass([ETGManpowerViewController class])]) {
            ETGManpowerViewController *manPowerVC = loadViewControllers[viewControllerClassName];
            [manPowerVC clearWebView];
        }

    }
    
    [self.sidePanelController.loadedViewControllers removeAllObjects];
    

}

- (void)showSlideMenu {
    
//    if (_didLogOut) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//        LeftViewController *leftViewController = (LeftViewController *)self.sidePanelController.leftPanel;
//        [leftViewController setShouldCheckModuleAccessPermission:YES];
//    } else {
        [self.sidePanelController setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:kLeftViewController]];
        [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:kHomeViewController]];
//    }

    [self dismissViewControllerAnimated:YES completion:nil];

    [(ELCUIApplication *)[UIApplication sharedApplication] resetIdleTimer];
}

/**  Method is called by Sign In button to check if the user entered any text in both the username and password fields and prompts the user to enter a valid text if fields are found empty. **/
-(BOOL)evaluateUserCredentials {

    if (_usernameField.text.length == 0 & _passwordField.text.length > 0) {
        _logInMessagePrompt.text = @"Invalid username.";
        return NO;
        
    } else if (_usernameField.text.length > 0 & _passwordField.text.length == 0) {
        _logInMessagePrompt.text = @"Invalid password.";
        return NO;
        
    } else if (_usernameField.text.length == 0 & _passwordField.text.length == 0) {
        _logInMessagePrompt.text = @"Please enter usename and password.";
        return NO;
    }
    
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
       (interfaceOrientation == UIInterfaceOrientationLandscapeRight))  {
        return YES;
    }
    return NO;
}


#pragma mark - TokenDelegate

-(void)setErrorLoginMessage:(NSString *)errorMessage
{
    //Could not connect to the server.
    if ([errorMessage isEqualToString:@"The request timed out."] | [errorMessage isEqualToString:@"Could not connect to the server."]){
        if ([self evaluateUserCredentials]) {
            NSString *password = [UICKeyChainStore stringForKey:kETGPassword];
            if (password == nil || ![password isEqualToString:_passwordField.text]) {
                _logInMessagePrompt.text = @"Invalid username and password.";
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Offline" message:serverCannotBeReachedAlert delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alertView show];
                [self showSlideMenu];
            }
        }
    } else{
        _logInMessagePrompt.text = errorMessage;
    }
}


@end
