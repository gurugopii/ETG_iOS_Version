//
//  ETGMapViltersViewController.m
//  ETG
//
//  Created by Tan Aik Keong on 12/31/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGMapFiltersViewController.h"
#import "ETGRegion.h"
#import "ETGCluster.h"
#import "ETGFilterModelController.h"
#import "ETGMapSection.h"
#import "ETGMapModelController.h"

enum section {
    kREPORTINGPERIOD,
    kREGION,
    kCLUSTER,
    KPROJECT,
    kSPEED,
    kDURATION,
};

@interface ETGMapFiltersViewController ()<SectionHeaderViewDelegate>

@end

@implementation ETGMapFiltersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterForSelectedReportingMonth) name:kDownloadMapFilterDataForGivenReportingMonthCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterForSelectedReportingMonthWithErrorLoadingMessage) name:kDownloadMapFilterDataForGivenReportingMonthFailed object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadMapFilterDataForGivenReportingMonthCompleted object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadMapFilterDataForGivenReportingMonthFailed object:nil];
    
    [self.delegate filtersviewControllerDidDismiss:[self currentSelectedSectionRows]];
}

- (void)initSectionInfoValues
{
	if ((self.sectionInfoArray == nil) || ([self.sectionInfoArray count] != [self numberOfSectionsInTableView:self.tableView]))
    {
        [self initMapSectionInfoValues];
	}
}

- (void)initMapSectionInfoValues {
    ETGSectionInfo *reportingPeriodSectionInfo = [[ETGSectionInfo alloc] init];
    reportingPeriodSectionInfo.name = @"Reporting Period";
    reportingPeriodSectionInfo.singleChoice = YES;
    reportingPeriodSectionInfo.open = YES;
    reportingPeriodSectionInfo.values = [[NSMutableArray alloc] init];
    reportingPeriodSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *regionSectionInfo = [[ETGSectionInfo alloc] init];
    regionSectionInfo.name = @"Region";
    regionSectionInfo.singleChoice = NO;
    regionSectionInfo.open = NO;
    regionSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGRegion" sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    regionSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *clusterSectionInfo = [[ETGSectionInfo alloc] init];
    clusterSectionInfo.name = @"Cluster";
    clusterSectionInfo.singleChoice = NO;
    clusterSectionInfo.open = NO;
    clusterSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGCluster" sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    clusterSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *speedSectionInfo = [[ETGSectionInfo alloc] init];
    speedSectionInfo.name = @"Speed";
    speedSectionInfo.singleChoice = NO;
    speedSectionInfo.open = NO;
    speedSectionInfo.values = [ETGMapSection getSpeedValues];
    speedSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *durationSectionInfo = [[ETGSectionInfo alloc] init];
    durationSectionInfo.name = @"Duration";
    durationSectionInfo.singleChoice = NO;
    durationSectionInfo.open = NO;
    durationSectionInfo.values = [ETGMapSection getDurationValues];
    durationSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    //Set selected rows
    if ([self.selectedRowsInFilter count] > 0) {
        //set last selected rows in sections
        [reportingPeriodSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kREPORTINGPERIOD]];
        [regionSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kREGION]];
        [clusterSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kCLUSTER]];
        [speedSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kSPEED]];
        [durationSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kDURATION]];
    } else {
        [self setDefaultSelectionForReportingMonthSection:reportingPeriodSectionInfo regionSection:regionSectionInfo clusterSection:clusterSectionInfo speedSection:speedSectionInfo durationSection:durationSectionInfo];
    }
    
    self.sectionInfoArray = [[NSMutableArray alloc] init];
    [self.sectionInfoArray addObject:reportingPeriodSectionInfo];
    [self.sectionInfoArray addObject:regionSectionInfo];
    [self.sectionInfoArray addObject:clusterSectionInfo];
    
    if([regionSectionInfo.selectedRows count] > 0)
    {
        [self clearAllValueOfSection:clusterSectionInfo];
        
        NSArray *fetchedObjects = [self filterClusterList];
        if ([fetchedObjects count] > 0)
        {
            [clusterSectionInfo.values addObjectsFromArray:fetchedObjects];
            [self setDefaultSelectionForAnySection:clusterSectionInfo];
        }
    }
    
    ETGSectionInfo *projectSectionInfo = [[ETGSectionInfo alloc] init];
    projectSectionInfo.name = @"Project";
    projectSectionInfo.open = NO;
    projectSectionInfo.values = [NSMutableArray arrayWithArray:[self filterProjectList]];
    projectSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    projectSectionInfo.singleChoice = NO;
    
    //Set selected rows for Project
    if ([self.selectedRowsInFilter count] > 0) {
        [projectSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[KPROJECT]];
    } else {
        [self setDefaultSelectionForProjectSection:projectSectionInfo];
    }
    
    [self.sectionInfoArray addObject:projectSectionInfo];    
    [self.sectionInfoArray addObject:speedSectionInfo];
    [self.sectionInfoArray addObject:durationSectionInfo];
    
    //Update Apply bar button
    if(regionSectionInfo.values.count == 0 || projectSectionInfo.selectedRows.count == 0)
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)setDefaultSelectionForReportingMonthSection:(ETGSectionInfo *)reportingPeriodSection
                                      regionSection:(ETGSectionInfo *)regionSection
                                      clusterSection:(ETGSectionInfo *)clusterSection
                                      speedSection:(ETGSectionInfo *)speedSection
                                      durationSection:(ETGSectionInfo *)durationSection
{
    //Reporting Month
    [reportingPeriodSection.selectedRows addObject:[CommonMethods latestReportingMonth]];
    
    //Select all regions
    for (NSInteger i = 0; i < [regionSection.values count]; i++) {
        [regionSection.selectedRows addObject:@(i + 1)];
    }
    
    //Select all clusters
    for (NSInteger i = 0; i < [clusterSection.values count]; i++) {
        [clusterSection.selectedRows addObject:@(i + 1)];
    }
    
    //Select all speeds
    for (NSInteger i = 0; i < [speedSection.values count]; i++) {
        [speedSection.selectedRows addObject:@(i + 1)];
    }
    
    //Select all duration
    for (NSInteger i = 0; i < [durationSection.values count]; i++) {
        [durationSection.selectedRows addObject:@(i + 1)];
    }
}

-(NSArray *)filterProjectList
{
    ETGSectionInfo *reportingMonthSection = self.sectionInfoArray[kREPORTINGPERIOD];
    NSDate *reportingMonth = reportingMonthSection.selectedRows[0];
    NSString *reportingMonthString = [self.dateFormatter stringFromDate:reportingMonth];
    
    NSMutableArray *selectedRegionKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *regionSection = [self.sectionInfoArray objectAtIndex:kREGION];
    for (NSNumber *row in regionSection.selectedRows) {
        ETGRegion *selectedRegion = [regionSection.values objectAtIndex:[row integerValue] - 1];
        [selectedRegionKeys addObject:selectedRegion.key];
    }
    
    NSMutableArray *selectedClusterKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *clusterSection = [self.sectionInfoArray objectAtIndex:kCLUSTER];
    for (NSNumber *row in clusterSection.selectedRows) {
        ETGCluster *selectedCluster = [clusterSection.values objectAtIndex:[row integerValue] - 1];
        [selectedClusterKeys addObject:selectedCluster.key];
    }
    
    NSArray *fetchedProjectObjects =  [ETGMapSection fetchProjectsBaseOnRegions:selectedRegionKeys clusters:selectedClusterKeys reportingMonth:reportingMonthString];
    
    //Update Apply bar button
    self.navigationItem.rightBarButtonItem.enabled = fetchedProjectObjects.count > 0 ? YES : NO;
    
    return fetchedProjectObjects;
}

- (void)updateProjectSection
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
    
    [self reloadSectionAtIndex:[self getProjectSection]];
}

-(void)updateClusterSection
{
    ETGSectionInfo *clusterSection = self.sectionInfoArray[kCLUSTER];
    [self clearAllValueOfSection:clusterSection];
    
    NSArray *fetchedObjects = [self filterClusterList];
    if ([fetchedObjects count] > 0) {
        [clusterSection.values addObjectsFromArray:fetchedObjects];
        [self setDefaultSelectionForAnySection:clusterSection];
    }
    
    [self reloadSectionAtIndex:kCLUSTER];
}
                               
-(NSArray *)filterClusterList
{
    NSMutableArray *selectedRegionKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *regionSection = [self.sectionInfoArray objectAtIndex:kREGION];
    for (NSNumber *row in regionSection.selectedRows) {
        ETGRegion *selectedRegion = [regionSection.values objectAtIndex:[row integerValue] - 1];
        [selectedRegionKeys addObject:selectedRegion.key];
    }
    NSArray *fetchedObjects =  [ETGMapSection fetchClustersBasedOnRegions:selectedRegionKeys];
    return fetchedObjects;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)getProjectSection {
    return KPROJECT;
}

- (IBAction)handleDefaultBarButtonPressed:(UIBarButtonItem *)sender {
    
    for (ETGSectionInfo *sectionInfo in self.sectionInfoArray) {
        //NSLog(@"Section: %@ - OpenStatus: %d", sectionInfo.name, sectionInfo.open);
        if (sectionInfo.headerView.disclosureButton.selected) {
            [sectionInfo.headerView toggleOpenWithUserAction:YES];
        }
        [sectionInfo.selectedRows removeAllObjects];
    }
    
    [self setDefaultSelectionForReportingMonthSection:self.sectionInfoArray[kREPORTINGPERIOD] regionSection:self.sectionInfoArray[kREGION] clusterSection:self.sectionInfoArray[kCLUSTER] speedSection:self.sectionInfoArray[kSPEED] durationSection:self.sectionInfoArray[kDURATION]];
    [self updateClusterSection];    
    [self updateProjectSection];
    [self.tableView reloadData];
    
    self.navigationItem.leftBarButtonItem = self.cancelBarButton;
    [self setIsNoProjectData:NO];
}

- (IBAction)handleApplyBarButtonPressed:(UIBarButtonItem *)sender {
    
    NSMutableDictionary *projectsDictionary = [NSMutableDictionary new];
    
    //Selected Reporting Month
    ETGSectionInfo *reportingMonthSection = [self.sectionInfoArray objectAtIndex:kREPORTINGPERIOD];
    NSDate *selectedReportingMonth = [reportingMonthSection.selectedRows objectAtIndex:0];
    [projectsDictionary setObject:selectedReportingMonth forKey:kSelectedReportingMonth];
    
    //Selected Projects
    NSMutableArray *selectedProjects = [[NSMutableArray alloc] init];
    ETGSectionInfo *projectSection = [self.sectionInfoArray objectAtIndex:[self getProjectSection]];
    for (NSNumber *row in projectSection.selectedRows) {
        ETGProject *selectedProject = [projectSection.values objectAtIndex:[row integerValue] - 1];
        [selectedProjects addObject:selectedProject];
    }
    [projectsDictionary setObject:selectedProjects forKey:kSelectedProjects];
    
    // Selected durations
    NSMutableArray *selectedDurations = [NSMutableArray new];
    ETGSectionInfo *durationSection = [self.sectionInfoArray objectAtIndex:kDURATION];
    for(NSNumber *row in durationSection.selectedRows)
    {
        ETGMapSection *section = [durationSection.values objectAtIndex:[row integerValue] - 1];
        [selectedDurations addObject:section];
    }
    projectsDictionary[kSelectedDurations] = selectedDurations;
    
    // Select speeds
    NSMutableArray *selectedSpeeds = [NSMutableArray new];
    ETGSectionInfo *speedSection = [self.sectionInfoArray objectAtIndex:kSPEED];
    for(NSNumber *row in speedSection.selectedRows)
    {
        ETGMapSection *section = [speedSection.values objectAtIndex:[row integerValue] - 1];
        [selectedSpeeds addObject:section];
    }
    projectsDictionary[kSelectedSpeeds] = selectedSpeeds;
    
    [self.delegate filtersViewControllerDidFinishWithProjectsDictionary:projectsDictionary];
}

- (void)getProjectBaseFiltersDataForReportingMonth:(NSTimer *)sender
{
    ETGSectionInfo *reportingMonthSection = self.sectionInfoArray[kREPORTINGPERIOD];
    NSDate *previousSelectedDate = reportingMonthSection.selectedRows[0];
    NSDate *selectedDate = sender.userInfo;
    if (![selectedDate isEqualToDate:previousSelectedDate])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
        [reportingMonthSection.selectedRows replaceObjectAtIndex:0 withObject:selectedDate];
        
        ETGSectionInfo *projectSection = [self.sectionInfoArray objectAtIndex:KPROJECT];
        [self clearAllValueOfSection:projectSection];
        
        //Check offline data
        NSArray *fetchedProjectObjects = [self filterProjectList];
        if ([fetchedProjectObjects count] > 0) {
            [projectSection.values addObjectsFromArray:fetchedProjectObjects];
            
            for (NSInteger i = 0; i < [projectSection.values count]; i++) {
                [projectSection.selectedRows addObject:@(i + 1)];
            }
            
            //Reload
            [self reloadSectionAtIndex:KPROJECT];
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
        } else {
            //Download new data from server
            NSString *reportingMonthString = [self.dateFormatter stringFromDate:selectedDate];
            [self disableUserInteractionOnAllSectionExceptReportingMonthSection];
            // Online mode
            [[ETGMapModelController sharedModel] getPgdAndPemForReportingMonth:reportingMonthString isManualRefresh:NO success:^(NSString *jsonString) {
            } failure:^(NSError *error) {
                [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
            }];
        }
    } else {
        [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETGSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    
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
    
    if (indexPath.section == [self getProjectSection])
    {
        NSMutableArray *selectedProjects = [[NSMutableArray alloc] init];
        for (NSNumber *row in sectionInfo.selectedRows)
        {
            [selectedProjects addObject:[sectionInfo.values objectAtIndex:([row integerValue] - 1)]];
        }
        self.navigationItem.rightBarButtonItem.enabled = sectionInfo.selectedRows.count > 0 ? YES : NO;
    }
    else if (indexPath.section == kREGION || indexPath.section == kCLUSTER)
    {
        if(indexPath.section == kREGION)
        {
            [self updateClusterSection];
        }
        [self updateProjectSection];
    }
    
    [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    if (self.navigationItem.leftBarButtonItem != self.defaultBarButton)
    {
        self.navigationItem.leftBarButtonItem = self.defaultBarButton;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETGSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) { //Select All row
        //Deselect all
        NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [sectionInfo.selectedRows count]; i++) {
            [indexPathsToReload addObject:[NSIndexPath indexPathForRow:(i + 1) inSection:indexPath.section]];
        }
        [sectionInfo.selectedRows removeAllObjects];
        [tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationNone];
    } else {
        [sectionInfo.selectedRows removeObject:@(indexPath.row)];
        //Check selection state of SelectAll cell
        if ([sectionInfo.selectedRows count] != [sectionInfo.values count]) {
            [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] animated:YES];
        }
    }
    
    if (indexPath.section == [self getProjectSection])
    {
        self.navigationItem.rightBarButtonItem.enabled = sectionInfo.selectedRows.count > 0 ? YES : NO;
    }
    else if (indexPath.section == kREGION || indexPath.section == kCLUSTER)
    {
        [self updateProjectSection];
        if(indexPath.section == kREGION)
        {
            [self updateClusterSection];
        }
    }
    
    [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    if (self.navigationItem.leftBarButtonItem != self.defaultBarButton) {
        self.navigationItem.leftBarButtonItem = self.defaultBarButton;
    }
}

- (void)updateSelectedValuesTitleOnSectionHeaderView:(ETGSectionInfo *)sectionInfo {    
    switch ([sectionInfo.selectedRows count]) {
        case 0:
            sectionInfo.headerView.categoryValueLabel.text = @"";
            break;
        case 1:{
            NSInteger selectedRow = [sectionInfo.selectedRows[0] integerValue];
            id object;
            if ([sectionInfo.values count] >= selectedRow) {
                object = sectionInfo.values[selectedRow - 1];
            }
            sectionInfo.headerView.categoryValueLabel.text = [object valueForKey:@"name"];
            break;
        }
        default:{
            if ([sectionInfo.selectedRows count] == [sectionInfo.values count]) {
                sectionInfo.headerView.categoryValueLabel.text = @"All";
            } else {
                sectionInfo.headerView.categoryValueLabel.text = @"Multiple Values";
            }
            break;
        }
    }
}

- (NSArray *)currentSelectedSectionRows {
    NSMutableArray *selectedSectionRows = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [self.sectionInfoArray count]; i++) {
        ETGSectionInfo *sectionInfo = self.sectionInfoArray[i];
        [selectedSectionRows addObject:sectionInfo.selectedRows];
    }
    
    return selectedSectionRows;
}

- (void)reloadFilterForSelectedReportingMonth
{
    self.shouldUpdateFilterErrorMessage = NO;
    [self updateProjectSection];
}

- (void)reloadFilterForSelectedReportingMonthWithErrorLoadingMessage
{
    self.shouldUpdateFilterErrorMessage = YES;
    self.tableFooterView.hidden = NO;
    self.navigationItem.rightBarButtonItem = self.applyBarButton;
}

@end
