//
//  ETGCpbFiltersViewController.m
//  ETG
//
//  Created by Tan Aik Keong on 1/28/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGEccrCpbFiltersViewController.h"
#import "ETGRegion.h"
#import "ETGCostAllocation.h"
#import "ETGOperatorship.h"

enum section {
    kBUDGETHOLDER,
    kCOSTCATEGORY,
    kOPERATORSHIP,
    kREGION,
    kPROJECT,
    kREPORTINGPERIOD,
};

@interface ETGEccrCpbFiltersViewController ()

@end

@implementation ETGEccrCpbFiltersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(NSMutableArray *)getCostAllocationWithouEmptyValue
{
    NSArray *results = [CommonMethods fetchEntity:@"ETGCostAllocation" sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext];
    NSMutableArray *temp = [NSMutableArray new];
    for(ETGCostAllocation *allocation in results)
    {
        if([allocation.name length] > 0)
        {
            [temp addObject:allocation];
        }
    }
    return temp;
}

- (void)initEccrSectionInfoValues
{
    ETGSectionInfo *budgetHolderSectionInfo = [[ETGSectionInfo alloc] init];
    budgetHolderSectionInfo.name = @"Budget Holder";
    budgetHolderSectionInfo.singleChoice = YES;
    budgetHolderSectionInfo.open = NO;
    budgetHolderSectionInfo.values = [self getCostAllocationWithouEmptyValue];
    budgetHolderSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *costCategorySectionInfo = [[ETGSectionInfo alloc] init];
    costCategorySectionInfo.name = @"Cost Category";
    costCategorySectionInfo.singleChoice = YES;
    costCategorySectionInfo.open = NO;
    costCategorySectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGCostCategory" sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    costCategorySectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *operatorshipSectionInfo = [[ETGSectionInfo alloc] init];
    operatorshipSectionInfo.name = @"Operatorship";
    operatorshipSectionInfo.singleChoice = NO;
    operatorshipSectionInfo.open = NO;
    operatorshipSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGOperatorship" sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    operatorshipSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *regionSectionInfo = [[ETGSectionInfo alloc] init];
    regionSectionInfo.name = @"Region";
    regionSectionInfo.singleChoice = NO;
    regionSectionInfo.open = NO;
    regionSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGRegion" sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    regionSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *projectSectionInfo = [[ETGSectionInfo alloc] init];
    projectSectionInfo.name = @"Project";
    projectSectionInfo.open = NO;
    projectSectionInfo.singleChoice = NO;
    projectSectionInfo.values = [NSMutableArray new];
    projectSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *reportingPeriodSectionInfo = [[ETGSectionInfo alloc] init];
    reportingPeriodSectionInfo.name = @"Reporting Period";
    reportingPeriodSectionInfo.open = YES;
    reportingPeriodSectionInfo.singleChoice = YES;
    reportingPeriodSectionInfo.values = [[NSMutableArray alloc] init];
    reportingPeriodSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    self.openSectionIndex = [self getReportingMonthSection];
    
    self.sectionInfoArray = [[NSMutableArray alloc] init];
    [self.sectionInfoArray addObject:budgetHolderSectionInfo];
    [self.sectionInfoArray addObject:costCategorySectionInfo];
    [self.sectionInfoArray addObject:operatorshipSectionInfo];
    [self.sectionInfoArray addObject:regionSectionInfo];
    [self.sectionInfoArray addObject:projectSectionInfo];
    [self.sectionInfoArray addObject:reportingPeriodSectionInfo];
    
    //Set selected rows for others
    if ([self.selectedRowsInFilter count] > 0)
    {
        //set last selected rows in sections
        [reportingPeriodSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kREPORTINGPERIOD]];
        [budgetHolderSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kBUDGETHOLDER]];
        [costCategorySectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kCOSTCATEGORY]];
        [operatorshipSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kOPERATORSHIP]];
        [regionSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kREGION]];
        projectSectionInfo.values = [[self filterProjectList] mutableCopy];
        [projectSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kPROJECT]];
    }
    else
    {
        [self setDefaultSelectionForOtherSection];
        projectSectionInfo.values = [[self filterProjectList] mutableCopy];
        [self setDefaultSelectionForProjectSection:projectSectionInfo];
    }
    
    //Update Apply bar button
    if(regionSectionInfo.values.count == 0 || projectSectionInfo.selectedRows.count == 0)
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    
    [self updateDisplayAccordingToConnection];
}

- (void)setDefaultSelectionForOtherSection
{
    ETGSectionInfo *reportingPeriodSection = self.sectionInfoArray[kREPORTINGPERIOD];
    ETGSectionInfo *budgetHolderSectionInfo = self.sectionInfoArray[kBUDGETHOLDER];
    ETGSectionInfo *costCategorySectionInfo = self.sectionInfoArray[kCOSTCATEGORY];
    ETGSectionInfo *operatorshipSection = self.sectionInfoArray[kOPERATORSHIP];
    ETGSectionInfo *regionSection = self.sectionInfoArray[kREGION];
    
    [reportingPeriodSection.selectedRows addObject:[CommonMethods latestReportingMonth]];
    
    // Default budget holder is Projects & Engineering
    for (NSInteger i = 0; i < [budgetHolderSectionInfo.values count]; i++) {
        ETGCostAllocation *allocation = (ETGCostAllocation *)budgetHolderSectionInfo.values[i];
        if([allocation.name isEqualToString:@"Projects & Engineering"])
        {
            [budgetHolderSectionInfo.selectedRows addObject:@(i)];
            break;
        }
    }
    
    [costCategorySectionInfo.selectedRows addObject:@(0)];
    
    for (NSInteger i = 0; i < [operatorshipSection.values count]; i++) {
        [operatorshipSection.selectedRows addObject:@(i + 1)];
    }
    
    for (NSInteger i = 0; i < [regionSection.values count]; i++) {
        [regionSection.selectedRows addObject:@(i + 1)];
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
    
    NSMutableArray *selectedOperatorshipKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *operatorshipSection = [self.sectionInfoArray objectAtIndex:kOPERATORSHIP];
    for (NSNumber *row in operatorshipSection.selectedRows) {
        ETGOperatorship *selectedOperatorship = [operatorshipSection.values objectAtIndex:[row integerValue] - 1];
        [selectedOperatorshipKeys addObject:selectedOperatorship.key];
    }
    
    NSArray *fetchedProjectObjects = [[ETGFilterModelController sharedController] fetchEccrProjectsBaseOnOperatorships:selectedOperatorshipKeys regions:selectedRegionKeys reportingMonth:reportingMonthString];
    
    //Update Apply bar button
    self.navigationItem.rightBarButtonItem.enabled = fetchedProjectObjects.count > 0 ? YES : NO;
    
    return fetchedProjectObjects;
}

-(NSMutableDictionary *)getProjectsDictionary
{
    NSMutableDictionary *projectsDictionary = [NSMutableDictionary new];
    //Selected Reporting Month
    ETGSectionInfo *reportingMonthSection = [self.sectionInfoArray objectAtIndex:kREPORTINGPERIOD];
    NSDate *selectedReportingMonth = [reportingMonthSection.selectedRows objectAtIndex:0];
    [projectsDictionary setObject:selectedReportingMonth forKey:kSelectedReportingMonth];
    
    //Selected Projects
    NSMutableArray *selectedProjects = [[NSMutableArray alloc] init];
    ETGSectionInfo *projectSection = [self.sectionInfoArray objectAtIndex:[self getProjectSection]];
    for (NSNumber *row in projectSection.selectedRows)
    {
        ETGProject *selectedProject = [projectSection.values objectAtIndex:[row integerValue] - 1];
        [selectedProjects addObject:selectedProject];
    }
    [projectsDictionary setObject:selectedProjects forKey:kSelectedProjects];
    
    // Selected budget holder
    NSMutableArray *selectedBudgetHolders = [[NSMutableArray alloc] init];
    ETGSectionInfo *budgetHolderSection = [self.sectionInfoArray objectAtIndex:kBUDGETHOLDER];
    for (NSNumber *row in budgetHolderSection.selectedRows)
    {
        ETGCostAllocation *selectedBudgetHolder = [budgetHolderSection.values objectAtIndex:[row integerValue]];
        [selectedBudgetHolders addObject:selectedBudgetHolder];
    }
    [projectsDictionary setObject:selectedBudgetHolders forKey:kSelectedBudgetHolder];
    
    // Selected cost category
    NSMutableArray *selectedCostCategories = [[NSMutableArray alloc] init];
    ETGSectionInfo *costCategorySection = [self.sectionInfoArray objectAtIndex:kCOSTCATEGORY];
    for (NSNumber *row in costCategorySection.selectedRows)
    {
        ETGCostCategory *selectedCostCategory = [costCategorySection.values objectAtIndex:[row integerValue]];
        [selectedCostCategories addObject:selectedCostCategory];
    }
    [projectsDictionary setObject:selectedCostCategories forKey:kSelectedCostCategory];
    return projectsDictionary;
}

- (IBAction)handleApplyBarButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate filtersViewControllerDidFinishWithProjectsDictionary:[self getProjectsDictionary]];
}

-(int)getRegionSection
{
    return kREGION;
}

-(int)getProjectSection
{
    return kPROJECT;
}

-(int)getBudgetHolderSection
{
    return kBUDGETHOLDER;
}

-(int)getReportingMonthSection
{
    return kREPORTINGPERIOD;
}

-(int)getOperatorShipSection
{
    return kOPERATORSHIP;
}

@end
