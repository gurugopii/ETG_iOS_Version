//
//  ETGProjectsLessonsLearntViewController.m
//  ETG
//
//  Created by Tony Pham on 12/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGProjectsLessonsLearntViewController.h"
#import "ETGPllLessonsCountModel.h"
#import "ETGPllLessonsCount.h"
#import "ETGPllModelController.h"
#import "ETGPllReviewsModel.h"
#import "ETGPllLesson.h"
#import "ETGPllLessons.h"
#import "ETGPllLessonModel.h"
#import "ETGPllFiltersViewController.h"
#import "ETGNetworkConnection.h"
#import "ETGFilterModelController.h"
#import "ETGPllFiltersViewController.h"
#import "ETGPllSearchResult.h"
#import "ETGCoreDataUtilities.h"
#import "Reachability.h"

#define kTabNameAvoid @"avoid"
#define kTabNameReplicate @"replicate"

enum PllPage
{
    kPLLWELCOME,
    kPLLSEARCHRESULT,
    kPLLSEARCHRESULTDETAIL,
    kPLLBOOKMARK,
} PllPage;

@interface ETGProjectsLessonsLearntViewController ()<ETGFiltersViewControllerDelegate, UIPopoverControllerDelegate, ETGPllFitersViewControllerDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate>
{
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) UIButton *bookmarkButton;;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filtersBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem *bookmarkBarButtonItem;
@property (nonatomic) UIPopoverController *filtersPopoverController;
@property (nonatomic, strong) NSArray *projectSectionInfo;
@property (nonatomic, strong) NSArray *lessonLearntSectionInfo;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSString *requestString;
@property (nonatomic) BOOL isBookmark;
@property (nonatomic, strong) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) NSString *bookmarkSearchString;
@property (nonatomic, strong) NSMutableDictionary *searchInputDictionary;
@property (nonatomic, strong) ETGPllLessonsCountModel *lessonsCountModel;
@property (nonatomic, strong) ETGPllLessonModel *lessonModel;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) NSString *selectedProjectKey;
@property (nonatomic, strong) NSString *selectedPllReviewKey;
@property (nonatomic) int selectedProjectDetailKey;
@property (nonatomic) BOOL shouldAutoRefreshWhenConnectionRestored;
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic) BOOL shouldUpdateFilterErrorMessage;
@property (nonatomic) BOOL isSearching;
@property (nonatomic) BOOL isNoConnectionDuringSearching;
@property (nonatomic) BOOL isDownloadAndBookmark;
@property (nonatomic, strong) NSString *currentSelectedTab;

@end

@implementation ETGProjectsLessonsLearntViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentSelectedTab = kTabNameReplicate;
    [self configureNavigationBar:kPLLWELCOME];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilter) name:kDownloadFilterDataForPllCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterWithErrorLoadingMessage) name:kDownloadFilterDataForPllFailed object:nil];    
    _appDelegate = (ETGAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadLessonsCountData) name:@"PllLessonsCountDataUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successLoadingSearchResultsData) name:@"PllSearchResultsDataUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failedLoadingSearchResultsData) name:@"PllSearchResultsDataFailedUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadLessonDataAndLoadWebView) name:@"PllLessonDataUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failLoadingLessonData) name:@"PllLessonDataFailedUpdated" object:nil];
    
    self.navigationController.hidesBottomBarWhenPushed = NO;

    [self loadWebViewWithHtmlFileName:@"ETGPLLWelcome"];
    
    self.searchInputDictionary = [NSMutableDictionary new];
    _managedObjectContext = [NSManagedObjectContext defaultContext];
    [self setupReachability];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAutoRefreshFlagDueToNoConnection) name:kDownloadPllShouldAutoRefresh object:nil];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired = 2;
    tapGesture.delegate = self;
    [self.webView addGestureRecognizer:tapGesture];
}

-(void)successLoadingSearchResultsData
{
    self.isNoConnectionDuringSearching = NO;
    self.isSearching = NO;
    [self reloadResultsData];
}

-(void)failedLoadingSearchResultsData
{
    self.isNoConnectionDuringSearching = YES;
    self.isSearching = NO;
    [_appDelegate stopActivityIndicatorSmall];
    self.searchResults = @[];
    [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populatePLLResults(%@);", [self convertSearchResultToJson]]];
}

-(void)reloadLessonDataAndLoadWebView
{
    [self loadWebViewWithHtmlFileName:@"ETGPLLDetail"];
    if(!self.isBookmark || nil == self.lessonModel)
    {
        self.lessonModel = [ETGPllModelController sharedModel].lessonModel;
        [self updateBookmarkIfRequired];
    }
    [self reloadLessonData];
}

-(void)failLoadingLessonData
{
    [_appDelegate stopActivityIndicatorSmall];
    if(self.isDownloadAndBookmark)
    {
        return;
    }
    // Try to get from bookmark
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ETGPllLessons"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectLessonDetailKey == %d", self.selectedProjectDetailKey];
    [request setPredicate:predicate];
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:nil];
    if([results count] > 0)
    {
        self.lessonModel = [ETGPllLessonModel pllLessonFromCoreData:[results objectAtIndex:0]];
        [self loadWebViewWithHtmlFileName:@"ETGPLLDetail"];
        [self reloadLessonData];
        self.selectedProjectDetailKey = -1;
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Offline" message:serverCannotBeReachedAlert delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        self.lessonModel = nil;
    }
}

- (void)handleTap:(UIGestureRecognizer*)gestureRecognizer
{
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

-(void)reloadFilter
{
    self.shouldUpdateFilterErrorMessage = NO;
}

-(void)reloadFilterWithErrorLoadingMessage
{
    self.shouldUpdateFilterErrorMessage = YES;
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
            [self performSelector:@selector(loadInitialData) withObject:nil afterDelay:1];
            self.shouldAutoRefreshWhenConnectionRestored = NO;
        }
    }
}

-(void)updateAutoRefreshFlagDueToNoConnection
{
    self.shouldAutoRefreshWhenConnectionRestored = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.sidePanelController addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    [self loadInitialData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
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

#pragma mark - Navigation Bar and Activity Indicator
-(void)goToBookmarkView:(id)sender
{
    if (_filtersPopoverController) {
        [_filtersPopoverController dismissPopoverAnimated:YES];
        _filtersPopoverController = nil;
    }
    
    self.bookmarkSearchString = @"";
    [self configureNavigationBar:kPLLBOOKMARK];
    [self loadWebViewWithHtmlFileName:@"ETGPLLResults"];
}

-(NSString *)convertBookmarkResultToJson:(NSArray *)bookmarkResults
{
    NSString *tagetSearchString = @"";
    if(nil == self.bookmarkSearchString)
    {
        tagetSearchString = @"";
    }
    else
    {
        tagetSearchString = self.bookmarkSearchString;
    }
    NSMutableString *result = [NSMutableString stringWithFormat:@"{\"searchBarContent\":\"%@\"", tagetSearchString];
    if(self.isBookmark)
    {
        [result appendString:[NSString stringWithFormat:@",\"pageFunction\":\"%@\"", @"bookmarks"]];
    }
    else
    {
        [result appendString:[NSString stringWithFormat:@",\"pageFunction\":\"%@\"", @"search"]];
    }
    
    if([bookmarkResults count] > 0)
    {
        [result appendString:[NSString stringWithFormat:@",\"searchResults\":["]];
    }
    else
    {
        [result appendString:[NSString stringWithFormat:@",\"searchResults\":[]"]];
        [result appendString:[NSString stringWithFormat:@"}"]];
        return result;
    }
    int i = 0;
    NSMutableArray *temp = [NSMutableArray new];
    for(ETGPllLessons *lesson in bookmarkResults)
    {
        i++;
        ETGPllSearchResultModel *model = [ETGPllSearchResultModel searchResultModelFromCoreDataModel:lesson];
        [temp addObject:model];
        [result appendString:[model toJSONString]];
        if(i < [bookmarkResults count])
            [result appendString:@","];
    }
    [result appendString:@"]}"];
    self.searchResults = temp;
    return result;
}


- (void)configureNavigationBar:(int)currentPage
{
    if(nil == self.bookmarkBarButtonItem)
    {
        self.bookmarkBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(goToBookmarkView:)];
    }
    self.navigationItem.rightBarButtonItems = nil;
    switch (currentPage)
    {
        case kPLLWELCOME:
            self.lessonLearntSectionInfo = @[];
            self.projectSectionInfo = @[];
            self.isBookmark = NO;
            self.navigationItem.rightBarButtonItems = @[self.bookmarkBarButtonItem];
            break;
        case kPLLSEARCHRESULT:
            self.isBookmark = NO;
            self.navigationItem.rightBarButtonItems = @[self.filtersBarButtonItem, self.bookmarkBarButtonItem];
            break;
        case kPLLBOOKMARK:
            self.isBookmark = YES;
            break;
        case kPLLSEARCHRESULTDETAIL:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialization
-(void) loadInitialData {
    [_appDelegate startActivityIndicatorSmallGrey];
    if([[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampInUserDefaultsMoreThanNumberOfDays:30 inModuleName:@"PllBaseFilter"])
    {
        [[ETGFilterModelController sharedController] getPllBaseFilters];
    }
    
    [[ETGPllModelController sharedModel] getLessonsCountWebServiceData];
}

-(void)reloadLessonsCountData
{
    [_appDelegate stopActivityIndicatorSmall];
    self.lessonsCountModel = [ETGPllModelController sharedModel].lessonsCountModel;
    [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populatePLLWelcome(%@);", [self.lessonsCountModel getPllAllLessonCountJson]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if([self.requestString rangeOfString:@"ETGPLLWelcome"].location != NSNotFound)
    {
        [self reloadLessonsCountData];
    }
    else if([self.requestString rangeOfString:@"ETGPLLResults"].location != NSNotFound)
    {
        [self reloadResultsData];
        self.lessonModel = nil;
    }
    else if([self.requestString rangeOfString:@"ETGPLLDetail"].location != NSNotFound)
    {
        [self reloadLessonData];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    self.requestString = [[request URL] absoluteString];
    //NSLog(@"The request string is %@", self.requestString);
    if([self.requestString rangeOfString:@"ETGPLLWelcome"].location != NSNotFound)
    {
        if(self.isSearching)
        {
            return NO;
        }
        self.title = @"Search";
        [self configureNavigationBar:kPLLWELCOME];
    }
    else if([self.requestString rangeOfString:@"ETGPLLResults"].location != NSNotFound)
    {
        if(self.isBookmark)
        {
            self.title = @"Bookmarks";
            [self configureNavigationBar:kPLLBOOKMARK];
        }
        else
        {
            self.title = @"Search";
            [self configureNavigationBar:kPLLSEARCHRESULT];
        }
    }
    else if([self.requestString rangeOfString:@"ETGPLLDetail"].location != NSNotFound)
    {
        self.title = @"Detail";
        [self configureNavigationBar:kPLLSEARCHRESULTDETAIL];
    }
    
    NSString *type = [self stringBetweenString:@"type=%22" andString:@"%22&value=" inputString:self.requestString];
    NSString *value = [self stringBetweenString:@"value=%22" andString:@"%22" inputString:self.requestString];
    //NSLog(@"The type is %@", type);
    //NSLog(@"The value is %@", value);
    
    if ([_requestString rangeOfString:@"ETG?module=%22pll%22"].location != NSNotFound)
    {
        if([type isEqualToString:@"searchlesson"])
        {
            if(self.isBookmark)
            {
                self.bookmarkSearchString = value;
            }
            else
            {
                self.searchString = value;
            }
            [self.searchInputDictionary removeAllObjects];
            self.searchInputDictionary[kInputPllSearchString] = self.searchString;
            if(!self.isBookmark)
            {
                [self performSearching];
            }
            [self loadWebViewWithHtmlFileName:@"ETGPLLResults"];
        }
        else if([type isEqualToString:@"projectcount"])
        {
            // sendNotificationToIOS("pll", "projectcount", 89);
            self.lessonLearntSectionInfo = @[];
            self.projectSectionInfo = @[];
            self.searchString = @"";
            self.bookmarkSearchString = @"";
            [self.searchInputDictionary removeAllObjects];
            self.selectedProjectKey = value;
            int intValue = [value intValue];
            self.searchInputDictionary[kInputPllProjectKey] = @[@(intValue)];
            [self performSearching];
            [self loadWebViewWithHtmlFileName:@"ETGPLLResults"];
        }
        else if([type isEqualToString:@"pllreviewcount"])
        {
            // sendNotificationToIOS("pll", "pllreviewcount", 39);
            self.lessonLearntSectionInfo = @[];
            self.projectSectionInfo = @[];
            self.searchString = @"";
            self.bookmarkSearchString = @"";
            [self.searchInputDictionary removeAllObjects];
            self.selectedPllReviewKey = value;
            int intValue = [value intValue];
            self.searchInputDictionary[kInputPllReviewItemKey] = @[@(intValue)];
            [self performSearching];
            [self loadWebViewWithHtmlFileName:@"ETGPLLResults"];
        }
        else if([type isEqualToString:@"showlesson"])
        {
            // sendNotificationToIOS("pll", "showlesson", 410);
            self.selectedProjectDetailKey = [value integerValue];
            if(self.isBookmark)
            {
                NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ETGPllLessons"];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectLessonDetailKey == %d", self.selectedProjectDetailKey];
                [request setPredicate:predicate];
                NSArray *results = [self.managedObjectContext executeFetchRequest:request error:nil];
                if([results count] > 0)
                {
                    self.lessonModel = [ETGPllLessonModel pllLessonFromCoreData:[results objectAtIndex:0]];
                    [self loadWebViewWithHtmlFileName:@"ETGPLLDetail"];
                }
                else
                {
                    [_appDelegate startActivityIndicatorSmallGrey];
                    [[ETGPllModelController sharedModel] getLessonWebServiceData:self.selectedProjectDetailKey];
                }
            }
            else
            {
                [_appDelegate startActivityIndicatorSmallGrey];
                [[ETGPllModelController sharedModel] getLessonWebServiceData:self.selectedProjectDetailKey];
            }
        }
        else if([type isEqualToString:@"savelesson"])
        {
            // sendNotificationToIOS("pll", "savelesson", 410);
            int key = [value integerValue];
            if([self isBookmarkOperation:key])
            {
                if(self.lessonModel.projectLessonDetailKey == key)
                {
                    [self upsertBookmark:self.lessonModel];
                }
                else
                {
                    self.isDownloadAndBookmark = YES;
                    [self downloadAndBookmark:[value integerValue]];
                }
            }
        }
        else if([type isEqualToString:@"changetab"])
        {
            // sendNotificationToIOS("pll", "changetab", "avoid");
            self.currentSelectedTab = value;
        }
        else if([type isEqualToString:@"searchhistory"])
        {
            // sendNotificationToIOS("pll", "searchhistory", "");
            [self configureNavigationBar:kPLLSEARCHRESULT];
            [self loadWebViewWithHtmlFileName:@"ETGPLLResults"];
        }
    }
    return YES;
}

- (BOOL)isBookmarkOperation:(int)key
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ETGPllLessons"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectLessonDetailKey == %d", key];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if([results count] == 0)
    {
        return YES;
    }
    
    ETGPllLessons *lesson = results[0];
    [self.managedObjectContext deleteObject:lesson];
    [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    return NO;
}

-(NSString*)stringBetweenString:(NSString *)start andString:(NSString *)end inputString:(NSString *)inputString{
    NSRange startRange = [inputString rangeOfString:start];
    if (startRange.location != NSNotFound) {
        NSRange targetRange;
        targetRange.location = startRange.location + startRange.length;
        targetRange.length = [inputString length] - targetRange.location;
        NSRange endRange = [inputString rangeOfString:end options:0 range:targetRange];
        if (endRange.location != NSNotFound) {
            targetRange.length = endRange.location - targetRange.location;
            return [inputString substringWithRange:targetRange];
        }
    }
    return nil;
}

-(void)reloadResultsData
{
    if(self.isBookmark)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ETGPllLessons"];
        if(0 != [self.bookmarkSearchString length])
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(impactDesc contains[cd] %@) OR (lessonDesc contains[cd] %@) OR (projectName contains[cd] %@)  OR (recommendationDesc contains[cd] %@)", self.bookmarkSearchString, self.bookmarkSearchString, self.bookmarkSearchString, self.bookmarkSearchString];
            [request setPredicate:predicate];
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"projectLessonDetailKey" ascending:YES];
            [request setSortDescriptors:@[sorter]];
        }
        NSError *error;
        NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
        if(error)
        {
            DDLogError(fetchError, error);
            return;
        }
        
        [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populatePLLResults(%@);", [self convertBookmarkResultToJson:results]]];
    }
    else
    {
        [_appDelegate stopActivityIndicatorSmall];
        if(!self.isSearching)
        {
            self.searchResults = [ETGPllModelController sharedModel].searchResultsModel;
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"projectLessonDetailID" ascending:YES];
            self.searchResults = [self.searchResults sortedArrayUsingDescriptors:@[sorter]];
            [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populatePLLResults(%@);", [self convertSearchResultToJson]]];
        }
    }
}

-(NSString *)convertSearchResultToJson
{
    if(nil == self.searchString)
    {
        self.searchString = @"";
    }
    NSMutableString *result = [NSMutableString stringWithFormat:@"{\"searchBarContent\":\"%@\"", self.searchString];
    if(self.isBookmark)
    {
        [result appendString:[NSString stringWithFormat:@",\"pageFunction\":\"%@\"", @"bookmarks"]];
    }
    else
    {
        [result appendString:[NSString stringWithFormat:@",\"pageFunction\":\"%@\"", @"search"]];
    }
    
    if(self.isNoConnectionDuringSearching)
    {
        [result appendString:[NSString stringWithFormat:@",\"isNoConnection\":\"%@\"", @"Y"]];
    }
    else
    {
        [result appendString:[NSString stringWithFormat:@",\"isNoConnection\":\"%@\"", @"N"]];
    }
    
    [result appendString:[NSString stringWithFormat:@",\"activeTab\":\"%@\"", self.currentSelectedTab]];
    
    if([self.searchResults count] > 0)
    {
        [result appendString:[NSString stringWithFormat:@",\"searchResults\":["]];
    }
    else
    {
        [result appendString:[NSString stringWithFormat:@",\"searchResults\":[]}"]];
        return result;
    }
    int i = 0;
    for(ETGPllSearchResultModel *searchResultModel in self.searchResults)
    {
        i++;
        [searchResultModel updateBookmarkStatusIfRequired];
        [result appendString:[searchResultModel toJSONString]];
        if(i < [self.searchResults count])
            [result appendString:@","];
    }
    [result appendString:@"]}"];
    return result;
}

-(void)reloadLessonData
{
    [_appDelegate stopActivityIndicatorSmall];
    [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"populatePLLDetail(%@);", [self.lessonModel getJsonString]]];
}

-(void)downloadAndBookmark:(int)key
{
    [[ETGPllModelController sharedModel] getLessonWebServiceData:key success:^(ETGPllLessonModel *lesson) {
        self.isDownloadAndBookmark = NO;
        [self upsertBookmark:lesson];
    } failure:^(NSError *error) {
        self.isDownloadAndBookmark = NO;
        [self reloadResultsData];
    }];
}



-(void)upsertBookmark:(ETGPllLessonModel *)inputLessonModel
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ETGPllLessons"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectLessonDetailKey == %d", inputLessonModel.projectLessonDetailKey];
    [request setPredicate:predicate];
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:nil];
    ETGPllLessons *lesson;
    if([results count] > 0)
    {
        lesson = results[0];
    }
    else
    {
        lesson = (ETGPllLessons *)[NSEntityDescription insertNewObjectForEntityForName:@"ETGPllLessons" inManagedObjectContext:self.managedObjectContext];
    }
    lesson = [inputLessonModel updateCoreDataModel:lesson];
    [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
}

-(void)updateBookmarkIfRequired
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ETGPllLessons"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectLessonDetailKey == %d", self.lessonModel.projectLessonDetailKey];
    [request setPredicate:predicate];
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:nil];
    ETGPllLessons *lesson;
    if([results count] > 0)
    {
        lesson = results[0];
        lesson = [self.lessonModel updateCoreDataModel:lesson];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showFilter"]) {
        ETGPllFiltersViewController *filtersViewController = (ETGPllFiltersViewController *)[(UINavigationController *)segue.destinationViewController topViewController];
        filtersViewController.moduleName = @"PLL";
        [filtersViewController setDelegate:self];
        [filtersViewController setSelectedRowsInLessonLearntFilter:self.lessonLearntSectionInfo];
        [filtersViewController setSelectedRowsInProjectFilter:self.projectSectionInfo];

        filtersViewController.shouldUpdateFilterErrorMessage = self.shouldUpdateFilterErrorMessage;
        
        if(0 != [self.selectedProjectKey length])
        {
            filtersViewController.selectedProjectKey = self.selectedProjectKey;
            self.selectedProjectKey = @"";
        }
        
        if(0 != [self.selectedPllReviewKey length])
        {
            filtersViewController.selectedPllReviewKey = self.selectedPllReviewKey;
            self.selectedPllReviewKey = @"";
        }
        
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

- (void)filtersViewControllerDidCancel {
    [_filtersPopoverController dismissPopoverAnimated:NO];
    _filtersPopoverController = nil;
}

- (void)filtersViewControllerDidFinishWithProjectSectionInfo:(NSArray *)projectSectionInfo andLessonLearnSessionInfo:(NSArray *)lessonLearntSessionInfo filterViewController:(ETGPllFiltersViewController *)filterViewController
{
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    
    // Store the search input in dictionary
    [self.searchInputDictionary removeAllObjects];
    if(self.searchString != nil)
    {
        self.searchInputDictionary[kInputPllSearchString] = self.searchString;        
    }
    self.searchInputDictionary[kInputPllCountryKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:projectSectionInfo[kCOUNTRY]];
    self.searchInputDictionary[kInputPllRegionKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:projectSectionInfo[kREGION]];
    self.searchInputDictionary[kInputPllClusterKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:projectSectionInfo[kCLUSTER]];
    self.searchInputDictionary[kInputPllProjectTypeKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:projectSectionInfo[kPROJECTTYPE]];
    self.searchInputDictionary[kInputPllProjectNatureKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:projectSectionInfo[kPROJECTNATURE]];
    self.searchInputDictionary[kInputPllComplexityKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:projectSectionInfo[kCOMPLEXITY]];
    self.searchInputDictionary[kInputPllProjectKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:projectSectionInfo[KPROJECT]];
    
    self.searchInputDictionary[kInputPllReviewItemKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:lessonLearntSessionInfo[kREVIEW]];
    self.searchInputDictionary[kInputPllProjectLessonImpactKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:lessonLearntSessionInfo[kIMPACTLEVELS]];
    self.searchInputDictionary[kInputPllRiskCategoryKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:lessonLearntSessionInfo[kPRAELEMENTS]];
    self.searchInputDictionary[kInputPllProjectLessonRatingKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:lessonLearntSessionInfo[kLESSONRATING]];
    self.searchInputDictionary[kInputPllAreaKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:lessonLearntSessionInfo[kAREA]];
    self.searchInputDictionary[kInputPllDisciplineKey] = [filterViewController getDisciplineSelectedRowsFromSectionInfo:lessonLearntSessionInfo[kDISCIPLINE]];
    self.searchInputDictionary[kInputPllLessonValueKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:lessonLearntSessionInfo[kLESSONVALUE]];
    self.searchInputDictionary[kInputPllActivityKey] = [ETGPllFiltersViewController getSelectedRowsFromSectionInfo:lessonLearntSessionInfo[kPPMSACTIVITY]];
    [self performSearching];
    
    [_filtersPopoverController dismissPopoverAnimated:YES];
    _filtersPopoverController = nil;
}

-(void)performSearching
{
    self.isSearching = YES;
    [_appDelegate startActivityIndicatorSmallGrey];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.searchInputDictionary
                                                       options:kNilOptions
                                                         error:nil];
    [[ETGPllModelController sharedModel] getSearchResultWithJsonData:jsonData];
}

- (void)filtersviewControllerDidDismiss:(NSArray *)selectedRowsInProjectFilter lessonLearnFilter:(NSArray *)selectedRowsInLessonLearntFilter
{
    self.projectSectionInfo = selectedRowsInProjectFilter;
    self.lessonLearntSectionInfo = selectedRowsInLessonLearntFilter;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    _filtersPopoverController = nil;
}

-(void)loadWebViewWithHtmlFileName:(NSString *)fileName
{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html" inDirectory:@"Charts"];
    NSURL *url = [NSURL fileURLWithPath:htmlFile];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[self.webView scrollView] setBounces: NO];
    self.webView.scrollView.scrollEnabled = NO;
    [self.webView setClearsContextBeforeDrawing:YES];
    [self.webView loadRequest:request];
}

@end
