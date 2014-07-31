    //
//  ETGFiltersViewController.m
//  PDF_Export
//
//  Created by Tony Pham on 8/26/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "ETGFiltersViewController.h"
#import "ETGFilterModelController.h"
#import <CoreData/CoreData.h>
#import "SRMonthPicker.h"
#import "ETGSectionHeaderView.h"
#import "ETGSectionInfo.h"
#import "ETGReportingMonthCell.h"
#import "CommonMethods.h"
#import "ETGProject.h"
#import "ETGOperatorship.h"
#import "ETGPhase.h"
#import "ETGRegion.h"
#import "ETGProjectStatus.h"
#import "ETGCostAllocation.h"
#import "ETGPortfolio.h"
#import "ETGCpb.h"
#import "ETGBaselineType.h"
#import "ETGRevision.h"
#import "ETGProjectSummary.h"
#import "ETGReportingMonth.h"
#import "ETGUserDefaultManipulation.h"
#import "ETGNetworkConnection.h"
#import "Reachability.h"

enum section {
    kREPORTINGPERIOD,
    kOPERATORSHIP,
    kPHASE,
    kREGION,
    KPROJECTSTATUS,
    KPROJECT,
    KBUDGETHOLDER,
    KBASELINETYPE,
    KREVISION
};

@interface ETGFiltersViewController () <SectionHeaderViewDelegate, SRMonthPickerDelegate>
@property (nonatomic) NSTimer *reportingMonthChangedTimer;
@property (nonatomic, strong) Reachability *hostReachability;
@property (nonatomic, strong) Reachability *internetReachability;
@property (nonatomic) BOOL isNoProjectData2;


@end


@implementation ETGFiltersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _managedObjectContext = [NSManagedObjectContext defaultContext];
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyyMMdd"];
    
    [self configureTableView];
    [self initSectionInfoValues];
    
    if(self.shouldUpdateFilterErrorMessage)
    {
        self.tableFooterView.hidden = NO;
    }
    else
    {
        self.tableFooterView.hidden = YES;
    }
    
     //NSLog(@"%@", _moduleName);

    if ([_moduleName isEqualToString:@"project"] || [_moduleName isEqualToString:@"portfolio"]) {
        NSArray * fetchedProjectObjects2 = nil;
        fetchedProjectObjects2 = [self filterProjectList];
        if ([fetchedProjectObjects2 count] == 0) {
            self.tableFooterView.hidden = NO;
            //        self.navigationItem.leftBarButtonItem.enabled = YES;
            self.isNoProjectData = YES;
        }else{
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
        }
        
        if ([_moduleName isEqualToString:@"project"]) {
            if (![[[_sectionInfoArray objectAtIndex:KPROJECT] valueForKey:@"values"] count]) {
                [self disableUserInteractionOnAllSectionExceptReportingMonthSection];
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterForSelectedReportingMonth) name:kDownloadFilterDataForGivenReportingMonthCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFilterForSelectedReportingMonthWithErrorLoadingMessage) name:kDownloadFilterDataForGivenReportingMonthFailed object:nil];
    
    NSString *serverAddress = [[NSURL URLWithString:kBaseURL] host];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    _internetReachability = [Reachability reachabilityForInternetConnection];
    [_internetReachability startNotifier];
    
    _hostReachability = [Reachability reachabilityWithHostName:serverAddress];
    [_hostReachability startNotifier];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForGivenReportingMonthCompleted object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForGivenReportingMonthFailed object:nil];
    
    if([_delegate respondsToSelector:@selector(filtersviewControllerDidDismiss:)])
    {
        [_delegate filtersviewControllerDidDismiss:[self currentSelectedSectionRows]];        
    }
    self.isNoProjectData2 = NO;
    self.isNoProjectData = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureTableView
{
    UINib *sectionHeaderNib = [UINib nibWithNibName:@"SectionHeaderView" bundle:nil];
    [self.tableView registerNib:sectionHeaderNib forHeaderFooterViewReuseIdentifier:SectionHeaderViewIdentifier];
    [self.tableView setEditing:YES animated:YES];
    self.tableView.sectionHeaderHeight = 44;
    self.openSectionIndex = [self getReportingMonthSection];
    self.tableFooterView.hidden = YES;
}

- (void)initSectionInfoValues {
    
    /*
     Check whether the section info array has been created, and if so whether the section count still matches the current section count. In general, you need to keep the section info synchronized with the rows and section. If you support editing in the table view, you need to appropriately update the section info during editing operations.
     */
	if ((self.sectionInfoArray == nil) || ([self.sectionInfoArray count] != [self numberOfSectionsInTableView:self.tableView]))
    {
        [self initCommonSectionInfoValues];
        [self initProjectAndBudgetHolderSectionInfoValues];

        if ([_moduleName isEqualToString:@"project"]) {
            [self initBaselineTypeAndRevisionSectionInfoValues];
        }
	}
}

- (void)initCommonSectionInfoValues
{
    ETGSectionInfo *reportingPeriodSectionInfo = [[ETGSectionInfo alloc] init];
    reportingPeriodSectionInfo.name = @"Reporting Period";
    reportingPeriodSectionInfo.singleChoice = YES;
    reportingPeriodSectionInfo.open = YES;
    reportingPeriodSectionInfo.values = [[NSMutableArray alloc] init];
    reportingPeriodSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *operatorshipSectionInfo = [[ETGSectionInfo alloc] init];
    operatorshipSectionInfo.name = @"Operatorship";
    if ([_moduleName isEqualToString:@"project"]) {
        operatorshipSectionInfo.singleChoice = NO;
    } else {
        operatorshipSectionInfo.singleChoice = YES;
    }
    operatorshipSectionInfo.open = NO;
    
    NSMutableArray *operatoeShipArray = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGOperatorship" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext]];
        
//        for (int i=0; i<[operatoeShipArray count]; i++) {
//            
//            NSManagedObject *object = [operatoeShipArray objectAtIndex:i];
//            NSString *type = [object valueForKey:@"name"];
//            if([type isEqualToString:@"JOB"] || [type isEqualToString:@"OBO"]){
//                
//                [operatoeShipArray removeObjectAtIndex:i];
//                i--;
//            }
//            
//        }
    operatorshipSectionInfo.values = operatoeShipArray;
    operatorshipSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *phaseSectionInfo = [[ETGSectionInfo alloc] init];
    phaseSectionInfo.name = @"Phase";
    if ([_moduleName isEqualToString:@"project"]) {
        phaseSectionInfo.singleChoice = NO;
    } else {
        phaseSectionInfo.singleChoice = YES;
    }
    phaseSectionInfo.open = NO;
    phaseSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGPhase" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext]];
    phaseSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *regionSectionInfo = [[ETGSectionInfo alloc] init];
    regionSectionInfo.name = @"Region";
    regionSectionInfo.singleChoice = NO;
    regionSectionInfo.open = NO;
    regionSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGRegion" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext]];
    regionSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *projectStatusSectionInfo = [[ETGSectionInfo alloc] init];
    projectStatusSectionInfo.name = @"Project Status";
    projectStatusSectionInfo.singleChoice = NO;
    projectStatusSectionInfo.open = NO;
    projectStatusSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGProjectStatus" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext]];
    projectStatusSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    //Set selected rows
    if ([_selectedRowsInFilter count] > 0) {
        //set last selected rows in sections
        [reportingPeriodSectionInfo.selectedRows addObjectsFromArray:_selectedRowsInFilter[kREPORTINGPERIOD]];
        [operatorshipSectionInfo.selectedRows addObjectsFromArray:_selectedRowsInFilter[kOPERATORSHIP]];
        [phaseSectionInfo.selectedRows addObjectsFromArray:_selectedRowsInFilter[kPHASE]];
        [regionSectionInfo.selectedRows addObjectsFromArray:_selectedRowsInFilter[kREGION]];
        [projectStatusSectionInfo.selectedRows addObjectsFromArray:_selectedRowsInFilter[KPROJECTSTATUS]];
    } else {
        [self setDefaultSelectionForReportingMonthSection:reportingPeriodSectionInfo operatorshipSection:operatorshipSectionInfo phaseSection:phaseSectionInfo regionSection:regionSectionInfo projectStatusSection:projectStatusSectionInfo];
    }
    
    _sectionInfoArray = [[NSMutableArray alloc] init];
    [_sectionInfoArray addObject:reportingPeriodSectionInfo];
    [_sectionInfoArray addObject:operatorshipSectionInfo];
    [_sectionInfoArray addObject:phaseSectionInfo];
    [_sectionInfoArray addObject:regionSectionInfo];
    [_sectionInfoArray addObject:projectStatusSectionInfo];
}

- (void)initProjectAndBudgetHolderSectionInfoValues
{
    //Project section
    ETGSectionInfo *projectSectionInfo = [[ETGSectionInfo alloc] init];
    projectSectionInfo.name = @"Project";
    projectSectionInfo.open = NO;
    projectSectionInfo.values = [NSMutableArray arrayWithArray:[self filterProjectList]];
    
    projectSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    if ([_moduleName isEqualToString:@"project"]) {
        projectSectionInfo.singleChoice = YES;
    } else {
        projectSectionInfo.singleChoice = NO;
    }
    
    //Budget Holder section
    ETGSectionInfo *budgetHolderSectionInfo = [[ETGSectionInfo alloc] init];
    budgetHolderSectionInfo.name = @"Budget Holder";
    budgetHolderSectionInfo.singleChoice = YES;
    budgetHolderSectionInfo.open = NO;
    
    NSMutableArray *selectedProjects = [[NSMutableArray alloc] init];
    if (projectSectionInfo.singleChoice) {
        if ([projectSectionInfo.values count] > 0) {
            int objForKey = [[_selectedRowsInFilter[KPROJECT] objectAtIndex:0] integerValue];
            [selectedProjects addObject:projectSectionInfo.values[objForKey]];
        }
    } else {
        [selectedProjects addObjectsFromArray:projectSectionInfo.values];
    }
    budgetHolderSectionInfo.values = [NSMutableArray arrayWithArray:[self filterBudgetHoldersBaseOnProjects:selectedProjects]];
    budgetHolderSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    //Set selected rows
    if ([_selectedRowsInFilter count] > 0) {
        if ([_selectedRowsInFilter[KPROJECT] count] <= [projectSectionInfo.values count]) {
            [projectSectionInfo.selectedRows addObjectsFromArray:_selectedRowsInFilter[KPROJECT]];
        } else {
            [self setDefaultSelectionForProjectSection:projectSectionInfo];
            //NSLog(@"-------> selected rows in project section is biger than project list");
        }
        
        [budgetHolderSectionInfo.selectedRows addObjectsFromArray:_selectedRowsInFilter[KBUDGETHOLDER]];
    } else {
        [self setDefaultSelectionForProjectSection:projectSectionInfo];
        [self setDefaultSelectionForBudgetHolderSection:budgetHolderSectionInfo];
    }
    
    [_sectionInfoArray addObject:projectSectionInfo];
    [_sectionInfoArray addObject:budgetHolderSectionInfo];
}

- (void)initBaselineTypeAndRevisionSectionInfoValues
{
    //Baseline type
    ETGSectionInfo *baselineTypeSection = [[ETGSectionInfo alloc] init];
    baselineTypeSection.name = @"Baseline Type";
    baselineTypeSection.singleChoice = YES;
    baselineTypeSection.open = NO;
    baselineTypeSection.selectedRows = [[NSMutableArray alloc] init];
    
    //Revision
    ETGSectionInfo *revisionSection = [[ETGSectionInfo alloc] init];
    revisionSection.name = @"Revision No.";
    revisionSection.singleChoice = YES;
    revisionSection.open = NO;
    revisionSection.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *projectSectionInfo = [_sectionInfoArray objectAtIndex:KPROJECT];
    if ([projectSectionInfo.values count] > 0) {
        NSInteger selectedProjectRow = [[projectSectionInfo.selectedRows objectAtIndex:0] integerValue];
        ETGProject *selectedProject = [projectSectionInfo.values objectAtIndex:selectedProjectRow];
        [self setBaselineTypeAndRevisionSectionValues:baselineTypeSection revisionSection:revisionSection forProject:selectedProject];
    }
    
    [_sectionInfoArray addObject:baselineTypeSection];
    [_sectionInfoArray addObject:revisionSection];

}

- (void)setBaselineTypeAndRevisionSectionValues:(ETGSectionInfo *)baselineTypeSection revisionSection:(ETGSectionInfo *)revisionSection forProject:(ETGProject *)selectedProject
{
    ETGSectionInfo *reportingPeriodSectionInfo = [_sectionInfoArray objectAtIndex:kREPORTINGPERIOD];
    NSDate *reportingMonth = [reportingPeriodSectionInfo.selectedRows objectAtIndex:0];
    NSArray *baselineTypes = [[ETGFilterModelController sharedController] getBaselineTypesOfProject:selectedProject forReportingMonth:reportingMonth];
    baselineTypeSection.values = [NSMutableArray arrayWithArray:baselineTypes];

    if ([baselineTypeSection.values count] > 0) {
        ETGBaselineType *baselineType = nil;
        NSNumber *selectedBaselineType = [NSNumber numberWithInt:0];
        
        if ([_selectedRowsInFilter[KBASELINETYPE] count]) {
            
            int currentSelectedBaselineType = [[[_selectedRowsInFilter objectAtIndex:KBASELINETYPE] firstObject] integerValue];
            
            if (baselineTypes.count > currentSelectedBaselineType) {
                selectedBaselineType = [[_selectedRowsInFilter objectAtIndex:KBASELINETYPE] firstObject];
            }
            
            baselineType = [baselineTypeSection.values objectAtIndex:[selectedBaselineType intValue]];
        } else {
            baselineType = [baselineTypeSection.values firstObject];
        }
        
        NSArray *revisions = [[ETGFilterModelController sharedController] getRevisionNumbersForABaselineTypes:baselineType];
        if ([revisions count] > 0) {
            revisionSection.values = [NSMutableArray arrayWithArray:revisions];
        }
        
        //selection
        if ([_selectedRowsInFilter[KBASELINETYPE] count] > 0) {
//            [baselineTypeSection.selectedRows addObjectsFromArray:_selectedRowsInFilter[KBASELINETYPE]];
//            [revisionSection.selectedRows addObjectsFromArray:_selectedRowsInFilter[KREVISION]];

            [baselineTypeSection.selectedRows addObject:selectedBaselineType];

            NSNumber *selectedRevisionNumber = [NSNumber numberWithInt:0];
            int currentSelectedRevision = [[[_selectedRowsInFilter objectAtIndex:KREVISION] firstObject] integerValue];
            
            if (revisions.count > currentSelectedRevision) {
                selectedRevisionNumber = [[_selectedRowsInFilter objectAtIndex:KREVISION] firstObject];
            }
            [revisionSection.selectedRows addObject:selectedRevisionNumber];

        } else {
            [self setDefaultSelectionForBaselineTypeSection:baselineTypeSection revisionSection:revisionSection];
        }
    }
}


- (void)setDefaultSelectionForReportingMonthSection:(ETGSectionInfo *)reportingPeriodSection
                                operatorshipSection:(ETGSectionInfo *)operatorshipSection
                                       phaseSection:(ETGSectionInfo *)phaseSection
                                      regionSection:(ETGSectionInfo *)regionSection
                               projectStatusSection:(ETGSectionInfo *)projectStatusSection
{
    //Reporting Month
    [reportingPeriodSection.selectedRows addObject:[CommonMethods latestReportingMonth]];
    
    //Operatorship = COB (Malaysia)
    for (ETGOperatorship *operatorship in operatorshipSection.values) {
        if ([operatorship.key isEqualToNumber:kDefaultOperatorshipKey]) {
            if (operatorshipSection.singleChoice) {
                [operatorshipSection.selectedRows addObject:@([operatorshipSection.values indexOfObject:operatorship])];
            } else {
                [operatorshipSection.selectedRows addObject:@([operatorshipSection.values indexOfObject:operatorship] + 1)];
            }
            break;
        }
    }
    if ([operatorshipSection.selectedRows count] == 0 && [operatorshipSection.values count] > 0) {
        if (operatorshipSection.singleChoice) {
            [operatorshipSection.selectedRows addObject:@0];
        } else {
            [operatorshipSection.selectedRows addObject:@1];
        }
    }
    
    //Phase = Execution
    for (ETGPhase *phase in phaseSection.values) {
        if ([phase.key isEqualToNumber:kDefaultProjectPhaseKey]) {
            if (phaseSection.singleChoice) {
                [phaseSection.selectedRows addObject:@([phaseSection.values indexOfObject:phase])];
            } else {
                [phaseSection.selectedRows addObject:@([phaseSection.values indexOfObject:phase] + 1)];
            }
            break;
        }
    }
    if ([phaseSection.selectedRows count] == 0 && [phaseSection.values count] > 0) {
        if (phaseSection.singleChoice) {
            [phaseSection.selectedRows addObject:@0];
        } else {
            [phaseSection.selectedRows addObject:@1];
        }
    }
    
    //Select all regions
    for (NSInteger i = 0; i < [regionSection.values count]; i++) {
        [regionSection.selectedRows addObject:@(i + 1)];
    }
    
    //Project status = Open
    for (ETGProjectStatus *projectStatus in projectStatusSection.values) {
        if ([projectStatus.key isEqualToNumber:kDefaultProjectStatusKey]) {
            NSInteger index = [projectStatusSection.values indexOfObject:projectStatus];
            [projectStatusSection.selectedRows addObject:@(index + 1)];
            break;
        }
    }
    if ([projectStatusSection.selectedRows count] == 0 && [projectStatusSection.values count] > 0) {
        [projectStatusSection.selectedRows addObject:@0];
    }
}

- (void)setDefaultSelectionForProjectSection:(ETGSectionInfo *)projectSection
{
    if (projectSection.singleChoice) {
        [projectSection.selectedRows addObject:@0];
    } else {
        for (NSInteger i = 0; i < [projectSection.values count]; i++) {
            [projectSection.selectedRows addObject:@(i + 1)];
        }
    }
}

- (void)setDefaultSelectionForBudgetHolderSection:(ETGSectionInfo *)budgetHolderSection
{
    //Budget holder = P&E
    for (ETGCostAllocation *budgetHolder in budgetHolderSection.values) {
        if ([budgetHolder.key isEqualToNumber:kDefaultBudgetHolderKey]) {
            NSInteger index = [budgetHolderSection.values indexOfObject:budgetHolder];
            [budgetHolderSection.selectedRows addObject:@(index)];
            break;
        }
    }
    if ([budgetHolderSection.selectedRows count] == 0 && [budgetHolderSection.values count] > 0) {
            [budgetHolderSection.selectedRows addObject:@0];
    }
    
}

- (void)setDefaultSelectionForBaselineTypeSection:(ETGSectionInfo *)baselineTypeSection revisionSection:(ETGSectionInfo *)revisionSection
{
    [baselineTypeSection.selectedRows addObject:@0];
    [revisionSection.selectedRows addObject:@0];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_sectionInfoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ETGSectionInfo *sectionInfo = _sectionInfoArray[section];
    NSInteger numberOfRows = 0;
    
    if (sectionInfo.singleChoice == YES) {
        if (section == [self getReportingMonthSection]) {
            numberOfRows = 1;
        } else {
            numberOfRows = [sectionInfo.values count];
        }
    } else {
        numberOfRows = [sectionInfo.values count] + 1;
    }

    return sectionInfo.open ? numberOfRows : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self getReportingMonthSection]) {
        return 216;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETGSectionInfo *sectionInfo = _sectionInfoArray[indexPath.section];

    if (indexPath.section == [self getReportingMonthSection]) {
        ETGReportingMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportingMonthCell" forIndexPath:indexPath];

        SRMonthPicker *reportingMonthPickerView = cell.datePickerView;
        reportingMonthPickerView.monthPickerDelegate = self;
        reportingMonthPickerView.date = [sectionInfo.selectedRows objectAtIndex:0];
        reportingMonthPickerView.minimumYear = @2012;
        NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
        reportingMonthPickerView.maximumYear = @([currentDateComponents year]);
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
        
        if (sectionInfo.singleChoice == NO && indexPath.row == 0) {
            cell.textLabel.text = @"Select All";
            
            //Check selection state of SelectAll cell
            if ([sectionInfo.selectedRows count] == [sectionInfo.values count]) {
                [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
        } else {
            NSEntityDescription *object;
            if (sectionInfo.singleChoice == YES) {
                object = sectionInfo.values[indexPath.row];
            } else {
                object = sectionInfo.values[indexPath.row - 1];
            }
            
            if ([object isKindOfClass:[ETGRevision class]]) {
                cell.textLabel.text = [[(ETGRevision *)object number] stringValue];
            } else {
                if ([object.name isEqualToString:@"JOB"] || [object.name isEqualToString:@"OBO"]) {
                    
                    cell.textLabel.text = object.name;
                    cell.userInteractionEnabled = NO;
                    cell.textLabel.enabled = NO;
                    
                }else{
                    
                    cell.textLabel.text = object.name;
                }
                
            }
            
            //Default selection
            for (NSNumber *selectedRow in sectionInfo.selectedRows) {
                if (indexPath.row == [selectedRow integerValue]) {
                    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                }
            }
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
  
    if (self.navigationItem.leftBarButtonItem.enabled == NO) {
        [self disableUserInteractionOnAllSectionExceptReportingMonthSection];
    } else {
        if (self.isNoProjectData2) {
            self.tableFooterView.hidden = NO;
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:NO];
        }else{
            if (self.isNoProjectData) {
                [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:NO];
            }else{
                [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ETGSectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderViewIdentifier];
    sectionHeaderView.delegate = self;
    sectionHeaderView.section = section;
    
    ETGSectionInfo *sectionInfo = _sectionInfoArray[section];
    sectionHeaderView.categoryLabel.text = sectionInfo.name;
    sectionInfo.headerView = sectionHeaderView;
    sectionInfo.section = section;

    if (section == [self getReportingMonthSection]) {
        sectionInfo.headerView.disclosureButton.selected = YES;
        if ([sectionInfo.selectedRows count] > 0) {
            [self updateSelectedReportingMonthValueLabel:sectionInfo.selectedRows[0]];
        } else {
            [self updateSelectedReportingMonthValueLabel:[NSDate date]];
        }
    } else {
        [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    }

    return sectionHeaderView;
}

- (void)updateSelectedValuesTitleOnSectionHeaderView:(ETGSectionInfo *)sectionInfo {

    switch ([sectionInfo.selectedRows count]) {
        case 0:
            sectionInfo.headerView.categoryValueLabel.text = @"";
            break;
        case 1:{
            NSInteger selectedRow = [sectionInfo.selectedRows[0] integerValue];
            NSEntityDescription *object;
            if (sectionInfo.singleChoice == YES) {
                if ([sectionInfo.values count] > selectedRow) {
                    object = sectionInfo.values[selectedRow];
                }
            } else {
                if (selectedRow - 1 >= 0 && [sectionInfo.values count] >= selectedRow) {
                    object = sectionInfo.values[selectedRow - 1];
                }
            }

            if ([object isKindOfClass:[ETGRevision class]]) {
                sectionInfo.headerView.categoryValueLabel.text = [[(ETGRevision *)object number] stringValue];
            } else {
                sectionInfo.headerView.categoryValueLabel.text = object.name;
            }
            
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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self getReportingMonthSection]) {
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETGSectionInfo *sectionInfo = [_sectionInfoArray objectAtIndex:indexPath.section];
    if (sectionInfo.singleChoice == YES) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        if ([sectionInfo.selectedRows count] > 0) {
            NSIndexPath *deselectIndexPath = [NSIndexPath indexPathForRow:[sectionInfo.selectedRows[0] integerValue] inSection:indexPath.section];
            [tableView deselectRowAtIndexPath:deselectIndexPath animated:YES];
            [sectionInfo.selectedRows replaceObjectAtIndex:0 withObject:@(indexPath.row)];
        } else {
            [sectionInfo.selectedRows addObject:@(indexPath.row)];
        }

        [sectionInfo.headerView toggleOpenWithUserAction:YES];
    } else {
        if (indexPath.row == 0) {
            //Handle select all
            [sectionInfo.selectedRows removeAllObjects];
            for (NSInteger i = 0; i < [sectionInfo.values count]; i++) {
                [sectionInfo.selectedRows addObject:@(i + 1)];
            }
            
            NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < [sectionInfo.selectedRows count]; i++) {
                [indexPathsToReload addObject:[NSIndexPath indexPathForRow:(i + 1) inSection:indexPath.section]];
            }
            [tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationNone];
        } else {
            [sectionInfo.selectedRows addObject:@(indexPath.row)];
            
            //Check selection state of SelectAll cell
            if ([sectionInfo.selectedRows count] == [sectionInfo.values count]) {
                [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
        }
    }
    
    if (indexPath.section == KPROJECT) {
        NSMutableArray *selectedProjects = [[NSMutableArray alloc] init];
        if (sectionInfo.singleChoice) {
            
            NSInteger selectedRow = [[sectionInfo.selectedRows objectAtIndex:0] integerValue];
            ETGProject *selectedProject = [sectionInfo.values objectAtIndex:selectedRow];
            [selectedProjects addObject:selectedProject];
           
            [self disableUserInteractionOnAllSectionExceptReportingMonthSection];
            [self checkDataAvailableAndReloadBaselineTypeAndRevisionNoForProject:selectedProject];

        } else {
            for (NSNumber *row in sectionInfo.selectedRows) {
                [selectedProjects addObject:[sectionInfo.values objectAtIndex:([row integerValue] - 1)]];
            }
        }
        
       
        if (self.isNoProjectData) {
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:NO];
            self.tableFooterView.hidden = NO;
            self.isNoProjectData = NO;
        } else{
        
            [self reloadBudgetHolderSectionBaseOnNewProjectList:selectedProjects];
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
            self.tableFooterView.hidden = YES;


        }
        
    } else if (indexPath.section != KBUDGETHOLDER && indexPath.section != KBASELINETYPE && indexPath.section != KREVISION) {
        [self updateProjectSection];
    } else if (indexPath.section == KBASELINETYPE) {

        //BaselineType value changed --> reload revision
        ETGSectionInfo *baselineTypeSection = [_sectionInfoArray objectAtIndex:KBASELINETYPE];
        NSInteger selectedRow = [[baselineTypeSection.selectedRows objectAtIndex:0] integerValue];
        ETGBaselineType *selectedBaselineType = [baselineTypeSection.values objectAtIndex:selectedRow];
        NSArray *newRevisons = [[ETGFilterModelController sharedController] getRevisionNumbersForABaselineTypes:selectedBaselineType];
        
        ETGSectionInfo *revisionSection = [_sectionInfoArray objectAtIndex:KREVISION];
        [self clearAllValueOfSection:revisionSection];
        
        if ([newRevisons count] > 0) {
            [revisionSection.values addObjectsFromArray:newRevisons];
            [revisionSection.selectedRows addObject:@0];
        }
        
        [self reloadSectionAtIndex:KREVISION];

    }
    
    [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];

    if (self.navigationItem.leftBarButtonItem != _defaultBarButton) {
        self.navigationItem.leftBarButtonItem = _defaultBarButton;
    }

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETGSectionInfo *sectionInfo = [_sectionInfoArray objectAtIndex:indexPath.section];
    
    if (sectionInfo.singleChoice == NO) {
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
            
            if (sectionInfo.singleChoice == NO) {
                //Check selection state of SelectAll cell
                if ([sectionInfo.selectedRows count] != [sectionInfo.values count]) {
                    [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] animated:YES];
                }
            }
        }
        
        if (indexPath.section == KPROJECT) {
            NSMutableArray *selectedProjects = [[NSMutableArray alloc] init];
            if (sectionInfo.singleChoice) {
                NSInteger selectedRow = [[sectionInfo.selectedRows objectAtIndex:0] integerValue];
                ETGProject *selectedProject = [sectionInfo.values objectAtIndex:selectedRow];
                [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:selectedProject];
            } else {
                for (NSNumber *row in sectionInfo.selectedRows) {
                    [selectedProjects addObject:[sectionInfo.values objectAtIndex:([row integerValue] - 1)]];
                }
            }
            self.navigationItem.rightBarButtonItem.enabled = sectionInfo.selectedRows.count > 0 ? YES : NO;

            if (![_moduleName isEqualToString:@"project"]) {
                [self reloadBudgetHolderSectionBaseOnNewProjectList:selectedProjects];
            }
            
        } else if (indexPath.section != KBUDGETHOLDER && indexPath.section != KBASELINETYPE && indexPath.section != KREVISION) {
            [self updateProjectSection];
        } else if (indexPath.section == KBASELINETYPE || indexPath.section == KREVISION) {
            NSInteger selectedRow = [[sectionInfo.selectedRows objectAtIndex:0] integerValue];
            ETGProject *selectedProject = [sectionInfo.values objectAtIndex:selectedRow];
            [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:selectedProject];
        }
        
        [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
        // Reload all sections
        [self reloadSections];
    }
    
    if (self.navigationItem.leftBarButtonItem != _defaultBarButton) {
        self.navigationItem.leftBarButtonItem = _defaultBarButton;
    }
}


- (void)reloadSectionAtIndex:(NSInteger)sectionIndex {
    NSIndexSet *reloadSectionsIndexSet = [[NSIndexSet alloc] initWithIndex:sectionIndex];
    [self.tableView reloadSections:reloadSectionsIndexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)updateProjectSection
{
    ETGSectionInfo *projectSection = [_sectionInfoArray objectAtIndex:KPROJECT];
    [self clearAllValueOfSection:projectSection];
    
    NSArray *fetchedProjectObjects = [self filterProjectList];
    if ([fetchedProjectObjects count] > 0) {
        [projectSection.values addObjectsFromArray:fetchedProjectObjects];
        [self setDefaultSelectionForProjectSection:projectSection];
        
        [self reloadBudgetHolderSectionBaseOnNewProjectList:fetchedProjectObjects];
        
        if ([_moduleName isEqualToString:@"project"]) {
            [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:projectSection.values[0]];
        }
    } else {
        [self reloadBudgetHolderSectionBaseOnNewProjectList:nil];

        if ([_moduleName isEqualToString:@"project"]) {
            [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:nil];
        }
    }
    
    // Reload all sections
    [self reloadSections];
}

- (NSArray *)filterProjectList
{
    ETGSectionInfo *reportingMonthSection = _sectionInfoArray[kREPORTINGPERIOD];
    NSDate *reportingMonth = reportingMonthSection.selectedRows[0];
    NSString *reportingMonthString = [_dateFormatter stringFromDate:reportingMonth];
    
    NSMutableArray *selectedOperatorshipKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *operatorshipSection = [_sectionInfoArray objectAtIndex:kOPERATORSHIP];
    if (operatorshipSection.singleChoice) {
        for (NSNumber *row in operatorshipSection.selectedRows) {
            ETGOperatorship *selectedOperatorship = [operatorshipSection.values objectAtIndex:[row integerValue]];
            [selectedOperatorshipKeys addObject:selectedOperatorship.key];
        }
    } else {
        for (NSNumber *row in operatorshipSection.selectedRows) {
            ETGOperatorship *selectedOperatorship = [operatorshipSection.values objectAtIndex:([row integerValue] - 1)];
            [selectedOperatorshipKeys addObject:selectedOperatorship.key];
        }
    }

    
    NSMutableArray *selectedPhaseKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *phaseSection = [_sectionInfoArray objectAtIndex:kPHASE];
    if (phaseSection.singleChoice) {
        for (NSNumber *row in phaseSection.selectedRows) {
            ETGPhase *selectedPhase = [phaseSection.values objectAtIndex:[row integerValue]];
            [selectedPhaseKeys addObject:selectedPhase.key];
        }
    } else {
        for (NSNumber *row in phaseSection.selectedRows) {
            ETGPhase *selectedPhase = [phaseSection.values objectAtIndex:([row integerValue] - 1)];
            [selectedPhaseKeys addObject:selectedPhase.key];
        }
    }
    
    NSMutableArray *selectedRegionKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *regionSection = [_sectionInfoArray objectAtIndex:kREGION];
    for (NSNumber *row in regionSection.selectedRows) {
        ETGRegion *selectedRegion = [regionSection.values objectAtIndex:[row integerValue] - 1];
        [selectedRegionKeys addObject:selectedRegion.key];
    }
    
    NSMutableArray *selectedProjectStatusKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *projectStatusSection = [_sectionInfoArray objectAtIndex:KPROJECTSTATUS];
    for (NSNumber *row in projectStatusSection.selectedRows) {
        ETGProjectStatus *selectedProjectStatus = [projectStatusSection.values objectAtIndex:[row integerValue] - 1];
        [selectedProjectStatusKeys addObject:selectedProjectStatus.key];
    }
    
    NSArray *fetchedProjectObjects = [[ETGFilterModelController sharedController] fetchProjectsBaseOnOperatorships:selectedOperatorshipKeys phases:selectedPhaseKeys regions:selectedRegionKeys projectStatuses:selectedProjectStatusKeys reportingMonth:reportingMonthString];
    
    //Update Apply bar button
    self.navigationItem.rightBarButtonItem.enabled = fetchedProjectObjects.count > 0 ? YES : NO;
    
    return fetchedProjectObjects;
}



- (void)clearAllValueOfSection:(ETGSectionInfo *)sectionInfo {
    [sectionInfo.values removeAllObjects];
    [sectionInfo.selectedRows removeAllObjects];
}

- (void)reloadBudgetHolderSectionBaseOnNewProjectList:(NSArray *)projectObjects
{
    ETGSectionInfo *budgetHolderSection = [_sectionInfoArray objectAtIndex:KBUDGETHOLDER];
    [self clearAllValueOfSection:budgetHolderSection];
    
    if ([projectObjects count] > 0) {
        NSArray *budgetHoldersArray = [self filterBudgetHoldersBaseOnProjects:projectObjects];
        
        if ([budgetHoldersArray count] > 0) {
            [budgetHolderSection.values addObjectsFromArray:budgetHoldersArray];
            [self setDefaultSelectionForBudgetHolderSection:budgetHolderSection];
        }
    }
    
    [self reloadSectionAtIndex:KBUDGETHOLDER];
}

- (void)reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:(ETGProject *)selectedProject
{
    ETGSectionInfo *baselineTypeSection = [_sectionInfoArray objectAtIndex:KBASELINETYPE];
    [self clearAllValueOfSection:baselineTypeSection];
    
    ETGSectionInfo *revisionSection = [_sectionInfoArray objectAtIndex:KREVISION];
    [self clearAllValueOfSection:revisionSection];
    
    
    [self setBaselineTypeAndRevisionSectionValues:baselineTypeSection revisionSection:revisionSection forProject:selectedProject];
}

- (NSArray *)filterBudgetHoldersBaseOnProjects:(NSArray *)projects
{
    NSMutableArray *filteredBudgetHolders = [[NSMutableArray alloc] init];

    if ([_moduleName isEqualToString:@"project"])
    {
        //Project module
        if (projects.count > 0) {
            ETGProject *selectedProject = projects[0];
            [filteredBudgetHolders addObjectsFromArray:[selectedProject.budgetHolders allObjects]];
        }
    } else
    {
        //Portfolio module
        NSArray *allBudgetHolders = [CommonMethods fetchEntity:@"ETGCostAllocation" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext];
        NSPredicate *bhPredicate = [NSPredicate predicateWithFormat:@"ANY projects IN %@", projects];
        [filteredBudgetHolders addObjectsFromArray:[allBudgetHolders filteredArrayUsingPredicate:bhPredicate]];
        
        /*
        for (ETGCostAllocation *budgetHolder in allBudgetHolders) {
            BOOL matched = NO;
            for (ETGCpb *cpb in budgetHolder.cpbs) {
                if ([projects containsObject:cpb.portfolio.project]) {
                    matched = YES;
                    break;
                }
            }
            
            if (matched) {
                [filteredBudgetHolders addObject:budgetHolder];
            }
        }*/
    }

    return filteredBudgetHolders;
}


#pragma mark - Section header delegate

-(void)sectionHeaderView:(ETGSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
    
	ETGSectionInfo *sectionInfo = (self.sectionInfoArray)[sectionOpened];
    
    if (!sectionInfo.open) {
        // Set section open status
        sectionInfo.open = YES;
        
        /*
         Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section
         */
        NSInteger countOfRowsToInsert;
        if (sectionOpened == [self getReportingMonthSection]) {
            countOfRowsToInsert = 1;
        } else {
            if (sectionInfo.singleChoice == YES) {
                countOfRowsToInsert = [sectionInfo.values count];
            } else {
                countOfRowsToInsert = [sectionInfo.values count] + 1;
            }
        }
        
        NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
            [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
        }
        
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
            if (previousOpenSectionIndex == [self getReportingMonthSection]) {
                countOfRowsToDelete = 1;
            } else {
                if (previousOpenSection.singleChoice == YES) {
                    countOfRowsToDelete = [previousOpenSection.values count];
                } else {
                    countOfRowsToDelete = [previousOpenSection.values count] + 1;
                }
            }
            
            for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
                [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
            }
        }
        
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
    } else {
        [sectionInfo.headerView toggleOpenWithUserAction:YES];
    }
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

        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}


#pragma mark - Reporting Month Date Picker View Delegate

- (void)monthPickerDidChangeDate:(SRMonthPicker *)monthPicker
{
    [self updateSelectedReportingMonthValueLabel:monthPicker.date];
    [self disableUserInteractionOnAllSectionExceptReportingMonthSection];
    
    if (!self.tableFooterView.hidden) {
        self.tableFooterView.hidden = YES;
    }
    
    if (self.navigationItem.leftBarButtonItem == _cancelBarButton) {
        self.navigationItem.leftBarButtonItem = _defaultBarButton;
    }
    
    //Timer
    if (_reportingMonthChangedTimer) {
        [_reportingMonthChangedTimer invalidate];
    }
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeEnableBaseFilterNotificationInNSUserDefaults:@"N"];
    _reportingMonthChangedTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getProjectBaseFiltersDataForReportingMonth:) userInfo:monthPicker.date repeats:NO];
}

- (void)updateSelectedReportingMonthValueLabel:(NSDate *)selectedDate
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:selectedDate];
    ETGSectionInfo *sectionInfo = [_sectionInfoArray objectAtIndex:[self getReportingMonthSection]];
    sectionInfo.headerView.categoryValueLabel.text = [NSString stringWithFormat:@"%d/%d", [dateComponents month], [dateComponents year]];
}

- (void)disableUserInteractionOnBaselineTypeAndRevisionNoSections
{
//    if ([_moduleName isEqualToString:@"project"]) {
        ETGSectionInfo *baselineTypeSection = _sectionInfoArray[KBASELINETYPE];
        [baselineTypeSection.headerView setUserInteractionEnabled:NO];
        [baselineTypeSection.headerView setAlpha:0.3];
        
        ETGSectionInfo *revisionSection = _sectionInfoArray[KREVISION];
        [revisionSection.headerView setUserInteractionEnabled:NO];
        [revisionSection.headerView setAlpha:0.3];
//    }
    
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)disableUserInteractionOnAllSectionExceptReportingMonthSection
{
    for (ETGSectionInfo *sectionInfo in _sectionInfoArray) {
        [sectionInfo.headerView setUserInteractionEnabled:NO];
        sectionInfo.headerView.alpha = 0.3;
    }
    
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:(BOOL)isEnable
{
    for (ETGSectionInfo *sectionInfo in _sectionInfoArray) {
        [sectionInfo.headerView setUserInteractionEnabled:YES];
        sectionInfo.headerView.alpha = 1.0;
    }
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    
    self.navigationItem.rightBarButtonItem = _applyBarButton;
    if (isEnable) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)getProjectBaseFiltersDataForReportingMonth:(NSTimer *)sender
{
    ETGSectionInfo *reportingMonthSection = _sectionInfoArray[kREPORTINGPERIOD];
    NSDate *previousSelectedDate = reportingMonthSection.selectedRows[0];
    NSDate *selectedDate = sender.userInfo;
    if (![selectedDate isEqualToDate:previousSelectedDate])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_activityIndicator];
        [reportingMonthSection.selectedRows replaceObjectAtIndex:0 withObject:selectedDate];
        
        ETGSectionInfo *projectSection = [_sectionInfoArray objectAtIndex:KPROJECT];
        [self clearAllValueOfSection:projectSection];
        
        //Check offline data
        NSArray *fetchedProjectObjects = [self filterProjectList];
        
        //TODO: Check time stamp
        if ([fetchedProjectObjects count] > 0) {
            [projectSection.values addObjectsFromArray:fetchedProjectObjects];
            
            //Select project
            if (projectSection.singleChoice) {
                [projectSection.selectedRows addObject:@0];
                [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:projectSection.values[0]];
            } else {
                for (NSInteger i = 0; i < [projectSection.values count]; i++) {
                    [projectSection.selectedRows addObject:@(i + 1)];
                }
            }
            
            //Reload
            [self reloadBudgetHolderSectionBaseOnNewProjectList:fetchedProjectObjects];
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
            // Reload all sections
            [self reloadSections];
        } else {
            //Download new data from server
         
            ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            [ETGNetworkConnection checkAvailability];
            
            if (appDelegate.isNetworkServerAvailable == YES) {

            NSString *reportingMonthString = [_dateFormatter stringFromDate:selectedDate];
            [[ETGFilterModelController sharedController] getProjectInfosBaseFiltersForReportingMonth:reportingMonthString];
            }else{
                [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:NO];
                
                self.tableFooterView.hidden = NO;
                self.navigationItem.rightBarButtonItem = _applyBarButton;
                self.navigationItem.rightBarButtonItem.enabled = NO;
                self.isNoProjectData = NO;
            }
        }
    } else {
        [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
        // Reload all sections
//        [self reloadSections];
    }
}


#pragma mark - Notification handler

- (void)reloadFilterForSelectedReportingMonth
{
    ETGSectionInfo *projectSection = [_sectionInfoArray objectAtIndex:KPROJECT];
    
    NSArray *fetchedProjectObjects = [self filterProjectList];
    if ([fetchedProjectObjects count] > 0) {
        [projectSection.values addObjectsFromArray:fetchedProjectObjects];
        [self setDefaultSelectionForProjectSection:projectSection];
        [self reloadBudgetHolderSectionBaseOnNewProjectList:fetchedProjectObjects];

        if ([_moduleName isEqualToString:@"project"]) {
            NSInteger selectedRow = [projectSection.selectedRows[0] integerValue];
            ETGProject *project = [projectSection.values objectAtIndex:selectedRow];
            [self checkDataAvailableAndReloadBaselineTypeAndRevisionNoForProject:project];
        } else {
            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
            // Reload all sections
            [self reloadSections];
        }
    } else {
        
        if ([_moduleName isEqualToString:@"project"]) {
            [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:nil];
        }
        [self reloadBudgetHolderSectionBaseOnNewProjectList:nil];
        [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:NO];
        // Reload all sections
        [self reloadSections];
    }
}

- (void)checkDataAvailableAndReloadBaselineTypeAndRevisionNoForProject:(ETGProject *)project
{
    NSDate *reportingMonth = [[_sectionInfoArray[kREPORTINGPERIOD] selectedRows] objectAtIndex:0];
    
    BOOL gotData = NO;
    for (ETGProjectSummary *projectSummary in project.projects) {
        //TODO: Verify date conversion
//        NSDate *reportingMonthDate = [_dateFormatter dateFromString:projectSummary.reportingMonth.name];
        NSDate *reportingMonthDate = projectSummary.reportingMonth.name;
        if ([CommonMethods isMonthOfDate:reportingMonthDate equalToDate:reportingMonth]) {
            gotData = YES;
            break;
        }
    }
    
    if (gotData) {
        [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:project];
        [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
        // Reload all sections
        [self reloadSections];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_activityIndicator];

        ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        if (appDelegate.isNetworkServerAvailable == YES) {

            [[ETGProjectModelController sharedModel] getProjectForReportingMonth:[_dateFormatter stringFromDate:reportingMonth] withProjectKey:[project.key stringValue] withKeyMilestonesData:nil withProjectReports:nil success:^(NSString *jsonString) {

                [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:project];
                [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
                // Reload all sections
                [self reloadSections];
            } failure:^(NSError *error) {
                
                [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:nil];
                [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
                // Reload all sections
                [self reloadSections];
            }];
        } else {
//            [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:nil];
//            [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
//            // Reload all sections
//            [self reloadSections];
            self.isNoProjectData =  YES;
            self.isNoProjectData2 = YES;
            
        }
    }
}

- (void)reloadFilterForSelectedReportingMonthWithErrorLoadingMessage
{
    self.tableFooterView.hidden = NO;
    
    self.navigationItem.rightBarButtonItem = _applyBarButton;
}

//- (void)reloadFilterForSelectedReportingMonthWithoutErrorLoadingMessage
//{
//    [self reloadFilterForSelectedReportingMonth];
//    self.tableFooterView.hidden = YES;
//    self.navigationItem.rightBarButtonItem = _applyBarButton;
//}

- (void)testProjectListForGivenReportingMonth
{
    NSArray *fetchedReportingMonths = [CommonMethods fetchEntity:@"ETGReportingMonth" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext];
    for (ETGReportingMonth *reportingMonth in fetchedReportingMonths) {
        //NSLog(@"\nReporting Month: %@", reportingMonth.name);
        for (ETGProject *project in reportingMonth.projects) {
            //NSLog(@"Project Name: %@", project.name);
        }
    }
}

- (void)reloadBaselineTypeAndRevisionSections
{
    ETGSectionInfo *projectSection = _sectionInfoArray[KPROJECT];
    NSInteger selectedRow = [[projectSection.selectedRows objectAtIndex:0] integerValue];
    ETGProject *selectedProject = [projectSection.values objectAtIndex:selectedRow];
    [self reloadBaselineTypeAndRevisionNoBaseOnNewSelectedProject:selectedProject];
}


#pragma mark - Actions

- (IBAction)handleCancelBarButtonPressed:(UIBarButtonItem *)sender {
    [self.delegate filtersViewControllerDidCancel];
}

- (IBAction)handleDefaultBarButtonPressed:(UIBarButtonItem *)sender {
    
    for (ETGSectionInfo *sectionInfo in _sectionInfoArray) {
        if (sectionInfo.headerView.disclosureButton.selected) {
            [sectionInfo.headerView toggleOpenWithUserAction:YES];
        }
        [sectionInfo.selectedRows removeAllObjects];
    }
    
    [self setDefaultSelectionForReportingMonthSection:_sectionInfoArray[kREPORTINGPERIOD] operatorshipSection:_sectionInfoArray[kOPERATORSHIP] phaseSection:_sectionInfoArray[kPHASE] regionSection:_sectionInfoArray[kREGION] projectStatusSection:_sectionInfoArray[KPROJECTSTATUS]];
    [self updateProjectSection];
    [self.tableView reloadData];
    
    self.navigationItem.leftBarButtonItem = _cancelBarButton;
    self.tableFooterView.hidden = YES;
    self.isNoProjectData = NO;

}

- (IBAction)handleApplyBarButtonPressed:(UIBarButtonItem *)sender {
    
    NSMutableDictionary *projectsDictionary = [[NSMutableDictionary alloc] initWithCapacity:5];

    //Selected Reporting Month
    ETGSectionInfo *reportingMonthSection = [_sectionInfoArray objectAtIndex:kREPORTINGPERIOD];
    NSDate *selectedReportingMonth = [reportingMonthSection.selectedRows objectAtIndex:0];
    [projectsDictionary setObject:selectedReportingMonth forKey:kSelectedReportingMonth];
    
    //Selected Projects
    NSMutableArray *selectedProjects = [[NSMutableArray alloc] init];
    ETGSectionInfo *projectSection = [_sectionInfoArray objectAtIndex:KPROJECT];

    if (projectSection.singleChoice && projectSection.values.count > 0) {
        NSInteger selectedRow = [[projectSection.selectedRows objectAtIndex:0] integerValue];
        [selectedProjects addObject:[projectSection.values objectAtIndex:selectedRow]];
    } else {
        for (NSNumber *row in projectSection.selectedRows) {
            ETGProject *selectedProject = [projectSection.values objectAtIndex:[row integerValue] - 1];
            [selectedProjects addObject:selectedProject];
        }
    }
    if (selectedProjects.count > 0) {
        [projectsDictionary setObject:selectedProjects forKey:kSelectedProjects];
    } else{
        if (![_moduleName isEqualToString:@"project"]) {
            NSArray *fetchedProjectObjects = [self filterProjectList];
            if ([fetchedProjectObjects count] > 0) {
                [projectsDictionary setObject:fetchedProjectObjects forKey:kSelectedProjects];
            }
        }
    }
    
    //Selected budget holder
    ETGCostAllocation *budgetHolder;
    ETGSectionInfo *budgetHolderSection = [_sectionInfoArray objectAtIndex:KBUDGETHOLDER];
    for (NSNumber *selectedRow in budgetHolderSection.selectedRows) {
        budgetHolder = [budgetHolderSection.values objectAtIndex:[selectedRow integerValue]];
        [projectsDictionary setObject:budgetHolder forKey:kSelectedBudgetHolder];
    }
    
    if ([_moduleName isEqualToString:@"project"]) {
        
        //KeyMilestone for selected baseline type and selected revision no
        ETGSectionInfo *baselineTypeSection = [_sectionInfoArray objectAtIndex:KBASELINETYPE];
        if ([baselineTypeSection.selectedRows count] > 0) {
            NSInteger selectedRow = [[baselineTypeSection.selectedRows objectAtIndex:0] integerValue];
            ETGBaselineType *selectedBaselineType = [baselineTypeSection.values objectAtIndex:selectedRow];
            
            //Selected revision
            ETGSectionInfo *revisionSection = [_sectionInfoArray objectAtIndex:KREVISION];
            NSInteger selectedRevisionRow = [[revisionSection.selectedRows objectAtIndex:0] integerValue];
            if ([revisionSection.values count] > selectedRevisionRow) {
                ETGRevision *selectedRevision = [revisionSection.values objectAtIndex:selectedRevisionRow];
                
                NSArray *keyMilestones = [[ETGFilterModelController sharedController] getKeyMilestoneWithBaselineType:selectedBaselineType revision:selectedRevision];
                
                if ([keyMilestones count] > 0) {
                    [projectsDictionary setObject:keyMilestones forKey:kSelectedKeyMilestone];
                }
            }
        }
    } else {
        //Selected Operatorship
        ETGSectionInfo *operatorshipSection = [_sectionInfoArray objectAtIndex:kOPERATORSHIP];
        if ([operatorshipSection.selectedRows count] > 0) {
            NSInteger selectedOperatorshipRow = [[operatorshipSection.selectedRows objectAtIndex:0] integerValue];
            NSString *selectedOperatorship = [[operatorshipSection.values objectAtIndex:selectedOperatorshipRow] name];
            if (selectedOperatorship) {
                [projectsDictionary setObject:selectedOperatorship forKey:kSelectedOperatorship];
            }
        }
        
        //Selected Phase
        ETGSectionInfo *phaseSection = [_sectionInfoArray objectAtIndex:kPHASE];
        if ([phaseSection.selectedRows count] > 0) {
            NSInteger selectedPhaseRow = [[phaseSection.selectedRows objectAtIndex:0] integerValue];
            NSString *selectedPhase = [[phaseSection.values objectAtIndex:selectedPhaseRow] name];
            if (selectedPhase) {
                [projectsDictionary setObject:selectedPhase forKey:kSelectedPhase];
            }
        }
    }
    
    [self.delegate filtersViewControllerDidFinishWithProjectsDictionary:projectsDictionary];
    self.isNoProjectData = NO;

}


- (NSArray *)currentSelectedSectionRows {
    NSMutableArray *selectedSectionRows = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [_sectionInfoArray count]; i++) {
        ETGSectionInfo *sectionInfo = _sectionInfoArray[i];
        [selectedSectionRows addObject:sectionInfo.selectedRows];
    }
    
    return selectedSectionRows;
}

- (void)setDefaultSelectionForAnySection:(ETGSectionInfo *)section
{
    if (section.singleChoice) {
        [section.selectedRows addObject:@0];
    } else {
        for (NSInteger i = 0; i < [section.values count]; i++) {
            [section.selectedRows addObject:@(i + 1)];
        }
    }
}

-(int)getReportingMonthSection
{
    return kREPORTINGPERIOD;
}
        
- (void)reloadSections
{
    if ([_moduleName isEqualToString:@"project"]) {
        [self reloadSectionAtIndex:KPROJECT];
        [self reloadSectionAtIndex:KBUDGETHOLDER];
        [self reloadSectionAtIndex:KBASELINETYPE];
        [self reloadSectionAtIndex:KREVISION];
    } else { // Portfolio
        [self reloadSectionAtIndex:KPROJECT];
        [self reloadSectionAtIndex:KBUDGETHOLDER];
    }
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    [self updateRefreshButtonWithReachability:curReach];
}

- (void)updateRefreshButtonWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    if (netStatus != NotReachable) {
        [self enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:YES];
        self.tableFooterView.hidden = YES;
        self.navigationItem.rightBarButtonItem.enabled = NO;

    }
}
@end
