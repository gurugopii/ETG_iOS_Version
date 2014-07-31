//
//  ETGMAPViewController.m
//  PDF_Export
//
//  Created by Tony Pham on 12/4/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGMAPViewController.h"
#import "ETGNetworkConnection.h"
#import "ETGFiltersViewController.h"
#import "ETGSectionInfo.h"
#import "ETGCoreDataUtilities.h"
#import "ETGFilterModelController.h"
#import "ETGNetworkConnection.h"
#import "CommonMethods.h"
#import "ETGMapFiltersViewController.h"
#import "ETGMapModelController.h"
#import "ETGMapPgdAndPem.h"
#import "RNBlurModalView.h"
#import "Reachability.h"

@interface ETGMAPViewController ()<ETGFiltersViewControllerDelegate, UIPopoverControllerDelegate, UIGestureRecognizerDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIWebView *keyMilestoneWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filtersBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateBarButtonItem;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIBarButtonItem *activityIndicatorBarButtonItem;
@property (nonatomic) UIPopoverController *filtersPopoverController;
@property (nonatomic) NSArray *selectedRowsInFilter;
@property (nonatomic, strong) NSString* reportingMonth;
@property (nonatomic, strong) NSString* selectedProjectKey;
@property (nonatomic, strong) NSString* requestString;
@property (nonatomic, strong) NSString* keyMilestoneRequestString;
@property (nonatomic, strong) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) NSString *pgdPemJsonString;
@property (nonatomic, strong) RNBlurModalView *keyMilestoneModalView;
@property (nonatomic) BOOL isModalDialogShown;
@property (nonatomic) BOOL shouldAutoRefreshWhenConnectionRestored;
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, strong) NSDictionary *filteredProjectsDictionary;

- (IBAction)toggleFiltersPopover:(id)sender;
- (IBAction)tapUpdateBarButtonItem:(id)sender;

@end

@implementation ETGMAPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"MAP Management Dashboard";
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired = 2;
    tapGesture.delegate = self;
    [self.webView addGestureRecognizer:tapGesture];
    [self fetchInitData];
    
    [self setupReachability];    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAutoRefreshFlagDueToNoConnection) name:kDownloadMapShouldAutoRefresh object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDisplayForUserChanged) name:kUserChanged object:nil];
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
        _updateBarButtonItem.enabled = YES;
        if(self.shouldAutoRefreshWhenConnectionRestored)
        {
            [self performSelector:@selector(fetchData:) withObject:@(1) afterDelay:1];
            self.shouldAutoRefreshWhenConnectionRestored = NO;
        }
    }
    else
    {
        _updateBarButtonItem.enabled = NO;
    }
}

-(void)updateDisplayForUserChanged
{
    self.pgdPemJsonString = @"";
    [self.keyMilestoneModalView hide];
    [self fetchInitData];
    [self fetchData:YES];
}

-(void)updateAutoRefreshFlagDueToNoConnection
{
    self.shouldAutoRefreshWhenConnectionRestored = YES;
}

-(void)fetchInitData
{
    //self.reportingMonth = @"20130601";
    _reportingMonth = [CommonMethods latestReportingMonthString];
    [self loadWebView];
}

-(void)fetchData:(BOOL)isManual
{
    [_appDelegate startActivityIndicatorSmallGrey];
    [self configureNavigationBar];
    
    if([[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampInUserDefaultsMoreThanNumberOfDays:30 inModuleName:@"MasterDataFilter"])
    {
        [[ETGFilterModelController sharedController] getMasterDataFilter];
    }
    
    [[ETGMapModelController sharedModel] getPgdAndPemForReportingMonth:self.reportingMonth isManualRefresh:isManual success:^(NSString *jsonString) {
        self.pgdPemJsonString = jsonString;
        
        ETGMapPgdAndPem *model = [ETGMapPgdAndPem new];
        model.filteredProjects = self.filteredProjectsDictionary[kSelectedProjects];
        model.filteredDurations = self.filteredProjectsDictionary[kSelectedDurations];
        model.filteredSpeeds = self.filteredProjectsDictionary[kSelectedSpeeds];
        self.pgdPemJsonString = [model getOfflineData:self.reportingMonth];
        
        [self setNavigationBarWithoutActivityIndicator];
        [_appDelegate stopActivityIndicatorSmall];
        [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populateAllCharts(%@);", self.pgdPemJsonString]];
    } failure:^(NSError *error) {
        [self setNavigationBarWithoutActivityIndicator];
        [_appDelegate stopActivityIndicatorSmall];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self fetchData:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNavigationBar) name:kRNBlurDidHidewNotification object:nil];
    [self.sidePanelController addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (appDelegate.isNetworkServerAvailable == YES) {
        _updateBarButtonItem.enabled = YES;
    } else {
        _updateBarButtonItem.enabled = NO;
    }
}

-(void)updateNavigationBar
{
    [self setNavigationBarWithoutActivityIndicator];
    self.isModalDialogShown = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRNBlurDidHidewNotification object:self];
    // Hide filter view if currently visible
    if (_filtersPopoverController) {
        [_filtersPopoverController dismissPopoverAnimated:YES];
        _filtersPopoverController = nil;
    }
    @try {
        [ETGAlert sharedAlert].alertShown = NO;
        [self.sidePanelController removeObserver:self forKeyPath:@"state"];
    }
    @catch (NSException *exception) {
        // Handle exceptions here
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // Observer for side panel changes
    if ([keyPath isEqualToString:@"state"]) {
        JASidePanelState newState = (JASidePanelState)[[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (newState == JASidePanelLeftVisible) {
            // Hide filter view if currently visible
            if (_filtersPopoverController) {
                [_filtersPopoverController dismissPopoverAnimated:YES];
                _filtersPopoverController = nil;
            }
        }
    }
}

- (void)handleTap:(UIGestureRecognizer*)gestureRecognizer {
    return;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *gesture = (UITapGestureRecognizer *)otherGestureRecognizer;
        if (gesture.numberOfTapsRequired == 2) {
            [otherGestureRecognizer.view removeGestureRecognizer:otherGestureRecognizer];
        }
    }
    return YES;
}

- (void)configureNavigationBar {
    [self createUIActivityIndicator];
    [self setNavigationBarWithActivityIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Bar and Activity Indicator
- (void)createUIActivityIndicator {
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 30, 50, 50)];
    _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityIndicatorBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_activityIndicator];
}

- (void)setNavigationBarWithActivityIndicator {
    
    self.navigationItem.rightBarButtonItems = nil;
    self.navigationItem.rightBarButtonItems = @[_filtersBarButtonItem, _activityIndicatorBarButtonItem];
    [_activityIndicator startAnimating];
}

- (void)setNavigationBarWithoutActivityIndicator
{
    self.navigationItem.rightBarButtonItems = nil;
    self.navigationItem.rightBarButtonItems = @[_filtersBarButtonItem, _updateBarButtonItem];
    [_activityIndicator stopAnimating];
}

- (void)setNavigationBarWithoutAnything
{
    self.navigationItem.rightBarButtonItems = nil;
    [_activityIndicator stopAnimating];
}

#pragma mark - Actions

- (IBAction)tapUpdateBarButtonItem:(id)sender {
    // Hide filter view if currently visible
    if (_filtersPopoverController) {
        [_filtersPopoverController dismissPopoverAnimated:YES];
        _filtersPopoverController = nil;
    }
    
    [self fetchData:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showFilter"]) {
        ETGMapFiltersViewController *filtersViewController = (ETGMapFiltersViewController *)[(UINavigationController *)segue.destinationViewController topViewController];
        filtersViewController.moduleName = @"MAP";
        [filtersViewController setDelegate:self];
        [filtersViewController setSelectedRowsInFilter:_selectedRowsInFilter];
        filtersViewController.shouldUpdateFilterErrorMessage = self.shouldAutoRefreshWhenConnectionRestored;
        
        UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
        _filtersPopoverController = popoverController;
        [popoverController setDelegate:self];
    }
}

#pragma mark - Webview Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(webView == self.webView)
    {
        _requestString = [[request URL] absoluteString];
        //NSLog(@"Request string is %@", self.requestString);
        if([self.requestString rangeOfString:@"ETGMAPKeyMilestone"].location != NSNotFound)
        {
            NSString *filterString = [self.requestString stringByReplacingOccurrencesOfString:@"seturl:ETGMAPKeyMilestone.html?projectKey=" withString:@""];
            if([filterString integerValue] != 0)
            {
                self.selectedProjectKey = filterString;
                if(!self.isModalDialogShown)
                {
                    [self loadKeyMilestoneWebView];
                    self.isModalDialogShown = YES;
                    [self setNavigationBarWithoutAnything];
                }
            }
        }
    }
    else if(webView == self.keyMilestoneWebView)
    {
        self.keyMilestoneRequestString = [[request URL] absoluteString];
        //NSLog(@"Request string is %@", self.keyMilestoneRequestString);
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(webView == self.webView)
    {
        if([self.requestString rangeOfString:@"ETGMAPLevel1"].location != NSNotFound || [self.requestString rangeOfString:@"ETGMAPLevel2"].location != NSNotFound)
        {
            if([self.pgdPemJsonString length] != 0)
            {
                [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populateAllCharts(%@);", self.pgdPemJsonString]];
            }
        }
    }
    else if(webView == self.keyMilestoneWebView)
    {
        if([self.keyMilestoneRequestString rangeOfString:@"ETGMAPKeyMilestone"].location != NSNotFound)
        {
            NSString *json = [[ETGMapModelController sharedModel] getKeyMilestonesOfflineData:self.reportingMonth withProjectKey:[self.selectedProjectKey integerValue]];
            [self.keyMilestoneWebView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populateKeyMilestone(%@);", json]];
        }
    }
}

- (IBAction)toggleFiltersPopover:(id)sender {
    if (_filtersPopoverController) {
        [_filtersPopoverController dismissPopoverAnimated:NO];
        _filtersPopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showFilter" sender:sender];
    }
}

- (void)filtersViewControllerDidCancel {
    [_filtersPopoverController dismissPopoverAnimated:NO];
    _filtersPopoverController = nil;
}

- (void)filtersViewControllerDidFinishWithProjectsDictionary:(NSDictionary *)filteredProjectsDictionary {
    [_filtersPopoverController dismissPopoverAnimated:YES];
    _filtersPopoverController = nil;
    
    ETGMapPgdAndPem *model = [ETGMapPgdAndPem new];
    model.filteredProjects = filteredProjectsDictionary[kSelectedProjects];
    model.filteredDurations = filteredProjectsDictionary[kSelectedDurations];
    model.filteredSpeeds = filteredProjectsDictionary[kSelectedSpeeds];
    
    self.filteredProjectsDictionary = filteredProjectsDictionary;
    
    NSDate *selectedMonth = filteredProjectsDictionary[kSelectedReportingMonth];
    if(nil != selectedMonth)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        self.reportingMonth = [formatter stringFromDate:selectedMonth];
    }
    
    self.pgdPemJsonString = [model getOfflineData:self.reportingMonth];
    [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populateAllCharts(%@);", self.pgdPemJsonString]];
}

- (void)filtersviewControllerDidDismiss:(NSArray *)selectedRowsInFilter {
    _selectedRowsInFilter = selectedRowsInFilter;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    _filtersPopoverController = nil;
}

- (void)loadWebView {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ETGMAPLevel1" ofType:@"html" inDirectory:@"Charts"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [_webView setOpaque:NO];
    [[_webView scrollView] setBounces: NO];
    [_webView setClearsContextBeforeDrawing:YES];
    [_webView loadRequest:request];
}

-(void)loadKeyMilestoneWebView
{
    self.keyMilestoneWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1000, 680)];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ETGMAPKeyMilestone" ofType:@"html" inDirectory:@"Charts"];
    //NSString *path = @"";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.keyMilestoneWebView setOpaque:NO];
    [[self.keyMilestoneWebView scrollView] setBounces: NO];
    [self.keyMilestoneWebView setClearsContextBeforeDrawing:YES];
    [self.keyMilestoneWebView loadRequest:request];
    self.keyMilestoneWebView.delegate = self;
    
    self.keyMilestoneModalView = [[RNBlurModalView alloc] initWithViewController:self view:self.keyMilestoneWebView];
    self.keyMilestoneModalView.dismissButtonRight = YES;
    [self.keyMilestoneModalView show];
}

@end
