//
//  ETGEccrAbrFiltersViewController.m
//  ETG
//
//  Created by Tan Aik Keong on 1/28/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGEccrAbrFiltersViewController.h"
#import "ETGRegion.h"
#import "ETGEccrAbrWebService.h"
#import "ETGEccrModelController.h"

enum section {
    kREGION,
    kCOSTCATEGORY,
    kPROJECT,
    kREPORTINGPERIOD,
};
@interface ETGEccrAbrFiltersViewController ()

@end

@implementation ETGEccrAbrFiltersViewController

- (void)initEccrSectionInfoValues
{
    ETGSectionInfo *costCategorySectionInfo = [[ETGSectionInfo alloc] init];
    costCategorySectionInfo.name = @"Cost Category";
    costCategorySectionInfo.singleChoice = YES;
    costCategorySectionInfo.open = NO;
    costCategorySectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGCostCategory" sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    costCategorySectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *regionSectionInfo = [[ETGSectionInfo alloc] init];
    regionSectionInfo.name = @"Region";
    regionSectionInfo.singleChoice = NO;
    regionSectionInfo.open = NO;
    regionSectionInfo.values = [NSMutableArray arrayWithArray:[CommonMethods fetchEntity:@"ETGRegion" sortDescriptorKey:@"name" inManagedObjectContext:self.managedObjectContext]];
    regionSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *projectSectionInfo = [[ETGSectionInfo alloc] init];
    projectSectionInfo.name = @"Project";
    projectSectionInfo.singleChoice = NO;
    projectSectionInfo.open = NO;
    projectSectionInfo.values = [NSMutableArray new];
    projectSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *reportingPeriodSectionInfo = [[ETGSectionInfo alloc] init];
    reportingPeriodSectionInfo.name = @"Reporting Period";
    reportingPeriodSectionInfo.singleChoice = YES;
    reportingPeriodSectionInfo.open = YES;
    self.openSectionIndex = [self getReportingMonthSection];
    reportingPeriodSectionInfo.values = [[NSMutableArray alloc] init];
    reportingPeriodSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    self.sectionInfoArray = [[NSMutableArray alloc] init];
    [self.sectionInfoArray addObject:regionSectionInfo];
    [self.sectionInfoArray addObject:costCategorySectionInfo];
    [self.sectionInfoArray addObject:projectSectionInfo];
    [self.sectionInfoArray addObject:reportingPeriodSectionInfo];
    self.openSectionIndex = [self getReportingMonthSection];
    
    //Set selected rows for others
    if ([self.selectedRowsInFilter count] > 0)
    {
        //set last selected rows in sections
        [reportingPeriodSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kREPORTINGPERIOD]];
        [costCategorySectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kCOSTCATEGORY]];
        [regionSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kREGION]];
        projectSectionInfo.values = [[self filterProjectList] mutableCopy];
        [projectSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kPROJECT]];    }
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
}

- (void)setDefaultSelectionForOtherSection
{
    ETGSectionInfo *reportingPeriodSection = self.sectionInfoArray[kREPORTINGPERIOD];
    ETGSectionInfo *costCategorySectionInfo = self.sectionInfoArray[kCOSTCATEGORY];
    ETGSectionInfo *regionSection = self.sectionInfoArray[kREGION];
    
    [reportingPeriodSection.selectedRows addObject:[CommonMethods latestReportingMonth]];
    
    [costCategorySectionInfo.selectedRows addObject:@(0)];
    
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
    
    NSArray *fetchedProjectObjects = [[ETGFilterModelController sharedController] fetchEccrProjectsBaseOnRegions:selectedRegionKeys reportingMonth:reportingMonthString];
    
    //Update Apply bar button
    self.navigationItem.rightBarButtonItem.enabled = fetchedProjectObjects.count > 0 ? YES : NO;
    
    return fetchedProjectObjects;
}

- (IBAction)handleApplyBarButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate filtersViewControllerDidFinishWithProjectsDictionary:[self getProjectsDictionary]];
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

-(int)getReportingMonthSection
{
    return kREPORTINGPERIOD;
}

-(int)getProjectSection
{
    return kPROJECT;
}

-(int)getRegionSection
{
    return kREGION;
}

@end
