//
//  ETGEccrViewController.m
//  ETG
//
//  Created by Tan Aik Keong on 1/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGManpowerViewController.h"
#import "ETGNetworkConnection.h"
#import "ETGManpowerAHCFilterViewController.h"
#import "ETGManpowerHCRFilterViewController.h"
#import "ETGManpowerLRFilterViewController.h"
#import "ETGFilterModelController.h"
#import "ETGCoreDataUtilities.h"
#import "CommonMethods.h"
#import "Reachability.h"
#import "ETGJsonHelper.h"
#import "ETGCostAllocation.h"
#import "ETGMpAhcWebService.h"
#import "ETGManPowerModelController.h"
#import "ETGDivision.h"
#import "ETGDepartment.h"
#import "ETGCountries.h"
#import "ETGProjectPosition.h"
#import "ETGMpLrWebService.h"
#import "ETGMpHcrWebService.h"
#import "ETGMpProject.h"
#import "ETGMpRegion.h"
#import "ETGMpCluster.h"
#import <RestKit/RestKit.h>

@interface ETGManpowerViewController ()<UIWebViewDelegate, UIGestureRecognizerDelegate, ETGFiltersViewControllerDelegate, UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filtersBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateBarButtonItem;
@property (nonatomic) UIPopoverController *AhcFilterPopoverController;
@property (nonatomic) UIPopoverController *HcrFilterPopoverController;
@property (nonatomic) UIPopoverController *LrFilterPopoverController;
@property (nonatomic) NSArray *selectedRowsInAhcFilter;
@property (nonatomic) NSArray *selectedRowsInHcrFilter;
@property (nonatomic) NSArray *selectedRowsInLrFilter;
@property (nonatomic) BOOL isAhcLoading;
@property (nonatomic) BOOL isHcrLoading;
@property (nonatomic) BOOL isLrLoading;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIBarButtonItem *activityIndicatorBarButtonItem;
@property (nonatomic) NSDictionary *filteredProjectsDictionaryAhc;
@property (nonatomic) NSDictionary *filteredProjectsDictionaryHcr;
@property (nonatomic) NSDictionary *filteredProjectsDictionaryLr;
@property (nonatomic, strong) NSString *requestString;
@property (nonatomic, strong) ETGAppDelegate *appDelegate;
@property (nonatomic) ManpowerTab selectedTab;
@property (nonatomic) NSInteger previousSelectedSegmentedControlIndex;
@property (nonatomic, strong) NSString *ahcJsonString;
@property (nonatomic, strong) NSString *hcrJsonString;
@property (nonatomic, strong) NSString *lrJsonString;
@property (nonatomic) BOOL shouldUpdateFilterErrorMessage;
@property (nonatomic) BOOL shouldAutoRefreshWhenConnectionRestored;
@property (nonatomic, strong) Reachability *reachability;
- (IBAction)tapUpdateBarButtonItem:(id)sender;
- (IBAction)toggleWebview:(id)sender;

@end

@implementation ETGManpowerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self updateForUac];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startFilter) name:kDownloadFilterDataForManpowerStarting object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilter) name:kDownloadFilterDataForManpowerCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterWithErrorLoadingMessage) name:kDownloadManpowerFilterDataForGivenReportingMonthFailed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAutoRefreshFlagDueToNoConnection) name:kDownloadManpowerShouldAutoRefresh object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDisplayForUserChanged) name:kDifferentUserLoggedIn object:nil];
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
    [self loadWebViewForCurrentSelectedTab];
    
    //    if([[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampInUserDefaultsMoreThanNumberOfDays:(int)kNumberOfExpiryDaysCoreData inModuleName:@"ManpowerFilter"])
    //    {
    self.filtersBarButtonItem.enabled = NO;
    [[ETGFilterModelController sharedController] getManpowerFilter:[self getReportingMonthString] reportType:self.selectedTab isFromFilter:NO];
    //    }
    //    else
    //    {
    //        [self fetchData:NO];
    //    }
}

-(void)updateDisplayForUserChanged
{
    [self updateForUac];
    self.ahcJsonString = @"";
    self.hcrJsonString = @"";
    self.lrJsonString = @"";
    self.previousSelectedSegmentedControlIndex = 0;
    self.selectedTab = [self getActualSelectedTab];
    self.selectedRowsInAhcFilter = @[];
    self.selectedRowsInHcrFilter = @[];
    self.selectedRowsInLrFilter = @[];
    [[ETGFilterModelController sharedController] getManpowerFilter:[self getReportingMonthString] reportType:self.selectedTab isFromFilter:NO];
}

-(void)updateForUac
{
    BOOL shouldShowAhc = [ETGJsonHelper canAccessInUac:kManpowerAverageHeadcountRequiredKey];
    BOOL shouldShowHcr = [ETGJsonHelper canAccessInUac:kManpowerHeadcountRequiredKey];
    BOOL shouldShowLr = [ETGJsonHelper canAccessInUac:kManpowerLoadingRequiredKey];
    
    NSString *title = @"";
    
    [self.segmentedControl removeAllSegments];
    if(shouldShowAhc)
    {
        [self.segmentedControl insertSegmentWithTitle:@"Yearly Headcount" atIndex:0 animated:NO];
        title = @"Yearly Headcount";
    }
    if(shouldShowHcr)
    {
        [self.segmentedControl insertSegmentWithTitle:@"Count by Cluster (P&E)" atIndex:self.segmentedControl.numberOfSegments animated:NO];
        title = @"Count by Cluster (P&E)";
    }
    if(shouldShowLr)
    {
        [self.segmentedControl insertSegmentWithTitle:@"Loading by Project (P&E)" atIndex:self.segmentedControl.numberOfSegments animated:NO];
        title = @"Loading by Project (P&E)";
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
        self.navigationItem.titleView = self.segmentedControl;
        self.segmentedControl.hidden = NO;
    }
}

-(ManpowerTab)getActualSelectedTab
{
    if([[self.segmentedControl titleForSegmentAtIndex:self.segmentedControl.selectedSegmentIndex] isEqualToString:@"Yearly Headcount"])
        return ManpowerTabAHC;
    else if([[self.segmentedControl titleForSegmentAtIndex:self.segmentedControl.selectedSegmentIndex] isEqualToString:@"Count by Cluster (P&E)"])
        return ManpowerTabHCR;
    else if([[self.segmentedControl titleForSegmentAtIndex:self.segmentedControl.selectedSegmentIndex] isEqualToString:@"Loading by Project (P&E)"])
        return ManpowerTabLR;
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
    [self configureNavigationBar];
    
    ETGManPowerModelController *modelController = [ETGManPowerModelController sharedModel];
    if(!isManual)
    {
        //[self.webView reload];
    }
    
    switch (self.selectedTab)
    {
        case ManpowerTabAHC:
        {
            self.isAhcLoading = YES;
            [modelController getAhcForReportingMonth:[self getReportingMonthString] isManualRefresh:isManual success:^(NSString *jsonString) {
                self.isAhcLoading = NO;
                ETGMpAhcWebService *webService = [ETGMpAhcWebService new];
                webService.filteredYears = [self getAhcYearBasedOnFilterName:kManpowerFilterAHCRootKey];
                webService.filteredDivisions = [self getAhcDivisionList];
                webService.filteredDepartments = [self getAhcDepartmentBasedOnFilterName:kManpowerFilterAHCRootKey];
                webService.filteredSections = [self getAhcSectionBasedOnFilterName:kManpowerFilterAHCRootKey];
                
                self.ahcJsonString = [webService getOfflineData:[self getReportingMonthString]];
                //NSLog(@"ahcjson offline data %@",self.ahcJsonString);
                if(self.selectedTab == ManpowerTabAHC)
                {
                    [self setNavigationBarWithoutActivityIndicator];
                    [self populateHtmlData];
                }
            } failure:^(NSError *error) {
                self.isAhcLoading = NO;
                [self setNavigationBarWithoutActivityIndicator];
            }];
            break;
        }
        case ManpowerTabHCR:
        {
            self.isHcrLoading = YES;
            [modelController getHcrForReportingMonth:[self getReportingMonthString] isManualRefresh:isManual success:^(NSString *jsonString) {
                self.isHcrLoading = NO;
                ETGMpHcrWebService *webService = [ETGMpHcrWebService new];
                webService.filteredYears = [self getHcrYearBasedOnFilterName:kManpowerFilterHCRRootKey];
                webService.filteredDepartments = [self getHcrDepartmentBasedOnFilterName:kManpowerFilterHCRRootKey];
                webService.filteredSections = [self getHcrSectionBasedOnFilterName:kManpowerFilterHCRRootKey];
                webService.filteredRegions = [self getHcrRegionBasedOnFilterName:kManpowerFilterHCRRootKey];
                webService.filteredClusters = [self getHcrClusterBasedOnFilterName:kManpowerFilterHCRRootKey];
                webService.filteredProjectPositions = [self getHcrProjectPositionBasedOnFilterName:kManpowerFilterHCRRootKey];
                
                self.hcrJsonString = [webService getOfflineData:[self getReportingMonthString]];
                //NSLog(@"hcrjson offline data %@",self.hcrJsonString);
                if(self.selectedTab == ManpowerTabHCR)
                {
                    [self setNavigationBarWithoutActivityIndicator];
                    [self populateHtmlData];
                }
            } failure:^(NSError *error) {
                self.isHcrLoading = NO;
                [self setNavigationBarWithoutActivityIndicator];
            }];
            break;
        }
        case ManpowerTabLR:
        {
            self.isLrLoading = YES;
            ETGMpLrWebService *webService = [ETGMpLrWebService new];
            webService.filteredYears = [self getLrYearBasedOnFilterName:kManpowerFilterLRRootKey];
            webService.filteredDepartments = [self getLrDepartmentBasedOnFilterName:kManpowerFilterLRRootKey];
            webService.filteredSections = [self getLrSectionBasedOnFilterName:kManpowerFilterLRRootKey];
            webService.filteredRegions = [self getLrRegionBasedOnFilterName:kManpowerFilterLRRootKey];
            webService.filteredClusters = [self getLRClusterBasedOnFilterName:kManpowerFilterLRRootKey];
            webService.filteredProjects = [self getLRProjectBasedOnFilterName:kManpowerFilterLRRootKey];
            webService.filteredProjectPositions = [self getLRProjectPositionBasedOnFilterName:kManpowerFilterLRRootKey];
            [webService sendRequestWithReportingMonth:[self getReportingMonthString] isManualRefresh:isManual success:^(NSString *jsonString) {
                self.isLrLoading = NO;
                self.lrJsonString = jsonString;
                //NSLog(@"lrjson offline data %@",self.lrJsonString);
                if(self.selectedTab == ManpowerTabLR)
                {
                    [self setNavigationBarWithoutActivityIndicator];
                    [self populateHtmlData];
                }
            } failure:^(NSError *error) {
                self.isLrLoading = NO;
                [self setNavigationBarWithoutActivityIndicator];
            }];
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
        case ManpowerTabAHC:
            shouldShowLoading = self.isAhcLoading;
            break;
        case ManpowerTabHCR:
            shouldShowLoading = self.isHcrLoading;
            break;
        case ManpowerTabLR:
            shouldShowLoading = self.isLrLoading;
            break;
    }
    if(shouldShowLoading)
    {
        [self configureNavigationBar];
    }
    else
    {
        [self setNavigationBarWithoutActivityIndicator];
    }
}

-(void)populateHtmlData
{
    switch(self.selectedTab)
    {
        case ManpowerTabAHC:{
            [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populateMPSChart(%@);",self.ahcJsonString]];
            break;
        }
        case ManpowerTabHCR:{
            [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populateMPSChart(%@);",self.hcrJsonString]];
            break;
        }
        case ManpowerTabLR:
        {
            [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populateMPSChart(%@);",self.lrJsonString]];
            break;
        }
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
    [self.AhcFilterPopoverController dismissPopoverAnimated:NO];
    self.AhcFilterPopoverController = nil;
    
    [self.HcrFilterPopoverController dismissPopoverAnimated:NO];
    self.HcrFilterPopoverController = nil;
    
    [self.LrFilterPopoverController dismissPopoverAnimated:NO];
    self.LrFilterPopoverController = nil;
}

#pragma mark - UIWebView Delegates

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if([self.requestString rangeOfString:@"ETGMPSChart"].location != NSNotFound)
    {
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
    self.filtersBarButtonItem.enabled = YES;
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
    
    [self loadWebViewForCurrentSelectedTab];
    [[ETGFilterModelController sharedController] getManpowerFilter:[self getReportingMonthString] reportType:self.selectedTab isFromFilter:NO];
    //[self fetchData:NO];
    //[self updateLoadingDisplayForCurrentTab];
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
            case ManpowerTabAHC:
            {
                self.AhcFilterPopoverController = popoverController;
                break;
            }
            case ManpowerTabHCR:
            {
                self.HcrFilterPopoverController = popoverController;
                break;
            }
            case ManpowerTabLR:
            {
                self.LrFilterPopoverController = popoverController;
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
        case ManpowerTabAHC:
        {
            if(self.AhcFilterPopoverController)
            {
                [self.AhcFilterPopoverController dismissPopoverAnimated:NO];
                self.AhcFilterPopoverController = nil;
            }
            else
            {
                [self performSegueWithIdentifier:[self getCurrentFilterSegue] sender:sender];
            }
            break;
        }
        case ManpowerTabHCR:
        {
            if(self.HcrFilterPopoverController)
            {
                [self.HcrFilterPopoverController dismissPopoverAnimated:NO];
                self.HcrFilterPopoverController = nil;
            }
            else
            {
                [self performSegueWithIdentifier:[self getCurrentFilterSegue] sender:sender];
            }
            break;
        }
        case ManpowerTabLR:
        {
            if(self.LrFilterPopoverController)
            {
                [self.LrFilterPopoverController dismissPopoverAnimated:NO];
                self.LrFilterPopoverController = nil;
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
        case ManpowerTabAHC:
        {
            [self.AhcFilterPopoverController dismissPopoverAnimated:NO];
            self.AhcFilterPopoverController = nil;
            break;
        }
        case ManpowerTabHCR:
        {
            [self.HcrFilterPopoverController dismissPopoverAnimated:NO];
            self.HcrFilterPopoverController = nil;
            break;
        }
        case ManpowerTabLR:
        {
            [self.LrFilterPopoverController dismissPopoverAnimated:NO];
            self.LrFilterPopoverController = nil;
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
        case ManpowerTabAHC:
        {
            self.filteredProjectsDictionaryAhc = filteredProjectsDictionary;
            [self.AhcFilterPopoverController dismissPopoverAnimated:YES];
            self.AhcFilterPopoverController = nil;
            
            break;
        }
        case ManpowerTabHCR:
        {
            self.filteredProjectsDictionaryHcr = filteredProjectsDictionary;
            [self.HcrFilterPopoverController dismissPopoverAnimated:YES];
            self.HcrFilterPopoverController = nil;
            break;
        }
        case ManpowerTabLR:
        {
            self.filteredProjectsDictionaryLr = filteredProjectsDictionary;
            [self.LrFilterPopoverController dismissPopoverAnimated:YES];
            self.LrFilterPopoverController = nil;
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
        case ManpowerTabAHC:
        {
            ETGMpAhcWebService *w = [ETGMpAhcWebService new];
            return [w needRefreshDataForReportingMonth:reportingMonth];
        }
        case ManpowerTabHCR:
        {
            ETGMpHcrWebService *w = [ETGMpHcrWebService new];
            return [w needRefreshDataForReportingMonth:reportingMonth];
        }
        case ManpowerTabLR:
        {
            ETGMpLrWebService *w = [ETGMpLrWebService new];
            return [w needRefreshDataForReportingMonth:reportingMonth];
            
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
    
    return NO;
}

- (void)filtersviewControllerDidDismiss:(NSArray *)selectedRowsInFilter withSender:(id)sender
{
    if([sender isKindOfClass:[ETGManpowerAHCFilterViewController class]])
    {
        self.selectedRowsInAhcFilter = selectedRowsInFilter;
    }
    else if([sender isKindOfClass:[ETGManpowerHCRFilterViewController class]])
    {
        self.selectedRowsInHcrFilter = selectedRowsInFilter;
    }
    else if([sender isKindOfClass:[ETGManpowerLRFilterViewController class]])
    {
        self.selectedRowsInLrFilter = selectedRowsInFilter;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    switch(self.selectedTab)
    {
        case ManpowerTabAHC:
        {
            self.AhcFilterPopoverController = nil;
            break;
        }
        case ManpowerTabHCR:
        {
            self.HcrFilterPopoverController = nil;
            break;
        }
        case ManpowerTabLR:
        {
            self.LrFilterPopoverController = nil;
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
    NSArray *selectedKeys = self.filteredProjectsDictionaryAhc[kSelectedBudgetHolder];
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


-(NSArray *)getAhcYearBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedYear = self.filteredProjectsDictionaryAhc[kSelectedYear];
    if([selectedYear count] > 0)
    {
        return selectedYear;
    }
    
    NSArray *temp = [[ETGFilterModelController sharedController] fetchYearsBasedOnReportingPeriod:[CommonMethods latestReportingMonth] andFilterName:filterName];
    
    if([temp count] > 0)
    {
        return temp;
    }
    return nil;
}

-(NSArray*)getAhcDivisionList
{
    NSDate *selectedMonth = self.filteredProjectsDictionaryAhc[kSelectedReportingMonth];
    
    NSArray *results;
    
    if(nil != selectedMonth)
    {
        results = [[ETGFilterModelController sharedController] fetchDivisionsBasedOnReportingPeriod:selectedMonth andFilterName:kManpowerFilterAHCRootKey];
        
        return results;
    }
    
    results = [[ETGFilterModelController sharedController] fetchDivisionsBasedOnReportingPeriod:[CommonMethods latestReportingMonth] andFilterName:kManpowerFilterAHCRootKey];
    
    if([results count] > 0)
    {
        return results;
    }
    return nil;
    
}


-(NSArray *)getAhcDepartmentBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedDepartment = self.filteredProjectsDictionaryAhc[kSelectedDepartment];
    if([selectedDepartment count] > 0)
    {
        return selectedDepartment;
    }
    
    NSArray *temp = [[ETGFilterModelController sharedController] fetchDepartmentsBasedOnReportingPeriod:[CommonMethods latestReportingMonth] andFilterName:filterName];
    
    if([temp count] > 0)
    {
        return temp;
    }
    return nil;
}

-(NSArray *)getAhcSectionBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedSection = self.filteredProjectsDictionaryAhc[kSelectedSection];
    if([selectedSection count] > 0)
    {
        return selectedSection;
    }
    
    NSArray *departments = [self getAhcDepartmentBasedOnFilterName:filterName];
    
    NSMutableArray *departmentKeys = [[NSMutableArray alloc] init];
    for (ETGDepartment *department in departments) {
        [departmentKeys addObject:department.key];
    }
    
    NSArray *temp = [[ETGFilterModelController sharedController] fetchSectionsBasedOnDepartments:departmentKeys reportingPeriod:[CommonMethods latestReportingMonth] andFilterName:kManpowerFilterAHCRootKey];
    
    if([temp count] > 0)
    {
        return temp;
    }
    return nil;
}

-(NSArray *)getHcrYearBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedYear = self.filteredProjectsDictionaryHcr[kSelectedYear];
    if([selectedYear count] > 0)
    {
        return selectedYear;
    }
    
    NSArray *temp = [[ETGFilterModelController sharedController] fetchYearsBasedOnReportingPeriod:[CommonMethods latestReportingMonth] andFilterName:filterName];
    
    if([temp count] > 0)
    {
        return temp;
    }
    return nil;
}

-(NSArray *)getHcrRegionBasedOnFilterName:(NSString*)filterName {
    
    NSArray *selectedRegion = self.filteredProjectsDictionaryHcr[kSelectedRegion];
    if([selectedRegion count] > 0)
    {
        return selectedRegion;
    }
    
    NSArray *temp = [[ETGFilterModelController sharedController] fetchRegionsBasedOnReportingPeriod:[CommonMethods latestReportingMonth] andFilterName:filterName];
    
    if([temp count] > 0)
    {
        //NSLog(@"Hcr region count: %lu",(unsigned long)[temp count]);
        return temp;
    }
    return nil;
}

-(NSArray *)getHcrClusterBasedOnFilterName:(NSString*)filterName {
    
    NSArray *selectedCluster = self.filteredProjectsDictionaryHcr[kSelectedCluster];
    if ([selectedCluster count] > 0) {
        return selectedCluster;
    }
    
    NSArray *regions = [[ETGFilterModelController sharedController] fetchRegionsBasedOnReportingPeriod:[CommonMethods latestReportingMonth] andFilterName:filterName];
    
    NSMutableArray *regionKeys = [[NSMutableArray alloc] init];
    for (ETGMpRegion *region in regions) {
        [regionKeys addObject:region.key];
    }
    
    NSArray *temp = [[ETGFilterModelController sharedController] fetchClustersBasedOnRegions:regionKeys reportingPeriod:[CommonMethods latestReportingMonth] andFilterName:filterName];
    
    if([temp count] > 0)
    {
        //NSLog(@"Hcr cluster count: %lu",(unsigned long)[temp count]);
        return temp;
    }
    return nil;
}

-(NSArray *)getHcrProjectPositionBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedProjectPosition = self.filteredProjectsDictionaryHcr[kSelectedProjectPosition];
    if([selectedProjectPosition count] > 0)
    {
        return selectedProjectPosition;
    }
    
    NSArray *clusters = [self getHcrClusterBasedOnFilterName:filterName];
    
    NSMutableArray *clusterKeys = [[NSMutableArray alloc] init];
    for (ETGMpCluster *cluster in clusters) {
        [clusterKeys addObject:cluster.key];
    }
    
    NSArray *temp = [[ETGFilterModelController sharedController] fetchProjectPositionsBasedOnClusters:clusterKeys reportingPeriod:[CommonMethods latestReportingMonth] andFilterName:filterName];
    
    if([temp count] > 0)
    {
        //NSLog(@"Hcr project position count: %lu",(unsigned long)[temp count]);
        return temp;
    }
    return nil;
    
}

-(NSArray *)getHcrDepartmentBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedDepartment = self.filteredProjectsDictionaryHcr[kSelectedDepartment];
    if([selectedDepartment count] > 0)
    {
        return selectedDepartment;
    }
    
    NSArray *temp = [[ETGFilterModelController sharedController] fetchDepartmentsBasedOnReportingPeriod:[CommonMethods latestReportingMonth] andFilterName:filterName];
    
    if([temp count] > 0)
    {
        return temp;
    }
    return nil;
}

-(NSArray *)getHcrSectionBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedSection = self.filteredProjectsDictionaryHcr[kSelectedSection];
    if([selectedSection count] > 0)
    {
        return selectedSection;
    }
    
    NSArray *departments = [self getHcrDepartmentBasedOnFilterName:filterName];
    
    NSMutableArray *departmentKeys = [[NSMutableArray alloc] init];
    for (ETGDepartment *department in departments) {
        [departmentKeys addObject:department.key];
    }
    
    NSArray *temp = [[ETGFilterModelController sharedController] fetchSectionsBasedOnDepartments:departmentKeys reportingPeriod:[CommonMethods latestReportingMonth] andFilterName:kManpowerFilterHCRRootKey];
    
    if([temp count] > 0)
    {
        //NSLog(@"Hcr section count: %lu",(unsigned long)[temp count]);
        return temp;
    }
    return nil;
}

-(NSArray *)getLrYearBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedYear = self.filteredProjectsDictionaryLr[kSelectedYear];
    if([selectedYear count] > 0)
    {
        return selectedYear;
    }
    
    if(self.filteredProjectsDictionaryLr == nil)
    {
        NSArray *temp = [[ETGFilterModelController sharedController] fetchYearsBasedOnReportingPeriod:[CommonMethods latestReportingMonth] andFilterName:filterName];
        
        if([temp count] > 0)
        {
            // Select only same year
            NSString *reportingMonth = [self getReportingMonthString];
            if([reportingMonth length] == 8)
            {
                NSString *year = [reportingMonth substringToIndex:4];
                NSPredicate *p = [NSPredicate predicateWithFormat:@"name == %@", year];
                NSArray *selectedYear = [temp filteredArrayUsingPredicate:p];
                if([selectedYear count] > 0)
                {
                    return  @[selectedYear[0]];
                }
            }
            
            return temp;
        }
    }
    return nil;
}

-(NSArray *)getLrDepartmentBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedDepartment = self.filteredProjectsDictionaryLr[kSelectedDepartment];
    if([selectedDepartment count] > 0)
    {
        return selectedDepartment;
    }
    
    NSArray *temp = [[ETGFilterModelController sharedController] fetchDepartmentsBasedOnReportingPeriod:[CommonMethods latestReportingMonth] andFilterName:filterName];
    if([temp count] > 0)
    {
        return temp;
    }
    return nil;
}

-(NSArray *)getLrSectionBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedSection = self.filteredProjectsDictionaryLr[kSelectedSection];
    if([selectedSection count] > 0)
    {
        return selectedSection;
    }
    
    return nil;
}

-(NSArray *)getLrRegionBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedRegion = self.filteredProjectsDictionaryLr[kSelectedRegion];
    if([selectedRegion count] > 0) {
        return selectedRegion;
    }
    
    return nil;
}

-(NSArray *)getLRClusterBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedCluster = self.filteredProjectsDictionaryLr[kSelectedCluster];
    if ([selectedCluster count] > 0) {
        return selectedCluster;
    }
    
    return nil;
}

-(NSArray *)getLRProjectBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedProject = self.filteredProjectsDictionaryLr[kSelectedProject];
    if ([selectedProject count] > 0) {
        return selectedProject;
    }
    
    return nil;
}

-(NSArray *)getLRProjectPositionBasedOnFilterName:(NSString*)filterName
{
    NSArray *selectedProjectPosition = self.filteredProjectsDictionaryLr[kSelectedProjectPosition];
    if ([selectedProjectPosition count] > 0) {
        return selectedProjectPosition;
    }
    
    return nil;
}

-(NSDictionary *)getCurrentFilteredDictionary
{
    switch(self.selectedTab)
    {
        case ManpowerTabAHC:
        {
            return self.filteredProjectsDictionaryAhc;
        }
        case ManpowerTabHCR:
        {
            return self.filteredProjectsDictionaryHcr;
        }
        case ManpowerTabLR:
        {
            return self.filteredProjectsDictionaryLr;
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
}

-(NSArray *)getCurrentSelectedRows
{
    switch(self.selectedTab)
    {
        case ManpowerTabAHC:
        {
            return self.selectedRowsInAhcFilter;
        }
        case ManpowerTabHCR:
        {
            return self.selectedRowsInHcrFilter;
        }
        case ManpowerTabLR:
        {
            return self.selectedRowsInLrFilter;
        }
        default:
            @throw [NSException exceptionWithName:@"Unsupported tab" reason:@"" userInfo:nil];
    }
}

-(NSString *)getCurrentFilterSegue
{
    switch(self.selectedTab)
    {
        case ManpowerTabAHC:
        {
            return @"showAhcFilter";
        }
        case ManpowerTabHCR:
        {
            return @"showHcrFilter";
        }
        case ManpowerTabLR:
        {
            return @"showLrFilter";
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
        case ManpowerTabAHC:
            fileName = @"ETGMPSChart";
            break;
        case ManpowerTabHCR:
            fileName = @"ETGMPSChart";
            break;
        case ManpowerTabLR:
            fileName = @"ETGMPSChart";
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

-(void)startFilter
{
    self.filtersBarButtonItem.enabled = NO;
    [self configureNavigationBar];
}

-(void)reloadFilter
{
    self.filtersBarButtonItem.enabled = YES;
    self.shouldUpdateFilterErrorMessage = NO;
    // AK, only load if current display is empty
    if([self isCurrentDisplayEmpty])
    {
        [self fetchData:NO];
    }
    [self updateLoadingDisplayForCurrentTab];
}

-(BOOL)isCurrentDisplayEmpty
{
    NSString *targetString;
    switch(self.selectedTab)
    {
        case ManpowerTabAHC:
            targetString = self.ahcJsonString;
            break;
        case ManpowerTabHCR:
            targetString = self.hcrJsonString;
            break;
        case ManpowerTabLR:
            targetString = self.lrJsonString;
            break;
    }
    if([targetString length] == 0)
    {
        return YES;
    }
    return NO;
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
        self.filtersBarButtonItem.enabled = YES;
        self.updateBarButtonItem.enabled = YES;
    }
    else
    {
        //self.filtersBarButtonItem.enabled = NO;
        self.updateBarButtonItem.enabled = NO;
    }
}

- (void)clearWebView
{
    //    // Cancel pending background downloads
    [[RKObjectManager sharedManager].operationQueue cancelAllOperations];
    // Set empty JSON string
    _ahcJsonString = @"";
    _hcrJsonString = @"";
    _lrJsonString = @"";
    
    _requestString = nil;
    // Show empty web view
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
    [self.webView reload];
    
    _selectedRowsInAhcFilter = nil;
    _selectedRowsInHcrFilter = nil;
    _selectedRowsInLrFilter = nil;
    
}

@end