//
//  KeyHighlightPagerViewController.m
//  ElevateToGo
//
//  Created by joseph.a.m.quiteles on 4/24/13.
//  Copyright (c) 2013 Accenture Mobility Services. All rights reserved.
//

#import "ETGKeyHighlightPagerViewController.h"
#import "ETGOverallPpaAndPpaKeyHighlightsController.h"
#import "ETGMonthlyAndPlannedKeyHighlightsController.h"
#import "ETGIssuesKeyHighlightsController.h"
#import "ETGKeyHighlightsProgress.h"


@interface ETGKeyHighlightPagerViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *noDataAvailable;

@property (nonatomic) UIPageViewController *pageViewController;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *keyHighlightControllers;

@property (nonatomic, strong) ETGKeyHighlightsProgress *keyhighlightsProgress;
@property (nonatomic, strong) ETGOverallPpaAndPpaKeyHighlightsController *overallPpaAndPpaKeyHighlights;
@property (nonatomic, strong) ETGMonthlyAndPlannedKeyHighlightsController *monthlyAndPlannedKeyHighlights;
@property (nonatomic, strong) ETGIssuesKeyHighlightsController *issuesKeyHighlights;

@end

@implementation ETGKeyHighlightPagerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _keyhighlightsProgress = [self.storyboard instantiateViewControllerWithIdentifier:@"keyhighlightsProgress"];
    _overallPpaAndPpaKeyHighlights = [self.storyboard instantiateViewControllerWithIdentifier:@"overallPpaAndPpaKeyHighlights"];
    _monthlyAndPlannedKeyHighlights = [self.storyboard instantiateViewControllerWithIdentifier:@"monthlyAndPlannedKeyHighlights"];
    _issuesKeyHighlights = [self.storyboard instantiateViewControllerWithIdentifier:@"issuesKeyHighlights"];
    _keyHighlightControllers = [[NSMutableArray alloc] initWithObjects:_keyhighlightsProgress, _overallPpaAndPpaKeyHighlights,
                                _monthlyAndPlannedKeyHighlights, _issuesKeyHighlights, nil];

    [self configurePageViewController];
    _pageControl.numberOfPages = [_keyHighlightControllers count];
    _pageControl.currentPage = 0;
}


- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForGivenReportingMonthNoError object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [ETGAlert sharedAlert].alertShown = NO;
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadControllerData)
                                                 name:kDownloadFilterDataForGivenReportingMonthNoError object:nil];
    [self reloadControllerData];
}


- (void)configurePageViewController
{
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    UIViewController *startingViewController = [self viewControllerAtIndex:0 storyboard:self.storyboard];
    [_pageViewController setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.view sendSubviewToBack:_pageViewController.view];
    _pageViewController.view.frame = self.view.bounds;
    
    [_pageViewController didMoveToParentViewController:self];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *currentViewController = [_pageViewController.viewControllers lastObject];
    NSInteger pageNumber = [self indexOfViewController:currentViewController];
    [_pageControl setCurrentPage:pageNumber];
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    if (([_keyHighlightControllers count] == 0) || (index >= [_keyHighlightControllers count])) {
        return nil;
    }
    
    UIViewController *viewController = [_keyHighlightControllers objectAtIndex:index];

    return viewController;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    if (viewController == _keyhighlightsProgress) {
        return 0;
    } else if (viewController == _overallPpaAndPpaKeyHighlights) {
        return 1;
    } else if (viewController == _monthlyAndPlannedKeyHighlights) {
        return 2;
    } else if (viewController == _issuesKeyHighlights) {
        return 3;
    }
    
    return 0;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [_keyHighlightControllers count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}


/** Initializes the data for all Key Highlights Sections **/
-(void)loadData {
    
    if (self.keyHighlightsData.count != 0) {
        self.keyhighlightsProgress.projectName = _projectName;
        self.keyhighlightsProgress.projectStatus = _projectStatus;
    
        NSMutableDictionary *progress = [NSMutableDictionary dictionary];
        [progress setValue:[[self.keyHighlightsData objectAtIndex:0] valueForKey:@"keyhighlightsProgress"] forKey:@"keyhighlightsProgress"];
        [progress setValue:[[self.keyHighlightsData objectAtIndex:0] valueForKey:@"keyhighLightsTable"] forKey:@"keyhighLightsTable"];
        [_keyhighlightsProgress setKeyhighlightsProgressArray:[NSMutableArray arrayWithObject:progress]];
        [_keyhighlightsProgress loadProgress];
        
        NSMutableDictionary *overallAndPpa = [NSMutableDictionary dictionary];
        
        NSMutableArray *arrayPPA = [[self.keyHighlightsData objectAtIndex:0] valueForKey:@"ppa"];
        for (NSMutableDictionary *dicPPA in arrayPPA) {
            for (NSDictionary *dicTable in _keyhighlightsProgress.keyhighlightsProgressTableArray) {
                if ([[dicPPA objectForKey:@"activity"] isEqualToString:[dicTable objectForKey:@"activityName"]]) {
                    [dicPPA setObject:[dicTable objectForKey:@"activityID"] forKey:@"activityID"];
                }
            }
        }
        [overallAndPpa setValue:arrayPPA forKey:@"ppa"];
        [overallAndPpa setValue:[[self.keyHighlightsData objectAtIndex:0] valueForKey:@"overallPpa"] forKey:@"overallPpa"];
        [_overallPpaAndPpaKeyHighlights setOverallPpaAndPpaValues:[NSMutableArray arrayWithObject:overallAndPpa]];
        [_overallPpaAndPpaKeyHighlights loadOverallAndPpaInfo];
        
        NSMutableDictionary *monthlyAndPlanned = [NSMutableDictionary dictionary];
        
        NSMutableArray *arrayMonthlyHighLights = [[self.keyHighlightsData objectAtIndex:0] valueForKey:@"monthlyHighLights"];
        for (NSMutableDictionary *dicMonthly in arrayMonthlyHighLights) {
            for (NSDictionary *dicTable in _keyhighlightsProgress.keyhighlightsProgressTableArray) {
                if ([[dicMonthly objectForKey:@"activity"] isEqualToString:[dicTable objectForKey:@"activityName"]]) {
                    [dicMonthly setObject:[dicTable objectForKey:@"activityID"] forKey:@"activityID"];
                }
            }
        }
        NSMutableArray *arrayPlannedActivities = [[self.keyHighlightsData objectAtIndex:0] valueForKey:@"plannedActivitiesforNextMonth"];
        for (NSMutableDictionary *dicPlanned in arrayPlannedActivities) {
            for (NSDictionary *dicTable in _keyhighlightsProgress.keyhighlightsProgressTableArray) {
                if ([[dicPlanned objectForKey:@"activity"] isEqualToString:[dicTable objectForKey:@"activityName"]]) {
                    [dicPlanned setObject:[dicTable objectForKey:@"activityID"] forKey:@"activityID"];
                }
            }
        }
        [monthlyAndPlanned setValue:arrayMonthlyHighLights forKey:@"monthlyHighLights"];
        [monthlyAndPlanned setValue:arrayPlannedActivities forKey:@"plannedActivities"];
        
        [_monthlyAndPlannedKeyHighlights setMonthlyAndPlannedValues:[NSMutableArray arrayWithObject:monthlyAndPlanned]];
        [_monthlyAndPlannedKeyHighlights loadMonthlyAndPlannedInfo];
        
        
        NSMutableArray *arrayIssuesConcerns = [[self.keyHighlightsData objectAtIndex:0] valueForKey:@"issuesConcerns"];
        for (NSMutableDictionary *dicIssues in arrayIssuesConcerns) {
            for (NSDictionary *dicTable in _keyhighlightsProgress.keyhighlightsProgressTableArray) {
                if ([[dicIssues objectForKey:@"activity"] isEqualToString:[dicTable objectForKey:@"activityName"]]) {
                    [dicIssues setObject:[dicTable objectForKey:@"activityID"] forKey:@"activityID"];
                }
            }
        }
        [_issuesKeyHighlights setIssuesAndConcernsValues:arrayIssuesConcerns];
        [_issuesKeyHighlights loadIssuesAndConcernsInfo];
        
    } else {
        [self showNoDataAvailableMessage];
    }
}

-(void)reloadControllerData {
    
    _noDataAvailable.hidden = YES;
    [_pageViewController.view setHidden:NO];
    [_pageControl setHidden:NO];

    [self loadData];
}

-(void)showNoDataAvailableMessage {
    _noDataAvailable.hidden = NO;
    [_pageViewController.view setHidden:YES];
    [_pageControl setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
