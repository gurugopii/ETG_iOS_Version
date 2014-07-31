//
//  ETGETGEccrBaseFiltersViewController.m
//  ETG
//
//  Created by Tan Aik Keong on 1/28/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGETGEccrBaseFiltersViewController.h"
#import "ETGEccrCpsFiltersViewController.h"
#import "ETGEccrAbrFiltersViewController.h"
#import "ETGEccrCpbFiltersViewController.h"
#import "ETGSectionHeaderView.h"
#import "Reachability.h"

@interface ETGETGEccrBaseFiltersViewController ()<SectionHeaderViewDelegate>
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic) BOOL hasConnection;
@end

@implementation ETGETGEccrBaseFiltersViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupReachability];
    [self updateDisplayAccordingToConnection];
}

- (void)viewWillAppear:(BOOL)animated
{    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterForSelectedReportingMonth) name:kDownloadEccrShouldAutoRefresh object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterForSelectedReportingMonthWithErrorLoadingMessage) name:kDownloadEccrFilterDataForGivenReportingMonthFailed object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadEccrFilterDataForGivenReportingMonthFailed object:nil];    
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
        if([self canEnableApplyButton])
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
        [self initEccrSectionInfoValues];
	}
}

- (void)initEccrSectionInfoValues
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

- (void)setDefaultSelectionForOtherSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(int)getOperatorShipSection
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

-(int)getBudgetHolderSection
{
    @throw [NSException exceptionWithName:@"Not implemented" reason:nil userInfo:nil];
}

-(int)getReportingMonthSection
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

-(void)updateProjectSection
{
    ETGSectionInfo *projectSection = [self.sectionInfoArray objectAtIndex:[self getProjectSection]];
    [self clearAllValueOfSection:projectSection];
    
    NSArray *fetchedProjectObjects = [self filterProjectList];
    if ([fetchedProjectObjects count] > 0)
    {
        [projectSection.values addObjectsFromArray:fetchedProjectObjects];
        [self setDefaultSelectionForProjectSection:projectSection];        
        [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
    }
    else
    {
        [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:NO];
    }
    
    [self updateDisplayAccordingToConnection];
    [self reloadSectionAtIndex:[self getProjectSection]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETGSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    
    if (sectionInfo.singleChoice == YES)
    {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        if ([sectionInfo.selectedRows count] > 0)
        {
            NSIndexPath *deselectIndexPath = [NSIndexPath indexPathForRow:[sectionInfo.selectedRows[0] integerValue] inSection:indexPath.section];
            [tableView deselectRowAtIndexPath:deselectIndexPath animated:YES];
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
    
    if (indexPath.section == [self getProjectSection])
    {
        NSMutableArray *selectedProjects = [[NSMutableArray alloc] init];
        for (NSNumber *row in sectionInfo.selectedRows)
        {
            if(sectionInfo.singleChoice)
            {
                [selectedProjects addObject:[sectionInfo.values objectAtIndex:([row integerValue])]];
            }
            else
            {
                [selectedProjects addObject:[sectionInfo.values objectAtIndex:([row integerValue] - 1)]];
            }
        }
        self.navigationItem.rightBarButtonItem.enabled = sectionInfo.selectedRows.count > 0 ? YES : NO;
        if([self isKindOfClass:[ETGEccrCpsFiltersViewController class]])
        {
            [self updateDisplayAccordingToConnection];
        }
    }
    else if ([self isKindOfClass:[ETGEccrCpbFiltersViewController class]] && indexPath.section == [self getRegionSection])
    {
        [self updateProjectSection];
    }
    else if (([self isKindOfClass:[ETGEccrCpbFiltersViewController class]] || [self isKindOfClass:[ETGEccrAbrFiltersViewController class]]) && indexPath.section == [self getRegionSection])
    {
        [self updateProjectSection];
    }
    else if([self isKindOfClass:[ETGEccrCpbFiltersViewController class] ] && indexPath.section == [self getOperatorShipSection])
    {
        [self updateProjectSection];
    }
    else if([self isKindOfClass:[ETGEccrCpbFiltersViewController class] ] && indexPath.section == [self getBudgetHolderSection])
    {
        [self updateDisplayAccordingToConnection];
    }
    
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
    
    if (indexPath.section == [self getProjectSection])
    {
        self.navigationItem.rightBarButtonItem.enabled = sectionInfo.selectedRows.count > 0 ? YES : NO;
    }
    else if ([self isKindOfClass:[ETGEccrCpbFiltersViewController class]] && indexPath.section == [self getRegionSection])
    {
        [self updateProjectSection];
    }
    else if (([self isKindOfClass:[ETGEccrCpbFiltersViewController class]] || [self isKindOfClass:[ETGEccrAbrFiltersViewController class]]) && indexPath.section == [self getRegionSection])
    {
        [self updateProjectSection];
    }
    else if([self isKindOfClass:[ETGEccrCpbFiltersViewController class] ] && indexPath.section == [self getOperatorShipSection])
    {
        [self updateProjectSection];
    }
    
    [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    if (self.navigationItem.leftBarButtonItem != self.defaultBarButton)
    {
        self.navigationItem.leftBarButtonItem = self.defaultBarButton;
    }
}

- (void)reloadFilterForSelectedReportingMonth
{
    self.shouldUpdateFilterErrorMessage = NO;
    //[self updateProjectSection];
}

- (void)reloadFilterForSelectedReportingMonthWithErrorLoadingMessage
{
    self.shouldUpdateFilterErrorMessage = YES;
    self.tableFooterView.hidden = NO;
    self.navigationItem.rightBarButtonItem = self.applyBarButton;
}

- (void)getProjectBaseFiltersDataForReportingMonth:(NSTimer *)sender
{
    ETGSectionInfo *reportingMonthSection = self.sectionInfoArray[[self getReportingMonthSection]];
    NSDate *previousSelectedDate = reportingMonthSection.selectedRows[0];
    NSDate *selectedDate = sender.userInfo;
    if (![selectedDate isEqualToDate:previousSelectedDate])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
        [reportingMonthSection.selectedRows replaceObjectAtIndex:0 withObject:selectedDate];
        
        ETGSectionInfo *projectSection = [self.sectionInfoArray objectAtIndex:[self getProjectSection]];
        ETGProject *selectedProject = nil;
        if(projectSection.singleChoice && [projectSection.selectedRows count] > 0)
        {
            NSNumber *index = projectSection.selectedRows[0];
            if([index integerValue] != NSNotFound)
            {
                selectedProject = projectSection.values[[index integerValue]];
            }
        }
        
        NSArray *fetchedProjectObjects = [self filterProjectList];
        if ([fetchedProjectObjects count] > 0)
        {
            if(projectSection.singleChoice)
            {
                [self clearAllValueOfSection:projectSection];
                [projectSection.values addObjectsFromArray:fetchedProjectObjects];
                if(selectedProject != nil)
                {
                    int index = [projectSection.values indexOfObject:selectedProject];
                    if(index == NSNotFound)
                    {
                        [projectSection.selectedRows addObject:@(0)];                        
                    }
                    else
                    {
                        [projectSection.selectedRows addObject:@(index)];
                    }
                }
                else
                {
                    [projectSection.selectedRows addObject:@(0)];
                }
            }
            else
            {
                NSMutableArray *temp = [NSMutableArray new];
                BOOL isPreviouslySelectAll = NO;
                if([projectSection.selectedRows count] == [projectSection.values count])
                {
                    isPreviouslySelectAll = YES;
                }
                for(NSNumber *n in projectSection.selectedRows)
                {
                    [temp addObject:projectSection.values[[n integerValue] - 1]];
                }
                [self clearAllValueOfSection:projectSection];
                [projectSection.values addObjectsFromArray:fetchedProjectObjects];
                
                if([temp count] > 0 && !isPreviouslySelectAll)
                {
                    for(ETGProject *p in temp)
                    {
                        int index = [projectSection.values indexOfObject:p];
                        if(index  != NSNotFound)
                        {
                            [projectSection.selectedRows addObject:@(index + 1)];
                        }
                    }
                }
                else
                {
                    [self setDefaultSelectionForProjectSection:projectSection];
                }
            }
            //Reload
            [self reloadSectionAtIndex:[self getProjectSection]];
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
        }
        else
        {
            //Reload
            [self clearAllValueOfSection:projectSection];
            [self reloadSectionAtIndex:[self getProjectSection]];
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:NO];
        }
        [self updateDisplayAccordingToConnection];
    }
    else
    {
        if([self canEnableApplyButton])
        {
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
        }
        else
        {
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:NO];
        }
    }
}

-(void)updateDisplayAccordingToConnection
{
    ETGEccrViewController *eccr = (ETGEccrViewController *)self.delegate;
    BOOL needRefresh = [eccr needRefreshWithProjectDictionary:[self getProjectsDictionary]];
    if(needRefresh && !self.hasConnection)
    {
        self.tableFooterView.hidden = NO;
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else
    {
        self.tableFooterView.hidden = YES;
        if([self canEnableApplyButton])
        {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
        else
        {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    }
}

-(BOOL)canEnableApplyButton
{
    ETGSectionInfo *projectSection = [self.sectionInfoArray objectAtIndex:[self getProjectSection]];
    if([projectSection.selectedRows count] > 0)
    {
        return YES;
    }
    return NO;
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
    [self updateProjectSection];
    [self.tableView reloadData];
    
    self.navigationItem.leftBarButtonItem = self.cancelBarButton;
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
    
    if (section == [self getReportingMonthSection])
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

@end
