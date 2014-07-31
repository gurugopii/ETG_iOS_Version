//
//  ETGETGManpowerBaseFiltersViewController.m
//  ETG
//
//  Created by Helmi Hasan on 2/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGETGManpowerBaseFiltersViewController.h"
#import "ETGManpowerAHCFilterViewController.h"
#import "ETGManpowerViewController.h"
#import "ETGSectionHeaderView.h"
#import "Reachability.h"
#import "ETGManPowerModelController.h"
#import "ETGManpowerHCRFilterViewController.h"
#import "ETGManpowerLRFilterViewController.h"

@interface ETGETGManpowerBaseFiltersViewController ()<SectionHeaderViewDelegate>
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic) BOOL hasConnection;
@property (nonatomic, strong) NSString *latestSelectedReportingMonthString;
@end

@implementation ETGETGManpowerBaseFiltersViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupReachability];
    [self updateDisplayAccordingToConnection];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishDownloadingFilterForNewReportingMonth) name:kDownloadFilterDataForManpowerCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterForSelectedReportingMonth) name:kDownloadManpowerShouldAutoRefresh object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterForSelectedReportingMonthWithErrorLoadingMessage) name:kDownloadManpowerFilterDataForGivenReportingMonthFailed object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadManpowerFilterDataForGivenReportingMonthFailed object:nil];
    [self.delegate filtersviewControllerDidDismiss:[self currentSelectedSectionRows] withSender:self];
}

- (void)enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:(BOOL)isEnable
{
    for (ETGSectionInfo *sectionInfo in self.sectionInfoArray)
    {
        [sectionInfo.headerView setUserInteractionEnabled:YES];
        sectionInfo.headerView.alpha = 1.0;
    }
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    
    self.navigationItem.rightBarButtonItem = self.applyBarButton;
    if (isEnable)
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    [self updateDisplayAccordingToConnection];
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
        self.hasConnection = YES;
        self.tableFooterView.hidden = YES;
        if([self IsAtLeastOneOptionIsSelected])
        {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    }
    else
    {
        self.hasConnection = NO;
    }
}

- (void)initSectionInfoValues
{
	if ((self.sectionInfoArray == nil) || ([self.sectionInfoArray count] != [self numberOfSectionsInTableView:self.tableView]))
    {
        [self initManpowerSectionInfoValues];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETGSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    
    if (sectionInfo.singleChoice == YES)
    {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        if ([sectionInfo.selectedRows count] > 0)
        {
            [sectionInfo.selectedRows replaceObjectAtIndex:0 withObject:@(indexPath.row)];
        }
        else
        {
            [sectionInfo.selectedRows addObject:@(indexPath.row)];
        }
        [sectionInfo.headerView toggleOpenWithUserAction:YES];
    }
    else
    {
        
        if (indexPath.row == 0)
        {
            //Handle select all
            [sectionInfo.selectedRows removeAllObjects];
            for (NSInteger i = 0; i < [sectionInfo.values count]; i++)
            {
                [sectionInfo.selectedRows addObject:@(i + 1)];
            }
            
            NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < [sectionInfo.selectedRows count]; i++)
            {
                [indexPathsToReload addObject:[NSIndexPath indexPathForRow:(i + 1) inSection:indexPath.section]];
            }
            [tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationNone];
        }
        else
        {
            [sectionInfo.selectedRows addObject:@(indexPath.row)];
            //Check selection state of SelectAll cell
            if ([sectionInfo.selectedRows count] == [sectionInfo.values count])
            {
                [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
        }
    }
    
    [self updateApplyButtonBasedOnSelectionInIndexPath:indexPath];
    
    //at least one is selected
    self.navigationItem.rightBarButtonItem.enabled = [self IsAtLeastOneOptionIsSelected];
    
    [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    if (self.navigationItem.leftBarButtonItem != self.defaultBarButton)
    {
        self.navigationItem.leftBarButtonItem = self.defaultBarButton;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETGSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    
    if(sectionInfo.singleChoice == NO)
    {
        if (indexPath.row == 0)
        {
            NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < [sectionInfo.selectedRows count]; i++) {
                [indexPathsToReload addObject:[NSIndexPath indexPathForRow:(i + 1) inSection:indexPath.section]];
            }
            [sectionInfo.selectedRows removeAllObjects];
            [tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationNone];
        }
        else
        {
            [sectionInfo.selectedRows removeObject:@(indexPath.row)];
            //Check selection state of SelectAll cell
            if ([sectionInfo.selectedRows count] != [sectionInfo.values count])
            {
                [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] animated:YES];
            }
        }
    }
    
    [self updateApplyButtonBasedOnSelectionInIndexPath:indexPath];
    
    //at least one is selected
    self.navigationItem.rightBarButtonItem.enabled = [self IsAtLeastOneOptionIsSelected];
    
    [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    if (self.navigationItem.leftBarButtonItem != self.defaultBarButton)
    {
        self.navigationItem.leftBarButtonItem = self.defaultBarButton;
    }
}

-(void)updateApplyButtonBasedOnSelectionInIndexPath:(NSIndexPath*)indexPath
{
    //apply for all 3 modules
    //update section, if department changes.
    if (indexPath.section == [self getDepartmentSection] && ([self isKindOfClass:[ETGManpowerAHCFilterViewController class]] || [self isKindOfClass:[ETGManpowerHCRFilterViewController class]] || [self isKindOfClass:[ETGManpowerLRFilterViewController class]]))
    {
        [self updateSectionSection];
    }
    
    //apply to HCR
    if (([self isKindOfClass:[ETGManpowerHCRFilterViewController class]]))
    {
        
        if ( indexPath.section == [self getRegionSection] )
        {
            [self updateClusterSection];
            [self updateProjectPositionSection];
        }
        
        //update project position, if Cluster changes
        else if (indexPath.section == [self getClusterSection])
        {
            [self updateProjectPositionSection];
        }
    }
    
    //apply to LR
    if (([self isKindOfClass:[ETGManpowerLRFilterViewController class]]))
    {
        //if region changes, update cluster section
        if ( indexPath.section == [self getRegionSection] )
        {
            [self updateClusterSection];
            [self updateProjectSection];
            [self updateProjectPositionSection];
        }
        else if (indexPath.section == [self getClusterSection])
        {
            [self updateProjectSection];
            [self updateProjectPositionSection];
        }
        //if project changes, update project position
        else if (indexPath.section == [self getProjectSection])
        {
            [self updateProjectPositionSection];
        }
    }
    
}
- (IBAction)handleDefaultBarButtonPressed:(UIBarButtonItem *)sender
{
    for (ETGSectionInfo *sectionInfo in self.sectionInfoArray)
    {
        if (sectionInfo.headerView.disclosureButton.selected)
        {
            [sectionInfo.headerView toggleOpenWithUserAction:YES];
        }
        [sectionInfo.selectedRows removeAllObjects];
    }
    
    [self setDefaultSelectionForOtherSection];
    [self updateAllSections];
    [self.tableView reloadData];
    
    self.navigationItem.leftBarButtonItem = self.cancelBarButton;
}

-(BOOL)IsAtLeastOneOptionIsSelected
{
    
    for (ETGSectionInfo *sectionInfo in self.sectionInfoArray)
    {
        if (sectionInfo.selectedRows.count ==0 && sectionInfo.singleChoice == NO)
            return NO;
    }
    
    return YES;
    
}

- (void)reloadFilterForSelectedReportingMonth
{
    self.shouldUpdateFilterErrorMessage = NO;
    
    [self updateAllSections];
}

- (void)reloadFilterForSelectedReportingMonthWithErrorLoadingMessage
{
    self.shouldUpdateFilterErrorMessage = YES;
    self.tableFooterView.hidden = NO;
    self.navigationItem.rightBarButtonItem = self.applyBarButton;
}

-(ManpowerTab)getCurrentTab
{
    if([self isKindOfClass:[ETGManpowerAHCFilterViewController class]])
    {
        return ManpowerTabAHC;
    }
    else if([self isKindOfClass:[ETGManpowerHCRFilterViewController class]])
    {
        return ManpowerTabHCR;
    }
    else
    {
        return ManpowerTabLR;
    }
}

-(void)finishDownloadingFilterForNewReportingMonth
{
    //Check offline data
    NSArray *fetchedProjectObjects = [self filterProjectList];
    if ([fetchedProjectObjects count] > 0) {
        
        //Reload
        [self reloadAllSections];
        [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
    } else {
        //Download new data from server
        [self disableUserInteractionOnAllSectionExceptReportingMonthSection];
        
        // Online mode
        [[ETGManPowerModelController sharedModel] getAhcForReportingMonth:self.latestSelectedReportingMonthString isManualRefresh:NO success:^(NSString *jsonString) {
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
            if ([jsonString isEqualToString:@"no data"])
            {
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
            else{
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
        } failure:^(NSError *error) {
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
        }];
    }
}

- (void)getProjectBaseFiltersDataForReportingMonth:(NSTimer *)sender
{
    ETGSectionInfo *reportingMonthSection = self.sectionInfoArray[0];
    NSDate *previousSelectedDate = reportingMonthSection.selectedRows[0];
    NSDate *selectedDate = sender.userInfo;
    if (![selectedDate isEqualToDate:previousSelectedDate])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
        [reportingMonthSection.selectedRows replaceObjectAtIndex:0 withObject:selectedDate];
        
        // Get latest filter
        self.latestSelectedReportingMonthString = [self.dateFormatter stringFromDate:selectedDate];
        [[ETGFilterModelController sharedController] getManpowerFilter:self.latestSelectedReportingMonthString reportType:[self getCurrentTab] isFromFilter:YES];
    } else {
        [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
    }
}

-(void)updateDisplayAccordingToConnection
{
    ETGManpowerViewController *manpower = (ETGManpowerViewController *)self.delegate;
    BOOL needRefresh = [manpower needRefreshWithProjectDictionary:[self getProjectsDictionary]];
    if(needRefresh && !self.hasConnection)
    {
        self.tableFooterView.hidden = NO;
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else
    {
        self.tableFooterView.hidden = YES;
        if([self IsAtLeastOneOptionIsSelected])
        {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
        else
        {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ETGSectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderViewIdentifier];
    sectionHeaderView.delegate = self;
    sectionHeaderView.section = section;
    
    ETGSectionInfo *sectionInfo = self.sectionInfoArray[section];
    sectionHeaderView.categoryLabel.text = sectionInfo.name;
    sectionInfo.headerView = sectionHeaderView;
    sectionInfo.section = section;
    
    if (section == [self getReportingPeriodSection])
    {
        if(self.openSectionIndex == section)
        {
            sectionInfo.headerView.disclosureButton.selected = YES;
        }
        else
        {
            sectionInfo.headerView.disclosureButton.selected = NO;
        }
        if ([sectionInfo.selectedRows count] > 0)
        {
            [self updateSelectedReportingMonthValueLabel:sectionInfo.selectedRows[0]];
        }
        else
        {
            [self updateSelectedReportingMonthValueLabel:[NSDate date]];
        }
    }
    else
    {
        [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    }
    
    return sectionHeaderView;
}

- (void)reloadAllSections {
    for (int section=0; section<[self.sectionInfoArray count]; section++) {
        NSIndexSet *reloadSectionsIndexSet = [[NSIndexSet alloc] initWithIndex:section];
        [self.tableView reloadSections:reloadSectionsIndexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Abstract Method

- (void)initManpowerSectionInfoValues
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

- (void)setDefaultSelectionForOtherSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(int)getYearSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(int)getDepartmentSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(int)getSectionSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(int)getRegionSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}
-(int)getProjectSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}
-(int)getClusterSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(int)getProjectPositionSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(int)getReportingPeriodSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(NSMutableDictionary *)getProjectsDictionary
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(NSArray *)filterProjectList
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(void)updateSectionSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(void)updateDepartmentSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(void)updateYearSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(void)updateRegionSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}
-(void)updateClusterSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(void)updateProjectSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(void)updateProjectPositionSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}
-(void)updateAllSections
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}
@end