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

#define kStatus @"status"
#define kImages @"images"
#define kImageData @"data"
#define kImageKey @"key"
#define kInputFileKey @"inpFileKey"

@interface ETGHomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSMutableArray *imagesArray;
@property (nonatomic) NSTimer *imageTimer;
@property (nonatomic) NSInteger currentImage;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation ETGHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_sideMenuButton setImage:[JASidePanelController defaultImage]
                               forState:UIControlStateNormal];
    _managedObjectContext = [NSManagedObjectContext defaultContext];
    _imagesArray = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getWelcomeImages];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // Invalidate timer
    [_imageTimer invalidate];
    _imageTimer = nil;
}

- (void)getWelcomeImages {
    [self loadImagesFromCoreData];
}

- (void)loadImagesFromCoreData
{
    //Fetch images
    NSArray *fetchedEntities = [ETGWelcomeImage findAll];
    
    if (![fetchedEntities count]) {
        // Remove all images
        [_imagesArray removeAllObjects];
        // Fetch images
        [self checkNewImagesFromServer];
    } else {
        for (ETGWelcomeImage *welcomeImageObject in fetchedEntities) {
            [_imagesArray addObject:welcomeImageObject];
        }
        if ([_imagesArray count] > 0) {
            ETGWelcomeImage *welcomeImageObject = [_imagesArray objectAtIndex:0];
            [_imageView setImage:[UIImage imageWithData:welcomeImageObject.data]];
            if (![_imageTimer isValid]) {
                _imageTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(showDynamicImages) userInfo:nil repeats:YES];
            }
        }
    }
}

- (void)checkNewImagesFromServer
{
    NSURL *imagesURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, kWelcomeImages]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:imagesURL];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
<<<<<<< Temporary merge branch 1
    [request setValue:[[ETGToken sharedToken] tokenFromKeyChain]  forHTTPHeaderField:@"X-Token"];
=======
    [request setValue:[[ETGToken sharedToken] token]  forHTTPHeaderField:@"X-Token"];
//    NSLog(@"homeToken: %@", [[ETGToken sharedToken] tokenFromKeyChain]);
>>>>>>> Temporary merge branch 2
    
    NSError *error = nil;
    NSDictionary *inpImageKeys = [[NSDictionary alloc] init];
    if ([_imagesArray count] > 0) {
        NSMutableArray *imageKeysArray = [[NSMutableArray alloc] initWithCapacity:[_imagesArray count]];
        for (ETGWelcomeImage *imageObject in _imagesArray) {
            [imageKeysArray addObject:imageObject.key];
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
        if (![_managedObjectContext save:&error]) {
            DDLogError(@"%@: %@, %@", saveCoreDataError, error, [error userInfo]);
        }
        [self loadImagesFromCoreData];
    }
}

- (void)saveImagesToCoreDataWithImageData:(NSData *)imageData imageKey:(NSNumber *)imageKey {
    ETGWelcomeImage *welcomeImageEntity = [NSEntityDescription insertNewObjectForEntityForName:@"ETGWelcomeImage" inManagedObjectContext:_managedObjectContext];
    welcomeImageEntity.key = imageKey;
    welcomeImageEntity.data = imageData;
}

- (void)deleteImageFromCoreData:(NSNumber *)imageKey {
    NSArray *deletedObjects = [CommonMethods searchEntityForName:@"ETGWelcomeImage" withID:imageKey context:_managedObjectContext];
    if ([deletedObjects count] > 0) {
        [_managedObjectContext deleteObject:[deletedObjects objectAtIndex:0]];
    }
}

- (void)showDynamicImages
{
    if ([_imagesArray count]) {
        _currentImage++ ;
        
        if (_currentImage > _imagesArray.count -1) {
            _currentImage = 0;
        }
        ETGWelcomeImage *welcomeImageObject = [_imagesArray objectAtIndex:_currentImage];
        [_imageView setImage:[UIImage imageWithData:welcomeImageObject.data]];
    }
}

- (IBAction)showHideLeftSideMenu:(id)sender {
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
