//
//  LeftViewController.m
//  ETG
//
//  Created by Tony Pham on 8/13/13.
//  Copyright (c) 2013 Petronas. All rights reserved.
//

#import "LeftViewController.h"
#import <AFNetworking.h>
#import "ETGPortfolioScorecardViewController.h"
#import "ETGProjectViewController.h"
#import "ETGLoginViewController.h"
#import "ETGHomeViewController.h"
#import <RestKit/RestKit.h>
#import "ETGJsonHelper.h"
#import "ETGManpowerViewController.h"
#import "ETGUacPermission.h"

#define kItemImageName @"kItemImageName"
#define kItemTitle @"kItemTitle"
#define kItemViewController @"kItemViewController"
#define kItemKey @"kItemKey"
#define kItemOrder @"kItemOrder"
#define kEnableReports @"kEnableReports"

@interface LeftViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIView *errorLoadingView;
@property (nonatomic) NSArray *fullModuleArray;
@property (nonatomic) NSArray *supportModuleArray;
@property (nonatomic) NSMutableArray *filteredMenuArray;
@property (nonatomic, strong) UIViewController *portfolioViewController;
@property (nonatomic, strong) UIViewController *projectViewController;
@property (nonatomic, strong) UIViewController *manpowerViewController;
@property (nonatomic, strong) UIViewController *homeViewController;

@end

@implementation LeftViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lockOutApp) name:@"TokenExpired" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prepareForNewUser) name:@"NewUSerNotif" object:nil];


    [self configureAllModuleItems];
    [self getEnableModulesAndReports];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create Portfolio view controller
    if (!_portfolioViewController) {
        _portfolioViewController = [self.storyboard instantiateViewControllerWithIdentifier:kPortfolioViewController];
    }
    // Create Project view controller
    if (!_projectViewController) {
        _projectViewController = [self.storyboard instantiateViewControllerWithIdentifier:kProjectViewController];
    }
    
    // Create Project view controller
    if (!_manpowerViewController) {
        _manpowerViewController = [self.storyboard instantiateViewControllerWithIdentifier:kManpowerViewController];
    }
    // Set Home view controller
    if (!_homeViewController) {
        if ([self.sidePanelController.centerPanel isKindOfClass:[ETGHomeViewController class]]) {
            _homeViewController = (ETGHomeViewController*)self.sidePanelController.centerPanel;
        }
    }
    
    if (_shouldCheckModuleAccessPermission) {
        [_filteredMenuArray removeAllObjects];
        _filteredMenuArray = [[NSMutableArray alloc] initWithObjects:_supportModuleArray, nil];
        [self getEnableModulesAndReports];
        _shouldCheckModuleAccessPermission = NO;
    }
}


- (void)configureAllModuleItems
{
    NSMutableDictionary *portfolioDictionary = [[NSMutableDictionary alloc] initWithDictionary:
  @{kItemImageName: @"icon_portfolio", kItemTitle: @"Portfolio", kItemViewController: kPortfolioViewController, kItemOrder: @1, kItemKey: kPortfolioModuleKeys}];
    NSMutableDictionary *projectDictionary = [[NSMutableDictionary alloc] initWithDictionary:
  @{kItemImageName: @"icon_project", kItemTitle: @"Project", kItemViewController: kProjectViewController, kItemOrder: @2, kItemKey: kProjectModuleKeys}];
    NSMutableDictionary *mapDictionary = [[NSMutableDictionary alloc] initWithDictionary:
  @{kItemImageName: @"icon_map", kItemTitle: @"Milestone Assurance", kItemViewController: kMAPViewController, kItemOrder: @3, kItemKey: kMapModuleKeys}];
    NSMutableDictionary *pllDictionary = [[NSMutableDictionary alloc] initWithDictionary:
  @{kItemImageName: @"icon_pll", kItemTitle: @"Lessons", kItemViewController: kPLLViewController, kItemOrder: @4, kItemKey: kPllModuleKeys}];
    NSMutableDictionary *resourcesDictionary = [[NSMutableDictionary alloc] initWithDictionary:
  @{kItemImageName: @"icon_resources", kItemTitle: @"Resources", kItemViewController: kManpowerViewController, kItemOrder: @6, kItemKey: kResourcesModuleKeys}];
    NSMutableDictionary *libraryDictionary = [[NSMutableDictionary alloc] initWithDictionary:
  @{kItemImageName: @"icon_library", kItemTitle: @"Library", kItemViewController: kLibraryViewController, kItemOrder: @7, kItemKey: kLibraryModuleKeys}];
    
    NSDictionary *homeDictionary = @{kItemImageName: @"icon_home", kItemTitle: @"Home", kItemViewController: kHomeViewController, kItemOrder: @8};
    NSDictionary *helpDictionary = @{kItemImageName: @"icon_help", kItemTitle: @"Help", kItemViewController: kHelpViewController, kItemOrder: @9};
    NSDictionary *logoutDictionary = @{kItemImageName: @"icon_signout", kItemTitle: @"Log Out", kItemOrder: @10};
    
    _fullModuleArray = @[portfolioDictionary,
                         projectDictionary,
                         mapDictionary,
                         pllDictionary,
                         resourcesDictionary,
                         libraryDictionary];

    _supportModuleArray = @[homeDictionary, helpDictionary, logoutDictionary];
    _filteredMenuArray = [[NSMutableArray alloc] initWithObjects:_supportModuleArray, nil];
}

- (void)getEnableModulesAndReports
{
    NSString *etgDashboardPath = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, kGetETGDashboard];
    NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:etgDashboardPath httpMethod:@"GET"];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                                         ^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
                                             [self saveEnableModulesAndReportsJSONToFile:json];
                                             [self handleETGDashboardOutput:json];
                                             [[NSNotificationCenter defaultCenter] postNotificationName:kDifferentUserLoggedIn object:nil];

                                             
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             [self loadEnableModulesAndReportsJSONFile];
                                            [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:response.allHeaderFields];
                                             
                                             DDLogError(@"Offline / Request left menu failed with Error: %@, %@", error, error.userInfo);
                                         }];
    
    operation.SSLPinningMode = AFSSLPinningModeCertificate;
    [operation start];
}

- (void)handleETGDashboardOutput:(id)json {
    //DDLogInfo(@"UAC JSON: %@", json);

    NSMutableArray *filterItems = [[NSMutableArray alloc] initWithCapacity:[_fullModuleArray count]];
    [filterItems addObject:_fullModuleArray[3]];
    
    //Add enable modules
    BOOL shouldEnableCostControlModule = NO;
    BOOL shouldEnableMPSModule = NO;
    for (NSDictionary *moduleDictionary in json) {
        if ([kCostModuleKeys containsObject:moduleDictionary[kModuleKey]]) {
            shouldEnableCostControlModule = YES;
        } else if ([kMPSModuleKeys containsObject:moduleDictionary[kModuleKey]]) {
            shouldEnableMPSModule = YES;
        } else {
            for (NSMutableDictionary *itemDictionary in _fullModuleArray) {
                if ([itemDictionary[kItemKey] containsObject:moduleDictionary[kModuleKey]]) {
                    [itemDictionary setObject:moduleDictionary[kEnableModuleReports] forKey:kEnableReports];
                    [filterItems addObject:itemDictionary];
                    break;
                }
            }
        }
    }
    if (shouldEnableCostControlModule) {
        NSMutableDictionary *costDictionary = [[NSMutableDictionary alloc] initWithDictionary:
                                               @{kItemImageName: @"icon_cost", kItemTitle: @"Cost Control", kItemViewController: kCostControlViewController, kItemOrder: @5, kItemKey: kCostModuleKeys}];
        [filterItems addObject:costDictionary];
    }
    if (shouldEnableMPSModule) {
        NSMutableDictionary *mpsDictionary = [[NSMutableDictionary alloc] initWithDictionary:
                                               @{kItemImageName: @"icon_resources", kItemTitle: @"Manpower", kItemViewController: kManpowerViewController, kItemOrder: @6, kItemKey: kMPSModuleKeys}];
        [filterItems addObject:mpsDictionary];
    }
    
    //Sort modules order
    NSArray *sortedFilterItems = [filterItems sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1[kItemOrder] compare:obj2[kItemOrder]];
    }];
    [_filteredMenuArray insertObject:sortedFilterItems atIndex:0];
    
    [self stopAndHideActivityIndicator];
    [self.tableView reloadData];
}

- (NSString *)getFilePath
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [pathArray[0] stringByAppendingPathComponent:@"enableModulesAndReports.json"];
}

- (void)saveEnableModulesAndReportsJSONToFile:(id)JSON
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:JSON options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        DDLogError(@"Serialize JSON to Data error: %@", error);
    }

    [ETGUacPermission truncateAll];
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
    ETGUacPermission *p = [ETGUacPermission insertInManagedObjectContext:[NSManagedObjectContext defaultContext]];
    p.content = jsonData;
    [[NSManagedObjectContext defaultContext] saveToPersistentStore:nil];
    
//    NSString *filePath = [self getFilePath];
//    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
//    if (!fileExist) {
//        //Create new file
//        [[NSFileManager defaultManager] createFileAtPath:filePath contents:jsonData attributes:nil];
//    } else {
//        //Update json
//        [jsonData writeToFile:filePath options:NSDataWritingFileProtectionNone error:nil];
//    }
}

- (void)loadEnableModulesAndReportsJSONFile
{
    ETGUacPermission *p = [ETGUacPermission findFirst];
    NSData *jsonData = p.content;
    if(nil != jsonData)
    {
        NSError *error = nil;
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if (!error)
        {
            [self handleETGDashboardOutput:jsonObject];
        }
        else
        {
            DDLogError(@"Serialize data to JSON error: %@", error);
        }
    }
    else
    {
        [_activityIndicator stopAnimating];
        _errorLoadingView.hidden = NO;
    }
    
//    NSString *filePath = [self getFilePath];
//    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
//        
//        NSError *error = nil;
//        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//        if (!error) {
//            [self handleETGDashboardOutput:jsonObject];
//        } else {
//            DDLogError(@"Serialize data to JSON error: %@", error);
//        }
//    } else {
//        [_activityIndicator stopAnimating];
//        _errorLoadingView.hidden = NO;
//    }
}

- (void)stopAndHideActivityIndicator {
    [_activityIndicator stopAnimating];
    [self.tableView setTableHeaderView:nil];
}

#pragma mark - Tap Gesture

- (IBAction)retryToGetEnableModulesAndReportsAgain:(id)sender {
    _errorLoadingView.hidden = YES;
    [_activityIndicator startAnimating];
    [self performSelector:@selector(getEnableModulesAndReports) withObject:nil afterDelay:0.5];
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_filteredMenuArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_filteredMenuArray objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return @" ";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];

    NSDictionary *cellDictionary = [[_filteredMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:cellDictionary[kItemImageName]];
    cell.imageView.highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_active", cellDictionary[kItemImageName]]];
    cell.textLabel.text = cellDictionary[kItemTitle];
    cell.textLabel.textColor = kPetronasGreenColor;
    cell.selectedBackgroundView.backgroundColor = kPetronasGreenColor;

    return cell;
}


#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellDictionary = [[_filteredMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSArray *lastArray = [_filteredMenuArray lastObject];
    NSIndexPath *logoutIndexPath = [NSIndexPath indexPathForRow:[lastArray indexOfObject:[lastArray lastObject]] inSection:[_filteredMenuArray indexOfObject:lastArray]];
    if ([indexPath isEqual:logoutIndexPath]) {
        [self showLogoutActionSheetForTable:tableView atIndexPath:indexPath];
    } else {
        if ([cellDictionary[kItemViewController] isEqualToString:kPortfolioViewController]) {
            ETGPortfolioScorecardViewController* portfolioVC = (ETGPortfolioScorecardViewController *)[(UINavigationController *)_portfolioViewController topViewController];
            [portfolioVC setEnableReports:cellDictionary[kEnableReports]];
            
            //Check Project module available
            NSArray *moduleSection = [_filteredMenuArray objectAtIndex:indexPath.section];
            for (NSDictionary *itemDictionary in moduleSection) {
                if ([itemDictionary[kItemViewController] isEqualToString:kProjectViewController]) {
                    [portfolioVC setEnableProjectReports:itemDictionary[kEnableReports]];
                    break;
                }
            }

            [self.sidePanelController setCenterPanel:_portfolioViewController];
        } else if ([cellDictionary[kItemViewController] isEqualToString:kProjectViewController]) {
            ETGProjectViewController* projectVC = (ETGProjectViewController *)[(UINavigationController *)_projectViewController topViewController];
            [projectVC setEnableReports:cellDictionary[kEnableReports]];
            [self.sidePanelController setCenterPanel:_projectViewController];
        } else if ([cellDictionary[kItemViewController] isEqualToString:kManpowerViewController]) {
            [self.sidePanelController setCenterPanel:_manpowerViewController];
        }
        else if ([cellDictionary[kItemViewController] isEqualToString:kHomeViewController]) {
            [self.sidePanelController setCenterPanel:_homeViewController];
        } else {
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:cellDictionary[kItemViewController]];
            [self.sidePanelController setCenterPanel:viewController];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UIActionSheetDelegate

- (void)showLogoutActionSheetForTable:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    UIActionSheet *signOutConfirm = [[UIActionSheet alloc] initWithTitle:@"Are you sure to log out?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Log Out" otherButtonTitles:@"Cancel", nil];
    CGRect signOutCellRect = [[tableView cellForRowAtIndexPath:indexPath] frame];
    signOutCellRect.origin.x = -730;
    [signOutConfirm showFromRect:signOutCellRect inView:tableView animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // Cancel pending background downloads
//        [[RKObjectManager sharedManager].operationQueue cancelAllOperations];
        [self clearWebViews];
        _shouldCheckModuleAccessPermission = YES;
        if (_homeViewController) {
            [self.sidePanelController setCenterPanel:_homeViewController];
        } else {
            _homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:kHomeViewController];
            [self.sidePanelController setCenterPanel:_homeViewController];
        }
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        ETGLoginViewController *loginViewController = [segue destinationViewController];
        loginViewController.didLogOut = YES;
    }
}

-(void)prepareForNewUser {
 
    [self clearWebViews];
    _shouldCheckModuleAccessPermission = YES;
    if (_homeViewController) {
        [self.sidePanelController setCenterPanel:_homeViewController];
    } else {
        _homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:kHomeViewController];
        [self.sidePanelController setCenterPanel:_homeViewController];
    }
   
}

-(void) lockOutApp {

    [self performSegueWithIdentifier:@"showLogin" sender:self];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clearWebViews
{
    ETGPortfolioScorecardViewController* portfolioVC = (ETGPortfolioScorecardViewController *)[(UINavigationController *)_portfolioViewController topViewController];
    [portfolioVC clearWebView];
    ETGProjectViewController* projectVC = (ETGProjectViewController *)[(UINavigationController *)_projectViewController topViewController];
    [projectVC clearWebView];
    
    ETGManpowerViewController* manpowerVC = (ETGManpowerViewController *)[(UINavigationController *)_manpowerViewController topViewController];
    [manpowerVC clearWebView];
}

@end
