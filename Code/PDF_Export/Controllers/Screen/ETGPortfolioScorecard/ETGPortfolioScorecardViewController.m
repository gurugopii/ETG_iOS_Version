//
//  PDFPortfolioViewController.m
//  PDF_Export
//
//  Created by Mendoza, Christine D. on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//  Updates

#import "ETGPortfolioScorecardViewController.h"
#import "ETGFiltersViewController.h"
#import "ETGSectionInfo.h"
#import "ETGProjectInformationViewController.h"
#import "ETGKeyHighlightPagerViewController.h"
#import "ETGPortfolioData.h"
// Model Controllers
#import "ETGScorecardModelController.h"
#import "ETGScorecard.h"
#import "ETGWebService.h"
#import "CommonMethods.h"
#import "ETGProjectViewController.h"
#import "ETGCoreDataUtilities.h"
#import "ETGFilterModelController.h"
#import "ETGJsonHelper.h"
#import "ETGProject.h"
#import "ETGRegion.h"
#import "ETGPortfolio.h"
#import "ETGCostAllocation.h"
#import "ETGReportingMonth.h"
#import "ETGCpb.h"
#import "ETGWpb.h"
#import "ETGNetworkConnection.h"
#import "Reachability.h"
#import "ETGJSONKeyReplaceManipulation.h"
#import "ETGScoreCardTableSummary.h"

#define kReportKey @"etgModuleItemKey"
#define kReportDetail @"etgModuleItemPopup"
#define kReportDetailKey @"etgModuleItemPopupKey"

@class ETGScorecardModelController;

@interface ETGPortfolioScorecardViewController () <UIWebViewDelegate, ETGFiltersViewControllerDelegate, UIPopoverControllerDelegate, ETGPortfolioDataDelegate, ETGScorecardModelControllerDelegate>{
    
    BOOL toHideScorecard;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *portfolioSegmentedButton;
@property (nonatomic, weak) IBOutlet UIWebView* portfolioWebview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filtersBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateBarButtonItem;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIBarButtonItem *activityIndicatorBarButtonItem;
@property (nonatomic) UIPopoverController *filtersPopoverController;

@property (nonatomic, strong) ETGKeyHighlightPagerViewController *keyHighlightsPagerViewController;
@property (nonatomic, strong) ETGProjectViewController *projectViewController;
@property (nonatomic, strong) ETGPortfolioData *portfolioDelegate;
@property (nonatomic, strong) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) Reachability *hostReachability;
@property (nonatomic, strong) Reachability *internetReachability;
@property (nonatomic, strong) NSManagedObjectContext* context;
@property (nonatomic, strong) NSMutableArray *keyHighlightsValues;
@property (nonatomic, strong) NSMutableArray *projectBackgroundValues;
@property (nonatomic, strong) NSMutableArray *dataForHydrocarbon;
@property (nonatomic, strong) NSMutableDictionary *dataForPortfolio;
@property (nonatomic, strong) NSMutableDictionary *dataForProductionRtbd;
@property (nonatomic, strong) NSMutableDictionary *dataForCpb;
@property (nonatomic, strong) NSMutableDictionary *dataForApc;
@property (nonatomic, strong) NSMutableDictionary *dataForHse;
@property (nonatomic, strong) NSMutableDictionary *dataForWpb;
@property (nonatomic, strong) NSMutableDictionary *dataForMlh;
@property (nonatomic, strong) NSMutableDictionary *projectDetails;
@property (nonatomic, strong) NSMutableDictionary *projectDetailsDictionaryForScorecard;
@property (nonatomic, strong) NSDictionary *filteredProjectsDictionaryForScorecard;
@property (nonatomic, strong) NSMutableDictionary *projectDetailsDictionary;
@property (nonatomic, strong) NSDictionary *filteredProjectsDictionary;
//@property (nonatomic, strong) NSMutableDictionary *projectDetailsDictionaryForGraph;
//@property (nonatomic, strong) NSDictionary *filteredProjectsDictionaryForGraph;
@property (nonatomic) NSArray *selectedRowsInFilter;
@property (nonatomic, strong) NSString* JSONStringForPopover;
@property (nonatomic, strong) NSString* JSONStringForScorecard;
@property (nonatomic, strong) NSString* JSONStringForPortfolio;
@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSString* reportingMonthForScorecard;
@property (nonatomic, strong) NSString* reportingMonth;
//@property (nonatomic, strong) NSString* reportingMonthForGraph;
@property (nonatomic, strong) NSString* projectKey;
@property (nonatomic, strong) NSString* PDFField;
@property (nonatomic, strong) NSString* requestString;
@property (nonatomic, strong) NSString* operatorshipValue;
@property (nonatomic, strong) NSString* phaseValue;
@property (nonatomic, strong) NSString* updateValue;
@property (nonatomic, strong) NSString* htmlPage;
@property (nonatomic, strong) NSString* keyHighlightsProjectName;
@property (nonatomic, strong) NSString* keyHighlightsProjectPhase;
@property (nonatomic, strong) NSString* requestStringForPortfolioLevel2;
@property (nonatomic)BOOL isFiltered;
@property (nonatomic)BOOL isTimeStampMoreThanADay;
@property (nonatomic)BOOL withError;
@property (nonatomic)BOOL isInitialRun;
@property (nonatomic)BOOL isInitialRunOfScorecard;
@property (nonatomic)BOOL isScorecardLoaded;
@property (nonatomic)BOOL isPortfolioLoaded;
@property (nonatomic)BOOL timestamp;
@property (nonatomic)BOOL timestampScorecard;
@property (nonatomic)BOOL isBaseFilterDownloadCompleted;
@property (nonatomic)BOOL isObserverReady;
@property (nonatomic)BOOL isUpdateButton;
@property (nonatomic)int sendRequestCounter;
@property (nonatomic)int fetchRequestCounter;
@property (nonatomic)int errorCode;
@property (nonatomic)int pageNumber;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) BOOL shouldReloadView;

@property (nonatomic, strong) UIApplication *app;

@property (nonatomic, strong) NSString* JSONStringForScorecardCache;
@property (nonatomic)BOOL wasToggled;

- (IBAction)toggleFiltersPopover:(id)sender;
- (IBAction)tapUpdateBarButtonItem:(id)sender;

@end
@implementation ETGPortfolioScorecardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"PortFooo V load");
    NSString *serverAddress = [[NSURL URLWithString:kBaseURL] host];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    _hostReachability = [Reachability reachabilityWithHostName:serverAddress];
    [_hostReachability startNotifier];
    
    _internetReachability = [Reachability reachabilityForInternetConnection];
    [_internetReachability startNotifier];
    
    _appDelegate = [[UIApplication sharedApplication] delegate];
    
    //DDLogInfo(@"Enable reports in Project Module: %@", _enableReports);
    //DDLogInfo(@"EnableProjectReports: %@", _enableProjectReports);

    _pageNumber = 1;
    _isInitialRun = NO;
    _isUpdateButton = NO;
    _isInitialRunOfScorecard = NO;
    toHideScorecard = YES;
    [self configureNavigationBar];
    
    // Initializes Portfolio delegate
    _portfolioDelegate = [[ETGPortfolioData alloc] init];
    
    // Parameters needed in requesting data
    NSDate *latestReportingMonth = [CommonMethods latestReportingMonth];
    //DDLogInfo(@"LatestReportingMoth: %@", latestReportingMonth);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    _reportingMonth = [formatter stringFromDate:latestReportingMonth];
    _reportingMonthForScorecard = _reportingMonth;
    
    _context = [NSManagedObjectContext contextForCurrentThread];
    _managedObjectContext = [NSManagedObjectContext defaultContext];

    //Set the background image for webView
    [self.portfolioWebview setOpaque:NO];
    self.portfolioWebview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];

    
    _withError = NO;
    _htmlPage = @"ETGPortfolioScorecard";
    //_isPortfolioLoaded = YES;
    _shouldReloadView = NO;
    
    [self loadContentWebview];
    
    _timestampScorecard = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:@"Scorecard" reportingMonth:_reportingMonth];
    
    if (_timestampScorecard == YES) {
        //_isBaseFilterDownloadCompleted = NO;
        //[[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonth];
        // Check server availability
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        if (_appDelegate.isNetworkServerAvailable == YES) {
            _isInitialRun = YES;
            _isInitialRunOfScorecard = YES;
            //[self shouldSendRequestForScorecard];
            
            [[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonth];
        } else {
            NSDictionary *defaults = [[NSDictionary alloc] initWithDictionary:[[ETGFilterModelController sharedController] getDefaultProjectsDictionary]];
            _filteredProjectsDictionaryForScorecard = defaults;
            _projectDetailsDictionaryForScorecard = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
            _reportingMonthForScorecard = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];
            _filteredProjectsDictionary = defaults;
            _projectDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
            _reportingMonth = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];

            _filteredProjectsDictionary = defaults;
            _projectDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
            _reportingMonth = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];

            [self filterScorecardWithProjects:_filteredProjectsDictionaryForScorecard[kSelectedProjects] inReportingMonth:[_reportingMonthForScorecard toDate]];
            [self setNavigationBarWithoutActivityIndicator];
        }
    } else {
        NSDictionary *defaults = [[NSDictionary alloc] initWithDictionary:[[ETGFilterModelController sharedController] getDefaultProjectsDictionary]];
        _filteredProjectsDictionaryForScorecard = defaults;
        _projectDetailsDictionaryForScorecard = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
        _reportingMonthForScorecard = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];
        
        _filteredProjectsDictionary = defaults;
        _projectDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
        _reportingMonth = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];

        [self filterScorecardWithProjects:_filteredProjectsDictionaryForScorecard[kSelectedProjects] inReportingMonth:[_reportingMonth toDate]];
        [self setNavigationBarWithoutActivityIndicator];
    }

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired = 2;
    tapGesture.delegate = self;
    [_portfolioWebview addGestureRecognizer:tapGesture];
    _wasToggled = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Check if view should reload
    if (_shouldReloadView) {
        
        if ([_htmlPage isEqualToString:@"ETGPortfolioScorecard"]){
            [self showMask];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideMask) userInfo:nil repeats:NO];
        } else{
            _JSONStringForPortfolio = @"";
        }
        
        _pageNumber = 1;
        _isInitialRun = NO;
        _isUpdateButton = NO;
        _isInitialRunOfScorecard = NO;
        [self configureNavigationBar];
        
        // Initializes Portfolio delegate
        _portfolioDelegate = [[ETGPortfolioData alloc] init];
        
        // Parameters needed in requesting data
        NSDate *latestReportingMonth = [CommonMethods latestReportingMonth];
        //DDLogInfo(@"LatestReportingMoth: %@", latestReportingMonth);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        _reportingMonth = [formatter stringFromDate:latestReportingMonth];
        //    _reportingMonth = @"20130101";
        
        _context = [NSManagedObjectContext contextForCurrentThread];
        _managedObjectContext = [NSManagedObjectContext defaultContext];
        
        //Set the background image for webView
        [self.portfolioWebview setOpaque:NO];
        self.portfolioWebview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
        
        _JSONStringForScorecard = nil;
        
        _withError = NO;
        if (_portfolioSegmentedButton.selectedSegmentIndex == 0 && (_portfolioSegmentedButton.numberOfSegments>1)) {
            _htmlPage = @"ETGPortfolioScorecard";
        } else {
            _htmlPage = @"ETGPortfolioLevel1";
        }
        [self loadContentWebview];
        
        _timestampScorecard = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:@"Scorecard" reportingMonth:_reportingMonth];
        
        //_timestamp = YES;
        
        if (_timestampScorecard == YES) {
            //_isBaseFilterDownloadCompleted = NO;
//            [[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonth];
            // Check server availability
            _appDelegate = [[UIApplication sharedApplication] delegate];
            [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
            [ETGNetworkConnection checkAvailability];
            if (_appDelegate.isNetworkServerAvailable == YES) {
                _isInitialRun = YES;
                _isInitialRunOfScorecard = YES;
                
                [[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonth];
//                [self shouldSendRequestForScorecard];
            } else {
                NSDictionary *defaults = [[NSDictionary alloc] initWithDictionary:[[ETGFilterModelController sharedController] getDefaultProjectsDictionary]];
                _filteredProjectsDictionaryForScorecard = defaults;
                _projectDetailsDictionaryForScorecard = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
                _reportingMonthForScorecard = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];
                
                _filteredProjectsDictionary = defaults;
                _projectDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
                _reportingMonth = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];

                [self filterScorecardWithProjects:_filteredProjectsDictionaryForScorecard[kSelectedProjects] inReportingMonth:[_reportingMonthForScorecard toDate]];
                [self setNavigationBarWithoutActivityIndicator];
            }
        } else {
        
            NSDictionary *defaults = [[NSDictionary alloc] initWithDictionary:[[ETGFilterModelController sharedController] getDefaultProjectsDictionary]];
            _filteredProjectsDictionaryForScorecard = defaults;
            _projectDetailsDictionaryForScorecard = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
            _reportingMonthForScorecard = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];

            _filteredProjectsDictionary = defaults;
            _projectDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
            _reportingMonth = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];

            [self filterScorecardWithProjects:_filteredProjectsDictionaryForScorecard[kSelectedProjects] inReportingMonth:[_reportingMonthForScorecard toDate]];
            [self setNavigationBarWithoutActivityIndicator];
        }

        _shouldReloadView = NO;
    }
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        self.portfolioWebview.frame = CGRectMake(0, 0, 1024, 700);
    }
}

-(void)loadPortfolioAfterScorecard {
   
    if (_portfolioSegmentedButton.selectedSegmentIndex == 1  || (_portfolioSegmentedButton.numberOfSegments==1)) {
        [self setNavigationBarWithActivityIndicator];
    }

    _timestamp = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:@"Portfolio" reportingMonth:_reportingMonth];
    
    if (_timestamp == YES) {
        // Check server availability
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        if (_appDelegate.isNetworkServerAvailable == YES) {
            ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
            [portfolioModel deletePortfolioTableSummaryForReportingMonth:_reportingMonth
                                                              withUserId:_projectKey
                                                                 success:^(bool removed) {
                                                                     [self shouldSendRequestForPortfolio];
                                                                 } failure:^(NSError *error) {
                                                                     
                                                                 }];
        } else {
            // Offline Mode
            [self getPortfolioReportDataForProjects:_filteredProjectsDictionary];
        }
    } else {
        [self getPortfolioReportDataForProjects:_filteredProjectsDictionary];
    }
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
        self.updateBarButtonItem.enabled = NO;
    } else {
        self.updateBarButtonItem.enabled = YES;
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

- (void)getPortfolioReportData
{
    //NSLog(@"Filter was changed");
//    _isBaseFilterDownloadCompleted = YES;
    
    if (_isInitialRun) {
        
        NSDictionary *defaults = [[NSDictionary alloc] initWithDictionary:[[ETGFilterModelController sharedController] getDefaultProjectsDictionary]];

        if (_portfolioSegmentedButton.selectedSegmentIndex == 0 && (_portfolioSegmentedButton.numberOfSegments>1)) {
        
            _filteredProjectsDictionaryForScorecard = defaults;
            _projectDetailsDictionaryForScorecard = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
            _reportingMonthForScorecard = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];
            
            _filteredProjectsDictionary = defaults;
            _projectDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionary];
            _reportingMonth = [_filteredProjectsDictionary[kSelectedReportingMonth] toReportingMonthDateString];

            if (!_isScorecardDownloading) {
                [self shouldSendRequestForScorecard];
            }
        }
        else if (_portfolioSegmentedButton.selectedSegmentIndex == 1 || (_portfolioSegmentedButton.numberOfSegments==1)) {
            
            _filteredProjectsDictionaryForScorecard = defaults;
            _projectDetailsDictionaryForScorecard = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
            _reportingMonthForScorecard = [_filteredProjectsDictionaryForScorecard[kSelectedReportingMonth] toReportingMonthDateString];
            
            _filteredProjectsDictionary = defaults;
            _projectDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionary];
            _reportingMonth = [_filteredProjectsDictionary[kSelectedReportingMonth] toReportingMonthDateString];
            
            if (!_isPortfolioGraphDownloading) {
                [self loadPortfolioAfterScorecard];
            }
        }
        
        _isInitialRun = NO;

    } else if (_isUpdateButton) {
        
        _timestamp = YES;
        _isUpdateButton = NO;

        if (_portfolioSegmentedButton.selectedSegmentIndex == 0 && (_portfolioSegmentedButton.numberOfSegments>1)) {
            [self shouldSendRequestForScorecard];
        } else if (_portfolioSegmentedButton.selectedSegmentIndex == 1 || (_portfolioSegmentedButton.numberOfSegments == 1)) {
//            [self loadPortfolioAfterScorecard];
            
            ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
            [portfolioModel deletePortfolioTableSummaryForReportingMonth:_reportingMonth
                                                              withUserId:_projectKey
                                                                 success:^(bool removed) {
                                                                     [self shouldSendRequestForPortfolio];

                                                                 } failure:^(NSError *error) {

                                                                 }];

        }
    }
}

- (void)getErrorCodeWhenBaseFilterRequestFailed:(NSNotification *)notification
{
    //_isBaseFilterDownloadCompleted = YES;
    
    if (_isUpdateButton) {
        _isUpdateButton = NO;
    }
    
    if (_isInitialRun) {
        _isInitialRun = NO;
    }
    
    if ([notification.object integerValue] == -1004 || [notification.object integerValue] == -1003) {
        [self setNavigationBarWithoutActivityIndicator];
        
        [ETGAlert sharedAlert].alertShown = NO;
        ETGAlert *timeOut = [ETGAlert sharedAlert];
        timeOut.alertDescription = serverCannotBeReachedAlert;
        [timeOut showPortfolioAlert];
        DDLogWarn(@"%@%@",logWarnPrefix,serverCannotBeReachedWarn);
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"PortFooo V Apper");
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeEnableBaseFilterNotificationInNSUserDefaults:@"Y"];
    //[self getPortfolioReportData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPortfolioReportData)
                                                 name:kDownloadFilterDataForGivenReportingMonthCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getErrorCodeWhenBaseFilterRequestFailed:)
                                                 name:kDownloadFilterDataForGivenReportingMonthFailed object:nil];
    [self.sidePanelController addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (appDelegate.isNetworkServerAvailable == YES) {
        _updateBarButtonItem.enabled = YES;
    } else {
        _updateBarButtonItem.enabled = NO;
    }
    //============================== Scorecard =============================
    //check if there was a halted process which needs to be continued
    if([_htmlPage isEqualToString:@"ETGPortfolioScorecard"]){
        if (_isScorecardDownloading == YES) {
            [self setNavigationBarWithActivityIndicator];
            [[ETGPortfolioModelController sharedModel] setQueuepriorityForScorecard:_reportingMonthForScorecard];
        }
    } else {
        if (_isPortfolioGraphDownloading == YES){
            [self setNavigationBarWithActivityIndicator];
            [[ETGPortfolioModelController sharedModel] setQueuepriorityForPortfolioGraph:_reportingMonth];
        }
    }
   /* if (toHideScorecard) {
        
        if (_portfolioSegmentedButton != nil) {
            
            [_portfolioSegmentedButton removeSegmentAtIndex:0 animated:NO];
        }
        _portfolioSegmentedButton.selectedSegmentIndex = 0;
        [self toggleWebview:_portfolioSegmentedButton];
        [[ETGPortfolioModelController sharedModel] setQueuepriorityForPortfolioGraph:_reportingMonth];
        
        toHideScorecard = NO;
    }*/
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForGivenReportingMonthCompleted object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForGivenReportingMonthFailed object:nil];

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
    
    [self setNavigationBarWithoutActivityIndicator];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Elevate To Go" message:@"Memory warning received. Please close and re-open the application." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];*/
}

- (void)configureNavigationBar {
    [self createUIActivityIndicator];
    [self setNavigationBarWithActivityIndicator];
}


#pragma mark - Webview Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"PortFooo web Delegate");
    
    _requestString = [[request URL] absoluteString];
    
    if ([_requestString rangeOfString:@"ETGPortfolioScorecard"].location == NSNotFound) {
        
        if ([_requestString rangeOfString:@"ETGPortfolioLevel2"].location != NSNotFound) {
            
            //Get Portfolio Level 2 html file
            _requestStringForPortfolioLevel2 = _requestString;
            
            //Display Level 2 data
            [self webViewDidFinishLoad:self.portfolioWebview];
        } else {
            
            if ([_requestString rangeOfString:@"ETGPortfolioLevel1"].location == NSNotFound){
                NSString* requestString = [[request URL] absoluteString];
                return [self shouldStartLoadForScorecard:requestString];
            } else {
                _requestStringForPortfolioLevel2 = @"";
            }
        }
    }

    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //NSLog(@"Emtpy ==> %@", _JSONStringForPortfolio);
    if (_portfolioSegmentedButton.selectedSegmentIndex == 1 || (_portfolioSegmentedButton.numberOfSegments == 1)) {
        if ([_requestString rangeOfString:@"ETGPortfolioLevel1"].location != NSNotFound) {
            [self.portfolioWebview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"populateAllChartsAtLevel1('%@');", _JSONStringForPortfolio]];
            if (_JSONStringForPortfolio == nil || [_JSONStringForPortfolio isEqualToString:@""]) {
                
                 [[ETGPortfolioModelController sharedModel] setQueuepriorityForPortfolioGraph:_reportingMonth];
            }
        } else if ([_requestString rangeOfString:@"ETGPortfolioLevel2"].location != NSNotFound) {
            [self.portfolioWebview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"populateAllChartsAtLevel2('%@');",
                                                                       _JSONStringForPortfolio]];
        }
    } else {
        //NSLog(@"Scorecard JSON: %@", _JSONStringForScorecard);
        if (_wasToggled == YES && _isScorecardDownloading == YES){
            _JSONStringForScorecard = _JSONStringForScorecardCache;
            _wasToggled = NO;
        }
        [self.portfolioWebview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"displayTable('%@' ,'%@')", _JSONStringForScorecard, [self getTopInformationForScorecard]]];
    }
}

#pragma mark - Scorecard and Portfolio

- (void)loadContentWebview {
    
    NSLog(@"PortFooo load request");
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:_htmlPage ofType:@"html" inDirectory:@"Charts"];
    NSURL *url = [NSURL fileURLWithPath:htmlFile];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[self.portfolioWebview scrollView] setBounces: NO];
    [self.portfolioWebview setClearsContextBeforeDrawing:YES];
    [self.portfolioWebview loadRequest:request];
    
}

- (NSArray *)fetchProjectsBaseOnProjectKey:(NSString *)projectKey phases:(NSString *)phaseKeys regions:(NSString *)regionKeys projectStatuses:(NSString *)projectStatusKeys reportingMonth:(NSString *)reportingMonth {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ETGProject" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reportingMonths.name CONTAINS %@ AND key == %@ ", [reportingMonth toDate], [NSNumber numberWithInt:[projectKey intValue]]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        DDLogError(fetchProjectError, error);
    }
    return fetchedObjects;
}

- (void) activityIndicatorForPopoverOn {
    
    if (!_isScorecardDownloading) {
        // Set the navigation bar
        [self setNavigationBarWithActivityIndicator];
    }
}

- (void) activityIndicatorForPopoverOff {
    
    if (!_isScorecardDownloading) {
        // Set the navigation bar
        [self setNavigationBarWithoutActivityIndicator];
    }
}

#pragma mark - Scorecard

- (BOOL)shouldStartLoadForScorecard:(NSString*)requestString {
    
     _projectViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectChart"];
    
    if ([requestString hasPrefix:@"js-chartview"]) {
        //NSLog(@"%@", requestString);
//        // Create the activity indicator
//        [self createUIActivityIndicator];
//        
//        // Set the navigation bar
        [self activityIndicatorForPopoverOn];
        
        _projectViewController.reportingMonth = _reportingMonthForScorecard;
        _projectViewController.projectKey = _projectKey;
        _projectViewController.isCalledFromScorecard = YES;

        NSMutableDictionary *projectsDictionary = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSArray *fetchedProjects = [self fetchProjectsBaseOnProjectKey:_projectKey phases:nil regions:nil projectStatuses:nil reportingMonth:_reportingMonthForScorecard];

        if (fetchedProjects.count > 0) {
            [projectsDictionary setObject:fetchedProjects forKey:kSelectedProjects];
            [projectsDictionary setObject:[_projectDetailsDictionaryForScorecard objectForKey:@"kSelectedReportingMonth"] forKey:kSelectedReportingMonth];

        }
        _projectViewController.dictionaryFromScorecard = projectsDictionary;
        [_projectViewController setEnableReports:_enableProjectReports];

        if ([projectsDictionary count] > 0){
        [self.navigationController pushViewController :_projectViewController animated:YES];
        }else{
            [ETGAlert sharedAlert].alertDescription = @"Project: No Data found.";
            [[ETGAlert sharedAlert] showProjectAlert];
        }
        
        [self activityIndicatorForPopoverOff];

        
    } else if ([requestString hasPrefix:@"js-highlightview"]) {
        
        // Create the activity indicator
        [self createUIActivityIndicator];
        
        // Set the navigation bar
        [self activityIndicatorForPopoverOn];
        
        _projectViewController.reportingMonth = _reportingMonth;
        _projectViewController.projectKey = _projectKey;
        _projectViewController.isCalledFromScorecard = YES;
        _projectViewController.isCalledFromKeyhighlights = YES;
        
        
        NSMutableDictionary *projectsDictionary = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSArray *fetchedProjects = [self fetchProjectsBaseOnProjectKey:_projectKey phases:nil regions:nil projectStatuses:nil reportingMonth:_reportingMonthForScorecard];
        
        if (fetchedProjects.count > 0) {
            [projectsDictionary setObject:fetchedProjects forKey:kSelectedProjects];
            [projectsDictionary setObject:[_projectDetailsDictionaryForScorecard objectForKey:@"kSelectedReportingMonth"]
                                   forKey:kSelectedReportingMonth];
            
        }
        _projectViewController.dictionaryFromScorecard = projectsDictionary;
        [_projectViewController setEnableReports:_enableProjectReports];
        
        if ([projectsDictionary count] > 0){
            [self.navigationController pushViewController :_projectViewController animated:YES];
        }else{
            [ETGAlert sharedAlert].alertDescription = @"Project: No Data found.";
            [[ETGAlert sharedAlert] showProjectAlert];
        }

        [self activityIndicatorForPopoverOff];


    } else if ([requestString hasPrefix:@"js-projectview"]) {
        
        // Create the activity indicator
        [self createUIActivityIndicator];
        
        // Set the navigation bar
        [self activityIndicatorForPopoverOn];
        
        _projectViewController.reportingMonth = _reportingMonthForScorecard;
        _projectViewController.projectKey = _projectKey;
        _projectViewController.isCalledFromScorecard = YES;
        _projectViewController.isCalledFromProjectView = YES;

        NSMutableDictionary *projectsDictionary = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSArray *fetchedProjects = [self fetchProjectsBaseOnProjectKey:_projectKey phases:nil regions:nil projectStatuses:nil reportingMonth:_reportingMonthForScorecard];
        
        if (fetchedProjects.count > 0) {
            [projectsDictionary setObject:fetchedProjects forKey:kSelectedProjects];
            [projectsDictionary setObject:[_projectDetailsDictionaryForScorecard objectForKey:@"kSelectedReportingMonth"]
                                   forKey:kSelectedReportingMonth];
            
        }
        _projectViewController.dictionaryFromScorecard = projectsDictionary;
        [_projectViewController setEnableReports:_enableProjectReports];
        
        if ([projectsDictionary count] > 0){
            [self.navigationController pushViewController :_projectViewController animated:YES];
        }else{
            [ETGAlert sharedAlert].alertDescription = @"Project: No Data found.";
            [[ETGAlert sharedAlert] showProjectAlert];
        }

        [self activityIndicatorForPopoverOff];

        
    } else if ([requestString hasPrefix:@"main"]) {
        
        _projectKey = [[requestString componentsSeparatedByString:@":"] objectAtIndex:2];
        NSString* popover = [[requestString componentsSeparatedByString:@":"] objectAtIndex:4];
        
        if ([popover isEqualToString:@"hse"]) {
//            // Create the activity indicator
//            [self createUIActivityIndicator];
            
            // Set the navigation bar
            [self activityIndicatorForPopoverOn];
            
            [[ETGScorecardModelController sharedModel] getHseTableSummaryForReportingMonth:_reportingMonthForScorecard withProjectKey:[NSNumber numberWithInt:[_projectKey integerValue]] success:^(NSString *jsonString) {

                _JSONStringForPopover = jsonString;
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", _JSONStringForPopover]];
                [self activityIndicatorForPopoverOff];

            } failure:^(NSError *error) {
//                [_portfolioDelegate.delegate displayDataErrorMessageForScorecard:error];
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", @"[]"]];

                [self activityIndicatorForPopoverOff];
            }];
            
        } else if ([popover isEqualToString:@"production"]) {
//            // Create the activity indicator
//            [self createUIActivityIndicator];
            
            // Set the navigation bar
            [self activityIndicatorForPopoverOn];
            
            [[ETGScorecardModelController sharedModel] getProductionTableSummaryForReportingMonth:_reportingMonthForScorecard withProjectKey:[NSNumber numberWithInt:[_projectKey integerValue]] success:^(NSString *jsonString) {
 
                _JSONStringForPopover = jsonString;
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", _JSONStringForPopover]];
                [self activityIndicatorForPopoverOff];

            } failure:^(NSError *error) {
//                [_portfolioDelegate.delegate displayDataErrorMessageForScorecard:error];
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", @"[]"]];
                [self activityIndicatorForPopoverOff];
            }];
            
        } else if ([popover isEqualToString:@"costpcsb"]) {
//            // Create the activity indicator
//            [self createUIActivityIndicator];
            
            // Set the navigation bar
            [self activityIndicatorForPopoverOn];
            
            [[ETGScorecardModelController sharedModel] getCostPcsbTableSummaryForReportingMonth:_reportingMonthForScorecard withProjectKey:[NSNumber numberWithInt:[_projectKey integerValue]] success:^(NSString *jsonString) {
                _JSONStringForPopover = jsonString;
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", _JSONStringForPopover]];
                [self activityIndicatorForPopoverOff];
           
            } failure:^(NSError *error) {
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", @"{\"APCPerformance\":\"no data\",\"CPBPerformance\":\"no data\",\"AFEPerformance\":[]}"]];
                [self activityIndicatorForPopoverOff];
            }];
        } else if ([popover isEqualToString:@"costpmu"]) {
//            // Create the activity indicator
//            [self createUIActivityIndicator];
            
            // Set the navigation bar
            [self activityIndicatorForPopoverOn];
            
            [[ETGScorecardModelController sharedModel] getCostPmuTableSummaryForReportingMonth:_reportingMonthForScorecard withProjectKey:[NSNumber numberWithInt:[_projectKey integerValue]] success:^(NSString *jsonString) {
                _JSONStringForPopover = jsonString;
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", _JSONStringForPopover]];
                [self activityIndicatorForPopoverOff];
            } failure:^(NSError *error) {
//                [_portfolioDelegate.delegate displayDataErrorMessageForScorecard:error];
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", @"{\"WPBDetails\":[],\"FDPPerformance\":\"no data\"}"]];
                [self activityIndicatorForPopoverOff];
            }];
        } else if ([popover isEqualToString:@"schedule"]) {
//            // Create the activity indicator
//            [self createUIActivityIndicator];
            
            // Set the navigation bar
            [self activityIndicatorForPopoverOn];
            
            [[ETGScorecardModelController sharedModel] getScheduleTableSummaryForReportingMonth:_reportingMonthForScorecard withProjectKey:[NSNumber numberWithInt:[_projectKey integerValue]] success:^(NSString *jsonString) {
                _JSONStringForPopover = jsonString;
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", _JSONStringForPopover]];
                [self activityIndicatorForPopoverOff];
            } failure:^(NSError *error) {
//                [_portfolioDelegate.delegate displayDataErrorMessageForScorecard:error];
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", @"{\"KeyMileStone\":\"no data\"}"]];
                [self activityIndicatorForPopoverOff];
            }];
        } else if ([popover isEqualToString:@"projectname"]) {
            [[ETGScorecardModelController sharedModel] setEnableReportFromScorecard:_enableProjectReports];
            _JSONStringForPopover = [[ETGScorecardModelController sharedModel] getProjectPopover];
           
            if (_enableProjectReports != nil) {
                
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"displayPopover('%@');", _JSONStringForPopover]];
            }
	} else if ([popover isEqualToString:@"manpower"]) {
            //            // Create the activity indicator
            //            [self createUIActivityIndicator];
            
            // Set the navigation bar
            [self activityIndicatorForPopoverOn];
            
            [[ETGScorecardModelController sharedModel] getManpowerTableSummaryForReportingMonth:_reportingMonthForScorecard withProjectKey:[NSNumber numberWithInt:[_projectKey integerValue]] success:^(NSString *jsonString) {
                
                _JSONStringForPopover = jsonString;
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", _JSONStringForPopover]];
                
                //NSLog(@"json manpower %@",_JSONStringForPopover);
                [self activityIndicatorForPopoverOff];
                
            } failure:^(NSError *error) {
                //                [_portfolioDelegate.delegate displayDataErrorMessageForScorecard:error];
                [self.portfolioWebview stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"displayPopover('%@');", @"[]"]];
                
                [self activityIndicatorForPopoverOff];
            }];
        //Portfolio to Project
        } else if ([popover isEqualToString:@"hydro1"] || [popover isEqualToString:@"hydro2"] || [popover isEqualToString:@"rtbd"] || [popover isEqualToString:@"cpb"] || [popover isEqualToString:@"apc"] || [popover isEqualToString:@"hse2"] || [popover isEqualToString:@"wpb"]){
            
            // Create the activity indicator
            [self createUIActivityIndicator];
            
            // Set the navigation bar
            //[self activityIndicatorForPopoverOn];
            
            _projectViewController.reportingMonth = _reportingMonth;
            _projectViewController.projectKey = [[requestString componentsSeparatedByString:@":"] objectAtIndex:3];
            _projectViewController.isCalledFromScorecard = NO;
            _projectViewController.isCalledFromProjectView = NO;
            _projectViewController.isCalledFromPortfolio = YES;
            _projectViewController.htmlPage = @"2.html";
            _projectViewController.htmlModule = [[requestString componentsSeparatedByString:@":"] objectAtIndex:4];
            
            NSMutableDictionary *projectsDictionary = [[NSMutableDictionary alloc] initWithCapacity:5];
            
            NSString *projKey = [[requestString componentsSeparatedByString:@":"] objectAtIndex:3];
            NSArray *fetchedProjects = [self fetchProjectsBaseOnProjectKey:projKey phases:nil regions:nil projectStatuses:nil reportingMonth:_reportingMonth];
            
            if (fetchedProjects.count > 0) {
                [projectsDictionary setObject:fetchedProjects forKey:kSelectedProjects];
                [projectsDictionary setObject:[_projectDetailsDictionary objectForKey:@"kSelectedReportingMonth"]
                                       forKey:kSelectedReportingMonth];
                
            }
            
            _projectViewController.dictionaryFromPortfolio = projectsDictionary;
            [_projectViewController setEnableReports:_enableProjectReports];
            
            if ([projectsDictionary count] > 0){
                [self.navigationController pushViewController :_projectViewController animated:YES];
            }else{
                [ETGAlert sharedAlert].alertDescription = @"Project: No Data found.";
                [[ETGAlert sharedAlert] showProjectAlert];
            }
            
            if ([_requestStringForPortfolioLevel2 rangeOfString:@"ETGPortfolioLevel2"].location == NSNotFound) {
                _requestString = [[NSBundle mainBundle] pathForResource:@"ETGPortfolioLevel1" ofType:@"html" inDirectory:@"Charts"];
            } else {
                _requestString = [[NSBundle mainBundle] pathForResource:@"ETGPortfolioLevel2" ofType:@"html" inDirectory:@"Charts"];
            }
        }
    }
    
    return NO;
}

#pragma mark - ScorecardModelController

- (NSString *)getTopInformationForScorecard {
    
    [self setValueProjectDetails];
    
    NSString *projectDetailsJson = nil;
    
    if (_projectDetails) {
        NSError *error;
        NSData *data = [RKMIMETypeSerialization dataFromObject:_projectDetails MIMEType:RKMIMETypeJSON error:&error];
        projectDetailsJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return projectDetailsJson;

}

- (NSDictionary *)filterDataFromWebServiceResult:(NSSet *)mappingResult {
    
    NSArray *filteredProjectsArray = _filteredProjectsDictionaryForScorecard[kSelectedProjects];
    NSMutableArray *filteredProjectsMArray = [NSMutableArray array];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@", [mappingResult valueForKey:@"projectKey"]];
    NSArray *filteredResult = [filteredProjectsArray filteredArrayUsingPredicate:predicate];
    
    if ([filteredResult count]) {
        [filteredProjectsMArray addObjectsFromArray:filteredResult];
    }
    
    NSMutableDictionary *filteredProjects = [[NSMutableDictionary alloc]  init];
    [filteredProjects setObject:[filteredProjectsMArray mutableCopy] forKey:@"kSelectedProjects"];

    return filteredProjects;

}

- (void)appendJSONToViewController:(NSSet *)mappingResult{

//    _JSONStringForScorecard = jsonStringFromInterface;
    NSDictionary *filteredProjects = [self filterDataFromWebServiceResult:mappingResult];
    if (filteredProjects) {
        [self filterScorecardWithProjects:filteredProjects [kSelectedProjects] inReportingMonth:[_reportingMonthForScorecard toDate]];
    }
    
    if (![_JSONStringForScorecard isEqualToString:@""]) {
        [self.portfolioWebview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"displayTable('%@' ,'%@')", _JSONStringForScorecard, [self getTopInformationForScorecard]]];
        
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    }
    
    _pageNumber += 1;
    //NSLog(@"%d", _pageNumber);
    
    [[ETGScorecardModelController sharedModel] getScorecardTableSummaryForReportingMonth:_reportingMonth pageSize:kPageSize pageNumber:_pageNumber isSelectedReportingMonth:YES  filteredDictionary:_filteredProjectsDictionaryForScorecard [kSelectedProjects] success:^(NSString *jsonString) {
        
    } failure:^(NSError *error) {
        
    }];

}

- (void)appendJSONOfLastPageToViewController:(NSSet *)mappingResult{

    _pageNumber = 1;
    
    _isScorecardDownloading = NO;
    [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:_reportingMonthForScorecard moduleName:@"Scorecard"];
    
    if (_portfolioSegmentedButton.selectedSegmentIndex == 0 && (_portfolioSegmentedButton.numberOfSegments>1)) {
        _isScorecardLoaded = YES;
//        _JSONStringForScorecard = jsonStringFromInterface;
        NSDictionary *filteredProjects = [self filterDataFromWebServiceResult:mappingResult];
        [self filterScorecardWithProjects:filteredProjects [kSelectedProjects] inReportingMonth:[_reportingMonthForScorecard toDate]];
        
        if (![_JSONStringForScorecard isEqualToString:@""]) {
            [self.portfolioWebview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"displayTable('%@' ,'%@')", _JSONStringForScorecard, [self getTopInformationForScorecard]]];
            
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
        }
        
        [self setNavigationBarWithoutActivityIndicator];
        
        if (_isInitialRunOfScorecard) {
            // Send request for portfolio when download is not in progress
            if (_isPortfolioGraphDownloading == NO){
                [self loadPortfolioAfterScorecard];
            }
//            _isInitialRun = NO;
        }
    }
    
    _isInitialRunOfScorecard = NO;
    // Clear Cache of JSON for Scorecard
    _JSONStringForScorecardCache = @"";
}

- (void)appendJSONOfCurrentPageToViewController:(NSSet *)mappingResult withError:(NSError *)error {

    _pageNumber = 1;

    _isScorecardDownloading = NO;
    [_portfolioDelegate.delegate displayDataErrorMessageForPortfolio:error];
    
    if (_portfolioSegmentedButton.selectedSegmentIndex == 0 && (_portfolioSegmentedButton.numberOfSegments>1)) {
        _isScorecardLoaded = YES;

//        if (_isInitialRun) {
//            _isInitialRun = NO;
//        }
        
        [ETGAlert sharedAlert].alertShown = NO;
        ETGAlert *timeOut = [ETGAlert sharedAlert];
        timeOut.alertDescription = serverCannotBeReachedAlert;
        [timeOut showPortfolioAlert];
        _withError = NO;

        // Set the navigation bar to remove the activity indicator
        [self setNavigationBarWithoutActivityIndicator];
        
    }
    
    _isInitialRunOfScorecard = NO;
}

- (void)shouldSendRequestForScorecard {
    
    [self createUIActivityIndicator];
    
    _isScorecardDownloading = YES;
     [ETGScorecardModelController sharedModel].delegate = self;
    
    [[ETGScorecardModelController sharedModel] getScorecardTableSummaryForReportingMonth:_reportingMonthForScorecard pageSize:kPageSize pageNumber:_pageNumber isSelectedReportingMonth:YES  filteredDictionary:_filteredProjectsDictionaryForScorecard[kSelectedProjects] success:^(NSString *jsonString) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Portfolio

- (void)shouldSendRequestForPortfolio {
    
    _sendRequestCounter = 0;

    // Refreshes Portfolio variables
    [self refreshPortfolioVariables];
    id disabled = @"disabled";

    // Portfolio delegate
    [_portfolioDelegate setDelegate:self];
    
    ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
    
    [portfolioModel setTimestampAgeMoreThanOneDay:_timestamp];
    //UAC
    [portfolioModel populateEnableReportsArray:_enableReports];
    
    // TODO: Check UAC before starting download for report
    //    JSON for Portfolio Hydrocarbon
    
    _isPortfolioGraphDownloading = YES;
    
    //_app.networkActivityIndicatorVisible = YES;
    
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"First Hydrocarbon/IA Tracking"];
    BOOL isEnabled = [portfolioModel isPortfolioReportEnabledForReportName:@"First Hydrocarbon/IA Tracking"];
    if (isEnabled) {
        [portfolioModel getPortfolioHydrocarbonForReportingMonth:_reportingMonth
                                                  withProjectKey:_projectKey
                                                         success:^(NSMutableArray* jsonData) {
                                                             
                                                             ++_sendRequestCounter;
                                                             _dataForHydrocarbon = jsonData;
                                                             [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                             //_app.networkActivityIndicatorVisible = NO;
                                                             
                                                         } failure: ^(NSError * error) {
                                                             
                                                             _withError = YES;
                                                             _errorCode = error.code;
                                                             ++_sendRequestCounter;
                                                             [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                             //_app.networkActivityIndicatorVisible = NO;
                                                         }];
    } else {
        _dataForHydrocarbon = disabled;
        ++_sendRequestCounter;
        [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
        //_app.networkActivityIndicatorVisible = NO;
    }
    
    //    JSON for Portfolio Production and RTBD
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"Production and RTBD"];
    isEnabled = [portfolioModel isPortfolioReportEnabledForReportName:@"Production and RTBD"];
    if (isEnabled) {
        [portfolioModel getPortfolioProdAndRtbdForReportingMonth:_reportingMonth
                                                  withProjectKey:_projectKey
                                                         success:^(NSMutableDictionary* jsonData) {
                                                             
                                                             ++_sendRequestCounter;
                                                             _dataForProductionRtbd = jsonData;
                                                             [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                             //_app.networkActivityIndicatorVisible = NO;
                                                             
                                                         } failure: ^(NSError * error) {
                                                             
                                                             _withError = YES;
                                                             _errorCode = error.code;
                                                             ++_sendRequestCounter;
                                                             [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                             //_app.networkActivityIndicatorVisible = NO;
                                                         }];
    } else {
        _dataForProductionRtbd = disabled;
        ++_sendRequestCounter;
        [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
        //_app.networkActivityIndicatorVisible = NO;
    }

    //    JSON for Portfolio CPB
    
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"Project and Cost Performance"];
    isEnabled = [portfolioModel isPortfolioReportEnabledForReportName:@"Project and Cost Performance"];
    if (isEnabled) {
        [portfolioModel getPortfolioCpbForReportingMonth:_reportingMonth
                                          withProjectKey:_projectKey
                                                 success:^(NSMutableDictionary* jsonData) {

                                                     ++_sendRequestCounter;
                                                     _dataForCpb = jsonData;
                                                     [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                     //_app.networkActivityIndicatorVisible = NO;
                                                     
                                                 } failure: ^(NSError * error) {

                                                     _withError = YES;
                                                     _errorCode = error.code;
                                                     ++_sendRequestCounter;
                                                     [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                     //_app.networkActivityIndicatorVisible = NO;
                                                 }];
    } else {
        _dataForCpb = disabled;
        ++_sendRequestCounter;
        [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
        //_app.networkActivityIndicatorVisible = NO;
    }
    
    //JSON for Portfolio APC
    
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"Project and Cost Performance"];
    isEnabled = [portfolioModel isPortfolioReportEnabledForReportName:@"Project and Cost Performance"];
    if (isEnabled) {
        [portfolioModel getPortfolioApcForReportingMonth:_reportingMonth
                                          withProjectKey:_projectKey
                                                 success:^(NSMutableDictionary* jsonData) {

                                                     ++_sendRequestCounter;
                                                     _dataForApc = jsonData;
                                                     [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                     //_app.networkActivityIndicatorVisible = NO;
                                                 } failure: ^(NSError * error) {

                                                     _withError = YES;
                                                     _errorCode = error.code;
                                                     ++_sendRequestCounter;
                                                     [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                     //_app.networkActivityIndicatorVisible = NO;
                                                 }];
    } else {
        _dataForApc = disabled;
        ++_sendRequestCounter;
        [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
        //_app.networkActivityIndicatorVisible = NO;
    }
    
    //    JSON for Portfolio WPB
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"WPB Performance"];
    isEnabled = [portfolioModel isPortfolioReportEnabledForReportName:@"WPB Performance"];
    if (isEnabled) {
        [portfolioModel getPortfolioWpbForReportingMonth:_reportingMonth
                                          withProjectKey:_projectKey
                                                 success:^(NSMutableDictionary* jsonData) {

                                                     ++_sendRequestCounter;
                                                     _dataForWpb = jsonData;
                                                     [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                     //_app.networkActivityIndicatorVisible = NO;
                                                 } failure: ^(NSError * error) {

                                                     _withError = YES;
                                                     _errorCode = error.code;
                                                     ++_sendRequestCounter;
                                                     [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                     //_app.networkActivityIndicatorVisible = NO;
                                                 }];
    } else {
        _dataForWpb = disabled;
        ++_sendRequestCounter;
        [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
        //_app.networkActivityIndicatorVisible = NO;
    }
    
    //    JSON for Portfolio HSE
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"HSE Performance"];
    isEnabled = [portfolioModel isPortfolioReportEnabledForReportName:@"HSE Performance"];
    if (isEnabled) {
        [portfolioModel getPortfolioHseForReportingMonth:_reportingMonth
                                          withProjectKey:_projectKey
                                                 success:^(NSMutableDictionary* jsonData) {

                                                     ++_sendRequestCounter;
                                                     _dataForHse = jsonData;
                                                     [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                     //_app.networkActivityIndicatorVisible = NO;
                                                 } failure: ^(NSError * error) {

                                                     _withError = YES;
                                                     _errorCode = error.code;
                                                     ++_sendRequestCounter;
                                                     [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                     //_app.networkActivityIndicatorVisible = NO;
                                                 }];
    } else {
        _dataForHse = disabled;
        ++_sendRequestCounter;
        [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
        //_app.networkActivityIndicatorVisible = NO;
    }
    
    //    JSON for Portfolio Manpower
    //UAC
    isEnabled = [ETGJsonHelper canAccessInUac:kManpowerPortfolioPerformanceRequiredKey];
    if (isEnabled) {

        [portfolioModel getPortfolioMlhForReportingMonth:_reportingMonth
                                          withProjectKey:_projectKey
                                                 success:^(NSMutableDictionary* jsonData) {
                                                     
                                                     ++_sendRequestCounter;
                                                     _dataForMlh = jsonData;
                                                     [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                     
                                                 } failure: ^(NSError * error) {
                                                     
                                                     _withError = YES;
                                                     _errorCode = error.code;
                                                     ++_sendRequestCounter;
                                                     [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
                                                     
                                                 }];
    } else {
        _dataForMlh = disabled;
        ++_sendRequestCounter;
        [_portfolioDelegate.delegate collectAllJsonDataFromWebServiceForPortfolio];
    }
    
}

- (void)shouldGetRequestForPortfolioHydrocarbon:(NSSet *)cachedData
                                        success:(void (^)(NSMutableArray *))success
                                        failure:(void (^)(NSError *))failure{
    // Portfolio delegate
    [_portfolioDelegate setDelegate:self];
    
    ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
    
    //    JSON for Portfolio Hydrocarbon
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"First Hydrocarbon/IA Tracking"];
    [portfolioModel collectPortfolioHydrocarbonForReportingMonth:cachedData
                                                         success:^(NSMutableArray* jsonData) {
                                                             success(jsonData);
                                                             
                                                         } failure: ^(NSError * error) {
                                                             failure(error);
                                                             //                                                             DDLogError(@"%@%@", logErrorPrefix, error.description);
                                                             
                                                         }];
}

- (void)shouldGetRequestForPortfolioRTBD:(NSSet *)cachedData
                                 success:(void (^)(NSMutableDictionary *))success
                                 failure:(void (^)(NSError *))failure{
    
    // Portfolio delegate
    [_portfolioDelegate setDelegate:self];
    
    ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
    
    //    JSON for Portfolio Production and RTBD
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"Production and RTBD"];
    [portfolioModel collectPortfolioProdAndRtbdForReportingMonth:cachedData
                                                         success:^(NSMutableDictionary* jsonData) {
                                                             success(jsonData);
                                                             
                                                         } failure: ^(NSError * error) {
                                                             failure(error);
                                                             //                                                             DDLogError(@"%@%@", logErrorPrefix, error.description);
                                                             
                                                         }];
}

- (void)shouldGetRequestForPortfolioCPB:(NSSet *)cachedData
                         reportingMonth:(NSString *)reportingMonth
                        withTableReport:(BOOL)yesNo
                                success:(void (^)(NSMutableDictionary *))success
                                failure:(void (^)(NSError *))failure{
    
    // Portfolio delegate
    [_portfolioDelegate setDelegate:self];
    
    ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
    
    //    JSON for Portfolio CPB
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"Project and Cost Performance"];
    [portfolioModel collectPortfolioCpbForReportingMonth:cachedData
                                          reportingMonth:reportingMonth
                                         withTableReport:yesNo
                                                 success:^(NSMutableDictionary* jsonData) {
                                                     success(jsonData);
                                                 } failure: ^(NSError * error) {
                                                     failure(error);
                                                     //                                                     DDLogError(@"%@%@", logErrorPrefix, error.description);
                                                 }];
}

- (void)shouldGetRequestForPortfolioAPC:(NSSet *)cachedData
                        withTableReport:(BOOL)yesNo
                                success:(void (^)(NSMutableDictionary *))success
                                failure:(void (^)(NSError *))failure{

    // Portfolio delegate
    [_portfolioDelegate setDelegate:self];
    
    ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
    
    //    JSON for Portfolio APC
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"Project and Cost Performance"];
    [portfolioModel collectPortfolioApcForReportingMonth:cachedData
                                         withTableReport:yesNo
                                                 success:^(NSMutableDictionary* jsonData) {
                                                     success(jsonData);
                                                 } failure: ^(NSError * error) {
                                                     failure(error);
                                                     //                                                     DDLogError(@"%@%@", logErrorPrefix, error.description);
                                                     
                                                 }];

}

- (void)shouldGetRequestForPortfolioWPB:(NSSet *)cachedData
                         reportingMonth:(NSString *)reportingMonth
                        withTableReport:(BOOL)yesNo
                                success:(void (^)(NSMutableDictionary *))success
                                failure:(void (^)(NSError *))failure{
    
    // Portfolio delegate
    [_portfolioDelegate setDelegate:self];
    
    ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
    
    //    JSON for Portfolio WPB
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"WPB Performance"];
    [portfolioModel collectPortfolioWpbForReportingMonth:cachedData
                                          reportingMonth:reportingMonth
                                         withTableReport:yesNo
                                                 success:^(NSMutableDictionary* jsonData) {
                                                     success(jsonData);
                                                 } failure: ^(NSError * error) {
                                                     failure(error);
                                                     //                                                     DDLogError(@"%@%@", logErrorPrefix, error.description);
                                                 }];
}

- (void)shouldGetRequestForPortfolioHSE:(NSSet *)cachedData
                                success:(void (^)(NSMutableDictionary *))success
                                failure:(void (^)(NSError *))failure{
    
    // Portfolio delegate
    [_portfolioDelegate setDelegate:self];
    
    ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
    
    //    JSON for Portfolio HSE
    //UAC
    //[portfolioModel getPortfolioReportNameForReport:@"HSE Performance"];
    [portfolioModel collectPortfolioHseForReportingMonth:cachedData
                                                 success:^(NSMutableDictionary* jsonData) {
                                                     success(jsonData);
                                                 } failure: ^(NSError * error) {
                                                     failure(error);
                                                     //                                                     DDLogError(@"%@%@", logErrorPrefix, error.description);
                                                     
                                                 }];
}

- (void)shouldGetRequestForPortfolioMLH:(NSSet *)cachedData
                         reportingMonth:(NSString *)reportingMonth
                                success:(void (^)(NSMutableDictionary *))success
                                failure:(void (^)(NSError *))failure{
    
    // Portfolio delegate
    [_portfolioDelegate setDelegate:self];
    
    ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
    
    //    JSON for Portfolio HSE
    //UAC
    //    [portfolioModel getPortfolioReportNameForReport:@"HSE Performance"];
    [portfolioModel collectPortfolioMlhForReportingMonth:cachedData reportingMonth:reportingMonth
                                                 success:^(NSMutableDictionary* jsonData) {
                                                     success(jsonData);
                                                 } failure: ^(NSError * error) {
                                                     failure(error);
                                                     //                                                     DDLogError(@"%@%@", logErrorPrefix, error.description);
                                                     
                                                 }];
}
//
#pragma mark - Portfolio Delegate
// Collects all Portfolio Data - Online
- (void)collectAllJsonDataFromWebServiceForPortfolio {

//    if (_sendRequestCounter >= 6 && _isBaseFilterDownloadCompleted) {
    if (_sendRequestCounter >= 7) {

        // Save TimeStamp
        if (_timestamp){
            [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:_reportingMonth moduleName:@"Portfolio"];
            _timestamp = NO;
        }

        _isPortfolioGraphDownloading = NO;
        [self getPortfolioReportDataForProjects:_filteredProjectsDictionary];
        
        if (_portfolioSegmentedButton.selectedSegmentIndex == 1 || (_portfolioSegmentedButton.numberOfSegments == 1)) {
            if (_withError) {
                [self setNavigationBarWithoutActivityIndicator];
                
                [ETGAlert sharedAlert].alertShown = NO;
                ETGAlert *timeOut = [ETGAlert sharedAlert];
                timeOut.alertDescription = serverCannotBeReachedAlert;
                [timeOut showPortfolioAlert];
                _withError = NO;
            }
            DDLogWarn(@"%@%@",logWarnPrefix,serverCannotBeReachedWarn);
        }
    }
}

// Collects all Portfolio Data - Offline
- (void)collectAllJsonDataFromCoreDataForPortfolio {
    
    // Collects all Portfolio data
    _dataForPortfolio = [NSMutableDictionary dictionaryWithDictionary:@{@"hydro":_dataForHydrocarbon,
                                                                        @"rtbd":_dataForProductionRtbd,
                                                                        @"cpb":_dataForCpb,
                                                                        @"apc":_dataForApc,
                                                                        @"hse":_dataForHse,
                                                                        @"wpb":_dataForWpb,
                                                                        @"projectDetails":[[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateWithNSString:_projectDetails],
                                                                        @"mps" : _dataForMlh}];
    
    // Converts CoreData to Json
    NSError *error;
    NSData *data = [RKMIMETypeSerialization dataFromObject:_dataForPortfolio MIMEType:RKMIMETypeJSON error:&error];
    _JSONStringForPortfolio = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%d", _fetchRequestCounter);
    // Checks if all fetch requests have been completed
    
    if (_fetchRequestCounter >= 6) {
        if (_portfolioSegmentedButton.selectedSegmentIndex == 1  || (_portfolioSegmentedButton.numberOfSegments == 1)) {
            [self webViewDidFinishLoad:_portfolioWebview];
            // Set the navigation bar to remove the activity indicator
            [self setNavigationBarWithoutActivityIndicator];
        }
    }
}

- (void)displayDataErrorMessageForScorecard:(NSError *)error {
    
    [ETGAlert sharedAlert].alertShown = NO;
    [ETGAlert sharedAlert].alertDescription = [NSString stringWithFormat:scoreCardAlert, error];
    [[ETGAlert sharedAlert] showScorecardAlert];
}

- (void)displayDataErrorMessageForPortfolio:(NSError *)error {
    _withError = YES;
}

#pragma mark - Portfolio Initialization
// Refreshes Portfolio variables
- (void)refreshPortfolioVariables {
    
    // Sets project details
    /*_projectDetails = [NSMutableDictionary dictionaryWithDictionary:@{@"reportingPeriod":_reportingMonth,
     @"operatorship": @"operatorship",
     @"phase": @"phase",
     @"update":@"14 Nov 2013"}];*/
    [self setValueProjectDetails];

    // Sets Portfolio temporary data storage
    id noData = @"no data";
    _dataForHydrocarbon = noData;
    _dataForProductionRtbd = noData;
    _dataForCpb = noData;
    _dataForApc = noData;
    _dataForHse = noData;
    _dataForWpb = noData;
    _dataForMlh = noData;
    
    // Refreshes Porfolio Json string storage
    _JSONStringForPortfolio = @"";
    
}

#pragma mark - Navigation Bar and Activity Indicator
- (void)createUIActivityIndicator {
    
    _activityIndicator =
    [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 30, 50, 50)];
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


#pragma mark - Actions

- (IBAction)tapUpdateBarButtonItem:(id)sender {

    // Set the navigation bar
    [self setNavigationBarWithActivityIndicator];

    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    
//    if (_appDelegate.isNetworkServerAvailable == YES) {

        // Hide filter view if currently visible
        if (_filtersPopoverController) {
            [_filtersPopoverController dismissPopoverAnimated:YES];
            _filtersPopoverController = nil;
        }

        _isUpdateButton = YES;
        [ETGAlert sharedAlert].alertShown = NO;
        //_isBaseFilterDownloadCompleted = NO;

        if (_portfolioSegmentedButton.selectedSegmentIndex == 0  && (_portfolioSegmentedButton.numberOfSegments>1)) {
            _JSONStringForScorecard = @"";
            [self.portfolioWebview reload];
        }

        [[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonth];

//        if (_portfolioSegmentedButton.selectedSegmentIndex == 1) {
//            [[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonth];
//            
//            ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
//            [portfolioModel deletePortfolioTableSummaryForReportingMonth:_reportingMonth
//                                                              withUserId:_projectKey
//                                                                 success:^(bool removed) {
//                                                                     [self shouldSendRequestForPortfolio];
//                                                                     
//                                                                 } failure:^(NSError *error) {
//                                                                     
//                                                                 }];
//            
//        } else {
//            [[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonthForScorecard];
//        }
//
//    } else {
//
//        _isApplyButton = NO;
//
//        [ETGAlert sharedAlert].alertShown = NO;
//        ETGAlert *timeOut = [ETGAlert sharedAlert];
//        timeOut.alertDescription = serverCannotBeReachedAlert;
//        [timeOut showPortfolioAlert];
//        
//        [self setNavigationBarWithoutActivityIndicator];
//
//        DDLogWarn(@"%@%@",logWarnPrefix,serverCannotBeReachedWarn);
//    }
    
    _wasToggled = NO;
    _JSONStringForScorecardCache = @"";
}

- (IBAction)toggleWebview:(UISegmentedControl *)sender {
    
    _wasToggled = YES;
    [self setNavigationBarWithActivityIndicator];
    _isInitialRunOfScorecard = NO;

    switch ([sender selectedSegmentIndex]) {
        case 0:
            
            _JSONStringForScorecard = nil;

            if (_isScorecardDownloading == YES) {
                [[ETGPortfolioModelController sharedModel] setQueuepriorityForScorecard:_reportingMonthForScorecard];
            } else {
                
                if (!_isInitialRun) {

                    if (![_reportingMonthForScorecard isEqualToString:_reportingMonth]) {
                        if (![_reportingMonthForScorecard isEqualToString:_reportingMonth]) {
                            _projectDetailsDictionaryForScorecard = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionary];
                            _filteredProjectsDictionaryForScorecard = _filteredProjectsDictionary;
                            _reportingMonthForScorecard = [[_filteredProjectsDictionaryForScorecard valueForKey:@"kSelectedReportingMonth"] toReportingMonthDateString];
                        }
                    }
                    
                    _timestampScorecard = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:@"Scorecard" reportingMonth:_reportingMonthForScorecard];
                    if (_timestampScorecard == YES) {
                        _appDelegate = [[UIApplication sharedApplication] delegate];
                        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
                        [ETGNetworkConnection checkAvailability];
                        if (_appDelegate.isNetworkServerAvailable == YES) {
                            [self shouldSendRequestForScorecard];
                        } else {
                            [self filterScorecardWithProjects:_filteredProjectsDictionaryForScorecard [kSelectedProjects] inReportingMonth:[_reportingMonthForScorecard toDate]];
                            [self setNavigationBarWithoutActivityIndicator];
                        }
                    } else {
                        [self filterScorecardWithProjects:_filteredProjectsDictionaryForScorecard [kSelectedProjects] inReportingMonth:[_reportingMonthForScorecard toDate]];
                        [self setNavigationBarWithoutActivityIndicator];
                    }
                }
            }
            
            _htmlPage = @"ETGPortfolioScorecard";
            _isPortfolioLoaded = NO;
            
            [self loadContentWebview];
            
            break;
        case 1:
            if (_isPortfolioGraphDownloading == YES){
                [[ETGPortfolioModelController sharedModel] setQueuepriorityForPortfolioGraph:_reportingMonth];
            }else{
                
                if (_isScorecardDownloading == YES) {
                    [[ETGPortfolioModelController sharedModel] setQueuepriorityForPortfolioGraph:_reportingMonth];
                }
                
                if (!_isInitialRun) {

                    if (![_reportingMonthForScorecard isEqualToString:_reportingMonth]) {
                        _projectDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:_filteredProjectsDictionaryForScorecard];
                        _filteredProjectsDictionary = _filteredProjectsDictionaryForScorecard;
                        _reportingMonth = [[_filteredProjectsDictionary valueForKey:@"kSelectedReportingMonth"] toReportingMonthDateString];
                    }

                        [self loadPortfolioAfterScorecard];
                }
            }
            
            _htmlPage = @"ETGPortfolioLevel1";
            _isPortfolioLoaded = YES;
            _isScorecardLoaded = NO;
            
            
            [self loadContentWebview];
            
            break;
        default:
            break;
    }
}


#pragma mark - Filters

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showFilter"]) {
        ETGFiltersViewController *filtersViewController = (ETGFiltersViewController *)[(UINavigationController *)segue.destinationViewController topViewController];
        [filtersViewController setDelegate:self];
        [filtersViewController setSelectedRowsInFilter:_selectedRowsInFilter];
        [filtersViewController setModuleName:@"portfolio"];

        UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
        _filtersPopoverController = popoverController;
        [popoverController setDelegate:self];
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


#pragma mark - Filters data


- (void) getLastTopInformation {
    
    NSMutableDictionary *operatorDictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *phaseDictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *projectDetails = [NSMutableDictionary dictionary];

    if (self.portfolioSegmentedButton.selectedSegmentIndex == 0) {
        projectDetails = _projectDetailsDictionaryForScorecard;
    } else {
        projectDetails = _projectDetailsDictionary;
    }
    
    operatorDictionary = [projectDetails valueForKey:@"kSelectedOperatorship"];
    phaseDictionary = [projectDetails valueForKey:@"kSelectedPhase"];

    if (![operatorDictionary isKindOfClass:[NSString class]]){
        _operatorshipValue = [operatorDictionary valueForKeyPath:@"name"];
    } else {
        _operatorshipValue = [projectDetails valueForKey:@"kSelectedOperatorship"];
    }
    
    if (![phaseDictionary isKindOfClass:[NSString class]]){
        _phaseValue = [phaseDictionary valueForKeyPath:@"name"];
    } else {
        _phaseValue = [projectDetails valueForKey:kSelectedPhase];
    }

    //    NSDate *currentDate = [NSDate date];
    //    _updateValue = [currentDate toChartDateString];
    
    if (_portfolioSegmentedButton.selectedSegmentIndex == 0 && (_portfolioSegmentedButton.numberOfSegments>1)) {
        _updateValue = [[[ETGCoreDataUtilities sharedCoreDataUtilities] retrieveTimeStampForModule:@"Scorecard" withReportingMonth:_reportingMonthForScorecard] toChartDateString];
    } else {
        _updateValue = [[[ETGCoreDataUtilities sharedCoreDataUtilities] retrieveTimeStampForModule:@"Portfolio" withReportingMonth:_reportingMonthForScorecard] toChartDateString];
    }
    
    if (!_updateValue) {
        _updateValue = [[NSDate date] toChartDateString];
    }
}

- (void) setValueProjectDetails {
    
    [self getLastTopInformation];
    
    NSString *reportMonth;
    
    if (self.portfolioSegmentedButton.selectedSegmentIndex == 0) {
        reportMonth = _reportingMonthForScorecard;
    } else {
        reportMonth = _reportingMonth;
    }

    if (reportMonth != nil && _operatorshipValue != nil && _phaseValue !=  nil && _updateValue != nil) {
        
        _projectDetails = [NSMutableDictionary dictionaryWithDictionary:@{@"reportingPeriod":reportMonth,
                                                                          @"operatorship": _operatorshipValue,
                                                                          @"phase": _phaseValue,
                                                                          @"update":_updateValue}];
    } else {
        // Set default values if there is no project details
        _projectDetails = [NSMutableDictionary dictionaryWithDictionary:@{/*@"reportingPeriod":_reportingMonth,*/
                                                                          @"operatorship": @"",
                                                                          @"phase": @"",
                                                                          @"update":@""}];
    }
    
    if (_projectDetails) {
        if (_enableProjectReports) {
            [_projectDetails setValue:@"yes" forKey:@"isProjectEnabled"];
            
        }else{
            [_projectDetails setValue:@"no" forKey:@"isProjectEnabled"];
        }
    }
}



#pragma mark - FiltersDelegate

- (void)filtersViewControllerDidCancel {
    [_filtersPopoverController dismissPopoverAnimated:NO];
    _filtersPopoverController = nil;
}

- (void)filtersViewControllerDidFinishWithProjectsDictionary:(NSDictionary *)filteredProjectsDictionary {
    
    [self setNavigationBarWithActivityIndicator];

    [_filtersPopoverController dismissPopoverAnimated:YES];
    _filtersPopoverController = nil;
    
    if (_portfolioSegmentedButton.selectedSegmentIndex == 0 && (_portfolioSegmentedButton.numberOfSegments>1)) {
        //Scorecard
        
        _JSONStringForScorecard = @"";
        [self.portfolioWebview reload];
        
        _projectDetailsDictionaryForScorecard = [NSMutableDictionary dictionaryWithDictionary:filteredProjectsDictionary];
        _filteredProjectsDictionaryForScorecard = filteredProjectsDictionary;
        _reportingMonthForScorecard = [[_filteredProjectsDictionaryForScorecard valueForKey:@"kSelectedReportingMonth"] toReportingMonthDateString];
        
        _timestampScorecard = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:@"Scorecard" reportingMonth:_reportingMonthForScorecard];
        
        if (!_isPortfolioGraphDownloading) {
            if (![_reportingMonthForScorecard isEqualToString:_reportingMonth]) {
                _projectDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:filteredProjectsDictionary];
                _filteredProjectsDictionary = filteredProjectsDictionary;
                _reportingMonth = [[_filteredProjectsDictionary valueForKey:@"kSelectedReportingMonth"] toReportingMonthDateString];
            }
        }
        
        if (_timestampScorecard == YES) {
            
            // Check server availability
            _appDelegate = [[UIApplication sharedApplication] delegate];
            [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
            [ETGNetworkConnection checkAvailability];
            
            if (_appDelegate.isNetworkServerAvailable == YES) {
//                _isApplyButton = YES;

//                [[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonthForScorecard];
                [self shouldSendRequestForScorecard];
            } else {
                [self filterScorecardWithProjects:_filteredProjectsDictionaryForScorecard [kSelectedProjects] inReportingMonth:[_reportingMonthForScorecard toDate]];
                [self setNavigationBarWithoutActivityIndicator];
            }
        } else {
            [self filterScorecardWithProjects:_filteredProjectsDictionaryForScorecard [kSelectedProjects] inReportingMonth:[_reportingMonthForScorecard toDate]];
            [self setNavigationBarWithoutActivityIndicator];
        }

    } else {
        //Portfolio

        _projectDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:filteredProjectsDictionary];
        _filteredProjectsDictionary = filteredProjectsDictionary;
        _reportingMonth = [[_filteredProjectsDictionary valueForKey:@"kSelectedReportingMonth"] toReportingMonthDateString];

        //TODO: Verify date conversion
        _timestamp = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampMoreThanOneDayForModule:@"Portfolio" reportingMonth:_reportingMonth];
        
        if (!_isScorecardDownloading) {
            if (![_reportingMonthForScorecard isEqualToString:_reportingMonth]) {
                if (![_reportingMonthForScorecard isEqualToString:_reportingMonth]) {
                    _projectDetailsDictionaryForScorecard = [NSMutableDictionary dictionaryWithDictionary:filteredProjectsDictionary];
                    _filteredProjectsDictionaryForScorecard = filteredProjectsDictionary;
                    _reportingMonthForScorecard = [[_filteredProjectsDictionaryForScorecard valueForKey:@"kSelectedReportingMonth"] toReportingMonthDateString];
                }
            }
        }

//        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
//        [ETGNetworkConnection checkAvailability];
        
        [self loadPortfolioAfterScorecard];
        
////        if (_timestamp == YES && _appDelegate.isNetworkServerAvailable == YES) {
//        if (_appDelegate.isNetworkServerAvailable == YES) {
//            _isApplyButton = YES;
//            //_isBaseFilterDownloadCompleted = NO;
//            
//            [[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:_reportingMonth];
//           
////            // Check server availability
////            _appDelegate = [[UIApplication sharedApplication] delegate];
////            [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
////            [ETGNetworkConnection checkAvailability];
////            
////            if (_appDelegate.isNetworkServerAvailable == YES) {
////                ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
////                [portfolioModel deletePortfolioTableSummaryForReportingMonth:_reportingMonth
////                                                                  withUserId:_projectKey
////                                                                     success:^(bool removed) {
////                                                                         [self shouldSendRequestForPortfolio];
////                                                                     } failure:^(NSError *error) {
////                                                                         
////                                                                     }];
////            } else {
////                //Offline Mode
////                [self getPortfolioReportDataForProjects:_filteredProjectsDictionary];
////            }
//        } else {
//            // [self shouldFetchOfflineDataForScorecard];
//            [self getPortfolioReportDataForProjects:_filteredProjectsDictionary];
//        }
    }
}

- (void)filtersviewControllerDidDismiss:(NSArray *)selectedRowsInFilter {
    _selectedRowsInFilter = selectedRowsInFilter;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    _filtersPopoverController = nil;
}


- (void)filterScorecardWithProjects:(NSArray *)selectedProjects inReportingMonth:(NSDate *)reportingMonth
{
    NSMutableArray *filteredScorecard = [[NSMutableArray alloc] init];
    
    for (ETGProject *project in selectedProjects) {
        for (ETGScorecard *scorecard in project.scorecards) {
            if ([scorecard.reportMonth isEqualToDate:reportingMonth]) {
                [filteredScorecard addObject:scorecard];
                break;
            }
        }
    }
    
    //Generate JSON to pass to html
    if ([filteredScorecard count] > 0) {
        NSMutableArray *scorecardJSONArray = [[NSMutableArray alloc] initWithCapacity:[filteredScorecard count]];
        for (ETGScorecard *scorecard in filteredScorecard)
        {
            NSDictionary *scorecardDict = @{@"hse":scorecard.hse != nil ? scorecard.hse : @"",
                                            @"costPMU":scorecard.costPmu != nil ? scorecard.costPmu : @"",
                                            @"production":scorecard.production != nil ? scorecard.production : @"",
                                            @"projectName":scorecard.project.name != nil ? scorecard.project.name : @"",
                                            @"region":scorecard.project.region.name != nil ? scorecard.project.region.name : @"",
                                            @"costPCSB":scorecard.costPcsb != nil ? scorecard.costPcsb : @"",
                                            @"projectKey":scorecard.project.key != nil ? scorecard.project.key : @"",
                                            @"schedule":scorecard.schedule != nil ? scorecard.schedule : @"",
                                            @"manpower":scorecard.manningHeadCount != nil ? scorecard.manningHeadCount : @""};
            
            [scorecardJSONArray addObject:scorecardDict];
        }
        
        NSData *jsonData = [RKMIMETypeSerialization dataFromObject:scorecardJSONArray MIMEType:RKMIMETypeJSON error:nil];
        _JSONStringForScorecard = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

//        [self.portfolioWebview reload];
        
    } else {
        _JSONStringForScorecard = @"";
//        [self.portfolioWebview reload];
    }
    //Cache the JSON for Scorecard
    if ([_JSONStringForScorecard length] > 0){
        NSString *removeFirst = [_JSONStringForScorecard substringFromIndex:1];
        NSString *removeLast = [removeFirst substringToIndex:[removeFirst length]-1];
        if ([_JSONStringForScorecardCache length] == 0){
            _JSONStringForScorecardCache = _JSONStringForScorecard;
        } else {
            NSString *removeFirstCache = [_JSONStringForScorecardCache substringFromIndex:1];
            NSString *removeLastCache = [removeFirstCache substringToIndex:[removeFirstCache length]-1];
            _JSONStringForScorecardCache = [NSString stringWithFormat:@"%@%@,%@%@", @"[",removeLastCache,removeLast,@"]" ];
        }
    }
}

- (void)getPortfolioReportDataForProjects:(NSDictionary *)projectDictionary {
    
    NSSet *apc = [[NSMutableSet alloc] init];
    NSSet *cpb = [[NSMutableSet alloc] init];
    NSSet *hse = [[NSMutableSet alloc] init];
    NSSet *hydro = [[NSMutableSet alloc] init];
    NSSet *rtbd = [[NSMutableSet alloc] init];
    NSSet *wpb = [[NSMutableSet alloc] init];
    NSSet *mlh = [[NSMutableSet alloc] init];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];

       /* DDLogInfo(@"Reporting Month: %@\n\
                  Operatorship: %@\n\
                  Phase: %@\n\
                  Budget Holder: %@", projectDictionary[kSelectedReportingMonth], projectDictionary[kSelectedOperatorship],
                  projectDictionary[kSelectedPhase], [(ETGCostAllocation *)projectDictionary[kSelectedBudgetHolder] name]);*/
            
        for (ETGProject *project in projectDictionary[kSelectedProjects]) {
            //DDLogInfo(@"Project: %@", project.name);
            for (ETGPortfolio *portfolio in project.portfolios) {
                //TODO: Verify date conversion
                //NSDate *reportingMonth = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",portfolio.reportingMonth.name]];
                NSDate *reportingMonth = portfolio.reportingMonth.name;
                if (reportingMonth) {
                    if ([CommonMethods isMonthOfDate:reportingMonth equalToDate:projectDictionary[kSelectedReportingMonth]]) {
                        //TODO: Verify date conversion
                        //NSLog(@"PortfolioKey: %@ name: %@", portfolio.projectKey, portfolio.reportMonth); _reportingMonth = portfolio.reportMonth;
                        //NSLog(@"PortfolioKey: %@ name: %@", portfolio.projectKey, portfolio.reportMonth);
//                        _reportingMonth = [portfolio.reportMonth toReportingMonthDateString];
                        // Collect JSON per Report
                        apc = [apc setByAddingObjectsFromSet:portfolio.etgApcPortfolios];
                        
                        for (ETGCpb *cpbData in portfolio.etgCpbPortfolios) {
                            if ([projectDictionary valueForKey:@"kSelectedBudgetHolder"]) {
                                if ([cpbData.costAllocation isEqual:[projectDictionary valueForKey:@"kSelectedBudgetHolder"]]) {
                                    cpb = [cpb setByAddingObject:cpbData];
                                }
                            } else {
                                cpb = [cpb setByAddingObjectsFromSet:portfolio.etgCpbPortfolios];
                            }
                        }
                        
                        hse = [hse setByAddingObjectsFromSet:portfolio.etgHsePortfolios];
                        hydro = [hydro setByAddingObjectsFromSet:portfolio.etgHydrocarbonPortfolios];
                        rtbd = [rtbd setByAddingObjectsFromSet:portfolio.etgProductionRtbdPortfolios];
                        wpb = [wpb setByAddingObjectsFromSet:portfolio.etgWpbPortfolios];
                        mlh = [mlh setByAddingObjectsFromSet:portfolio.etgMLPortfolios];

                        break;
                    }
                }
            }
        }

    [self refreshPortfolioVariables];
    _fetchRequestCounter = 0;
    
    // Preaparation only for UAC, replace UAC checking when ready
    [[ETGPortfolioModelController sharedModel] populateEnableReportsArray:_enableReports];
    
    NSString *reportName = @"First Hydrocarbon/IA Tracking";
    BOOL isReportEnabled = [[ETGPortfolioModelController sharedModel] isPortfolioReportEnabledForReportName:reportName];
    BOOL isTableEnabled;
    id disabled = @"disabled";
    
    if (isReportEnabled){
        
        [self shouldGetRequestForPortfolioHydrocarbon:hydro success:^(NSMutableArray* jsonData) {
            ++_fetchRequestCounter;
            _dataForHydrocarbon = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceMutableArrayNSDateWithNSString:jsonData];
            // Combine collected JSON
            [self collectAllJsonDataFromCoreDataForPortfolio];
        } failure: ^(NSError * error) {
            ++_fetchRequestCounter;
            [self collectAllJsonDataFromCoreDataForPortfolio];
            DDLogError(@"%@%@", logErrorPrefix, error.description);

        }];
    } else {
        _dataForHydrocarbon = disabled;
        ++_fetchRequestCounter;
        [self collectAllJsonDataFromCoreDataForPortfolio];
        //DDLogInfo(@"%@%@", logInfoPrefix, @"Report Disabled");
    }

    reportName = @"Production and RTBD";
    isReportEnabled = [[ETGPortfolioModelController sharedModel] isPortfolioReportEnabledForReportName:reportName];
    
    if (isReportEnabled){
        
        [self shouldGetRequestForPortfolioRTBD:rtbd success:^(NSMutableDictionary *jsonData) {
            ++_fetchRequestCounter;
            _dataForProductionRtbd = jsonData;
            [self collectAllJsonDataFromCoreDataForPortfolio];
        }failure:^(NSError * error){
            ++_fetchRequestCounter;
            [self collectAllJsonDataFromCoreDataForPortfolio];
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        }];
    } else {
        _dataForProductionRtbd = disabled;
        ++_fetchRequestCounter;
        [self collectAllJsonDataFromCoreDataForPortfolio];
        //DDLogInfo(@"%@%@", logInfoPrefix, @"Report Disabled");
    }
    
    reportName = @"Project and Cost Performance";
    isReportEnabled = [[ETGPortfolioModelController sharedModel] isPortfolioReportEnabledForReportName:reportName];
    
    if (isReportEnabled){
        
        isTableEnabled = [[ETGPortfolioModelController sharedModel] isPortfolioTableReportEnabledForReportName:reportName];

        [self shouldGetRequestForPortfolioCPB:cpb reportingMonth:_reportingMonth withTableReport:isTableEnabled success:^(NSMutableDictionary *jsonData) {
            ++_fetchRequestCounter;
            _dataForCpb = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateJSONByKeyValue:jsonData forKey:@"reportingdate"];
            [self collectAllJsonDataFromCoreDataForPortfolio];
        }failure:^(NSError * error){
            ++_fetchRequestCounter;
            [self collectAllJsonDataFromCoreDataForPortfolio];
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        }];
    } else {
        _dataForCpb = disabled;
        ++_fetchRequestCounter;
        [self collectAllJsonDataFromCoreDataForPortfolio];
        //DDLogInfo(@"%@%@", logInfoPrefix, @"Report Disabled");
    }
    
    reportName = @"Project and Cost Performance";
    isReportEnabled = [[ETGPortfolioModelController sharedModel] isPortfolioReportEnabledForReportName:reportName];
    
    if (isReportEnabled){
        
        isTableEnabled = [[ETGPortfolioModelController sharedModel] isPortfolioTableReportEnabledForReportName:reportName];
        
        [self shouldGetRequestForPortfolioAPC:apc withTableReport:isTableEnabled success:^(NSMutableDictionary *jsonData) {
            ++_fetchRequestCounter;
            _dataForApc = jsonData;
            [self collectAllJsonDataFromCoreDataForPortfolio];
        }failure:^(NSError * error){
            ++_fetchRequestCounter;
            [self collectAllJsonDataFromCoreDataForPortfolio];
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        }];
    } else {
        _dataForApc = disabled;
        ++_fetchRequestCounter;
        [self collectAllJsonDataFromCoreDataForPortfolio];
        //DDLogInfo(@"%@%@", logInfoPrefix, @"Report Disabled");
    }
    
    reportName = @"WPB Performance";
    isReportEnabled = [[ETGPortfolioModelController sharedModel] isPortfolioReportEnabledForReportName:reportName];
    
    if (isReportEnabled){
        
        isTableEnabled = [[ETGPortfolioModelController sharedModel] isPortfolioTableReportEnabledForReportName:reportName];
        
        [self shouldGetRequestForPortfolioWPB:wpb reportingMonth:_reportingMonth withTableReport:isTableEnabled success:^(NSMutableDictionary *jsonData) {
            ++_fetchRequestCounter;
            _dataForWpb = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateJSONByKeyValue:jsonData forKey:@"reportingdate"];
            [self collectAllJsonDataFromCoreDataForPortfolio];
        }failure:^(NSError * error){
            ++_fetchRequestCounter;
            [self collectAllJsonDataFromCoreDataForPortfolio];
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        }];
    } else {
        _dataForWpb = disabled;
        ++_fetchRequestCounter;
        [self collectAllJsonDataFromCoreDataForPortfolio];
        //DDLogInfo(@"%@%@", logInfoPrefix, @"Report Disabled");
    }

    reportName = @"HSE Performance";
    isReportEnabled = [[ETGPortfolioModelController sharedModel] isPortfolioReportEnabledForReportName:reportName];
    
    if (isReportEnabled){
        
        [self shouldGetRequestForPortfolioHSE:hse success:^(NSMutableDictionary *jsonData) {
            ++_fetchRequestCounter;
            _dataForHse = jsonData;
            [self collectAllJsonDataFromCoreDataForPortfolio];
        }failure:^(NSError * error){
            ++_fetchRequestCounter;
            [self collectAllJsonDataFromCoreDataForPortfolio];
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        }];
    } else {
        _dataForHse = disabled;
        ++_fetchRequestCounter;
        [self collectAllJsonDataFromCoreDataForPortfolio];
        //DDLogInfo(@"%@%@", logInfoPrefix, @"Report Disabled");
    }

//    reportName = @"Portfolio Performance - Manpower Loading Histogram";
//    isReportEnabled = [[ETGPortfolioModelController sharedModel] isPortfolioReportEnabledForReportName:reportName];

    isReportEnabled = [ETGJsonHelper canAccessInUac:kManpowerPortfolioPerformanceRequiredKey];

    if (isReportEnabled){
        
        [self shouldGetRequestForPortfolioMLH:mlh reportingMonth:_reportingMonth success:^(NSMutableDictionary *jsonData) {
            ++_fetchRequestCounter;
            _dataForMlh = jsonData;
            [self collectAllJsonDataFromCoreDataForPortfolio];
        }failure:^(NSError * error){
            ++_fetchRequestCounter;
            [self collectAllJsonDataFromCoreDataForPortfolio];
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        }];
    } else {
        _dataForMlh = disabled;
        ++_fetchRequestCounter;
        [self collectAllJsonDataFromCoreDataForPortfolio];
        //DDLogInfo(@"%@%@", logInfoPrefix, @"Report Disabled");
    }

}


#pragma mark - Project Background

- (void)prepareProjectBackgroundView {
    // Set the navigation bar
    [self setNavigationBarWithActivityIndicator];
    
    // Get Core Data for Key Highlight
    [[ETGScorecardModelController sharedModel] getProjectBackgroundTableSummaryOfflineForReportingMonth:_reportingMonthForScorecard withProjectKey:_projectKey success:^(NSMutableArray *projectBackground) {
        
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

-(void)showProjectView {
    
    if ([_projectBackgroundValues count]) {
        ETGProjectInformationViewController *projectInfoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"projectBackground"];
        projectInfoViewController.projectBackgroundValues = _projectBackgroundValues;
        [self.navigationController pushViewController :projectInfoViewController animated:YES];
    }
}

#pragma mark - Key Highlights

- (void)prepareKeyHighlightView {
    // Set the navigation bar
    [self setNavigationBarWithActivityIndicator];
    
    // Get Web Service Data for Project Background
    
    [[ETGScorecardModelController sharedModel] getKeyHighlightsSummaryOfflineForReportingMonth:_reportingMonthForScorecard withProjectKey:_projectKey success:^(NSMutableArray *keyHighlights) {
        
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

-(void)showKeyHighlightsView {
    

    
    if ([_keyHighlightsValues count]) {
        _keyHighlightsPagerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ETGKeyHighlightPagerViewController"];

        [_keyHighlightsPagerViewController setKeyHighlightsData:_keyHighlightsValues];
        [_keyHighlightsPagerViewController setProjectName:_keyHighlightsProjectName];
        [_keyHighlightsPagerViewController setProjectStatus:_keyHighlightsProjectPhase];
        [_keyHighlightsPagerViewController reloadControllerData];
        [self.navigationController pushViewController :_keyHighlightsPagerViewController animated:YES];

    } else {
        [ETGAlert sharedAlert].alertDescription = @"Key Highlight: No Data found.";
        [[ETGAlert sharedAlert] showKeyHighlightsAlert];
    }
    
}

- (void)clearWebView
{
    // Cancel pending background downloads
    [[RKObjectManager sharedManager].operationQueue cancelAllOperations];
    _htmlPage = @"Blank";
    [self loadContentWebview];
    _shouldReloadView = YES;
    
    _selectedRowsInFilter = nil;
    _enableProjectReports = nil;
}

- (void)showMask{
    CGRect rect = CGRectMake(20, 73, 983, 605);
    UIView *maskView = [[UIView alloc] initWithFrame:rect];
    [maskView setBackgroundColor:[UIColor whiteColor]];
    maskView.tag = 997;
    [self.view addSubview:maskView];
    //NSLog(@"show Mask");
}

- (void)hideMask{
    UIView *maskView = [self.view viewWithTag:997];
    if(maskView) {
        [maskView removeFromSuperview];
    }
    //NSLog(@"hide mask");
}

@end
