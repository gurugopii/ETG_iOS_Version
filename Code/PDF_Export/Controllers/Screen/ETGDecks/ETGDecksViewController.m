        //
//  ETGDecksViewController.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 10/8/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGDecksViewController.h"
#import "ETGDecksLayoutModelController.h" //All Formatting for ETG Decks
#import "ReaderViewController.h" //PDF Full Screen View
#import "PDFCheckFile.h" //For checking if pdf file exists in path
#import "ETGUserDefaultManipulation.h"
#import "ETGNetworkConnection.h"
#import "Reachability.h"

@interface ETGDecksViewController () <ReaderViewControllerDelegate, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>{
    
    UIPopoverController *popoverController;

    UIBarButtonItem *_refreshButtonItem;
    
    UILabel *_labelTimeStamp;
    
    NSString *fileName;
    
    ReaderViewController *readerVC;
}

@property (nonatomic, strong) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) Reachability *hostReachability;
@property (nonatomic, strong) Reachability *internetReachability;
@property (nonatomic, strong) IBOutlet UISearchBar *categorySearchBar;
@property (nonatomic, strong) IBOutlet UITableView *decksTableView;
@property (nonatomic, strong) IBOutlet UICollectionView *decksCollectionView;
@property (nonatomic, strong) IBOutlet UINavigationBar *categoryNavBar;
@property (weak, nonatomic) IBOutlet UINavigationBar *detailNavigationBar;
@property (nonatomic, strong) IBOutlet UINavigationItem *categoryNavigation;
@property (nonatomic, strong) IBOutlet UINavigationItem *collectionViewNavigation;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) BOOL isCategories;
@property (nonatomic) BOOL isDecks;
@property (nonatomic) BOOL isRecentDecks;
@property (nonatomic) BOOL isDownloadButton;
@property (nonatomic) BOOL isMorethanTenDays;
@property (nonatomic, strong) NSString *pdfFilePath;
@property (nonatomic, strong) NSString *pdfFileTempPath;
@property (nonatomic, strong)NSArray *filteredDecksArray;
@property (nonatomic, strong) NSArray *recentDecksArray;
@property (nonatomic, strong) NSArray *recentDecksArray2;
@property (nonatomic, strong) NSMutableArray *allMonthsArray;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSIndexPath *downloadIndexPath;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;

- (IBAction)toggleMonthsAndCategories:(UISegmentedControl *)sender;


@end

@implementation ETGDecksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *serverAddress = [[NSURL URLWithString:kBaseURL] host];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    _internetReachability = [Reachability reachabilityForInternetConnection];
    [_internetReachability startNotifier];
    
    _hostReachability = [Reachability reachabilityWithHostName:serverAddress];
    [_hostReachability startNotifier];
    
    [self customizeNavigationBarAppearance];
    
    _appDelegate = [[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePDFFileNotification:) name:@"PDFFileNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPDFView) name:@"DecksDataUpdated" object:nil];
    
    _refreshButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refreshBarButton"] style:UIBarButtonItemStylePlain target:self action:@selector(reloadDecksViewData)];
    
    _categoryNavigation.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    _categoryNavigation.rightBarButtonItem = _refreshButtonItem;
    
    _collectionViewNavigation.title = @"Recently Uploaded";
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
        _refreshButtonItem.enabled = NO;
    } else {
        _refreshButtonItem.enabled = YES;
    }
}

- (void)customizeNavigationBarAppearance
{
    [_statusView setBackgroundColor:kPetronasGreenColor];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [_categoryNavBar setTintColor:kPetronasGreenColor];
        [_detailNavigationBar setTintColor:kPetronasGreenColor];
    } else {
        [_categoryNavBar setBarTintColor:kPetronasGreenColor];
        [_detailNavigationBar setBarTintColor:kPetronasGreenColor];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [ETGAlert sharedAlert].deckAlertShown = NO;
    _isDownloadButton = NO;

}

- (void)viewWillAppear:(BOOL)animated {
    
    [self loadGestureRecognizers];
    if ([self.categoryNavigation.title isEqualToString:@"Categories"]) {
        [self loadInitialData];
    }
    [self refreshDownloadDecks];
    
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (_appDelegate.isNetworkServerAvailable == YES) {
        _refreshButtonItem.enabled = YES;
    } else {
        _refreshButtonItem.enabled = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isDownloadingDecks"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        if (newValue == YES) {
            // TODO: Perform the necessary handling if isDownloadingDecks was set to YES. See ETGPDFModelController, this property was set to YES before starting the web service request
            //NSLog(@"Decks started downloading");
            
        } else {
            // TODO: Perform the necessary handling if isDownloadingDecks was set to NO. See ETGPDFModelController, this property was set to NO inside the success/failure block which indicates that the web service has completed the processing.
            // TODO: Maybe this is where you will call/start fetching the categories
            //NSLog(@"Decks finished downloading");
            [[ETGPDFModelController sharedModel] getCategoriesServiceData];
            
            BOOL isTimeStampMoreThanTenDays = [[ETGUserDefaultManipulation sharedUserDefaultManipulation] isTimeStampMoreThanAWeekForModule:@"PDF_Feature"];
            
            if (isTimeStampMoreThanTenDays) {
                
                [self loadInitialData];
                [self loadTimeStamp];
                
                [[ETGPDFModelController sharedModel] getCategoriesServiceData];
                _isMorethanTenDays = YES;
                
            }
        }
    } else if ([keyPath isEqualToString:@"isDownloadingCategories"]) {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        if (newValue == YES) {
            // TODO: Perform the necessary handling if isDownloadingDecks was set to YES. See ETGPDFModelController, this property was set to YES before starting the web service request
            //NSLog(@"Categories started downloading");
            
        } else {
            // TODO: Perform the necessary handling if isDownloadingDecks was set to NO. See ETGPDFModelController, this property was set to NO inside the success/failure block which indicates that the web service has completed the processing.
            // TODO: Maybe this is where you will call/start refreshing the view. This assumes that all the necessary data was already fetched from web service
            //NSLog(@"Categories finished downloading");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DecksDataUpdated" object:self];
        }
    }
}



#pragma mark - Initialization
-(void) loadInitialData {
    
    [_appDelegate performSelector:@selector(startActivityIndicatorSmallGrey) withObject:self afterDelay:0];
    
    _allMonthsArray = [[ETGPDFModelController sharedModel] getMonths];
    [[ETGPDFModelController sharedModel] getCategories];
    _recentDecksArray = [[ETGPDFModelController sharedModel] getRecentDecks];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [self.decksTableView reloadData];
    [self displayRecentlyViewed];
    
    [[ETGPDFModelController sharedModel] getDecksWebServiceData];
}

-(void) reloadDecksViewData {
    
    [_appDelegate performSelector:@selector(startActivityIndicatorSmallGrey) withObject:self afterDelay:0];
    
    [[ETGPDFModelController sharedModel] getDecksWebServiceData];
    [self loadMainCategory];
}

- (void) loadPDFView {
    
    if (_isMorethanTenDays) {
        
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeTimeStampInNSUserDefaults:[NSDate date] forModule:@"PDF_Feature"];
        _isMorethanTenDays = NO;

        
    }
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeTimeStampInNSUserDefaults:[NSDate date] forModule:@"PDF_Feature"];
    [self loadTimeStamp];

    
    _allMonthsArray = [[ETGPDFModelController sharedModel] getMonths];
    [[ETGPDFModelController sharedModel] getCategories];
    _recentDecksArray = [[ETGPDFModelController sharedModel] getRecentDecks];
    
    [self.decksTableView reloadData];
    [self displayRecentlyViewed];
    
    [_appDelegate performSelector:@selector(stopActivityIndicatorSmall) withObject:self afterDelay:0];
    
}

-(void)loadTimeStamp{
    NSDate *updateDate = [[ETGUserDefaultManipulation sharedUserDefaultManipulation] retrieveTimeStampFromNSUserDefaults:@"PDF_Feature"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"dd MMM yyyy"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *strLastUpdatedDate = [formatter stringFromDate:updateDate];
    
    UILabel  *timeStampLabel = [[UILabel alloc] initWithFrame:CGRectMake(460, 5, 270, 20)];
    timeStampLabel.font = [UIFont italicSystemFontOfSize:12.0f];
    timeStampLabel.text = [NSString stringWithFormat:@"Updated: %@", strLastUpdatedDate];
    timeStampLabel.textColor = [UIColor grayColor];
    timeStampLabel.backgroundColor = [UIColor clearColor];

    if (_labelTimeStamp == nil) {
        _labelTimeStamp = timeStampLabel;
        [_decksCollectionView addSubview:timeStampLabel];
    }
    else{
        _labelTimeStamp.text = timeStampLabel.text;
    }
    
//    if (([strLastUpdatedDate rangeOfString:@"null"].location == NSNotFound) || ( [strLastUpdatedDate length] == 0)) {
//        [_decksCollectionView addSubview:timeStampLabel];
//    }
}

#pragma mark - Show Initial Page
/* Reload table view to show the main categories (Months/Categories). Reloads also the collection to display the Recently View Decks. */
-(void) loadMainCategory {
    
    _isDecks = NO;
    _categoryNavigation.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    _categoryNavigation.rightBarButtonItem = _refreshButtonItem;
    
    _monthsCategories.hidden = NO;
    _categoryNavigation.title = @"Categories";
    _collectionViewNavigation.title = @"Recently Uploaded";//Uploaded Viewed
    _categorySearchBar.text = nil;
    _categorySearchBar.placeholder = @"Search for decks";
    
    [self.decksTableView reloadData];
    [self displayRecentlyViewed];
    
}

/* Display Recently Viewed Decks */
-(void) displayRecentlyViewed {
    
    if (_recentDecksArray.count != 0) {
        _isRecentDecks = YES;
        _imagesArray = [[ETGPDFModelController sharedModel] loadRecentlyViewedImagesThroughRecentDecks:_recentDecksArray];
        
        _flowLayout.itemSize = CGSizeMake(150, 200);
        
        _decksCollectionView.collectionViewLayout = _flowLayout;
        
        [_decksCollectionView reloadData];
    }
//    _isRecentDecks = YES;
//    _imagesArray = [[ETGPDFModelController sharedModel] loadRecentlyViewedImagesThroughRecentDecks:_recentDecksArray];
//    
//    _flowLayout.itemSize = CGSizeMake(150, 200);
//
//    _decksCollectionView.collectionViewLayout = _flowLayout;
//   
//    [_decksCollectionView reloadData];
}

-(void) loadGestureRecognizers {
    
    /* Add gesture recognizer to display popover when long pressing a recently viewed deck */
    _longPressGesture = [[UILongPressGestureRecognizer alloc]                                                      initWithTarget:self action:@selector(handleLongPressGesture:)];
    _longPressGesture.minimumPressDuration = 0.5; //seconds
    _longPressGesture.delegate = self;
    [_decksCollectionView addGestureRecognizer:_longPressGesture];
    
    /* Add gesture recognizer to display popover when long pressing a category or subcategory in the table. */
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [_decksTableView addGestureRecognizer:_longPressGesture];
    
    /* Add gesture recognizer to display popover when long pressing the category navigation bar. */
    UILongPressGestureRecognizer *longPressNavBar = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestureForNavBar:)];
    longPressNavBar.minimumPressDuration = 0.5;
    longPressNavBar.delegate = self;
    [_categoryNavBar addGestureRecognizer:longPressNavBar];
    
}

#pragma mark - Notifications

- (void) receivePDFFileNotification:(NSNotification *) notification {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    /* Check if PDF File was downloaded  by tapping on the download button and moves the file to the documents if yes. */
    /*  move the file from temporary to cach first */
    
    [fileManager moveItemAtPath:_pdfFileTempPath toPath:_pdfFilePath error:NULL];
    
//    NSString *destPath = [[ETGPDFModelController sharedModel] checkDestPathWithOriginPath:_pdfFilePath];

    
    if (_isRecentDecks) {
        [_appDelegate performSelector:@selector(stopActivityIndicatorSmall) withObject:self afterDelay:0];
        [self viewPdfWithFilePath:_pdfFilePath fileName:fileName startPageNumber:1];
    } else {
        _imagesArray = [[ETGPDFModelController sharedModel] displaySlidePerDeckWithIndexPath:[[ETGPDFModelController sharedModel] indexPath] decksArray:[[ETGPDFModelController sharedModel] decks] andFilePath:_pdfFilePath];
        [_decksCollectionView reloadData];
        _flowLayout.itemSize = CGSizeMake(100, 120);
        _decksCollectionView.collectionViewLayout = _flowLayout;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *bgView = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = YES;
    cell.textLabel.enabled = YES;
    cell.detailTextLabel.enabled = YES;
    _longPressGesture.enabled = YES;

    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell = [[ETGDecksLayoutModelController sharedModel] formatCell:cell];
    
    if (_isCategories & !_isDecks) {
        /** Cell Layout for Categories **/
        cell.accessoryType=UITableViewCellSelectionStyleGray;
        cell = [[ETGDecksLayoutModelController sharedModel] formatCellContentForCategoryWithIndexPath:indexPath andTableCell:cell];
    } else if (_isDecks) {
        /** Cell Layout for SubCategories **/
        cell.selectionStyle = UITableViewCellSelectionStyleGray;//UITableViewCellSelectionStyleNone;

        if (_filteredDecksArray.count) {
            cell = [[ETGDecksLayoutModelController sharedModel] formatDeckCellContentWithIndexPath:indexPath tableCell:cell andDecksArray:_filteredDecksArray];
            /* Add download button to the Table View Cell. */
            UIButton *btnDownload = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnDownload setImage:[[ETGPDFModelController sharedModel] checkDownloadButtonImageWithDecksArray:_filteredDecksArray andArrayIndex:indexPath.row] forState:UIControlStateNormal];
            btnDownload.frame = CGRectMake(185, 0, 60, 60);
            [btnDownload addTarget:self action:@selector(downloadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnDownload];
            bgView.backgroundColor = [UIColor clearColor];
            cell.backgroundView=bgView;
        } else {
            cell.textLabel.text = @"No Available Decks.";
            cell.userInteractionEnabled = NO;
            cell.textLabel.enabled = NO;
            cell.detailTextLabel.enabled = NO;
            cell.accessoryType=UITableViewCellAccessoryNone;
            _longPressGesture.enabled = NO;

        }
        _monthsCategories.hidden = YES;
        /* Change left button to Back Button */
        _categoryNavigation.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(loadMainCategory)];
        
        UIView *selectionColor = [[UIView alloc] init];
        selectionColor.backgroundColor = [UIColor colorWithRed:(205/255.0) green:1.0f blue:(238/255.0) alpha:1.0f];;
        cell.selectedBackgroundView = selectionColor;
        
        return cell;
    } else {
        /** Cell Layout for Months **/
        cell.textLabel.text = [_allMonthsArray objectAtIndex:indexPath.row];
        cell.indentationLevel = 2;
        bgView.backgroundColor = [UIColor clearColor];
        cell.backgroundView=bgView;
    }
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(174/255.0) blue:(154/255.0) alpha:1];
    cell.selectedBackgroundView = selectionColor;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = 0;
    if (_isCategories & !_isDecks) {
        NSArray *subCategories = [[ETGPDFModelController sharedModel] findSubCategoryWithIndexPathSection:section];
        rowCount = subCategories.count;
    } else if (_isDecks) {
        rowCount = [_filteredDecksArray count];
        if (rowCount == 0) {
            rowCount++;
        }
    } else {
        rowCount = [_allMonthsArray count];
    }
    return rowCount;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sectionNumber = 1;
    if (_isCategories & !_isDecks) {
        sectionNumber = [[[ETGPDFModelController sharedModel] uniqueCategories] count];
        
    }
    return sectionNumber;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_isCategories & !_isDecks) {
        /** Display the Category Header **/
        UILabel *categoryHeaderLabel = [[ETGDecksLayoutModelController sharedModel] formatCategoryHeader];
        categoryHeaderLabel.text = @"";
        NSArray *subCategories = [[ETGPDFModelController sharedModel] findSubCategoryWithIndexPathSection:section];
        if (subCategories.count) {
            if(![[subCategories objectAtIndex:0] isEqual:@"None" ]){
                categoryHeaderLabel.text = [NSString stringWithFormat:@"   %@",[[[ETGPDFModelController sharedModel] uniqueCategories] objectAtIndex:section]];
            }
        }
        return categoryHeaderLabel;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isCategories & !_isDecks) {
        NSArray *subCategories = [[ETGPDFModelController sharedModel] findSubCategoryWithIndexPathSection:section];
        if (subCategories.count) {
            if(![[subCategories objectAtIndex:0] isEqual:@"None" ]){
                return 25.0;
            }else {
                return 7.0;
            }
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _downloadIndexPath = indexPath;

    [_imagesArray removeAllObjects];
    _flowLayout.itemSize = CGSizeMake(100, 120);
    _decksCollectionView.collectionViewLayout = _flowLayout;
    [_decksCollectionView reloadData];
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    _isRecentDecks = NO;
    
    if (!_isDecks & !_monthsCategories.hidden) {
        
        _isDecks = YES;
        _categoryNavigation.title = selectedCell.textLabel.text;
        
        if (!_isCategories) {
            //Months
            _filteredDecksArray = [[ETGPDFModelController sharedModel] findDecksWithReportingMonth:selectedCell.textLabel.text];
        } else {
            //Categories
            _filteredDecksArray = [[ETGPDFModelController sharedModel] findDecksWithCategory:[[[ETGPDFModelController sharedModel] uniqueCategories] objectAtIndex:indexPath.section] andSubCategory:selectedCell.textLabel.text];
        }
        
        [self.decksTableView reloadData];
        
    } else {
        //SubCategory
        NSArray *decks = [NSArray arrayWithArray:_filteredDecksArray];
        
        if (_isRecentDecks) {
            decks = _recentDecksArray;
        }
        _collectionViewNavigation.title = [[[[decks objectAtIndex:indexPath.row] objectForKey:@"fileName"] lastPathComponent] stringByDeletingPathExtension];
        [_imagesArray removeAllObjects];
        
        //Downloads the PDF File from the Web Service.
        _pdfFilePath = [[ETGPDFModelController sharedModel] checkIfFileExistsWithDecks:decks andArrayIndex:indexPath.row];
        fileName = [[decks objectAtIndex:indexPath.row] objectForKey:@"fileName"];
        
        NSString *pdfDocPath = [[ETGPDFModelController sharedModel] getFilePathInDocumentsPDFDirectory:decks andArrayIndex:indexPath.row];
        NSString *pdfCachePath = [[ETGPDFModelController sharedModel] getFilePathInCacheDirectory:decks andArrayIndex:indexPath.row];
        _pdfFileTempPath = [[ETGPDFModelController sharedModel] getFilePathInCacheTempDirectory:decks andArrayIndex:indexPath.row];
        
        if ([PDFCheckFile isPDFExist:pdfDocPath]) {
            _pdfFilePath = pdfDocPath;
            _imagesArray = [[ETGPDFModelController sharedModel]displaySlidePerDeckWithIndexPath:indexPath decksArray:decks andFilePath:_pdfFilePath];
        }
        else if ([PDFCheckFile isPDFExist:pdfCachePath]){
            _pdfFilePath = pdfCachePath;
            _imagesArray = [[ETGPDFModelController sharedModel]displaySlidePerDeckWithIndexPath:indexPath decksArray:decks andFilePath:_pdfFilePath];
        }
        else {
            _pdfFilePath = pdfCachePath;
            [[ETGPDFModelController sharedModel] downloadPdfFileWithIndexPath:indexPath decksArray:_recentDecksArray andFilePath:_pdfFileTempPath];
        }
        
        [_decksCollectionView reloadData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isDecks) {
        return  80;
    }
    return 44;
    
}

#pragma mark - Collection View Source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellIdentifier = @"Cell Identifier";
    [_decksCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    UIImageView *pdfImage = [[UIImageView alloc] initWithImage:[_imagesArray objectAtIndex:indexPath.row]];
    
    NSArray *collectionViewDataArray;
    if (_isRecentDecks) {
        collectionViewDataArray = [NSArray arrayWithArray:_recentDecksArray];
    } else {
        collectionViewDataArray = [NSArray arrayWithArray:_filteredDecksArray];
    }
    
    if (collectionViewDataArray) {
        if (_isRecentDecks) {
            cell = [[ETGDecksLayoutModelController sharedModel] formatRecentDeckLabelsWithRecentDecks:collectionViewDataArray indexPath:indexPath andCollectionViewCell:cell];
            pdfImage.frame =    CGRectMake(30, 40, 50, 50);

            
        } else {
            cell = [[ETGDecksLayoutModelController sharedModel] formatDeckLabelsWithIndexPath:indexPath andCollectionViewCell:cell];
            pdfImage.frame =    CGRectMake(30, 40, 120, 100);

        }

        pdfImage.tag = -1;
        [cell.contentView addSubview:pdfImage];        
    } else {
        [cell.contentView removeFromSuperview];
    }
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (_isRecentDecks) {
        return UIEdgeInsetsMake(20, 80, 20, 80);

    } else {
        return UIEdgeInsetsMake(10, 20, 10, 80);
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(120, 200);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imagesArray.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isRecentDecks) {
        if (_recentDecksArray.count != 0) {
            _downloadIndexPath = indexPath;
            fileName = [[_recentDecksArray objectAtIndex:indexPath.row] objectForKey:@"fileName"];
            
    //        _pdfFilePath = [[ETGPDFModelController sharedModel] checkIfFileExistsWithDecks:_recentDecksArray andArrayIndex:indexPath.row];
            
            NSString *pdfDocPath = [[ETGPDFModelController sharedModel] getFilePathInDocumentsPDFDirectory:_recentDecksArray andArrayIndex:indexPath.row];
            NSString *pdfCachePath = [[ETGPDFModelController sharedModel] getFilePathInCacheDirectory:_recentDecksArray andArrayIndex:indexPath.row];
            _pdfFileTempPath = [[ETGPDFModelController sharedModel] getFilePathInCacheTempDirectory:_recentDecksArray andArrayIndex:indexPath.row];
            
            if ([PDFCheckFile isPDFExist:pdfDocPath]) {
                _pdfFilePath = pdfDocPath;
                [self viewPdfWithFilePath:_pdfFilePath fileName:fileName startPageNumber:1];
            }
            else if ([PDFCheckFile isPDFExist:pdfCachePath]){
                _pdfFilePath = pdfCachePath;
                [self viewPdfWithFilePath:_pdfFilePath fileName:fileName startPageNumber:1];
            }
            else {
                _pdfFilePath = pdfCachePath;
                [[ETGPDFModelController sharedModel] downloadPdfFileWithIndexPath:indexPath decksArray:_recentDecksArray andFilePath:_pdfFileTempPath];
            }
        }
    } else {
        
        [self viewPdfWithFilePath:_pdfFilePath fileName:fileName startPageNumber:(indexPath.row + 1)];
    }
}


#pragma mark - PDFReaderViewController

- (void)viewPdfWithFilePath:(NSString *)filePath startPageNumber:(NSInteger)startPageNumber {
    [self viewPdfWithFilePath:filePath fileName:nil startPageNumber:startPageNumber];
}

- (void)viewPdfWithFilePath:(NSString *)filePath fileName:(NSString *)fileNameStr startPageNumber:(NSInteger)startPageNumber {
    
    [[ETGPDFModelController sharedModel] setPdfFilePathInUse:filePath];
    //make a pdf copy
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *destPath = [[ETGPDFModelController sharedModel] getFilePathForReadInCacheTempDirectory];
    
    if ([fileManager fileExistsAtPath:destPath]) {
        [fileManager removeItemAtPath:destPath error:nil];
    }
    [fileManager copyItemAtPath:filePath toPath:destPath error:NULL];
    
	NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    
//	ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
    ReaderDocument *document = [[ReaderDocument alloc] initWithFilePath:destPath password:phrase];
    if (fileNameStr != nil) {
        document.fileName = fileNameStr;
    }
    document.pageNumber = @(startPageNumber); //Start on page number
    
    //DDLogInfo(@"%@%@",logInfoPrefix,[NSString stringWithFormat:filePathLog, destPath]);
    
	if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
    {
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
		readerViewController.delegate = self; // Set the ReaderViewController delegate to self
		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        readerVC = readerViewController;
        
        [self presentViewController:readerViewController animated:YES completion:nil];
	}
}

- (void)dismissReaderViewController:(ReaderViewController *)viewController {
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Action

- (IBAction)toggleMonthsAndCategories:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0: {
            _isCategories = NO;
            [self.decksTableView reloadData];
            break;
        }
        case 1: {
            _isCategories = YES;
            [self.decksTableView reloadData];
            break;
        }
    }
}

/* Search PDF File based on the text entered into the search bar. */
- (void)searchBarSearchButtonClicked:(UISearchBar *)categorySearchBar {
    _filteredDecksArray = [[ETGPDFModelController sharedModel] searchCategoriesForPDFFilesWithSearchParameters:categorySearchBar.text];
    _isDecks = YES;
    [categorySearchBar resignFirstResponder];
    if (_filteredDecksArray.count) {
        _categoryNavigation.title = categorySearchBar.text;
    } else {
        _categoryNavigation.title = @"Results";
    }
    [self.decksTableView reloadData];
}

/* Sets the corresponding action when the download button in the PDF Reader or Table View is clicked. */
- (void)downloadButtonPressed:(UIButton *)downloadButton {
    
    NSIndexPath *indexPath;
    NSString *fileId;
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    CGPoint buttonPosition = [downloadButton convertPoint:CGPointZero toView:self.decksTableView];

    //Fullscreen
    if (downloadButton.tag == 993) {
        if (_isRecentDecks) {
            //For Collection View
            indexPath = _downloadIndexPath;
            _pdfFilePath = [[ETGPDFModelController sharedModel] checkIfFileExistsWithDecks:_recentDecksArray andArrayIndex:indexPath.row];
            fileId = [[_recentDecksArray objectAtIndex:indexPath.row] valueForKey:@"fileId"];
        } else {
            //For Table View
            indexPath = _downloadIndexPath;
            _pdfFilePath = [[ETGPDFModelController sharedModel] checkIfFileExistsWithDecks:_filteredDecksArray andArrayIndex:indexPath.row];
            fileId = [[_filteredDecksArray objectAtIndex:indexPath.row] valueForKey:@"fileId"];
        }
    } else {
        //For Table View
        CGPoint buttonPosition = [downloadButton convertPoint:CGPointZero toView:self.decksTableView];
        indexPath = [self.decksTableView indexPathForRowAtPoint:buttonPosition];
        _pdfFilePath = [[ETGPDFModelController sharedModel] checkIfFileExistsWithDecks:_filteredDecksArray andArrayIndex:indexPath.row];
        
        fileId = [[_filteredDecksArray objectAtIndex:indexPath.row] valueForKey:@"fileId"];
        
        NSString *pdfDocPath = [[ETGPDFModelController sharedModel] getFilePathInDocumentsPDFDirectory:_filteredDecksArray andArrayIndex:indexPath.row];
        
        _pdfFileTempPath = [[ETGPDFModelController sharedModel] getFilePathInCacheTempDirectory:_filteredDecksArray andArrayIndex:indexPath.row];
        
        if ([PDFCheckFile isPDFExist:_pdfFilePath]) {
            // Indicate that file is for offline use. File should be present in Documents directory
        } else {
            _collectionViewNavigation.title = [[[[_filteredDecksArray objectAtIndex:indexPath.row] objectForKey:@"fileName"] lastPathComponent] stringByDeletingPathExtension];
            [_imagesArray removeAllObjects];
            
            
            [[ETGPDFModelController sharedModel] downloadPdfFileWithIndexPath:indexPath decksArray:_filteredDecksArray andFilePath:_pdfFileTempPath success:^(bool done) {
                
                // Update database to indicate if the file is available for offline use.
                [[ETGPDFModelController sharedModel] updateDecksForOfflineUseWithFileId:fileId];
                
                
                // Set the download image button to indicate if file is available for offline use
                [downloadButton setImage:[UIImage imageNamed:@"pdf_download"] forState:UIControlStateNormal];
                [ETGAlert sharedAlert].alertDescription = [NSString stringWithFormat:@"%@%@", pdfFeatureAlert, deckOfflineAvailableAlert];
                [[ETGAlert sharedAlert] showDownloadDeckAlert];
                
                // Reload Downloaded Decks TableView
                if ([self.categoryNavigation.title isEqualToString:@"Downloaded Decks"]) {
                    _filteredDecksArray = [[ETGPDFModelController sharedModel] findDecksWithCategory:[[[ETGPDFModelController sharedModel] uniqueCategories] objectAtIndex:indexPath.section] andSubCategory:self.categoryNavigation.title];
                    [self.decksTableView reloadData];
                    [self.decksCollectionView reloadData];
                }
                
                [ETGAlert sharedAlert].deckAlertShown = NO;
                
                // Moves file to either Documents/Cache path depending on its original path
                _pdfFilePath = pdfDocPath;
                //                    NSString *destPath = [[ETGPDFModelController sharedModel] checkDestPathWithOriginPath:_pdfFilePath];
                [fileManager moveItemAtPath:_pdfFileTempPath toPath:_pdfFilePath error:NULL];
                
                [_appDelegate performSelector:@selector(stopActivityIndicatorSmall) withObject:self afterDelay:0];
                
            } failure:^(NSError *error) {
                if (error.code != -999) {//operation cancel error code
                [ETGAlert sharedAlert].alertDescription = [NSString stringWithFormat:@"%@%@", pdfFeatureAlert, error.localizedDescription];
                [[ETGAlert sharedAlert] showDownloadDeckAlert];
                [ETGAlert sharedAlert].deckAlertShown = NO;
                
                }
                
                [_appDelegate performSelector:@selector(stopActivityIndicatorSmall) withObject:self afterDelay:0];
            }];
            
        }
    }
    
    if ([PDFCheckFile isPDFExist:_pdfFilePath]) {
        // Update database to indicate if the file is available for offline use.
        [[ETGPDFModelController sharedModel] updateDecksForOfflineUseWithFileId:fileId];
        
        // Set the download image button to indicate if file is available for offline use
        if (![[ETGPDFModelController sharedModel] isFileAvailableOffline:_pdfFilePath]) {
            [downloadButton setImage:[UIImage imageNamed:@"pdf_download"] forState:UIControlStateNormal];
            [ETGAlert sharedAlert].alertDescription = [NSString stringWithFormat:@"%@%@", pdfFeatureAlert, deckOfflineAvailableAlert];
            [[ETGAlert sharedAlert] showDownloadDeckAlert];
        } else {
            [downloadButton setImage:[UIImage imageNamed:@"pdf_download_grey"] forState:UIControlStateNormal];
            [ETGAlert sharedAlert].alertDescription = [NSString stringWithFormat:@"%@%@", pdfFeatureAlert, deckOfflineNotAvailableAlert];
            [[ETGAlert sharedAlert] showDownloadDeckAlert];
        }
        
        // Moves file to either Documents/Cache path depending on its original path
        NSString *destPath = [[ETGPDFModelController sharedModel] checkDestPathWithOriginPath:_pdfFilePath];
        [fileManager moveItemAtPath:_pdfFilePath toPath:destPath error:NULL];
        
        // Reload Downloaded Decks TableView
        if (downloadButton.tag == 993) {
//            [readerVC dismissViewControllerAnimated:NO completion:^{
//               [self viewPdfWithFilePath:destPath startPageNumber:1];
//            }];
        }
        else{
            [self refreshDownloadDecks];
        }
        
        [[ETGPDFModelController sharedModel] setPdfFilePathInUse:destPath];
        
        [ETGAlert sharedAlert].deckAlertShown = NO;
    }
}

- (void)refreshDownloadDecks
{
    if ([self.categoryNavigation.title isEqualToString:@"Downloaded Decks"]) {
        _filteredDecksArray = [[ETGPDFModelController sharedModel] findDecksWithCategory:@"Downloaded Decks" andSubCategory:self.categoryNavigation.title];
        [self.decksTableView reloadData];
        
        [_imagesArray removeAllObjects];
        [self.decksCollectionView reloadData];
    }
}


#pragma mark - Long Press Gesture
/* Long Press Gesture for Table and Collection View */
-(void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    CGPoint gesturePoint;
    NSString *pdfName;
    NSString *gestureView = [NSString stringWithFormat:@"%@",[gestureRecognizer valueForKey:@"view"]];
    NSRange range = [gestureView rangeOfString:@"UICollectionView"];
    if (range.location != NSNotFound) {
        //Recent Decks
        gesturePoint = [gestureRecognizer locationInView:_decksCollectionView];
        NSIndexPath *indexPath = [_decksCollectionView indexPathForItemAtPoint:gesturePoint];
        UICollectionViewCell *cell = [_decksCollectionView cellForItemAtIndexPath:indexPath];
        
        if (indexPath != nil) {
            pdfName = [[[[_recentDecksArray objectAtIndex:indexPath.row] objectForKey:@"fileName"] lastPathComponent] stringByDeletingPathExtension];
            NSString *pdfCategory = [[ETGPDFModelController sharedModel] getCategoryForLongTapGestureWithRecentDecks:_recentDecksArray andArrayIndex:indexPath.row];
            NSString *reportingMonth = [[_recentDecksArray objectAtIndex:indexPath.row] objectForKey:@"reportingMonth"];
            
            if (pdfName.length > 11 | pdfCategory.length > 11 | reportingMonth.length > 11 ) {
                if (popoverController) {
                    [self dismissPopoverController];
                    popoverController = nil;
                }
                /** Sets the properties of the popover. **/
                popoverController = [[ETGDecksLayoutModelController sharedModel] formatPopoverWithFileName:pdfName category:pdfCategory andReportingMonth:reportingMonth];
                popoverController.passthroughViews = [NSArray arrayWithObject:_decksCollectionView];
                popoverController = [[ETGDecksLayoutModelController sharedModel] formatPopoverLocationWithEndColumn:indexPath.row popoverController:popoverController andCell:cell];
            }
        }
    } else {
        //Category & SubCategory
        gesturePoint = [gestureRecognizer locationInView:_decksTableView];
        NSIndexPath *indexPath = [_decksTableView indexPathForRowAtPoint:gesturePoint];
        UITableViewCell *cell = [_decksTableView cellForRowAtIndexPath:indexPath];
        if (indexPath != nil) {
            NSString *popoverContent;
            if (!_isDecks & !_monthsCategories.hidden) {
                //Months or Category
                popoverContent = cell.textLabel.text;
                if (popoverContent.length > 29) {
                    if (popoverController) {
                        [self dismissPopoverController];
                        popoverController = nil;
                    }
                    /** Sets the properties of the popover. **/
                    popoverController = [[ETGDecksLayoutModelController sharedModel] formatPopoverWithSingleString:popoverContent];
                    popoverController.passthroughViews = [NSArray arrayWithObject:_decksCollectionView];
                    popoverController = [[ETGDecksLayoutModelController sharedModel] formatPopoverLocationWithEndColumn:indexPath.row popoverController:popoverController andTableCell:cell];
                }
            } else {
                //Subcategory
                popoverContent = [[[[_filteredDecksArray objectAtIndex:indexPath.row] objectForKey:@"fileName"] lastPathComponent] stringByDeletingPathExtension];
                if (popoverContent.length > 10) {
                    if (popoverController) {
                        [self dismissPopoverController];
                        popoverController = nil;
                    }
                    /** Sets the properties of the popover. **/
                    popoverController = [[ETGDecksLayoutModelController sharedModel] formatPopoverWithSingleString:popoverContent];
                    popoverController.passthroughViews = [NSArray arrayWithObject:_decksCollectionView];
                    popoverController = [[ETGDecksLayoutModelController sharedModel] formatPopoverLocationWithEndColumn:indexPath.row popoverController:popoverController andTableCell:cell];
                }
            }
        }
    }
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissPopoverController) userInfo:nil repeats:NO];
}

/* Long Press Gesture for Category Navigation Bar */
-(void) handleLongPressGestureForNavBar:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (_categoryNavigation.title != nil) {
        if (_categoryNavigation.title.length > 10) {
            if (popoverController) {
                [self dismissPopoverController];
                popoverController = nil;
            }
            popoverController = [[ETGDecksLayoutModelController sharedModel] formatPopoverWithSingleString:_categoryNavigation.title];
            popoverController.passthroughViews = [NSArray arrayWithObject:_decksCollectionView];
            CGRect rect = CGRectMake(_categoryNavBar.bounds.origin.x + 190, _categoryNavBar.bounds.origin.y + 10, 50, 30);
            
            [popoverController presentPopoverFromRect:rect inView:_categoryNavBar.viewForBaselineLayout
                             permittedArrowDirections:UIPopoverArrowDirectionLeft animated:NO];
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissPopoverController) userInfo:nil repeats:NO];
        }
    }
}

/* Dismiss popover for Long Press Gestures */
-(void) dismissPopoverController {
    [popoverController dismissPopoverAnimated:YES];
}

@end
