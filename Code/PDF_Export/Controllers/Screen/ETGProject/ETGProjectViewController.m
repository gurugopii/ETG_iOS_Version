          //
//  PDFReportViewController.m
//  PDF_Export
//
//  Created by mobilitySF on 7/10/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "ETGProjectViewController.h"
#import "ETGProjectModelController.h"
#import "ETGScorecardModelController.h"
#import "ETGKeyHighlightPagerViewController.h"
#import "ETGProjectInformationViewController.h"
#import "ETGPortfolioData.h"
#import "ETGCoreDataUtilities.h"
#import "ETGFiltersViewController.h"
#import "ETGFilterModelController.h"
#import "ETGBaselineType.h"
#import "ETGRevision.h"
#import "ETGProject.h"
#import "CommonMethods.h"
#import "ETGProjectSummary.h"
#import "ETGAlert.h"
#import "ETGNetworkConnection.h"
#import "Reachability.h"
#import <RestKit/RestKit.h>


@interface ETGProjectViewController () <UIWebViewDelegate, UIPopoverControllerDelegate, ETGFiltersViewControllerDelegate, ETGPortfolioDataDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *projectSegmentedButton;
@property (nonatomic, weak) IBOutlet UIWebView *projectChartWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filtersBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateBarButtonItem;
@property (nonatomic) UIPopoverController *filterPopoverController;
@property (nonatomic) NSArray *selectedRowsInFilter;

@property (nonatomic, strong) ETGAppDelegate *appDelegate;

@property (nonatomic, strong) ETGPortfolioData *portfolioDelegate;
@property (nonatomic, strong) ETGKeyHighlightPagerViewController *keyHighlightsPagerViewController;
@property (nonatomic, strong) ETGProjectInformationViewController *projectInfoViewController;
@property (nonatomic, strong) Reachability *hostReachability;
@property (nonatomic, strong) Reachability *internetReachability;
@property (nonatomic, strong) NSMutableArray *keyHighlightsValues;
@property (nonatomic, strong) NSMutableArray *projectBackgroundValues;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIBarButtonItem *activityIndicatorBarButtonItem;
@property (nonatomic, strong) NSArray *keyMilestones;
@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSString *requestString;
@property (nonatomic, strong) NSString *PDFField;
@property (nonatomic, strong) NSString *JSONString;
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *projectStatus;
@property (nonatomic, strong) NSString *errorDescription;
@property (nonatomic) BOOL isTimeStampMoreThanADay;
@property (nonatomic) BOOL withError;
@property (nonatomic) BOOL timestamp;
@property (nonatomic) int fetchRequestCounter;
@property (nonatomic) int sendRequestCounter;
@property (nonatomic)int errorCode;
@property (nonatomic) BOOL didStartDonwloadProjects;
@property (nonatomic) BOOL shouldDownloadMultipleProjectsInBackground;
@property (nonatomic) BOOL isObserverReady;
@property (nonatomic) BOOL willDownloadBackgroundProjects;
@property (nonatomic) NSDateFormatter *dateFormatter;
@property (nonatomic) BOOL shouldReloadView;
@property (nonatomic, strong) NSDictionary *dictionaryFromFilter;
@property (nonatomic) BOOL shouldHideFilter;
@property (nonatomic, strong) NSDictionary *filterDictionary;

- (void)reloadControllerData;
- (void)prepareProjectBackgroundView;
- (void)prepareKeyHighlightView;
- (IBAction)tapUpdateBarButtonItem:(id)sender;

@end


@implementation ETGProjectViewController

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"willDownloadBackgroundProjects"]) {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        if (newValue == YES) {
            self.willDownloadBackgroundProjects = NO;
            if (_shouldDownloadMultipleProjectsInBackground == YES){
                [self shouldSendRequestForProjectInBackground];
            }
        }
    }
    // Observer for side panel changes
    if ([keyPath isEqualToString:@"state"]) {
        JASidePanelState newState = (JASidePanelState)[[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (newState == JASidePanelLeftVisible) {
            // Hide filter view if currently visible
            if (_filterPopoverController) {
                [_filterPopoverController dismissPopoverAnimated:YES];
                _filterPopoverController = nil;
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Project V Load");
    NSString *serverAddress = [[NSURL URLWithString:kBaseURL] host];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    _internetReachability = [Reachability reachabilityForInternetConnection];
    [_internetReachability startNotifier];
    
    _hostReachability = [Reachability reachabilityWithHostName:serverAddress];
    [_hostReachability startNotifier];

    
    _appDelegate = [[UIApplication sharedApplication] delegate];

    //DDLogInfo(@"Enable reports in Project Module: %@", _enableReports);

    // Initializes Portfolio delegate
    _portfolioDelegate = [[ETGPortfolioData alloc] init];
    [_portfolioDelegate setDelegate:self];
    
    NSDate *latestReportingMonth = [CommonMethods latestReportingMonth];
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyyMMdd"];
    _reportingMonth = [_dateFormatter stringFromDate:latestReportingMonth];
    
    _withError = YES;
    
    // Create the activity indicator
    [self createUIActivityIndicator];
    
    // Set the navigation bar
    [self setNavigationBarWithActivityIndicator];
    [self.projectChartWebView setOpaque:NO];
    self.projectChartWebView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    _didStartDonwloadProjects = NO;
    
    // Get dictionary
    NSDictionary *defaultProjectDict;
    
    if ((_isCalledFromScorecard) &&(floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)) {
        
        NSLog(@"Project V Load 1");
        _shouldReloadView = YES;
        
            if (_isCalledFromProjectView) {
                _projectChartWebView.hidden = YES;
                _projectSegmentedButton.selectedSegmentIndex = 1;
                _projectInfoViewController = nil;
                
            }else if (_isCalledFromKeyhighlights){
                _projectChartWebView.hidden = YES;
                _projectSegmentedButton.selectedSegmentIndex = 2;
                _keyHighlightsPagerViewController = nil;
            }

        _shouldDownloadMultipleProjectsInBackground = NO;

    } else {
        
        if (_isCalledFromScorecard) {
            
            NSLog(@"Project V Load 2");

        defaultProjectDict = [[ETGFilterModelController sharedController]
                              getDefaultProjectsDictionary];
        NSMutableDictionary *mutableDefaultProjectDict = [defaultProjectDict mutableCopy];
            
        [mutableDefaultProjectDict setObject:[_dictionaryFromScorecard objectForKey:@"kSelectedProjects"]
                                          forKey:@"kSelectedProjects"];
        [mutableDefaultProjectDict setObject:[_dictionaryFromScorecard objectForKey:@"kSelectedReportingMonth"]
                                          forKey:@"kSelectedReportingMonth"];
        defaultProjectDict =  mutableDefaultProjectDict;
      
            if (_isCalledFromProjectView) {
                _projectChartWebView.hidden = YES;
                _projectSegmentedButton.selectedSegmentIndex = 1;
                _projectInfoViewController = nil;
                NSLog(@"Project V Load 3");
        
            }else if (_isCalledFromKeyhighlights){
                _projectChartWebView.hidden = YES;
                _projectSegmentedButton.selectedSegmentIndex = 2;
                _keyHighlightsPagerViewController = nil;
                
                NSLog(@"Project V Load 4");
            }
        // ===== Navigated from Portfolio =====
        } else if (_isCalledFromPortfolio){
            defaultProjectDict = [[ETGFilterModelController sharedController]
                                  getDefaultProjectsDictionary];
            NSMutableDictionary *mutableDefaultProjectDict = [defaultProjectDict mutableCopy];
            
            [mutableDefaultProjectDict setObject:[_dictionaryFromPortfolio objectForKey:@"kSelectedProjects"]
                                          forKey:@"kSelectedProjects"];
            [mutableDefaultProjectDict setObject:[_dictionaryFromPortfolio objectForKey:@"kSelectedReportingMonth"]
                                          forKey:@"kSelectedReportingMonth"];
            defaultProjectDict =  mutableDefaultProjectDict;
            _shouldReloadView = NO;
            NSLog(@"Project V Load 5");
        // ===== Navigated from Portfolio =====
        } else {
            defaultProjectDict = [[ETGFilterModelController sharedController] getDefaultProjectsDictionary];
            NSLog(@"Project V Load 6");
        }
  
        [self getProjectReportDataFromFilterSelectionDictionary:defaultProjectDict];
        
        if (!_isCalledFromPortfolio && !_isCalledFromScorecard) {
            _shouldDownloadMultipleProjectsInBackground = YES;
        }
        
        [self loadProjectContentWebview];
        NSLog(@"Project V Load 7");
    }
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired = 2;
    tapGesture.delegate = self;
    [_projectChartWebView addGestureRecognizer:tapGesture];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UISegmentedControl appearance] setTintColor:[UIColor whiteColor]];

    NSLog(@"Project V Apper");
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeEnableBaseFilterNotificationInNSUserDefaults:@"Y"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProjectReportData)
                                                 name:kDownloadFilterDataForGivenReportingMonthCompleted object:nil];
    ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (appDelegate.isNetworkServerAvailable == YES) {
        _updateBarButtonItem.enabled = YES;
    } else {
        _updateBarButtonItem.enabled = NO;
    }
    
    //Disable filter button when coming from Portfolio
    if(_isCalledFromPortfolio){
        _filtersBarButtonItem.enabled = NO;
    } else {
        _filtersBarButtonItem.enabled = YES;
    }
    
    //Set priority for Project
    //[[ETGProjectModelController sharedModel] setQueuepriorityForProject:_reportingMonth];
    NSLog(@"Project V appear 2");
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    [self updateRefreshButtonWithReachability:curReach];
}

- (void)updateRefreshButtonWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    if (netStatus == NotReachable) {
        _updateBarButtonItem.enabled = NO;
    } else {
        _updateBarButtonItem.enabled = YES;
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

- (void)getProjectReportData
{
    if([[[ETGUserDefaultManipulation sharedUserDefaultManipulation] retrieveEnableBaseFilterNotificationFromNSUserDefaults] isEqualToString:@"Y"]){
        //DDLogInfo(@"Filter was changed");
        NSDictionary *defaultProjectDict = [[ETGFilterModelController sharedController] getDefaultProjectsDictionary];
        defaultProjectDict = _dictionaryFromFilter;
        [self getProjectFromDictionary:defaultProjectDict];
        [self shouldSendRequestForProject];
    }
}
- (void)getManpowerReportData
{
    if([[[ETGUserDefaultManipulation sharedUserDefaultManipulation] retrieveEnableBaseFilterNotificationFromNSUserDefaults] isEqualToString:@"Y"]){
        //DDLogInfo(@"Filter was changed");
        NSDictionary *defaultProjectDict = [[ETGFilterModelController sharedController] getDefaultProjectsDictionary];
        defaultProjectDict = _dictionaryFromFilter;
        [self getProjectFromDictionary:defaultProjectDict];
        /*if ([_reportingMonth isEqualToString:[_dateFormatter stringFromDate:defaultProjectDict[kSelectedReportingMonth]]]){
            _shouldDownloadMultipleProjectsInBackground = YES;
        } else {
            _shouldDownloadMultipleProjectsInBackground = NO;
        }*/
        [self shouldSendRequestForProject];
    }
    
    /*if (_shouldDownloadMultipleProjectsInBackground == YES){
        [self shouldSendRequestForProjectInBackground];
    }
    self.willDownloadBackgroundProjects = YES;*/
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForGivenReportingMonthCompleted object:nil];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self addObserver:self forKeyPath:@"willDownloadBackgroundProjects" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    [self.sidePanelController addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // Check if view should reload
    if (_shouldReloadView) {
        
        if (!_isCalledFromPortfolio && !_isCalledFromScorecard) {
            _shouldDownloadMultipleProjectsInBackground = YES;
        }
        
        [self setNavigationBarWithActivityIndicator];
        NSDictionary *defaultProjectDict;
        
        if (_isCalledFromScorecard) {
            
            defaultProjectDict = [[ETGFilterModelController sharedController] getDefaultProjectsDictionary];
            NSMutableDictionary *mutableDefaultProjectDict = [defaultProjectDict mutableCopy];
            
            [mutableDefaultProjectDict setObject:[_dictionaryFromScorecard objectForKey:@"kSelectedProjects"]
                                          forKey:@"kSelectedProjects"];
            [mutableDefaultProjectDict setObject:[_dictionaryFromScorecard objectForKey:@"kSelectedReportingMonth"]
                                          forKey:@"kSelectedReportingMonth"];
            defaultProjectDict =  mutableDefaultProjectDict;
            
            if (_isCalledFromProjectView) {
                
                _projectSegmentedButton.selectedSegmentIndex = 1;
                _projectInfoViewController = nil;
                
            }else if (_isCalledFromKeyhighlights){
                
                _projectSegmentedButton.selectedSegmentIndex = 2;
                _keyHighlightsPagerViewController = nil;
                
            }
        }else{
            defaultProjectDict = [[ETGFilterModelController sharedController] getDefaultProjectsDictionary];
        }
        [self getProjectReportDataFromFilterSelectionDictionary:defaultProjectDict];
        [self loadProjectContentWebview];
        _shouldReloadView = NO;
    }
    
    // Check if already downloading in background
    if (_shouldDownloadMultipleProjectsInBackground == YES) {
        if (_willDownloadBackgroundProjects == YES) {
            // There is a pending download of projects in background, trigger the download
            self.willDownloadBackgroundProjects = YES;
        } else {
            // Resume suspended requests
            [[ETGProjectModelController sharedModel] startProjectDownloadInBackgroundForReportingMonth:_reportingMonth];
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Hide filter view if currently visible
    if (_filterPopoverController) {
        [_filterPopoverController dismissPopoverAnimated:YES];
        _filterPopoverController = nil;
    }
    
    @try {
        [ETGAlert sharedAlert].alertShown = NO;
        [self removeObserver:self forKeyPath:@"willDownloadBackgroundProjects"];
        [self.sidePanelController removeObserver:self forKeyPath:@"state"];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForGivenReportingMonthCompleted object:nil];
    }
    @catch (NSException *exception) {
        // Handle exception here
    }
    // Pause requests
    [[ETGProjectModelController sharedModel] stopProjectDownloadInBackgroundForReportingMonth:_reportingMonth];
}


#pragma mark - UIWebView Delegates
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    _requestString = [[request URL] absoluteString];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //DDLogInfo(@"%@%@%@", logInfoPrefix, jsonLog, _JSONString);
    
    if ([_requestString rangeOfString:@"ETGProjectModuleLevel1"].location != NSNotFound) {
        [self.projectChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"populateAllChartsAtLevel1(%@)", _JSONString]];
    }
    else if ([_requestString rangeOfString:@"ETGProjectModuleLevel2"].location != NSNotFound) {
        if(_isCalledFromPortfolio){
            //NSLog(@"%@", _htmlModule);
            [self.projectChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"populateAllChartsAtLevel2(%@,%@,'%@')", _JSONString,literalTrue,_htmlModule]];
        } else {
            [self.projectChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"populateAllChartsAtLevel2(%@,%@,'%@')", _JSONString,literalFalse,@""]];
        }
    }
}


#pragma mark - Project WebView

- (void)loadProjectContentWebview {
    
    //NSLog(@"%@", _htmlPage);
    
    NSString *htmlFile;
    NSString *endOfFile = [_requestString substringFromIndex:[_requestString length] - 6];
    
    NSURL *url;
    NSURLRequest *rq;
    if (endOfFile != nil){
        if ([endOfFile isEqualToString:@"1.html"]){
            htmlFile = [[NSBundle mainBundle] pathForResource:@"ETGProjectModuleLevel1" ofType:@"html" inDirectory:@"Charts"];
            url = [NSURL fileURLWithPath:htmlFile];
            rq = [NSURLRequest requestWithURL:url];
        } else {
            htmlFile = [[NSBundle mainBundle] pathForResource:@"ETGProjectModuleLevel2" ofType:@"html" inDirectory:@"Charts"];
            url = [NSURL fileURLWithPath:htmlFile];
            
            NSString *URLString = [[NSString alloc] initWithFormat:@"%@%@%@", url, [url query] ? @"&" : @"?", [_requestString substringFromIndex:[_requestString length] - 5]];
     
            NSURL *theURL = [NSURL URLWithString:URLString];
            rq = [NSURLRequest requestWithURL:theURL];
        }
    } else {
        
        if (_isCalledFromPortfolio){
            htmlFile = [[NSBundle mainBundle] pathForResource:@"ETGProjectModuleLevel2" ofType:@"html" inDirectory:@"Charts"];
            url = [NSURL fileURLWithPath:htmlFile];
            
            NSString *pageID;
            if(_requestString == nil){
                pageID = kDefaultPageID;
            } else {
                pageID = [_requestString substringFromIndex:[_requestString length] - 5];
            }
            
            NSString *URLString = [[NSString alloc] initWithFormat:@"%@%@%@", url, [url query] ? @"&" : @"?", pageID];
            
            NSURL *theURL = [NSURL URLWithString:URLString];
            rq = [NSURLRequest requestWithURL:theURL];
        } else {
            htmlFile = [[NSBundle mainBundle] pathForResource:@"ETGProjectModuleLevel1" ofType:@"html" inDirectory:@"Charts"];
            url = [NSURL fileURLWithPath:htmlFile];
            rq = [NSURLRequest requestWithURL:url];
        }
    }
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[self.projectChartWebView scrollView] setBounces: NO];
    [self.projectChartWebView setClearsContextBeforeDrawing:YES];
    [self.projectChartWebView loadRequest:rq];
    
    NSLog(@"Project Webview Load");
}

-(void) loadJsonForProjectWithoutData {
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(key == %@)", _projectKey];
    ETGProject *project = [ETGProject findFirstWithPredicate:predicate inContext:[NSManagedObjectContext defaultContext]];

    NSString *reportName = [project valueForKeyPath:@"name"];
    NSString *currency = [project valueForKeyPath:@"projectBackground.currencyName"];
    NSString *phase = [project valueForKeyPath:@"phase.name"];
    NSString *status = [project valueForKeyPath:@"projectBackground.projectStatusName"];
    NSDate *update = [[ETGCoreDataUtilities sharedCoreDataUtilities] retrieveTimeStampForModule:@"Project" withReportingMonth:_reportingMonth];
    NSString *updateStr = @"";

    if (update) {
        updateStr = [update toChartDateString];
    } else {
        updateStr = [[NSDate date] toChartDateString];
    }

    if (!currency) {
        currency = @"No Data";
    }

    if (!status) {
        status = @"No Data";
    }

    if (!phase) {
        phase = @"No Data";
    }

    if (!reportName) {
        reportName = @"No Data";
    }

    NSDictionary *jsonDict = [NSMutableDictionary dictionaryWithDictionary:@{@"keymilestone": @"no data", @"schedule": @"no data", @"budget": @"no data", @"rtbd":@"no data", @"hse": @"no data", @"afe": @"no data", @"riskOpportunity": @"no data", @"ppms":@"no data", @"projectDetails":@{@"reportName":reportName, @"reportingMonth":_reportingMonth, @"currency":currency, @"status":status, @"update":updateStr, @"phase":phase} }];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    _JSONString = jsonString;

}

- (BOOL)shouldSendRequestForProject {

    _sendRequestCounter = 0;
    //[[ETGProjectModelController sharedModel] setTimestampAgeMoreThanOneDay:_timestamp];
    _didStartDonwloadProjects = YES;
    
    ETGProjectModelController *projectModel = [[ETGProjectModelController alloc] init];
    projectModel.filterDictionary = [NSDictionary dictionary];
    projectModel.filterDictionary = _filterDictionary;

    if (_projectKey == nil){
        NSDictionary *defaultProjectDict = [[ETGFilterModelController sharedController] getDefaultProjectsDictionary];
        [self getProjectFromDictionary:defaultProjectDict];
    }
    
    [projectModel getProjectForReportingMonth:_reportingMonth withProjectKey:_projectKey withKeyMilestonesData:_keyMilestones withProjectReports:_enableReports success:^(NSString *jsonString) {
    
        _withError = NO;

        _JSONString = jsonString;
        [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];

        if (_shouldDownloadMultipleProjectsInBackground == YES) {
            self.willDownloadBackgroundProjects = YES;
        }
        
        [self setNavigationBarWithoutActivityIndicator];

    } failure:^(NSError *error) {

        [_portfolioDelegate.delegate displayDataErrorMessageForPortfolio:error];
        [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
    }];

    return YES;

}

- (BOOL)shouldFetchOfflineDataForProject {
    
    _fetchRequestCounter = 0;

    // Get Offline data
    ETGProjectModelController *projectModel = [[ETGProjectModelController alloc] init];
    projectModel.filterDictionary = [NSDictionary dictionary];
    projectModel.filterDictionary = _filterDictionary;
    
    [projectModel getProjectOfflineForReportingMonth:_reportingMonth withProjectKey:_projectKey withKeyMilestonesData:_keyMilestones withProjectReports:_enableReports success:^(NSString *jsonString) {
    
        _withError = NO;
        _JSONString = jsonString;
        [_portfolioDelegate.delegate collectAllJsonDataFromCoreDataForPortfolio];
        
    } failure:^(NSError *error) {
        
        [_portfolioDelegate.delegate displayDataErrorMessageForPortfolio:error];

        if (_isCalledFromScorecard) {
            
            if (error.code != 105) {
                [self shouldSendRequestForProject];
            } else {
                [self loadJsonForProjectWithoutData];
                [self setNavigationBarWithoutActivityIndicator];
                
                [ETGAlert sharedAlert].alertShown = NO;
                ETGAlert *timeOut = [ETGAlert sharedAlert];
                timeOut.alertDescription = _errorDescription;
                [timeOut showProjectAlert];
                _withError = NO;
            }

        } else {
            [_portfolioDelegate.delegate collectAllJsonDataFromCoreDataForPortfolio];
        }
    }];
    
    return YES;
}

-(void)getProjectFromDictionary:(NSDictionary *)inputDictionary{
    for (ETGProject *project in inputDictionary[kSelectedProjects]){
        if (project.key != nil){

            _projectKey = [NSString stringWithFormat:@"%@", project.key];
            _projectName = [NSString stringWithFormat:@"%@", project.name];
            _projectStatus = [NSString stringWithFormat:@"%@", [project projectStatus]];
            id projPhase = [project phase];
            _projectStatus = [NSString stringWithFormat:@"%@", [projPhase name]];
            
            break;
        }
    }
}

- (BOOL)shouldSendRequestForProjectInBackground{

    _didStartDonwloadProjects = YES;
    [[ETGProjectModelController sharedModel] getBackgroundProjectForReportingMonth:_reportingMonth withProjectKey:_projectKey withKeyMilestonesData:_keyMilestones withProjectReports:_enableReports success:^(void) {
        _didStartDonwloadProjects = NO;
//        [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:_reportingMonth moduleName:@"Project"];
        //[self setNavigationBarWithoutActivityIndicator];
        _shouldDownloadMultipleProjectsInBackground = NO;
        
    } failure:^(NSError *error) {
        _didStartDonwloadProjects = NO;
        //[[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:_reportingMonth moduleName:@"Project"];
        DDLogError(@"%@%@", logInfoPrefix, @"Multiple projects download failed");
    }];
    
    return YES;
    
}

#pragma mark - Portfolio Delegate
// Collects all Project Data - Online
- (void)collectAllJsonDataFromWebServiceForPortfolio {
    
    if (_withError) {
        
        [self loadJsonForProjectWithoutData];
        [self setNavigationBarWithoutActivityIndicator];
        
        [ETGAlert sharedAlert].alertShown = NO;
        ETGAlert *timeOut = [ETGAlert sharedAlert];
        timeOut.alertDescription = _errorDescription;
        [timeOut showProjectAlert];
        _withError = NO;
    }

    [self reloadControllerData];
    
    // Set the navigation bar to remove the activity indicator
    _isTimeStampMoreThanADay = NO;

}
    
// Collects all Project Data - Online
- (void)collectAllJsonDataFromCoreDataForPortfolio {
    
    if (!_isTimeStampMoreThanADay) {
        // Set the navigation bar to remove the activity indicator
        [self setNavigationBarWithoutActivityIndicator];
        
        if (_withError) {
            [self loadJsonForProjectWithoutData];

//            [ETGAlert sharedAlert].alertDescription = [NSString stringWithFormat:projectAlert, itemNoAvailableDataAlert];
//            [[ETGAlert sharedAlert] showProjectAlert];
        }
    }
    
    [self reloadControllerData];

}

- (void)displayDataErrorMessageForScorecard:(NSError *)error {
}

- (void)displayDataErrorMessageForPortfolio:(NSError *)error {

    _withError = YES;
    _errorCode = error.code;
    _errorDescription = error.localizedDescription;
}

#pragma mark - Navigation Bar and Activity Indicator
- (void)createUIActivityIndicator {
    
    _activityIndicator =
    [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    _activityIndicatorBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_activityIndicator];
    
}

- (void)setNavigationBarWithActivityIndicator {
    
    self.navigationItem.rightBarButtonItems = nil;
    self.navigationItem.rightBarButtonItems = @[self.filtersBarButtonItem, _activityIndicatorBarButtonItem];
    [_activityIndicator startAnimating];
}

- (void)setNavigationBarWithoutActivityIndicator {
    
    self.navigationItem.rightBarButtonItems = nil;
    self.navigationItem.rightBarButtonItems = @[_filtersBarButtonItem, _updateBarButtonItem];
    [_activityIndicator stopAnimating];
}

- (void)reloadControllerData {
    
    //[self loadProjectContentWebview];
    [self webViewDidFinishLoad:_projectChartWebView];
    switch (_projectSegmentedButton.selectedSegmentIndex) {
        case 1:
            _shouldHideFilter = NO;
            [self prepareProjectBackgroundView];
            break;
        
        case 2:
            _shouldHideFilter = NO;
            [self prepareKeyHighlightView];
            break;
        
        default:
        break;
    }
}

- (void)prepareProjectBackgroundView {
    // Set the navigation bar
    [self setNavigationBarWithActivityIndicator];
    
    // Get Core Data for Key Highlight
    [[ETGScorecardModelController sharedModel] getProjectBackgroundTableSummaryOfflineForReportingMonth:_reportingMonth withProjectKey:_projectKey success:^(NSMutableArray *projectBackground) {
        
        _projectBackgroundValues = projectBackground;
        [self showProjectView];
        
        // Set the navigation bar to remove the activity indicator
        [self setNavigationBarWithoutActivityIndicator];
        
    } failure: ^(NSError * error) {
        _projectBackgroundValues = nil;
        [self showProjectView];
        
        // Set the navigation bar to remove the activity indicator
        [self setNavigationBarWithoutActivityIndicator];
    }];
}
    
- (void)prepareKeyHighlightView {
    // Set the navigation bar
    [self setNavigationBarWithActivityIndicator];
    
    // Get Web Service Data for Project Background
//    [[ETGScorecardModelController sharedModel] getKeyHighlightsSummaryOfflineForReportingMonth:_reportingMonth withProjectKey:_projectKey success:^(NSMutableArray *keyHighlights) {
    
        [[ETGScorecardModelController sharedModel] getKeyHighlightsSummaryOfflineForReportingMonth:_reportingMonth withProjectKey:_filterDictionary[kSelectedProjects] success:^(NSMutableArray *keyHighlights) {

        _keyHighlightsValues = keyHighlights;
        [self showKeyHighlightsView];
        
        // Set the navigation bar to remove the activity indicator
        [self setNavigationBarWithoutActivityIndicator];
        
    } failure: ^(NSError * error) {
        _keyHighlightsValues = nil;
        [self showKeyHighlightsView];
        
        // Set the navigation bar to remove the activity indicator
        [self setNavigationBarWithoutActivityIndicator];
    }];
}


#pragma mark - Actions

- (IBAction)tapUpdateBarButtonItem:(id)sender {
    // Set the navigation bar
    [self setNavigationBarWithActivityIndicator];

    //Set HTML module to blank
    _htmlModule = @"";
    
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (_appDelegate.isNetworkServerAvailable == YES) {

        // Hide filter view if currently visible
        if (_filterPopoverController) {
            [_filterPopoverController dismissPopoverAnimated:YES];
            _filterPopoverController = nil;
        }
        
        [ETGAlert sharedAlert].alertShown = NO;
        
        // Send the request
        [self shouldSendRequestForProject];
        
        NSDate *latestReportingMonth = [CommonMethods latestReportingMonth];
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyyMMdd"];
        NSString *reportingMonthLatest = [_dateFormatter stringFromDate:latestReportingMonth];
        if([_reportingMonth isEqualToString:reportingMonthLatest]){
            if (!_isCalledFromPortfolio &&!_isCalledFromScorecard) {
                _shouldDownloadMultipleProjectsInBackground = YES;
            }
        } else {
            _shouldDownloadMultipleProjectsInBackground = NO;
        }
        
        //[[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonth];
    } else {
        
        [ETGAlert sharedAlert].alertShown = NO;
        ETGAlert *timeOut = [ETGAlert sharedAlert];
        timeOut.alertDescription = serverCannotBeReachedAlert;
        [timeOut showProjectAlert];
        
        [self setNavigationBarWithoutActivityIndicator];

        DDLogWarn(@"%@%@",logWarnPrefix,serverCannotBeReachedWarn);
    }
}

- (IBAction)toggleWebview:(id)sender {
    
    UISegmentedControl *projectToggle = sender;
    switch ([projectToggle selectedSegmentIndex]) {
        case 0:
            [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeEnableBaseFilterNotificationInNSUserDefaults:@"Y"];
            /** Insert Project Dashboard **/
            _projectChartWebView.hidden = NO;
            // Remove project background or key highlight view
            for (UIViewController *controller in self.childViewControllers) {
                if ([controller isKindOfClass:[ETGProjectInformationViewController class]] ||
                    [controller isKindOfClass:[ETGKeyHighlightPagerViewController class]]) {
                    [controller removeFromParentViewController];
                    [controller.view removeFromSuperview];
                }
            }
            _projectInfoViewController = nil;
            _keyHighlightsPagerViewController = nil;
        
            break;
        case 1: {
            [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeEnableBaseFilterNotificationInNSUserDefaults:@"N"];
            _shouldHideFilter = YES;
            [self prepareProjectBackgroundView];
            break;
        }
        case 2: {
            [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeEnableBaseFilterNotificationInNSUserDefaults:@"N"];
            _shouldHideFilter = YES;
            [self prepareKeyHighlightView];
            break;
        }
        default:
            break;
    }
}
    
#pragma mark - Project Background
    
-(void)showProjectView {
    
    // Hide filter view if currently visible
    if (_shouldHideFilter == YES){
        if (_filterPopoverController) {
            [_filterPopoverController dismissPopoverAnimated:YES];
            _filterPopoverController = nil;
        }
    }

    if (_projectInfoViewController == nil) {
        
        for (UIViewController *controller in self.childViewControllers) {
            if ([controller isKindOfClass:[ETGKeyHighlightPagerViewController class]]) {
                [controller removeFromParentViewController];
                [controller.view removeFromSuperview];
                _keyHighlightsPagerViewController = nil;
                break;
            }
        }
        
        _projectInfoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"projectBackground"];
        [self addChildViewController:_projectInfoViewController];

        CGRect frame = self.view.frame;
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            frame.origin.y = 64;
        }
        
        _projectInfoViewController.view.frame = frame;
        
        [self.view addSubview:_projectInfoViewController.view];
        [self.view bringSubviewToFront:_projectInfoViewController.view];
    }
    
    if ([_projectBackgroundValues count]) {
        
        _projectInfoViewController.projectBackgroundValues = _projectBackgroundValues;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        NSDate *selectedReportingMonth = [dateFormatter dateFromString:_reportingMonth];
        [dateFormatter setDateFormat:@"MMM yyyy"];
        
        _projectInfoViewController.reportingMonth = [dateFormatter stringFromDate:selectedReportingMonth];
        
        [_projectInfoViewController reloadControllerData];
    } else {
        [_projectInfoViewController showNoDataAvailableMessage];
    }
}

#pragma mark - Key Highlights
-(void)showKeyHighlightsView {
    
    // Hide filter view if currently visible
    if (_shouldHideFilter == YES){
        if (_filterPopoverController) {
            [_filterPopoverController dismissPopoverAnimated:YES];
            _filterPopoverController = nil;
        }
    }
    
    if (_keyHighlightsPagerViewController == nil) {
        
        for (UIViewController *controller in self.childViewControllers) {
            if ([controller isKindOfClass:[ETGProjectInformationViewController class]]) {
                [controller removeFromParentViewController];
                [controller.view removeFromSuperview];
                _projectInfoViewController = nil;
                break;
            }
        }
        
         _keyHighlightsPagerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ETGKeyHighlightPagerViewController"];
        [self addChildViewController:_keyHighlightsPagerViewController];

        CGRect frame = self.view.frame;
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            frame.origin.y = 64;
        }
        _keyHighlightsPagerViewController.view.frame = frame;

        [self.view addSubview:_keyHighlightsPagerViewController.view];
        [self.view bringSubviewToFront:_keyHighlightsPagerViewController.view];
    }
    
    if ([_keyHighlightsValues count]) {
        [_keyHighlightsPagerViewController setKeyHighlightsData:_keyHighlightsValues];
        [_keyHighlightsPagerViewController setProjectName:_projectName];
        [_keyHighlightsPagerViewController setProjectStatus:_projectStatus];
        [_keyHighlightsPagerViewController reloadControllerData];
        
    } else {
        [_keyHighlightsPagerViewController showNoDataAvailableMessage];
        //[ETGAlert sharedAlert].alertDescription = [NSString stringWithFormat:@"%@%@", keyHighlightsAlert, noDataFoundError];
        //[[ETGAlert sharedAlert] showKeyHighlightsAlert];
    }
}


#pragma mark - Filters

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showFilter"]) {
        ETGFiltersViewController *filterViewController = (ETGFiltersViewController *)[(UINavigationController *)segue.destinationViewController topViewController];
        [filterViewController setDelegate:self];
        [filterViewController setSelectedRowsInFilter:_selectedRowsInFilter];
        [filterViewController setModuleName:@"project"];
        
        UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
        _filterPopoverController = popoverController;
        [popoverController setDelegate:self];
    }
}
 
- (IBAction)toggleFiltersPopover:(id)sender {
    if (_filterPopoverController) {
        [_filterPopoverController dismissPopoverAnimated:NO];
        _filterPopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showFilter" sender:sender];
    }
}


#pragma mark - Filter Delegate

- (void)filtersViewControllerDidCancel {
    [_filterPopoverController dismissPopoverAnimated:NO];
    _filterPopoverController = nil;
}

- (void)filtersViewControllerDidFinishWithProjectsDictionary:(NSDictionary *)filteredProjectsDictionary
{
    [self setNavigationBarWithActivityIndicator];

    [_filterPopoverController dismissPopoverAnimated:YES];
    _filterPopoverController = nil;
    
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeEnableBaseFilterNotificationInNSUserDefaults:@"Y"];
    //Apply filter
    _htmlModule = @"";
    [self getProjectReportDataFromFilterSelectionDictionary:filteredProjectsDictionary];
}

- (void)filtersviewControllerDidDismiss:(NSArray *)selectedRowsInFilter {
    _selectedRowsInFilter = selectedRowsInFilter;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    _filterPopoverController = nil;
}


#pragma mark - Generate JSON Report data

- (void)getProjectReportDataFromFilterSelectionDictionary:(NSDictionary *)filterSelectionDictionary {
    
    //NSLog(@"FilterDictionary: %@", filterSelectionDictionary);
    _filterDictionary = filterSelectionDictionary;

    ETGProject *selectedProject = nil;
    if ([filterSelectionDictionary[kSelectedProjects] count]) {
        selectedProject = [filterSelectionDictionary[kSelectedProjects] objectAtIndex:0];
    }
    
    //Specifically for Key milleston do logic below
    //JSON for KeyMilestone
    //    NSArray *keyMilestones = filterSelectionDictionary[kSelectedKeyMilestone];
//    _keyMilestones = filterSelectionDictionary[kSelectedKeyMilestone];
//    if ([_keyMilestones count] == 0) {
//        _keyMilestones = [[ETGFilterModelController sharedController] getLatestKeyMilestoneOfProject:selectedProject forReportingMonth:filterSelectionDictionary[kSelectedReportingMonth]];
//    }
    
    //call generateKeyMilestoneJSON:(NSArray *)keyMilestoneArray
    
    //TODO: Verify date conversion
//    if ([_reportingMonth isEqualToString:[_dateFormatter stringFromDate:filterSelectionDictionary[kSelectedReportingMonth]]]){
    if ([_reportingMonth isEqualToString:[filterSelectionDictionary[kSelectedReportingMonth] toReportingMonthDateString]]){
        if (!_isCalledFromPortfolio && !_isCalledFromScorecard) {
            _shouldDownloadMultipleProjectsInBackground = YES;
        }
    } else {
        _shouldDownloadMultipleProjectsInBackground = NO;
    }

    //TODO: Verify date conversion
//    _reportingMonth = [_dateFormatter stringFromDate:filterSelectionDictionary[kSelectedReportingMonth]];
    _reportingMonth = [filterSelectionDictionary[kSelectedReportingMonth] toReportingMonthDateString];
    NSArray *reporthMonth = [CommonMethods fetchEntity:@"ETGReportingMonth" withPredicate:[NSPredicate predicateWithFormat:@"name == %@", filterSelectionDictionary[kSelectedReportingMonth]] sortDescriptorBy:@"name" inManagedObjectContext:[NSManagedObjectContext defaultContext]];
    
    _timestamp = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:@"Project" reportingMonth:_reportingMonth];
    
    [self getProjectFromDictionary:filterSelectionDictionary];
    _dictionaryFromFilter = filterSelectionDictionary;
    
    if ((reporthMonth.count == 0) || (reporthMonth.count > 0 && _timestamp == YES)){
        if (_didStartDonwloadProjects == NO)
        {
            [ETGNetworkConnection checkAvailability];
            ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            if (appDelegate.isNetworkServerAvailable == YES) {
                [[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonth];
            } else {
                [self shouldFetchOfflineDataForProject];
            }
        } else {
            _shouldDownloadMultipleProjectsInBackground = NO;
            ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            if (appDelegate.isNetworkServerAvailable == YES) {
                [self shouldSendRequestForProject];
            } else {
                [self shouldFetchOfflineDataForProject];
            }
        }
    } else {
        if (_didStartDonwloadProjects == NO){
            
            if (_isCalledFromPortfolio || _isCalledFromScorecard) {
                [self fetchData];
            } else {
                [self shouldFetchOfflineDataForProject];
            }
        } else {
            [self fetchData];
        }
    }
}

- (void) fetchData {
    
    // Check project exist in core data
    //NSArray *projectSummary = [CommonMethods fetchEntity:@"ETGProjectSummary" withPredicate:[NSPredicate predicateWithFormat:@"projectKey == %@ AND reportingMonth == %@", _projectKey, _reportingMonth] sortDescriptorBy:@"projectKey" inManagedObjectContext:[NSManagedObjectContext defaultContext]];
    NSInteger projectSummary = [ETGProjectSummary countOfEntitiesWithPredicate:[NSPredicate predicateWithFormat:@"projectKey == %@ AND reportMonth == %@",_projectKey, [_reportingMonth toDate]]];
    
    if (projectSummary == 0){
        
        [ETGNetworkConnection checkAvailability];
        ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
        if (appDelegate.isNetworkServerAvailable == YES) {
            _shouldDownloadMultipleProjectsInBackground = NO;
            [self shouldSendRequestForProject];
        } else {
            [self shouldFetchOfflineDataForProject];
        }
    } else {
        [self shouldFetchOfflineDataForProject];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearWebView
{
    // Cancel pending background downloads
    [[RKObjectManager sharedManager].operationQueue cancelAllOperations];
    // Set empty JSON string
    _JSONString = @"";
    _requestString = nil;
    // Show empty web view
    [self loadProjectContentWebview];
    // Set should reload view
    _shouldReloadView = YES;
    
    _selectedRowsInFilter = nil;
}

@end
