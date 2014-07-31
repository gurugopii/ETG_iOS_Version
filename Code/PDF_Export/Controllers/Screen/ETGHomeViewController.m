//
//  ETGHomeViewController.m
//  PDF_Export
//
//  Created by Tony Pham on 9/25/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "ETGHomeViewController.h"
#import <AFNetworking.h>
#import "ETGWelcomeImage.h"
#import "Base64.h"
#import "CommonMethods.h"
#import "ETGImageViewController.h"
#import "ETGPageModelController.h"

#define kStatus @"status"
#define kImages @"images"
#define kImageData @"data"
#define kImageKey @"key"
#define kInputFileKey @"inpFileKey"

@interface ETGHomeViewController () <UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic) UIPageViewController *pageViewController;
@property (nonatomic) ETGPageModelController *pageModelController;
@property (nonatomic) NSMutableArray *imagesArray;
@property (nonatomic) NSTimer *imageTimer;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation ETGHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _managedObjectContext = [NSManagedObjectContext defaultContext];
    _imagesArray = [[NSMutableArray alloc] init];
    
    [_sideMenuButton setImage:[JASidePanelController defaultImage] forState:UIControlStateNormal];
    
    [self configurePageViewController];
    [self.view sendSubviewToBack:_pageViewController.view];
    
    [self loadImagesFromCoreData];
    
    [self performSelector:@selector(showleftMenu) withObject:nil afterDelay:1.0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self playSlideShow];
    [self checkNewImagesFromServer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self stopSlideShow];
}

- (void)loadImagesFromCoreData
{
    [_imagesArray removeAllObjects];
    [_pageModelController.pageData removeAllObjects];

    //Fetch images
    NSArray *fetchedEntities = [CommonMethods fetchEntity:@"ETGWelcomeImage" sortDescriptorKey:@"key" inManagedObjectContext:_managedObjectContext];
    
    if ([fetchedEntities count] > 0) {
        [_imagesArray addObjectsFromArray:fetchedEntities];
        
        for (ETGWelcomeImage *welcomeImageObject in _imagesArray) {
            [_pageModelController.pageData addObject:[UIImage imageWithData:welcomeImageObject.data]];
        }
        [_pageControl setNumberOfPages:[_pageModelController.pageData count]];
        
        [self playSlideShow];
    } else {
        [self setDefaultImageForPageModelController];
    }
    
    _currentPage = 0;
    [self showPageAtIndex:0];
}

- (void)checkNewImagesFromServer
{
    
    [_imagesArray removeAllObjects];
    NSString *imageURLPath = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, kWelcomeImages];
    NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:imageURLPath httpMethod:@"POST"];
    
    NSError *error = nil;
    NSDictionary *inpImageKeys = [[NSDictionary alloc] init];
    
    NSArray *fetchedEntities = [CommonMethods fetchEntity:@"ETGWelcomeImage" sortDescriptorKey:@"key" inManagedObjectContext:_managedObjectContext];
    if ([fetchedEntities count] > 0) {
        [_imagesArray addObjectsFromArray:fetchedEntities];
    }
    NSInteger totalImage = [_imagesArray count];
    if (totalImage > 0) {
        NSMutableArray *imageKeysArray = [[NSMutableArray alloc] initWithCapacity:totalImage];
        for (ETGWelcomeImage *imageObject in _imagesArray) {
            if (imageObject.key) {
                [imageKeysArray addObject:imageObject.key];
            }
        }
        inpImageKeys = @{kInputFileKey: [imageKeysArray componentsJoinedByString:@","]};
    } else {
        inpImageKeys = @{kInputFileKey: @"-1"};
    }
    NSData *imageKeysJSON = [NSJSONSerialization dataWithJSONObject:inpImageKeys
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    [request setHTTPBody:imageKeysJSON];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                                         ^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
                                             [self handleJSONImagesData:json];
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                         }];
    operation.SSLPinningMode = AFSSLPinningModeCertificate;
    [operation start];
}

- (void)handleJSONImagesData:(id)json {
//    DDLogInfo(@"imagesJSON: %@", json);
    
    if ([json[kStatus] isEqualToNumber:@(1)]) {
        for (NSDictionary *imageDict in json[kImages]) {
            NSData *imageData = [Base64 decode:imageDict[kImageData]];
            if (imageData) {
                [self saveImagesToCoreDataWithImageData:imageData imageKey:imageDict[kImageKey]];
            } else {
                [self deleteImageFromCoreData:imageDict[kImageKey]];
            }
        }
        
        //Save all changes
        NSError *error = nil;
        [_managedObjectContext saveToPersistentStoreAndWait];
        if (![_managedObjectContext save:&error]) {
            DDLogError(@"%@: %@, %@", saveCoreDataError, error, [error userInfo]);
        }

        [self loadImagesFromCoreData];
    }
}

- (void)saveImagesToCoreDataWithImageData:(NSData *)imageData imageKey:(NSNumber *)imageKey
{
    ETGWelcomeImage *welcomeImageEntity;

    NSArray *fetchedWelcomeImages = [CommonMethods searchEntityForName:@"ETGWelcomeImage" withID:imageKey context:_managedObjectContext];
    if (fetchedWelcomeImages.count > 0) {
        welcomeImageEntity = [fetchedWelcomeImages objectAtIndex:0];
    } else {
        welcomeImageEntity = [NSEntityDescription insertNewObjectForEntityForName:@"ETGWelcomeImage" inManagedObjectContext:_managedObjectContext];
        welcomeImageEntity.key = imageKey;
    }
    
    welcomeImageEntity.data = imageData;
}

- (void)deleteImageFromCoreData:(NSNumber *)imageKey {
    NSArray *deletedObjects = [CommonMethods searchEntityForName:@"ETGWelcomeImage" withID:imageKey context:_managedObjectContext];
    if ([deletedObjects count] > 0) {
        [_managedObjectContext deleteObject:[deletedObjects objectAtIndex:0]];
    }
}


#pragma mark - PageViewController 

- (void)configurePageViewController
{
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    ETGImageViewController *startingViewController = [self.pageModelController viewControllerAtIndex:0 storyboard:self.storyboard];
    [_pageViewController setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [_pageViewController setDataSource:_pageModelController];
    [_pageViewController setDelegate:self];
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    _pageViewController.view.frame = self.view.bounds;
    
    [_pageViewController didMoveToParentViewController:self];
    self.view.gestureRecognizers = _pageViewController.gestureRecognizers;
}

- (ETGPageModelController *)pageModelController
{
    if (!_pageModelController) {
        _pageModelController = [[ETGPageModelController alloc] init];
        _pageModelController.pageData = [[NSMutableArray alloc] init];
        [self setDefaultImageForPageModelController];
    }
    
    return _pageModelController;
}

- (void)setDefaultImageForPageModelController
{
    [_pageModelController.pageData addObject:[UIImage imageNamed:@"Welcome"]];
    [_pageControl setNumberOfPages:1];
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    ETGImageViewController *currentViewController = [_pageViewController.viewControllers lastObject];
    NSInteger pageNumber = [_pageModelController indexOfViewController:currentViewController];
    [_pageControl setCurrentPage:pageNumber];
    
    //Stop play slide show
    [self stopSlideShow];
}


#pragma Actions

- (void)playSlideShow
{
    //NSLog(@"pageCount: %d", [_pageModelController.pageData count]);
    if (_imageTimer.isValid) {
        [_imageTimer invalidate];
    }
    
    if (_pageModelController.pageData.count > 1 && _imageTimer.isValid == NO) {
        _imageTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(showNextPage) userInfo:nil repeats:YES];
    }
}

- (void)stopSlideShow
{
    [_imageTimer invalidate];
}

- (void)showNextPage
{
    ETGImageViewController *currentViewController = [_pageViewController.viewControllers lastObject];
   _currentPage = [_pageModelController indexOfViewController:currentViewController];
    if (_currentPage == _pageModelController.pageData.count - 1) {
        _currentPage = 0;
    } else {
        _currentPage++;
    }
    
    [self showPageAtIndex:_currentPage];
}

- (void)showPageAtIndex:(NSInteger)index
{
    ETGImageViewController *nextViewController = [self.pageModelController viewControllerAtIndex:index storyboard:self.storyboard];
    [_pageViewController setViewControllers:@[nextViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [_pageControl setCurrentPage:index];
}

- (IBAction)showHideLeftSideMenu:(id)sender {
    if (self.sidePanelController.state == JASidePanelLeftVisible) {
        [self.sidePanelController showCenterPanel:YES];
    } else if (self.sidePanelController.state == JASidePanelCenterVisible) {
        [self.sidePanelController showLeftPanel:YES];
    }
}

- (void)showleftMenu
{
    [self.sidePanelController showLeftPanel:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
