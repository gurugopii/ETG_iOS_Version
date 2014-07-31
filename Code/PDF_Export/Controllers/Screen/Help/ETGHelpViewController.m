//
//  ETGHelpViewController.m
//  ETG
//
//  Created by Tony Pham on 1/8/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGHelpViewController.h"
#import "ETGPageModelController.h"
#import "ETGImageViewController.h"

@interface ETGHelpViewController () <UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic) UIPageViewController *pageViewController;
@property (nonatomic) ETGPageModelController *pageModelController;

@end

@implementation ETGHelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_sideMenuButton setImage:[CommonMethods sideMenuImage] forState:UIControlStateNormal];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"] == YES) {
        [_sideMenuButton setHidden:NO];
        [_skipButton setHidden:YES];
        [_tapGestureRecognizer removeTarget:self action:@selector(showLoginViewController:)];
    } else {
        [_sideMenuButton setHidden:YES];
        [_skipButton setHidden:NO];
    }
    
    [self configurePageViewController];
}


- (void)configurePageViewController
{
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    ETGImageViewController *startingViewController = [self.pageModelController viewControllerAtIndex:0 storyboard:self.storyboard];
    [_pageViewController setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    _pageViewController.dataSource = _pageModelController;
    _pageViewController.delegate = self;
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.view sendSubviewToBack:_pageViewController.view];
    _pageViewController.view.frame = self.view.bounds;
    
    [_pageViewController didMoveToParentViewController:self];
}

- (ETGPageModelController *)pageModelController
{
    // Return the model controller object, creating it if necessary.
    if (!_pageModelController) {
        _pageModelController = [[ETGPageModelController alloc] init];
        _pageModelController.pageData = [[NSMutableArray alloc] initWithObjects:
                                         [UIImage imageNamed:@"firstHelp"],
                                         [UIImage imageNamed:@"secondHelp"],
                                         [UIImage imageNamed:@"thirdHelp"],
//                                         [UIImage imageNamed:@"fourthHelp"], //An image with Scorecard. Temporary disable
                                         [UIImage imageNamed:@"fifthHelp"],
                                         [UIImage imageNamed:@"sixthHelp"],
                                         [UIImage imageNamed:@"seventhHelp"],
                                         [UIImage imageNamed:@"eighthHelp"],nil];
        
        [_pageControl setNumberOfPages:[_pageModelController.pageData count]];
    }
    
    return _pageModelController;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    ETGImageViewController *currentViewController = [_pageViewController.viewControllers lastObject];
    NSInteger pageNumber = [_pageModelController indexOfViewController:currentViewController];
    [_pageControl setCurrentPage:pageNumber];
}


#pragma mark - Actions

- (IBAction)showLoginViewController:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"] == NO) {
        UIViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:kLoginViewController];
        [self.sidePanelController setCenterPanel:loginViewController];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [_sideMenuButton setHidden:NO];
        [_skipButton removeFromSuperview];
        [_tapGestureRecognizer removeTarget:self action:@selector(showLoginViewController:)];
    }
}

- (IBAction)handleShowHideLeftMenu:(id)sender
{
    if (self.sidePanelController.state == JASidePanelLeftVisible) {
        [self.sidePanelController showCenterPanel:YES];
    } else if (self.sidePanelController.state == JASidePanelCenterVisible) {
        [self.sidePanelController showLeftPanel:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
