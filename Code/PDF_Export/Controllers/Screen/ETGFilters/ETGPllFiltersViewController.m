//
//  ETGPllFiltersViewViewController.m
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPllFiltersViewController.h"
#import "ETGCountries.h"
#import "ETGRegion.h"
#import "ETGCluster.h"
#import "ETGProjectTypes.h"
#import "ETGProjectNatures.h"
#import "ETGProjetComplexities.h"
#import "ETGProject.h"
#import "ETGFilterModelController.h"
#import "ETGSectionHeaderView.h"
#import "ETGPllReviews.h"
#import "ETGPllImpactLevels.h"
#import "ETGPllPraElements.h"
#import "ETGPllLessonRatings.h"
#import "ETGPllPpmsActivity.h"
#import "ETGPllAreasDisciplines.h"
#import "ETGPllLessonValues.h"
#import "ETGPllDisciplines.h"
#import "ETGCustomSegmentedControl.h"

enum filterSegmentIndex {
    kSEGMENTPROJECT,
    kSEGMENTLESSONLEARNT,
};

@interface ETGPllFiltersViewController ()<SectionHeaderViewDelegate>

@property (nonatomic) int selectedSegmentIndex;
@property (nonatomic, strong) NSMutableArray *projectSectionInfo;
@property (nonatomic, strong) NSMutableArray *lessonLearntSectionInfo;
@property (nonatomic, strong) NSArray *fullDisciplinesArray;
@property (nonatomic) BOOL isPreviousStateNoConnection;
@property (nonatomic, strong) UISegmentedControl *statFilter;
@end

@implementation ETGPllFiltersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilter) name:kDownloadFilterDataForPllCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterWithErrorLoadingMessage) name:kDownloadFilterDataForPllFailed object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForPllCompleted object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForPllFailed object:nil];
    
    [self.delegate filtersviewControllerDidDismiss:[self currentSelectedProjectSectionRows] lessonLearnFilter:[self currentSelectedLessonLearntSectionRows]];
}

- (NSArray *)currentSelectedProjectSectionRows
{
    NSMutableArray *selectedSectionRows = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [self.projectSectionInfo count]; i++) {
        ETGSectionInfo *sectionInfo = self.projectSectionInfo[i];
        [selectedSectionRows addObject:sectionInfo.selectedRows];
    }
    
    return selectedSectionRows;
}

- (NSArray *)currentSelectedLessonLearntSectionRows
{
    NSMutableArray *selectedSectionRows = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [self.lessonLearntSectionInfo count]; i++) {
        ETGSectionInfo *sectionInfo = self.lessonLearntSectionInfo[i];
        [selectedSectionRows addObject:sectionInfo.selectedRows];
    }
    
    return selectedSectionRows;
}

- (void)reloadFilter
{
    self.shouldUpdateFilterErrorMessage = NO;
    self.tableFooterView.hidden = YES;
    [self configureTableView];
}

- (void)reloadFilterWithErrorLoadingMessage
{
    self.isPreviousStateNoConnection = YES;
    self.shouldUpdateFilterErrorMessage = YES;
    self.tableFooterView.hidden = NO;
    self.navigationItem.rightBarButtonItem = self.applyBarButton;
}

-(void)configureNavigationBar
{
    self.statFilter = [[ETGCustomSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Project", @"Lesson Learnt", nil]];
    [self.statFilter addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.statFilter setSegmentedControlStyle:UISegmentedControlStyleBar];
    [self.statFilter setTintColor:kPetronasGreenColor];
    [self.statFilter sizeToFit];
    self.statFilter.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.statFilter;
}

-(void)configureTableView
{
    [super configureTableView];
    self.openSectionIndex = NSNotFound;
    self.selectedSegmentIndex = kSEGMENTPROJECT;
    self.sectionInfoArray = self.projectSectionInfo;
    [self updateDisplayForSegmentChanged];
}

-(void)segmentedControlValueChanged:(UISegmentedControl *)segmentedControl
{
    if(self.selectedSegmentIndex == segmentedControl.selectedSegmentIndex)
        return;
    
    for (ETGSectionInfo *sectionInfo in self.sectionInfoArray)
    {
        if (sectionInfo.headerView.disclosureButton.selected)
        {
            [sectionInfo.headerView toggleOpenWithUserAction:YES];
        }
    }
    
    self.selectedSegmentIndex = segmentedControl.selectedSegmentIndex;
    self.openSectionIndex = NSNotFound;
    [self updateDisplayForSegmentChanged];
}

-(void)updateDisplayForSegmentChanged
{
    if(self.selectedSegmentIndex == kSEGMENTPROJECT)
    {
        self.lessonLearntSectionInfo = self.sectionInfoArray;
        self.sectionInfoArray = self.projectSectionInfo;
    }
    else
    {
        self.projectSectionInfo = self.sectionInfoArray;
        self.sectionInfoArray = self.lessonLearntSectionInfo;
    }
    [self.tableView reloadData];
}

- (void)initSectionInfoValues
{
	if ((self.projectSectionInfo == nil) || ([self.projectSectionInfo count] != [self numberOfSectionsInTableView:self.tableView]))
    {
        [self initPllProjectSectionInfoValues];
	}
    
   	if (self.lessonLearntSectionInfo == nil)
    {
        [self initPllLessonLearnSectionInfoValue];
	}
    
    self.sectionInfoArray = self.projectSectionInfo;
    [self.tableView reloadData];
}

-(void)initPllLessonLearnSectionInfoValue
{
    ETGSectionInfo *reviewSectionInfo = [[ETGSectionInfo alloc] init];
    reviewSectionInfo.name = @"PLL Review";
    reviewSectionInfo.singleChoice = NO;
    reviewSectionInfo.open = NO;
    reviewSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGPllReviews class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    reviewSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *impactLevelsSectionInfo = [[ETGSectionInfo alloc] init];
    impactLevelsSectionInfo.name = @"Impact Levels";
    impactLevelsSectionInfo.singleChoice = NO;
    impactLevelsSectionInfo.open = NO;
    impactLevelsSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGPllImpactLevels class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    impactLevelsSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *praElementsSectionInfo = [[ETGSectionInfo alloc] init];
    praElementsSectionInfo.name = @"PRA Elements";
    praElementsSectionInfo.singleChoice = NO;
    praElementsSectionInfo.open = NO;
    praElementsSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGPllPraElements class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    praElementsSectionInfo.selectedRows = [[NSMutableArray alloc] init];
   
    ETGSectionInfo *lessonRatingSectionInfo = [[ETGSectionInfo alloc] init];
    lessonRatingSectionInfo.name = @"Lesson Rating";
    lessonRatingSectionInfo.singleChoice = NO;
    lessonRatingSectionInfo.open = NO;
    lessonRatingSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGPllLessonRatings class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    lessonRatingSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *ppmsActivitySectionInfo = [[ETGSectionInfo alloc] init];
    ppmsActivitySectionInfo.name = @"PPMS Activity";
    ppmsActivitySectionInfo.singleChoice = NO;
    ppmsActivitySectionInfo.open = NO;
    ppmsActivitySectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGPllPpmsActivity class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    ppmsActivitySectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *areaSectionInfo = [[ETGSectionInfo alloc] init];
    areaSectionInfo.name = @"Area";
    areaSectionInfo.singleChoice = NO;
    areaSectionInfo.open = NO;
    areaSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGPllAreasDisciplines class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    areaSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *disciplinesSectionInfo = [[ETGSectionInfo alloc] init];
    disciplinesSectionInfo.name = @"Discipline";
    disciplinesSectionInfo.singleChoice = NO;
    disciplinesSectionInfo.open = NO;
    disciplinesSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGPllDisciplines class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    disciplinesSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *lessonValueSectionInfo = [[ETGSectionInfo alloc] init];
    lessonValueSectionInfo.name = @"Lesson Value";
    lessonValueSectionInfo.singleChoice = NO;
    lessonValueSectionInfo.open = NO;
    lessonValueSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGPllLessonValues class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    lessonValueSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    self.lessonLearntSectionInfo = [[NSMutableArray alloc] init];
    [self.lessonLearntSectionInfo addObjectsFromArray:@[reviewSectionInfo, impactLevelsSectionInfo, praElementsSectionInfo, lessonRatingSectionInfo, ppmsActivitySectionInfo, areaSectionInfo, disciplinesSectionInfo, lessonValueSectionInfo]];
    
    //Set selected rows
    if ([self.selectedRowsInLessonLearntFilter count] > 0 && !self.isPreviousStateNoConnection)
    {
        //set last selected rows in sections
        for(int i = kREVIEW; i <= kLESSONVALUE; i++)
        {
            ETGSectionInfo *sectionInfo = self.lessonLearntSectionInfo[i];
            [sectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInLessonLearntFilter[i]];
        }
    }
    else
    {
        self.isPreviousStateNoConnection = NO;
        [self setDefaultSelectionForLessonLearntSection];
    }
    
    if([self.selectedPllReviewKey length] > 0)
    {
        ETGSectionInfo *sectionInfo = self.lessonLearntSectionInfo[kREVIEW];
        for(int i = 0; i < [sectionInfo.values count]; i++)
        {
            ETGPllReviews *review = sectionInfo.values[i];
            if([review.key integerValue] == [self.selectedPllReviewKey integerValue])
            {
                [sectionInfo.selectedRows removeAllObjects];
                [sectionInfo.selectedRows addObject:[NSNumber numberWithInt:++i]];
                break;
            }
        }
    }
}

- (void)initPllProjectSectionInfoValues {
    ETGSectionInfo *countrySectionInfo = [[ETGSectionInfo alloc] init];
    countrySectionInfo.name = @"Country";
    countrySectionInfo.singleChoice = NO;
    countrySectionInfo.open = NO;
    countrySectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGCountries class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    countrySectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *regionSectionInfo = [[ETGSectionInfo alloc] init];
    regionSectionInfo.name = @"Region";
    regionSectionInfo.singleChoice = NO;
    regionSectionInfo.open = NO;
    regionSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGRegion class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    regionSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *clusterSectionInfo = [[ETGSectionInfo alloc] init];
    clusterSectionInfo.name = @"Cluster";
    clusterSectionInfo.singleChoice = NO;
    clusterSectionInfo.open = NO;
    clusterSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGCluster class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    clusterSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *projectTypeSectionInfo = [[ETGSectionInfo alloc] init];
    projectTypeSectionInfo.name = @"Project Type";
    projectTypeSectionInfo.singleChoice = NO;
    projectTypeSectionInfo.open = NO;
    projectTypeSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGProjectTypes class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    projectTypeSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *projectNatureSectionInfo = [[ETGSectionInfo alloc] init];
    projectNatureSectionInfo.name = @"Project Nature";
    projectNatureSectionInfo.singleChoice = NO;
    projectNatureSectionInfo.open = NO;
    projectNatureSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGProjectNatures class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    projectNatureSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *projectComplexitySectionInfo = [[ETGSectionInfo alloc] init];
    projectComplexitySectionInfo.name = @"Project Complexity";
    projectComplexitySectionInfo.singleChoice = NO;
    projectComplexitySectionInfo.open = NO;
    projectComplexitySectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGProjetComplexities class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    projectComplexitySectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *projectNameSectionInfo = [[ETGSectionInfo alloc] init];
    projectNameSectionInfo.name = @"Project Name";
    projectNameSectionInfo.singleChoice = NO;
    projectNameSectionInfo.open = NO;
    projectNameSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGProject class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    projectNameSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    self.projectSectionInfo = [[NSMutableArray alloc] init];
    [self.projectSectionInfo addObjectsFromArray:@[countrySectionInfo, regionSectionInfo, clusterSectionInfo, projectTypeSectionInfo, projectNatureSectionInfo, projectComplexitySectionInfo, projectNameSectionInfo]];
    
    //Set selected rows
    if ([self.selectedRowsInProjectFilter count] > 0 && !self.isPreviousStateNoConnection) {
        //set last selected rows in sections
        for(int i = kCOUNTRY; i <= KPROJECT; i++) {
            ETGSectionInfo *sectionInfo = self.projectSectionInfo[i];
            [sectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInProjectFilter[i]];
        }
    } else {
        self.isPreviousStateNoConnection = NO;
        [self setDefaultSelectionForProjectSection];
    }
    
    if([self.selectedProjectKey length] > 0)
    {
        ETGSectionInfo *sectionInfo = self.projectSectionInfo[KPROJECT];
        for(int i = 0; i < [sectionInfo.values count]; i++)
        {
            ETGProject *project = sectionInfo.values[i];
            if([project.key integerValue] == [self.selectedProjectKey integerValue])
            {
                [sectionInfo.selectedRows removeAllObjects];
                [sectionInfo.selectedRows addObject:[NSNumber numberWithInt:++i]];
                break;
            }
        }
    }
}

-(int)getProjectSection {
    return KPROJECT;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleDefaultBarButtonPressed:(UIBarButtonItem *)sender
{
    for (ETGSectionInfo *sectionInfo in self.sectionInfoArray)
    {
        //NSLog(@"Section: %@ - OpenStatus: %d", sectionInfo.name, sectionInfo.open);
        if (sectionInfo.headerView.disclosureButton.selected)
        {
            [sectionInfo.headerView toggleOpenWithUserAction:YES];
        }
        [sectionInfo.selectedRows removeAllObjects];
    }
    
    // Shows all projects
    ETGSectionInfo *sectionInfo = self.projectSectionInfo[KPROJECT];
    sectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:NSStringFromClass([ETGProject class]) sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    
    [self setDefaultSelectionForProjectSection];
    [self setDefaultSelectionForLessonLearntSection];
    [self.tableView reloadData];
    
    self.navigationItem.leftBarButtonItem = self.cancelBarButton;
}

- (IBAction)handleApplyBarButtonPressed:(UIBarButtonItem *)sender {
    if([self.delegate respondsToSelector:@selector(filtersViewControllerDidFinishWithProjectSectionInfo:andLessonLearnSessionInfo:filterViewController:)])
    {
        [self.delegate filtersViewControllerDidFinishWithProjectSectionInfo:self.projectSectionInfo andLessonLearnSessionInfo:self.lessonLearntSectionInfo filterViewController:self];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETGSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    BOOL isDisciplineSection = [self isDisciplineSection:indexPath.section];
    
    if (indexPath.row == 0)
    {
        //Handle select all
        [sectionInfo.selectedRows removeAllObjects];
        for (NSInteger i = 0; i < [sectionInfo.values count]; i++)
        {
            if(!isDisciplineSection)
            {
                [sectionInfo.selectedRows addObject:@(i + 1)];
            }
            else
            {
                int row = [self getPllDisciplineActualIndexInTable:i];
                [sectionInfo.selectedRows addObject:@(row)];
            }
        }
        
        NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [sectionInfo.selectedRows count]; i++)
        {
            if(!isDisciplineSection)
            {
                [indexPathsToReload addObject:[NSIndexPath indexPathForRow:(i + 1) inSection:indexPath.section]];
            }
            else
            {
                int row = [self getPllDisciplineActualIndexInTable:i];
                [indexPathsToReload addObject:[NSIndexPath indexPathForRow:row inSection:indexPath.section]];
            }
        }
        [tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationNone];
    }
    else
    {
        if(isDisciplineSection)
        {
            if(![self isDisciplineHeaderSubSection:indexPath.section rowNumber:indexPath.row])
            {
                [sectionInfo.selectedRows addObject:@(indexPath.row)];
            }
        }
        else
        {
            [sectionInfo.selectedRows addObject:@(indexPath.row)];
        }
        //Check selection state of SelectAll cell
        if ([sectionInfo.selectedRows count] == [sectionInfo.values count]) {
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    
    if(self.selectedSegmentIndex == kSEGMENTPROJECT)
    {
        if (indexPath.section == [self getProjectSection]) {
            NSMutableArray *selectedProjects = [[NSMutableArray alloc] init];
            for (NSNumber *row in sectionInfo.selectedRows) {
                [selectedProjects addObject:[sectionInfo.values objectAtIndex:([row integerValue] - 1)]];
            }
        } else {
            [self updateProjectSection];
            if(indexPath.section == kREGION || indexPath.section == kCOUNTRY)
            {
                if(indexPath.section == kCOUNTRY)
                {
                    [self updateRegionSection];
                }
                [self updateClusterSection];
            }
        }
    }
    else if(self.selectedSegmentIndex == kSEGMENTLESSONLEARNT)
    {
        if(indexPath.section == kAREA)
        {
            [self updateDisciplineSection];
        }
        else if(indexPath.section == kDISCIPLINE)
        {
            if([self isDisciplineHeaderSubSection:indexPath.section rowNumber:indexPath.row])
            {
                [tableView deselectRowAtIndexPath:indexPath animated:NO];
            }
        }
    }
    
    if([self isDisciplineSection:kDISCIPLINE])
    {
        [self updateSelectedValuesTitleOnSectionHeaderViewForDiscipline];
    }
    else
    {
        [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    }
    
    if (self.navigationItem.leftBarButtonItem != self.defaultBarButton) {
        self.navigationItem.leftBarButtonItem = self.defaultBarButton;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETGSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    BOOL isDisciplineSection = [self isDisciplineSection:indexPath.section];
    
    if (indexPath.row == 0)
    {
        //Deselect all
        NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [sectionInfo.selectedRows count]; i++)
        {
            if(!isDisciplineSection)
            {
                [indexPathsToReload addObject:[NSIndexPath indexPathForRow:(i + 1) inSection:indexPath.section]];
            }
            else
            {
                int row = [self getPllDisciplineActualIndexInTable:i];
                [indexPathsToReload addObject:[NSIndexPath indexPathForRow:row inSection:indexPath.section]];
            }
        }
        
        [sectionInfo.selectedRows removeAllObjects];
        [tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationNone];
    }
    else
    {
        if(isDisciplineSection)
        {
            if(![self isDisciplineHeaderSubSection:indexPath.section rowNumber:indexPath.row])
            {
                [sectionInfo.selectedRows removeObject:@(indexPath.row)];
            }
        }
        else
        {
            [sectionInfo.selectedRows removeObject:@(indexPath.row)];
        }
        //Check selection state of SelectAll cell
        if ([sectionInfo.selectedRows count] != [sectionInfo.values count]) {
            [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] animated:YES];
        }
    }
    
    if(self.selectedSegmentIndex == kSEGMENTPROJECT)
    {
        if (indexPath.section == [self getProjectSection]) {
            NSMutableArray *selectedProjects = [[NSMutableArray alloc] init];
            for (NSNumber *row in sectionInfo.selectedRows) {
                [selectedProjects addObject:[sectionInfo.values objectAtIndex:([row integerValue] - 1)]];
            }
        } else  {
            [self updateProjectSection];
            if(indexPath.section == kREGION || indexPath.section == kCOUNTRY)
            {
                if(indexPath.section == kCOUNTRY)
                {
                    [self updateRegionSection];
                }
                [self updateClusterSection];
            }
        }
    }
    else if(self.selectedSegmentIndex == kSEGMENTLESSONLEARNT)
    {
        if(indexPath.section == kAREA)
        {
            [self updateDisciplineSection];
        }
    }
    
    if([self isDisciplineSection:kDISCIPLINE])
    {
        [self updateSelectedValuesTitleOnSectionHeaderViewForDiscipline];
    }
    else
    {
        [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    }
    if (self.navigationItem.leftBarButtonItem != self.defaultBarButton) {
        self.navigationItem.leftBarButtonItem = self.defaultBarButton;
    }
}

-(NSArray *)getSelectedKeysForSection:(int)section
{
    NSMutableArray *temp = [NSMutableArray new];
    ETGSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    for (NSNumber *row in sectionInfo.selectedRows) {
        id selectedRow = [sectionInfo.values objectAtIndex:[row integerValue] - 1];
        [temp addObject:[selectedRow valueForKey:@"key"]];
    }
    return temp;
}

-(NSArray *)filterProjectList
{
    NSArray *selectedRegionKeys = [self getSelectedKeysForSection:kREGION];
    NSArray *selectedClusterKeys = [self getSelectedKeysForSection:kCLUSTER];
    NSArray *selectedComplexityKeys = [self getSelectedKeysForSection:kCOMPLEXITY];
    NSArray *selectedNatureKeys = [self getSelectedKeysForSection:kPROJECTNATURE];
    NSArray *selectedtypeKeys = [self getSelectedKeysForSection:kPROJECTTYPE];
    
    NSArray *fetchedProjectObjects =  [[ETGFilterModelController sharedController] fetchProjectsBaseOnClusters:selectedClusterKeys complexities:selectedComplexityKeys natures:selectedNatureKeys type:selectedtypeKeys region:selectedRegionKeys];
    
    return fetchedProjectObjects;
}

- (void)updateProjectSection
{
    if(self.selectedSegmentIndex != kSEGMENTPROJECT)
        return;
    ETGSectionInfo *projectSection = [self.sectionInfoArray objectAtIndex:[self getProjectSection]];
    [self clearAllValueOfSection:projectSection];
    
    NSArray *fetchedProjectObjects = [self filterProjectList];
    if ([fetchedProjectObjects count] > 0) {
        [projectSection.values addObjectsFromArray:fetchedProjectObjects];
        [self setDefaultSelectionForProjectSection:projectSection];
    }
    
    [self reloadSectionAtIndex:[self getProjectSection]];
}

-(int)getPllDisciplineActualIndexInValues:(int)positionInTable
{
    // Remove select all
    ETGPllDisciplines *disciplines = self.fullDisciplinesArray[positionInTable - 1];
    ETGSectionInfo *section = self.lessonLearntSectionInfo[kDISCIPLINE];
    int index = [section.values indexOfObject:disciplines];
    return index;
}

-(int)getPllDisciplineActualIndexInTable:(int)positionInValues
{
    ETGSectionInfo *section = self.lessonLearntSectionInfo[kDISCIPLINE];
    ETGPllDisciplines *disciplines = section.values[positionInValues];
    return ([self.fullDisciplinesArray indexOfObject:disciplines] + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETGSectionInfo *sectionInfo = self.sectionInfoArray[indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.backgroundColor = [UIColor whiteColor];
    
    if (sectionInfo.singleChoice == NO && indexPath.row == 0)
    {
        cell.textLabel.text = @"Select All";
        
        //Check selection state of SelectAll cell
        if ([sectionInfo.selectedRows count] == [sectionInfo.values count])
        {
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    else
    {
        if([self isDisciplineSection:indexPath.section])
        {
            if([self isDisciplineHeaderSubSection:indexPath.section rowNumber:indexPath.row])
            {
                // Display area name for this row
                cell.backgroundColor = kFilterSubSectionColor;
                
                ETGPllAreasDisciplines *area = self.fullDisciplinesArray[indexPath.row - 1];
                cell.textLabel.text = area.name;
            }
            else
            {
                NSEntityDescription *object;
                int row = [self getPllDisciplineActualIndexInValues:indexPath.row];
                object = sectionInfo.values[row];
                cell.textLabel.text = object.name;
            }
            
            //Default selection
            for (NSNumber *selectedRow in sectionInfo.selectedRows)
            {
                if (indexPath.row == [selectedRow integerValue])
                {
                    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                }
            }
        }
        else
        {
            NSEntityDescription *object;
            object = sectionInfo.values[indexPath.row - 1];
            cell.textLabel.text = object.name;
            cell.textLabel.numberOfLines = 0;
            
            //Default selection
            for (NSNumber *selectedRow in sectionInfo.selectedRows)
            {
                if (indexPath.row == [selectedRow integerValue])
                {
                    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                }
            }
        }
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ETGSectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderViewIdentifier];
    sectionHeaderView.delegate = self;
    sectionHeaderView.section = section;
    
    ETGSectionInfo *sectionInfo = self.sectionInfoArray[section];
    sectionHeaderView.categoryLabel.text = sectionInfo.name;
    sectionInfo.headerView = sectionHeaderView;
    sectionInfo.section = section;
    [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    
    return sectionHeaderView;
}

-(void)sectionHeaderView:(ETGSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
    
	ETGSectionInfo *sectionInfo = (self.sectionInfoArray)[sectionOpened];
	sectionInfo.open = YES;
    
    /*
     Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section
     */
    NSInteger countOfRowsToInsert;
    if (sectionInfo.singleChoice == YES) {
        countOfRowsToInsert = [sectionInfo.values count];
    } else {
        if([self isDisciplineSection:sectionOpened])
        {
            countOfRowsToInsert = [self.fullDisciplinesArray count] + 1;
        }
        else
        {
            countOfRowsToInsert = [sectionInfo.values count] + 1;
        }
    }
    
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    //NSLog(@"Section Opened: indexPathsToInsert: %@", indexPathsToInsert);
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
        
		ETGSectionInfo *previousOpenSection = (self.sectionInfoArray)[previousOpenSectionIndex];
        previousOpenSection.open = NO;
        [previousOpenSection.headerView toggleOpenWithUserAction:NO];
        
        NSInteger countOfRowsToDelete;
        if (previousOpenSection.singleChoice == YES) {
            countOfRowsToDelete = [previousOpenSection.values count];
        } else {
            if([self isDisciplineSection:previousOpenSectionIndex])
            {
                countOfRowsToDelete = [self.fullDisciplinesArray count] + 1;
            }
            else
            {
                countOfRowsToDelete = [previousOpenSection.values count] + 1;
            }
        }
        
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    //NSLog(@"Section Opened: indexPathsToDelete: %@", indexPathsToDelete);
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // Apply the updates.
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    self.openSectionIndex = sectionOpened;
}

-(void)sectionHeaderView:(ETGSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	ETGSectionInfo *sectionInfo = (self.sectionInfoArray)[sectionClosed];
    
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.tableView numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        //NSLog(@"SectionClosed: indexPathsToDelete: %@", indexPathsToDelete);
        
        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ETGSectionInfo *sectionInfo = self.sectionInfoArray[section];
    NSInteger numberOfRows = 0;
    
    if (sectionInfo.singleChoice == YES) {
       numberOfRows = [sectionInfo.values count];
    } else {
        if([self isDisciplineSection:section])
        {
            numberOfRows = [self.fullDisciplinesArray count] + 1;
        }
        else
        {
            numberOfRows = [sectionInfo.values count] + 1;
        }
    }
    
    int rows = sectionInfo.open ? numberOfRows : 0;
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self isDisciplineHeaderSubSection:indexPath.section rowNumber:indexPath.row])
    {
        return 44;
    }
    
    ETGSectionInfo *sectionInfo = self.sectionInfoArray[indexPath.section];
    if(![self isDisciplineSection:indexPath.section] && indexPath.row != 0)
    {
        NSEntityDescription *object;
        object = sectionInfo.values[indexPath.row - 1];
        CGSize size = [object.name sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];
        if(size.height > 44)
        {
            return size.height + 10;
        }
    }
    return 44;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self isDisciplineHeaderSubSection:indexPath.section rowNumber:indexPath.row])
    {
        return NO;
    }
    return YES;
}

-(BOOL)isDisciplineHeaderSubSection:(int)sectionNumber rowNumber:(int)rowNumber
{
    if(self.selectedSegmentIndex == kSEGMENTLESSONLEARNT && sectionNumber == kDISCIPLINE)
    {
        if(rowNumber == 0)
            return NO;
        id object = [self.fullDisciplinesArray objectAtIndex:(rowNumber - 1)];
        if([object isKindOfClass:[ETGPllAreasDisciplines class]])
        {
            return  YES;
        }
    }
    return NO;
}

-(BOOL)isDisciplineSection:(int)sectionNumber
{
    if(self.selectedSegmentIndex == kSEGMENTLESSONLEARNT && sectionNumber == kDISCIPLINE)
        return YES;
    return NO;
}

- (void)setDefaultSelectionForProjectSection
{
    for(int i = kCOUNTRY; i <= KPROJECT; i++)
        [self selectAllRows:self.projectSectionInfo[i]];
}

- (void)setDefaultSelectionForLessonLearntSection
{
    for(int i = kREVIEW; i <= kLESSONVALUE; i++)
    {
        if(i == kDISCIPLINE)
        {
            continue;
        }
        [self selectAllRows:self.lessonLearntSectionInfo[i]];
    }
    
    ETGSectionInfo *disciplineSection = self.lessonLearntSectionInfo[kDISCIPLINE];
    [self clearAllValueOfSection:disciplineSection];
    
    NSMutableArray *selectedAreaKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *areaSection = [self.lessonLearntSectionInfo objectAtIndex:kAREA];
    for (NSNumber *row in areaSection.selectedRows)
    {
        ETGRegion *selectedArea = [areaSection.values objectAtIndex:[row integerValue] - 1];
        [selectedAreaKeys addObject:selectedArea.key];
    }
    NSArray *results = [[ETGFilterModelController sharedController] fetchDisciplinesBasedOnAreas:selectedAreaKeys];
    self.fullDisciplinesArray = results[1];
    NSArray *fetchedObjects = results[0];
    if ([fetchedObjects count] > 0)
    {
        [disciplineSection.values addObjectsFromArray:fetchedObjects];
        [self setDefaultSelectionForDisciplineSection:disciplineSection];
    }
}

-(void)setDefaultSelectionForDisciplineSection:(ETGSectionInfo *)disciplineSection
{
    for (NSInteger i = 0; i < [disciplineSection.values count]; i++)
    {
        int row = [self getPllDisciplineActualIndexInTable:i];
        [disciplineSection.selectedRows addObject:@(row)];
    }
}

-(void)selectAllRows:(ETGSectionInfo *)sectionInfo
{
    [sectionInfo.selectedRows removeAllObjects];
    for (NSInteger i = 0; i < [sectionInfo.values count]; i++) {
        [sectionInfo.selectedRows addObject:@(i + 1)];
    }
}

+(NSArray *)getSelectedRowsFromSectionInfo:(ETGSectionInfo *)inputSectionInfo
{
    NSMutableArray *temp = [NSMutableArray new];
    if([inputSectionInfo.selectedRows count] == [inputSectionInfo.values count])
    {
        return temp;
    }
    for(NSNumber *selectedRow in inputSectionInfo.selectedRows)
    {
        id object = inputSectionInfo.values[[selectedRow integerValue] - 1];
        [temp addObject:[object valueForKey:@"key"]];
    }
    return temp;
}

-(NSArray *)getDisciplineSelectedRowsFromSectionInfo:(ETGSectionInfo *)inputSectionInfo
{
    NSMutableArray *temp = [NSMutableArray new];
    if([inputSectionInfo.selectedRows count] == [inputSectionInfo.values count])
    {
        return temp;
    }
    for(NSNumber *selectedRow in inputSectionInfo.selectedRows)
    {
        int actualIndex = [self getPllDisciplineActualIndexInValues:[selectedRow integerValue]];
        id object = inputSectionInfo.values[actualIndex];
        [temp addObject:[object valueForKey:@"key"]];
    }
    return temp;
}

-(void)updateDisciplineSection
{
    ETGSectionInfo *disciplineSection = self.sectionInfoArray[kDISCIPLINE];
    [self clearAllValueOfSection:disciplineSection];
    
    NSArray *fetchedObjects = [self filterDisciplineList];
    if ([fetchedObjects count] > 0) {
        [disciplineSection.values addObjectsFromArray:fetchedObjects];
        [self setDefaultSelectionForDisciplineSection:disciplineSection];
    }
    
    [self reloadSectionAtIndex:kDISCIPLINE];
}

-(void)updateRegionSection
{
    ETGSectionInfo *regionSection = self.sectionInfoArray[kREGION];
    [self clearAllValueOfSection:regionSection];
    
    NSArray *fetchedObjects = [self filterRegionList];
    if ([fetchedObjects count] > 0) {
        [regionSection.values addObjectsFromArray:fetchedObjects];
        [self setDefaultSelectionForAnySection:regionSection];
    }
    
    [self reloadSectionAtIndex:kREGION];
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

-(NSArray *)filterDisciplineList
{
    NSMutableArray *selectedAreaKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *areaSection = [self.sectionInfoArray objectAtIndex:kAREA];
    for (NSNumber *row in areaSection.selectedRows) {
        ETGRegion *selectedArea = [areaSection.values objectAtIndex:[row integerValue] - 1];
        [selectedAreaKeys addObject:selectedArea.key];
    }
    NSArray *results = [[ETGFilterModelController sharedController] fetchDisciplinesBasedOnAreas:selectedAreaKeys];
    self.fullDisciplinesArray = results[1];
    return results[0];
}

-(NSArray *)filterRegionList
{
    NSMutableArray *selectedCountryKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *countrySection = [self.sectionInfoArray objectAtIndex:kCOUNTRY];
    for (NSNumber *row in countrySection.selectedRows) {
        ETGRegion *selectedCountry = [countrySection.values objectAtIndex:[row integerValue] - 1];
        [selectedCountryKeys addObject:selectedCountry.key];
    }
    NSArray *fetchedObjects =  [[ETGFilterModelController sharedController] fetchRegionsBasedOnCountries:selectedCountryKeys];
    return fetchedObjects;
}

-(NSArray *)filterClusterList
{
    NSMutableArray *selectedRegionKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *regionSection = [self.sectionInfoArray objectAtIndex:kREGION];
    for (NSNumber *row in regionSection.selectedRows) {
        ETGRegion *selectedRegion = [regionSection.values objectAtIndex:[row integerValue] - 1];
        [selectedRegionKeys addObject:selectedRegion.key];
    }
    NSArray *fetchedObjects =  [[ETGFilterModelController sharedController] fetchClustersBasedOnRegions:selectedRegionKeys];
    return fetchedObjects;
}

- (void)updateSelectedValuesTitleOnSectionHeaderViewForDiscipline
{
    ETGSectionInfo *sectionInfo = self.lessonLearntSectionInfo[kDISCIPLINE];
    switch ([sectionInfo.selectedRows count]) {
        case 0:
            sectionInfo.headerView.categoryValueLabel.text = @"";
            break;
        case 1:
        {
            NSInteger selectedRow = [sectionInfo.selectedRows[0] integerValue];
            NSEntityDescription *object;
            object = sectionInfo.values[[self getPllDisciplineActualIndexInValues:selectedRow]];
            sectionInfo.headerView.categoryValueLabel.text = object.name;
            break;
        }
        default:{
            if ([sectionInfo.selectedRows count] == [sectionInfo.values count])
            {
                sectionInfo.headerView.categoryValueLabel.text = @"All";
            }
            else
            {
                sectionInfo.headerView.categoryValueLabel.text = @"Multiple Values";
            }
            break;
        }
    }
}

@end
