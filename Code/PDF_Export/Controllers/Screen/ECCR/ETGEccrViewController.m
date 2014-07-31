//
//  ETGEccrViewController.m
//  ETG
//
//  Created by Tan Aik Keong on 1/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGEccrViewController.h"
#import "ETGEccrModelController.h"
#import "ETGNetworkConnection.h"
#import "ETGEccrAbrFiltersViewController.h"
#import "ETGEccrCpbFiltersViewController.h"
#import "ETGEccrCpsFiltersViewController.h"
#import "ETGFilterModelController.h"
#import "ETGCoreDataUtilities.h"
#import "ETGCostCategory.h"
#import "CommonMethods.h"
#import "Reachability.h"
#import "ETGEccrAbrWebService.h"
#import "ETGEccrCpbWebService.h"
#import "ETGEccrCpsWebService.h"
#import "ETGJsonHelper.h"
#import "ETGCostAllocation.h"
#import "ETGRegion.h"
#import "ETGOperatorship.h"

typedef enum
{
    EccrTabCpb,
    EccrTabAbr,
    EccrTabCps,
} EccrTab;

@interface ETGEccrViewController ()<UIWebViewDelegate, UIGestureRecognizerDelegate, ETGFiltersViewControllerDelegate, UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filtersBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateBarButtonItem;
@property (nonatomic) UIPopoverController *cpbFilterPopoverController;
@property (nonatomic) UIPopoverController *abrFilterPopoverController;
@property (nonatomic) UIPopoverController *cpsFilterPopoverController;
@property (nonatomic) NSArray *selectedRowsInCpbFilter;
@property (nonatomic) NSArray *selectedRowsInAbrFilter;
@property (nonatomic) NSArray *selectedRowsInCpsFilter;
@property (nonatomic) BOOL isCpbLoading;
@property (nonatomic) BOOL isAbrLoading;
@property (nonatomic) BOOL isCpsLoading;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIBarButtonItem *activityIndicatorBarButtonItem;
@property (nonatomic) NSDictionary *filteredProjectsDictionaryCpb;
@property (nonatomic) NSDictionary *filteredProjectsDictionaryAbr;
@property (nonatomic) NSDictionary *filteredProjectsDictionaryCps;
@property (nonatomic, strong) NSString *requestString;
@property (nonatomic, strong) ETGAppDelegate *appDelegate;
@property (nonatomic) EccrTab selectedTab;
@property (nonatomic) int previousSelectedSegmentedControlIndex;
@property (nonatomic, strong) NSString *cpbJsonString;
@property (nonatomic, strong) NSString *abrJsonString;
@property (nonatomic, strong) NSString *cpsJsonString;
@property (nonatomic) BOOL shouldUpdateFilterErrorMessage;
@property (nonatomic) BOOL shouldAutoRefreshWhenConnectionRestored;
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic) NSString *lastSelectedTabInCps;
- (IBAction)tapUpdateBarButtonItem:(id)sender;
- (IBAction)toggleWebview:(id)sender;

@end

@implementation ETGEccrViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self updateForUac];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilter) name:kDownloadFilterDataForEccrCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterWithErrorLoadingMessage) name:kDownloadFilterDataForEccrFailed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAutoRefreshFlagDueToNoConnection) name:kDownloadEccrShouldAutoRefresh object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDisplayForUserChanged) name:kUserChanged object:nil];
    [self setupReachability];
    
    self.selectedTab = [self getActualSelectedTab];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    
    // Create the activity indicator
    [self createUIActivityIndicator];
    
    // Set the navigation bar
    [self setNavigationBarWithActivityIndicator];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired = 2;
    tapGesture.delegate = self;
    [self.webView addGestureRecognizer:tapGesture];
    
    if([[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampInUserDefaultsMoreThanNumberOfDays:30 inModuleName:@"ECCRFilter"])
    {
        self.filtersBarButtonItem.enabled = NO;
        [[ETGFilterModelController sharedController] getEccrFilter];
    }
    else
    {
        [self fetchData:NO];
    }
}

-(void)updateDisplayForUserChanged
{
    [self updateForUac];
    self.cpbJsonString = @"";
    self.abrJsonString = @"";
    self.cpsJsonString = @"";
    self.previousSelectedSegmentedControlIndex = 0;
    self.selectedTab = [self getActualSelectedTab];
    self.selectedRowsInAbrFilter = @[];
    self.selectedRowsInCpbFilter = @[];
    self.selectedRowsInCpsFilter = @[];
    [[ETGFilterModelController sharedController] getEccrFilter];
}

-(void)updateForUac
{
    BOOL shouldShowCps = [ETGJsonHelper canAccessInUac:kEccrCostPerformanceSummaryKey];
    BOOL shouldShowCpb = [ETGJsonHelper canAccessInUac:kEccrCpbWaterfallChartKey];
    BOOL shouldShowAbr = [ETGJsonHelper canAccessInUac:kEccrAbrMonitoringKey];
    //shouldShowCpb = NO;
    //shouldShowCps = NO;
    NSString *title = @"";
    
    [self.segmentedControl removeAllSegments];
    if(shouldShowCpb)
    {
        [self.segmentedControl insertSegmentWithTitle:@"CPB" atIndex:0 animated:NO];
        title = @"CPB";
    }
    if(shouldShowAbr)
    {
        [self.segmentedControl insertSegmentWithTitle:@"ABR" atIndex:self.segmentedControl.numberOfSegments animated:NO];
        title = @"ABR";
    }
    if(shouldShowCps)
    {
        [self.segmentedControl insertSegmentWithTitle:@"CPS" atIndex:self.segmentedControl.numberOfSegments animated:NO];
        title = @"CPS";
    }
    
    [self.segmentedControl setSelectedSegmentIndex:0];
    
    if(self.segmentedControl.numberOfSegments == 1)
    {
        self.segmentedControl.hidden = YES;
        UILabel *lblTitle = [[UILabel alloc] init];
        lblTitle.text = title;
        lblTitle.backgroundColor = [UIColor clearColor];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.shadowColor = [UIColor whiteColor];
        lblTitle.shadowOffset = CGSizeMake(0, 1);
        lblTitle.font = [UIFont systemFontOfSize:16];
        [lblTitle sizeToFit];
        
        self.navigationItem.titleView = lblTitle;
    }
    else
    {
        self.segmentedControl.hidden = NO;
    }
}

-(EccrTab)getActualSelectedTab
{
    int selectedIndex = self.segmentedControl.selectedSegmentIndex;
    NSString *title = [self.segmentedControl titleForSegmentAtIndex:selectedIndex];
    if([title isEqualToString:@"CPB"])
        return EccrTabCpb;
    else if([title isEqualToString:@"ABR"])
        return EccrTabAbr;
    else if([title isEqualToString:@"CPS"])
        return EccrTabCps;
    else
        @throw [NSException exceptionWithName:@"Unsupported tab" reason:nil userInfo:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [ETGNetworkConnection checkAvailability];
    if (appDelegate.isNetworkServerAvailable == YES)
    {
        _updateBarButtonItem.enabled = YES;
    }
    else
    {
        _updateBarButtonItem.enabled = NO;
    }
}

-(void)fetchData:(BOOL)isManual
{
    //[_appDelegate startActivityIndicatorSmallGrey];
    [self configureNavigationBar];
    
    ETGEccrModelController *modelController = [ETGEccrModelController sharedModel];
    if(!isManual)
    {
        [self loadWebViewForCurrentSelectedTab];
    }
    switch (self.selectedTab)
    {
        case EccrTabCpb:
        {
            self.isCpbLoading = YES;
            [modelController getCpbForReportingMonth:[self getReportingMonthString] budgetHolderKeys:[self getCpbBudgetHolderKeys] projectKeys:[self getProjectsForTab:EccrTabCpb] isManualRefresh:isManual success:^(NSString *jsonString) {
                //NSLog(@"CPB JSON string is %@", jsonString);
                self.isCpbLoading = NO;
                ETGEccrCpbWebService *webService = [ETGEccrCpbWebService new];
                webService.filteredProjects = [self getProjectsForTab:EccrTabCpb];
                webService.filteredCostCategories = [self getCpbCostCategoriesKeys];
                webService.budgetHolderKeys = [self getCpbBudgetHolderKeys];
                self.cpbJsonString = [webService getOfflineData:[self getReportingMonthString]];
                if(self.selectedTab == EccrTabCpb)
                {
                    [self setNavigationBarWithoutActivityIndicator];
                    //[_appDelegate stopActivityIndicatorSmall];
                    [self populateHtmlData];
                }
            } failure:^(NSError *error) {
                self.isCpbLoading = NO;
                [self setNavigationBarWithoutActivityIndicator];
                //[_appDelegate stopActivityIndicatorSmall];
            }];
            break;
        }
        case EccrTabAbr:
        {
            self.isAbrLoading = YES;
            [modelController getAbrForReportingMonth:[self getReportingMonthString] projectKeys:[self getProjectsForTab:EccrTabAbr] isManualRefresh:isManual success:^(NSString *jsonString) {
                //NSLog(@"ABR JSON string is %@", jsonString);
                self.isAbrLoading = NO;
                ETGEccrAbrWebService *webService = [ETGEccrAbrWebService new];
                webService.filteredProjects = [self getProjectsForTab:EccrTabAbr];
                webService.filteredCostCategories = [self getAbrCostCategoriesKeys];
                self.abrJsonString = [webService getOfflineData:[self getReportingMonthString]];
                if(self.selectedTab == EccrTabAbr)
                {
                    [self setNavigationBarWithoutActivityIndicator];
                    [self populateHtmlData];
                }
            } failure:^(NSError *error) {
                self.isAbrLoading = NO;
                [self setNavigationBarWithoutActivityIndicator];
            }];
            break;
        }
        case EccrTabCps:
        {
            if([self getCpsProjectKey] != nil)
            {
                // Update top information first
                if([self.cpsJsonString length] == 0)
                {
                    ETGEccrCpsWebService *webService = [ETGEccrCpsWebService new];
                    self.cpsJsonString = [webService getOfflineDataTopInformation:[self getReportingMonthString] projectKey:[[self getCpsProjectKey] description] isNavigateFromWpb:self.lastSelectedTabInCps];
                    [self populateHtmlData];
                }
                
                self.isCpsLoading = YES;
                [modelController getCpsForReportingMonth:[self getReportingMonthString] projectKey:[[self getCpsProjectKey] description] isWpb:self.lastSelectedTabInCps isManualRefresh:isManual success:^(NSString *jsonString) {
                    self.isCpsLoading = NO;
                    //NSLog(@"CPS JSON string is %@", jsonString);
                    ETGEccrCpsWebService *webService = [ETGEccrCpsWebService new];
                    self.cpsJsonString = [webService getOfflineData:[self getReportingMonthString] projectKey:[[self getCpsProjectKey] description] isNavigateFromWpb:self.lastSelectedTabInCps];
                    if(self.selectedTab == EccrTabCps)
                    {
                        [self setNavigationBarWithoutActivityIndicator];
                        //[_appDelegate stopActivityIndicatorSmall];
                        [self populateHtmlData];
                    }
                } failure:^(NSError *error) {
                    self.isCpsLoading = NO;
                    [self setNavigationBarWithoutActivityIndicator];
                    //[_appDelegate stopActivityIndicatorSmall];
                }];
            }
            else
            {
                [self setNavigationBarWithoutActivityIndicator];
                //[_appDelegate stopActivityIndicatorSmall];
            }
            break;
        }
        default:
            break;
    }
}

-(void)updateLoadingDisplayForCurrentTab
{
    BOOL shouldShowLoading = NO;
    switch(self.selectedTab)
    {
        case EccrTabAbr:
            shouldShowLoading = self.isAbrLoading;
            break;
        case EccrTabCpb:
            shouldShowLoading = self.isCpbLoading;
            break;
        case EccrTabCps:
            shouldShowLoading = self.isCpsLoading;
            break;
    }
    if(shouldShowLoading)
    {
        [self configureNavigationBar];
        //[_appDelegate startActivityIndicatorSmallGrey];
    }
    else
    {
        [self setNavigationBarWithoutActivityIndicator];
        //[_appDelegate stopActivityIndicatorSmall];
    }
}

-(void)populateHtmlData
{
    switch(self.selectedTab)
    {
        case EccrTabAbr:
            [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populateWpbAbr(%@);", self.abrJsonString]];
            break;
        case EccrTabCpb:
            [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populateCpb(%@);", self.cpbJsonString]];
            break;
        case EccrTabCps:
            [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populateCps(%@);", self.cpsJsonString]];
            break;
    }
}

- (void)handleTap:(UIGestureRecognizer*)gestureRecognizer
{
    return;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        UITapGestureRecognizer *gesture = (UITapGestureRecognizer *)otherGestureRecognizer;
        if (gesture.numberOfTapsRequired == 2)
        {
            [otherGestureRecognizer.view removeGestureRecognizer:otherGestureRecognizer];
        }
    }
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.sidePanelController addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Hide filter view if currently visible
    [self dismissAllFiltersViewController];
    
    @try
    {
        [ETGAlert sharedAlert].alertShown = NO;
        [self.sidePanelController removeObserver:self forKeyPath:@"state"];
    }
    @catch (NSException *exception)
    {
        // Handle exception here
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // Observer for side panel changes
    if ([keyPath isEqualToString:@"state"])
    {
        JASidePanelState newState = (JASidePanelState)[[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (newState == JASidePanelLeftVisible)
        {
            // Hide filter view if currently visible
            [self dismissAllFiltersViewController];
        }
    }
}

-(void)dismissAllFiltersViewController
{
    [self.cpbFilterPopoverController dismissPopoverAnimated:NO];
    self.cpbFilterPopoverController = nil;
    
    [self.abrFilterPopoverController dismissPopoverAnimated:NO];
    self.abrFilterPopoverController = nil;
    
    [self.cpsFilterPopoverController dismissPopoverAnimated:NO];
    self.cpsFilterPopoverController = nil;
}

#pragma mark - UIWebView Delegates
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.requestString = [[request URL] absoluteString];
    NSString *type = [self stringBetweenString:@"type=%22" andString:@"%22&value=" inputString:self.requestString];
    NSString *value = [self stringBetweenString:@"value=%22" andString:@"%22" inputString:self.requestString];
    
    if ([_requestString rangeOfString:@"ETG?module=%22ECCR%22"].location != NSNotFound)
    {
        if([type rangeOfString:@"justification"].location != NSNotFound)
        {
            // Display popup
            ETGEccrModelController *modelController = [ETGEccrModelController sharedModel];
            NSString *justifications = [modelController getJustififcationForInputType:type inputValue:value reportingMonth:[self getReportingMonthString] projectKey:[[self getCpsProjectKey] description]];
            [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover(%@);", justifications]];
        }
        else if([type rangeOfString:@"changetab"].location != NSNotFound)
        {
            self.lastSelectedTabInCps = value;
        }
        else if([type rangeOfString:@"navigateToCPS"].location != NSNotFound)
        {
            // Show CPS from CPB
            self.cpsJsonString = nil;
            NSArray *projects = [CommonMethods searchEntityForName:@"ETGProject" withID:@([value integerValue]) context:[NSManagedObjectContext defaultContext]];
            if([projects count] > 0)
            {
                self.lastSelectedTabInCps = @"CPB";
                NSMutableDictionary *temp = [self.filteredProjectsDictionaryCps mutableCopy];
                if(nil == temp)
                {
                    temp = [NSMutableDictionary new];
                }
                temp[kSelectedProjects] = @[projects[0]];
                if(nil == self.filteredProjectsDictionaryCpb[kSelectedReportingMonth])
                {
                    temp[kSelectedReportingMonth] = [CommonMethods latestReportingMonth];
                }
                else
                {
                    temp[kSelectedReportingMonth] = self.filteredProjectsDictionaryCpb[kSelectedReportingMonth];
                }
                
                NSArray *cpbSelectedRows = [self getCurrentSelectedRows];
                NSMutableArray *cpsSelectedRows = [self.selectedRowsInCpsFilter mutableCopy];
                if(nil == cpsSelectedRows)
                {
                    cpsSelectedRows = [NSMutableArray new];
                }
                // Set selected project
                NSArray *projects2 = [[ETGFilterModelController sharedController] fetchEccrProjectsBaseOnReportingMonth:[self getReportingMonthString]];
                int index = [projects2 indexOfObject:projects[0]];
                cpsSelectedRows[0] = @[@(index)];
                // Set reporting period
                if(nil != cpbSelectedRows)
                {
                    cpsSelectedRows[1] = cpbSelectedRows[5];
                }
                else
                {
                    cpsSelectedRows[1] = @[[CommonMethods latestReportingMonth]];
                }
                self.selectedRowsInCpsFilter = cpsSelectedRows;
                
                self.filteredProjectsDictionaryCps = temp;
                [self.segmentedControl setSelectedSegmentIndex:EccrTabCps];
                [self toggleWebview:self.segmentedControl];
                [self loadWebViewForCurrentSelectedTab];
            }
        }
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if([self.requestString rangeOfString:@"ETGECCRCPB"].location != NSNotFound)
    {
        self.lastSelectedTabInCps = @"";
        [self populateHtmlData];
    }
    else if([self.requestString rangeOfString:@"ETGECCRCPS"].location != NSNotFound)
    {
        [self populateHtmlData];
    }
    else if([self.requestString rangeOfString:@"ETGECCRWPBABR"].location != NSNotFound)
    {
        self.lastSelectedTabInCps = @"";
        [self populateHtmlData];
    }
}

#pragma mark - Navigation Bar and Activity Indicator
- (void)configureNavigationBar
{
    [self createUIActivityIndicator];
    [self setNavigationBarWithActivityIndicator];
}

- (void)createUIActivityIndicator
{
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    _activityIndicatorBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_activityIndicator];
}

- (void)setNavigationBarWithActivityIndicator
{
    self.navigationItem.rightBarButtonItems = nil;
    self.navigationItem.rightBarButtonItems = @[self.filtersBarButtonItem, _activityIndicatorBarButtonItem];
    [_activityIndicator startAnimating];
}

- (void)setNavigationBarWithoutActivityIndicator
{
    self.navigationItem.rightBarButtonItems = nil;
    self.navigationItem.rightBarButtonItems = @[_filtersBarButtonItem, _updateBarButtonItem];
    [_activityIndicator stopAnimating];
}

- (IBAction)tapUpdateBarButtonItem:(id)sender
{
    // Hide filter view if currently visible
    [self dismissAllFiltersViewController];
    [self fetchData:YES];
}

- (IBAction)toggleWebview:(id)sender
{
    [self dismissAllFiltersViewController];
    UISegmentedControl *toggle = sender;
    if(toggle.selectedSegmentIndex == self.previousSelectedSegmentedControlIndex)
    {
        return;
    }
    
    self.previousSelectedSegmentedControlIndex = toggle.selectedSegmentIndex;
    self.selectedTab = [self getActualSelectedTab];
    [self fetchData:NO];
    [self updateLoadingDisplayForCurrentTab];
}

#pragma mark - Filters

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:[self getCurrentFilterSegue]])
    {
        NSArray *targetSelectedRows = [self getCurrentSelectedRows];
        ETGFiltersViewController *filterViewController = (ETGFiltersViewController *)[(UINavigationController *)segue.destinationViewController topViewController];
        [filterViewController setDelegate:self];
        [filterViewController setSelectedRowsInFilter:targetSelectedRows];
        filterViewController.shouldUpdateFilterErrorMessage = self.shouldUpdateFilterErrorMessage;
        
        UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
        switch(self.selectedTab)
        {
            case EccrTabCpb:
            {
                self.cpbFilterPopoverController = popoverController;
                break;
            }
            case EccrTabAbr:
            {
                self.abrFilterPopoverController = popoverController;
                break;
            }
            case EccrTabCps:
            {
                self.cpsFilterPopoverController = popoverController;
                break;
            }
            default:
                @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
        }
        [popoverController setDelegate:self];
    }
}

- (IBAction)toggleFiltersPopover:(id)sender
{
    switch(self.selectedTab)
    {
        case EccrTabCpb:
        {
            if(self.cpbFilterPopoverController)
            {
                [self.cpbFilterPopoverController dismissPopoverAnimated:NO];
                self.cpbFilterPopoverController = nil;
            }
            else
            {
                [self performSegueWithIdentifier:[self getCurrentFilterSegue] sender:sender];
            }
            break;
        }
        case EccrTabAbr:
        {
            if(self.abrFilterPopoverController)
            {
                [self.abrFilterPopoverController dismissPopoverAnimated:NO];
                self.abrFilterPopoverController = nil;
            }
            else
            {
                [self performSegueWithIdentifier:[self getCurrentFilterSegue] sender:sender];
            }
            break;
        }
        case EccrTabCps:
        {
            if(self.cpsFilterPopoverController)
            {
                [self.cpsFilterPopoverController dismissPopoverAnimated:NO];
                self.cpsFilterPopoverController = nil;
            }
            else
            {
                [self performSegueWithIdentifier:[self getCurrentFilterSegue] sender:sender];
            }
            break;
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
}


#pragma mark - Filter Delegate

- (void)filtersViewControllerDidCancel
{
    switch(self.selectedTab)
    {
        case EccrTabCpb:
        {
            [self.cpbFilterPopoverController dismissPopoverAnimated:NO];
            self.cpbFilterPopoverController = nil;
            break;
        }
        case EccrTabAbr:
        {
            [self.abrFilterPopoverController dismissPopoverAnimated:NO];
            self.abrFilterPopoverController = nil;
            break;
        }
        case EccrTabCps:
        {
            [self.cpsFilterPopoverController dismissPopoverAnimated:NO];
            self.cpsFilterPopoverController = nil;
            break;
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
}

- (void)filtersViewControllerDidFinishWithProjectsDictionary:(NSDictionary *)filteredProjectsDictionary
{
    switch(self.selectedTab)
    {
        case EccrTabCpb:
        {
            self.filteredProjectsDictionaryCpb = filteredProjectsDictionary;
            [self.cpbFilterPopoverController dismissPopoverAnimated:YES];
            self.cpbFilterPopoverController = nil;
            break;
        }
        case EccrTabAbr:
        {
            self.filteredProjectsDictionaryAbr = filteredProjectsDictionary;
            [self.abrFilterPopoverController dismissPopoverAnimated:YES];
            self.abrFilterPopoverController = nil;
            break;
        }
        case EccrTabCps:
        {
            self.filteredProjectsDictionaryCps = filteredProjectsDictionary;
            [self.cpsFilterPopoverController dismissPopoverAnimated:YES];
            self.cpsFilterPopoverController = nil;
            break;
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
    
    [self fetchData:NO];
}

-(BOOL)needRefreshWithProjectDictionary:(NSDictionary *)projectDictionary
{
    NSDate *selectedMonth = projectDictionary[kSelectedReportingMonth];
    NSString *reportingMonth = @"";
    if(nil != selectedMonth)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        reportingMonth = [formatter stringFromDate:selectedMonth];
    }
    
    switch(self.selectedTab)
    {
        case EccrTabCpb:
        {
            ETGEccrCpbWebService *w = [ETGEccrCpbWebService new];
            NSArray *selectedKeys = projectDictionary[kSelectedBudgetHolder];
            if(selectedKeys != nil && [selectedKeys count] > 0)
            {
                ETGCostAllocation *allocation = selectedKeys[0];
                w.filteredProjects = projectDictionary[kSelectedProjects];
                w.budgetHolderKeys = @[allocation.key];
                return [w needRefreshDataWithReportingMonth:reportingMonth];
            }
            break;
        }
        case EccrTabAbr:
        {
            ETGEccrAbrWebService *w = [ETGEccrAbrWebService new];
            w.filteredProjects = projectDictionary[kSelectedProjects];
            return [w needRefreshDataForReportingMonth:reportingMonth];
        }
        case EccrTabCps:
        {
            ETGEccrCpsWebService *w = [ETGEccrCpsWebService new];
            NSArray *selectedKeys = projectDictionary[kSelectedProjects];
            if([selectedKeys count] > 0)
            {
                ETGProject *p = selectedKeys[0];
                return [w needRefreshDataWithReportingMonth:reportingMonth projectKey:[p.key description]];
            }
            break;
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
    
    return NO;
}

- (void)filtersviewControllerDidDismiss:(NSArray *)selectedRowsInFilter withSender:(id)sender
{
    if([sender isKindOfClass:[ETGEccrCpbFiltersViewController class]])
    {
        self.selectedRowsInCpbFilter = selectedRowsInFilter;
    }
    else if([sender isKindOfClass:[ETGEccrAbrFiltersViewController class]])
    {
        self.selectedRowsInAbrFilter = selectedRowsInFilter;
    }
    else if([sender isKindOfClass:[ETGEccrCpsFiltersViewController class]])
    {
        self.selectedRowsInCpsFilter = selectedRowsInFilter;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    switch(self.selectedTab)
    {
        case EccrTabCpb:
        {
            self.cpbFilterPopoverController = nil;
            break;
        }
        case EccrTabAbr:
        {
            self.abrFilterPopoverController = nil;
            break;
        }
        case EccrTabCps:
        {
            self.cpsFilterPopoverController = nil;
            break;
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
}

-(NSString *)getReportingMonthStringFromFitleredDictionary:(NSDictionary *)dictionary
{
    NSDate *selectedMonth = dictionary[kSelectedReportingMonth];
    if(nil != selectedMonth)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        return [formatter stringFromDate:selectedMonth];
    }
    return [CommonMethods latestReportingMonthString];
}

-(NSString *)getReportingMonthString
{
    NSString *targetReportingMonthString = [self getReportingMonthStringFromFitleredDictionary:[self getCurrentFilteredDictionary]];
    if(nil == targetReportingMonthString)
    {
        NSDate *latestReportingMonth = [CommonMethods latestReportingMonth];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        return [formatter stringFromDate:latestReportingMonth];
    }
    return targetReportingMonthString;
}

-(NSMutableArray *)getCostAllocationWithoutEmptyValue
{
    NSArray *results = [CommonMethods fetchEntity:@"ETGCostAllocation" sortDescriptorKey:@"name" inManagedObjectContext:[NSManagedObjectContext defaultContext]];
    NSMutableArray *temp = [NSMutableArray new];
    for(ETGCostAllocation *allocation in results)
    {
        if([allocation.name length] > 0)
        {
            [temp addObject:allocation];
        }
    }
    return temp;
}

-(NSArray *)getCpbBudgetHolderKeys
{
    NSArray *selectedKeys = self.filteredProjectsDictionaryCpb[kSelectedBudgetHolder];
    if(selectedKeys != nil && [selectedKeys count] > 0)
    {
        ETGCostAllocation *allocation = selectedKeys[0];
        return @[allocation.key];
    }
    
    NSArray *allKeys = [self getCostAllocationWithoutEmptyValue];
    if(allKeys != nil && [allKeys count] > 0)
    {
        for (NSInteger i = 0; i < [allKeys count]; i++)
        {
            ETGCostAllocation *allocation = (ETGCostAllocation *)allKeys[i];
            if([allocation.name isEqualToString:@"Projects & Engineering"])
            {
                return @[allocation.key];
            }
        }
    }
    return nil;
}

-(NSArray *)getProjectsForTab:(EccrTab)selectedTab
{
    NSDictionary *selectedDictionary = nil;
    if(selectedTab == EccrTabAbr)
    {
        selectedDictionary = self.filteredProjectsDictionaryAbr;
    }
    else if(selectedTab == EccrTabCpb)
    {
        selectedDictionary = self.filteredProjectsDictionaryCpb;
    }
    NSArray *selectedProjects = selectedDictionary[kSelectedProjects];
    if(selectedProjects != nil && [selectedProjects count] > 0)
    {
        return selectedProjects;
    }
    
    NSString *date = [self getReportingMonthStringFromFitleredDictionary:selectedDictionary];
    NSMutableArray *regions = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGRegion" sortDescriptorKey:@"name" inManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    NSMutableArray *selectedRegionKeys = [NSMutableArray new];
    for (ETGRegion *row in regions)
    {
        [selectedRegionKeys addObject:row.key];
    }
    
    if(self.selectedTab == EccrTabAbr)
    {
        return [[ETGFilterModelController sharedController] fetchEccrProjectsBaseOnRegions:selectedRegionKeys reportingMonth:date];
    }
    else
    {
        NSMutableArray *operatorships = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGOperatorship" sortDescriptorKey:@"name" inManagedObjectContext:[NSManagedObjectContext defaultContext]]];
        NSMutableArray *selectedOperatorshipKeys = [NSMutableArray new];
        for (ETGOperatorship *row in operatorships)
        {
            [selectedOperatorshipKeys addObject:row.key];
        }
        return [[ETGFilterModelController sharedController] fetchEccrProjectsBaseOnOperatorships:selectedOperatorshipKeys regions:selectedRegionKeys reportingMonth:date];
    }
}

-(NSArray *)getCpbCostCategoriesKeys
{
    NSArray *selectedKeys = self.filteredProjectsDictionaryCpb[kSelectedCostCategory];
    if([selectedKeys count] > 0)
    {
        return selectedKeys;
    }
    
    NSArray *temp = [CommonMethods fetchEntity:@"ETGCostCategory" sortDescriptorKey:@"name" inManagedObjectContext:[NSManagedObjectContext defaultContext]];
    if([temp count] > 0)
    {
        return @[temp[0]];
    }
    return nil;
}

-(NSArray *)getAbrCostCategoriesKeys
{
    NSArray *selectedKeys = self.filteredProjectsDictionaryAbr[kSelectedCostCategory];
    if([selectedKeys count] > 0)
    {
        return selectedKeys;
    }
    
    NSArray *temp = [CommonMethods fetchEntity:@"ETGCostCategory" sortDescriptorKey:@"name" inManagedObjectContext:[NSManagedObjectContext defaultContext]];
    if([temp count] > 0)
    {
        return @[temp[0]];
    }
    return nil;
}

-(NSNumber *)getCpsProjectKey
{
    NSArray *selectedKeys = self.filteredProjectsDictionaryCps[kSelectedProjects];
    if([selectedKeys count] > 0)
    {
        ETGProject *p = selectedKeys[0];
        return p.key;
    }
    
    NSArray *fetchedProjectObjects = [[ETGFilterModelController sharedController] fetchEccrProjectsBaseOnReportingMonth:[self getReportingMonthString]];
    if([fetchedProjectObjects count] > 0)
    {
        ETGProject *p = fetchedProjectObjects[0];
        return p.key;
    }
    return nil;
}

-(NSDictionary *)getCurrentFilteredDictionary
{
    switch(self.selectedTab)
    {
        case EccrTabCpb:
        {
            return self.filteredProjectsDictionaryCpb;
        }
        case EccrTabAbr:
        {
            return self.filteredProjectsDictionaryAbr;
        }
        case EccrTabCps:
        {
            return self.filteredProjectsDictionaryCps;
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
}

-(NSArray *)getCurrentSelectedRows
{
    switch(self.selectedTab)
    {
        case EccrTabCpb:
        {
            return self.selectedRowsInCpbFilter;
        }
        case EccrTabAbr:
        {
            return self.selectedRowsInAbrFilter;
        }
        case EccrTabCps:
        {
            return self.selectedRowsInCpsFilter;
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
}

-(NSString *)getCurrentFilterSegue
{
    switch(self.selectedTab)
    {
        case EccrTabCpb:
        {
            return @"showCpbFilter";
        }
        case EccrTabAbr:
        {
            return @"showAbrFilter";
        }
        case EccrTabCps:
        {
            return @"showCpsFilter";
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
}

-(void)loadWebViewForCurrentSelectedTab
{
    NSString *fileName = nil;
    switch (self.selectedTab)
    {
        case EccrTabAbr:
            fileName = @"ETGECCRWPBABR";
            break;
        case EccrTabCpb:
            fileName = @"ETGECCRCPB";
            break;
        case EccrTabCps:
            fileName = @"ETGECCRCPS";
            break;
        default:
            break;
    }
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html" inDirectory:@"Charts"];
    NSURL *url = [NSURL fileURLWithPath:htmlFile];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[self.webView scrollView] setBounces: NO];
    self.webView.scrollView.scrollEnabled = NO;
    [self.webView setOpaque:NO];
    [self.webView setClearsContextBeforeDrawing:YES];
    [self.webView loadRequest:request];
}

-(NSString*)stringBetweenString:(NSString *)start andString:(NSString *)end inputString:(NSString *)inputString
{
    NSRange startRange = [inputString rangeOfString:start];
    if (startRange.location != NSNotFound)
    {
        NSRange targetRange;
        targetRange.location = startRange.location + startRange.length;
        targetRange.length = [inputString length] - targetRange.location;
        NSRange endRange = [inputString rangeOfString:end options:0 range:targetRange];
        if (endRange.location != NSNotFound)
        {
            targetRange.length = endRange.location - targetRange.location;
            return [inputString substringWithRange:targetRange];
        }
    }
    return nil;
}

-(void)updateAutoRefreshFlagDueToNoConnection
{
    self.shouldAutoRefreshWhenConnectionRestored = YES;
}

-(void)reloadFilter
{
    self.filtersBarButtonItem.enabled = YES;
    self.shouldUpdateFilterErrorMessage = NO;
    [self fetchData:NO];
}

-(void)reloadFilterWithErrorLoadingMessage
{
    self.shouldUpdateFilterErrorMessage = YES;
    [self fetchData:NO];
}

-(void)setupReachability
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    NSString *serverAddress = [[NSURL URLWithString:kBaseURL] host];
    self.reachability = [Reachability reachabilityWithHostName:serverAddress];
    [self.reachability startNotifier];
}

-(void)reachabilityChanged:(NSNotification *)notification
{
    NetworkStatus networkStatus = [self.reachability currentReachabilityStatus];
    if(networkStatus != NotReachable)
    {
        if(self.shouldAutoRefreshWhenConnectionRestored)
        {
            [self performSelector:@selector(fetchData:) withObject:@(NO) afterDelay:1];
            self.shouldAutoRefreshWhenConnectionRestored = NO;
        }
        self.updateBarButtonItem.enabled = YES;
    }
    else
    {
        self.updateBarButtonItem.enabled = NO;
    }
}

@end
