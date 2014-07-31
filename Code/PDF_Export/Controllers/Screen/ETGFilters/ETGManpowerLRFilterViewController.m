//
//  ETGManpowerLRFilterViewController.m
//  ETG
//
//  Created by Helmi Hasan on 2/26/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGManpowerLRFilterViewController.h"
#import "ETGYear.h"
#import "ETGSection.h"
#import "ETGDepartment.h"
#import "ETGManPowerModelController.h"
#import "ETGDivision.h"
#import "ETGMpCluster.h"
#import "ETGMpRegion.h"
#import "ETGMpProject.h"
#import "ETGCountries.h"

enum section {
    kREPORTINGPERIOD,
    kYEAR,
    kDEPARTMENT,
    kSECTION,
    kREGION,
    kCLUSTER,
    kPROJECT,
    kPROJECTPOSITION
};

@interface ETGManpowerLRFilterViewController ()

@end

@implementation ETGManpowerLRFilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)initManpowerSectionInfoValues
{
    ETGSectionInfo *reportingPeriodSectionInfo = [[ETGSectionInfo alloc] init];
    reportingPeriodSectionInfo.name = @"Reporting Period";
    reportingPeriodSectionInfo.open = YES;
    reportingPeriodSectionInfo.singleChoice = YES;
    reportingPeriodSectionInfo.values = [[NSMutableArray alloc] init];
    reportingPeriodSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    self.openSectionIndex = [self getReportingPeriodSection];
    
    ETGSectionInfo *yearSectionInfo = [[ETGSectionInfo alloc] init];
    yearSectionInfo.name = @"Year";
    yearSectionInfo.singleChoice = NO;
    yearSectionInfo.open = NO;
    yearSectionInfo.values = [[self filterYearList] mutableCopy];
    yearSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *departmentSectionInfo = [[ETGSectionInfo alloc] init];
    departmentSectionInfo.name = @"Department";
    departmentSectionInfo.singleChoice = NO;
    departmentSectionInfo.open = NO;
    departmentSectionInfo.values = [[self filterDepartmentList] mutableCopy];
    departmentSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *sectionSectionInfo = [[ETGSectionInfo alloc] init];
    sectionSectionInfo.name = @"Section";
    sectionSectionInfo.singleChoice = NO;
    sectionSectionInfo.open = NO;
    sectionSectionInfo.values = [[self filterSectionList] mutableCopy];
    sectionSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *regionSectionInfo = [[ETGSectionInfo alloc] init];
    regionSectionInfo.name = @"Region";
    regionSectionInfo.singleChoice = NO;
    regionSectionInfo.open = NO;
    regionSectionInfo.values = [[self filterRegionList] mutableCopy];
    regionSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *clusterSectionInfo = [[ETGSectionInfo alloc] init];
    clusterSectionInfo.name = @"Cluster";
    clusterSectionInfo.singleChoice = NO;
    clusterSectionInfo.open = NO;
    clusterSectionInfo.values = [[self filterClusterList] mutableCopy];
    clusterSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *projectSectionInfo = [[ETGSectionInfo alloc] init];
    projectSectionInfo.name = @"Project";
    projectSectionInfo.singleChoice = NO;
    projectSectionInfo.open = NO;
    projectSectionInfo.values = [[self LRfilterProjectList] mutableCopy];
    projectSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    ETGSectionInfo *projectPositionSectionInfo = [[ETGSectionInfo alloc] init];
    projectPositionSectionInfo.name = @"Project Position";
    projectPositionSectionInfo.singleChoice = NO;
    projectPositionSectionInfo.open = NO;
    projectPositionSectionInfo.values = [[self filterProjectPositionList] mutableCopy];
    projectPositionSectionInfo.selectedRows = [[NSMutableArray alloc] init];
    
    self.sectionInfoArray = [[NSMutableArray alloc] init];
    [self.sectionInfoArray addObject:reportingPeriodSectionInfo];
    [self.sectionInfoArray addObject:yearSectionInfo];
    [self.sectionInfoArray addObject:departmentSectionInfo];
    [self.sectionInfoArray addObject:sectionSectionInfo];
    [self.sectionInfoArray addObject:regionSectionInfo];
    [self.sectionInfoArray addObject:clusterSectionInfo];
    [self.sectionInfoArray addObject:projectSectionInfo];
    [self.sectionInfoArray addObject:projectPositionSectionInfo];

    //Set selected rows for others
    if ([self.selectedRowsInFilter count] > 0)
    {
        //set last selected rows in sections
        [reportingPeriodSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kREPORTINGPERIOD]];
        yearSectionInfo.values = [[self filterYearList] mutableCopy];
        [yearSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kYEAR]];
        departmentSectionInfo.values = [[self filterDepartmentList] mutableCopy];
        [departmentSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kDEPARTMENT]];
        sectionSectionInfo.values = [[self filterSectionList] mutableCopy];
        [sectionSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kSECTION]];
        [regionSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kREGION]];
        regionSectionInfo.values = [[self filterRegionList] mutableCopy];
        [clusterSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kCLUSTER]];
        clusterSectionInfo.values = [[self filterClusterList] mutableCopy];
        [projectSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kPROJECT]];
        projectSectionInfo.values = [[self LRfilterProjectList] mutableCopy];
        [projectPositionSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kPROJECTPOSITION]];
        projectPositionSectionInfo.values = [[self filterProjectPositionList] mutableCopy];
    }
    else
    {
        [self setDefaultSelectionForOtherSection];
    }
    
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [self updateDisplayAccordingToConnection];
    });
}

- (void)setDefaultSelectionForOtherSection
{
    ETGSectionInfo *reportingPeriodSection = self.sectionInfoArray[kREPORTINGPERIOD];
    ETGSectionInfo *yearSectionInfo = self.sectionInfoArray[kYEAR];
    ETGSectionInfo *departmentSectionInfo = self.sectionInfoArray[kDEPARTMENT];
    ETGSectionInfo *sectionSectionInfo = self.sectionInfoArray[kSECTION];
    ETGSectionInfo *regionSectionInfo = self.sectionInfoArray[kREGION];
    ETGSectionInfo *clusterSectionInfo = self.sectionInfoArray[kCLUSTER];
    ETGSectionInfo *projectSectionInfo = self.sectionInfoArray[kPROJECT];
    ETGSectionInfo *projectPositionSectionInfo = self.sectionInfoArray[kPROJECTPOSITION];

    [reportingPeriodSection.selectedRows addObject:[CommonMethods latestReportingMonth]];
    
    for (NSInteger i = 0; i < [yearSectionInfo.values count]; i++) {
        [yearSectionInfo.selectedRows addObject:@(i + 1)];
    }
    
    for (NSInteger i = 0; i < [departmentSectionInfo.values count]; i++) {
        [departmentSectionInfo.selectedRows addObject:@(i + 1)];
    }
    
    for (NSInteger i = 0; i < [sectionSectionInfo.values count]; i++) {
        [sectionSectionInfo.selectedRows addObject:@(i + 1)];
    }
    
    for (NSInteger i = 0; i < [regionSectionInfo.values count]; i++) {
        [regionSectionInfo.selectedRows addObject:@(i + 1)];
    }
    
    for (NSInteger i = 0; i < [clusterSectionInfo.values count]; i++) {
        [departmentSectionInfo.selectedRows addObject:@(i + 1)];
    }
    
    for (NSInteger i = 0; i < [projectSectionInfo.values count]; i++) {
        [projectSectionInfo.selectedRows addObject:@(i + 1)];
    }
    
    for (NSInteger i = 0; i < [projectPositionSectionInfo.values count]; i++) {
        [projectPositionSectionInfo.selectedRows addObject:@(i + 1)];
    }
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self updateAllSections];
    });
}

- (IBAction)handleApplyBarButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate filtersViewControllerDidFinishWithProjectsDictionary:[self getProjectsDictionaryWithSetEmptyArrayIfAllSelected]];
}

-(NSMutableDictionary *)getProjectsDictionaryWithSetEmptyArrayIfAllSelected
{
    NSMutableDictionary *projectsDictionary = [NSMutableDictionary new];
    
    //Selected Reporting Month
    ETGSectionInfo *reportingMonthSection = [self.sectionInfoArray objectAtIndex:kREPORTINGPERIOD];
    NSDate *selectedReportingMonth = [reportingMonthSection.selectedRows objectAtIndex:0];
    [projectsDictionary setObject:selectedReportingMonth forKey:kSelectedReportingMonth];
    
    // Selected year
    NSMutableArray *selectedyear = [[NSMutableArray alloc] init];
    ETGSectionInfo *yearSection = [self.sectionInfoArray objectAtIndex:kYEAR];
    for (NSNumber *row in yearSection.selectedRows)
    {
        ETGYear *year = [yearSection.values objectAtIndex:[row integerValue]-1];
        [selectedyear addObject:year];
    }
    [projectsDictionary setObject:selectedyear forKey:kSelectedYear];
    
    // Selected department
    NSMutableArray *selectedDepartment = [[NSMutableArray alloc] init];
    ETGSectionInfo *departmentSection = [self.sectionInfoArray objectAtIndex:kDEPARTMENT];
    for (NSNumber *row in departmentSection.selectedRows)
    {
        ETGDepartment *department = [departmentSection.values objectAtIndex:[row integerValue]-1];
        [selectedDepartment addObject:department];
    }
    [projectsDictionary setObject:selectedDepartment forKey:kSelectedDepartment];
    
    // Selected section
    NSMutableArray *selectedSection = [[NSMutableArray alloc] init];
    ETGSectionInfo *sectionSection = [self.sectionInfoArray objectAtIndex:kSECTION];
    if([sectionSection.selectedRows count] == [sectionSection.values count])
    {
        [projectsDictionary setObject:@[] forKey:kSelectedSection];
    }
    else
    {
        for (NSNumber *row in sectionSection.selectedRows)
        {
            ETGSection *section = [sectionSection.values objectAtIndex:[row integerValue]-1];
            [selectedSection addObject:section];
        }
        [projectsDictionary setObject:selectedSection forKey:kSelectedSection];
    }
    
    // Selected region
    NSMutableArray *selectedRegion = [[NSMutableArray alloc] init];
    ETGSectionInfo *regionSection = [self.sectionInfoArray objectAtIndex:kREGION];
    if([regionSection.selectedRows count] == [regionSection.values count])
    {
        [projectsDictionary setObject:@[] forKey:kSelectedRegion];
    }
    else
    {
        for (NSNumber *row in regionSection.selectedRows)
        {
            ETGMpRegion *region = [regionSection.values objectAtIndex:[row integerValue]-1];
            [selectedRegion addObject:region];
        }
        [projectsDictionary setObject:selectedRegion forKey:kSelectedRegion];
    }
    
    // Selected cluster
    NSMutableArray *selectedCluster = [[NSMutableArray alloc] init];
    ETGSectionInfo *clusterSection = [self.sectionInfoArray objectAtIndex:kCLUSTER];
    if([clusterSection.selectedRows count] == [clusterSection.values count])
    {
        [projectsDictionary setObject:@[] forKey:kSelectedCluster];
    }
    else
    {
        for (NSNumber *row in clusterSection.selectedRows)
        {
            ETGMpCluster *cluster = [clusterSection.values objectAtIndex:[row integerValue]-1];
            [selectedCluster addObject:cluster];
        }
        [projectsDictionary setObject:selectedCluster forKey:kSelectedCluster];
    }
    
    // Selected project
    NSMutableArray *selectedProject = [[NSMutableArray alloc] init];
    ETGSectionInfo *projectSection = [self.sectionInfoArray objectAtIndex:kPROJECT];
    if([projectSection.selectedRows count] == [projectSection.values count])
    {
        [projectsDictionary setObject:@[] forKey:kSelectedProject];
    }
    else
    {
        for (NSNumber *row in projectSection.selectedRows)
        {
            ETGMpProject *project = [projectSection.values objectAtIndex:[row integerValue]-1];
            [selectedProject addObject:project];
        }
        [projectsDictionary setObject:selectedProject forKey:kSelectedProject];
    }
    
    // Selected project position
    NSMutableArray *selectedProjectPosition = [[NSMutableArray alloc] init];
    ETGSectionInfo *projectPositionSection = [self.sectionInfoArray objectAtIndex:kPROJECTPOSITION];
    if([projectPositionSection.selectedRows count] == [projectPositionSection.values count])
    {
        [projectsDictionary setObject:@[] forKey:kSelectedProjectPosition];
    }
    else
    {
        for (NSNumber *row in projectPositionSection.selectedRows)
        {
            ETGProjectPosition *projectPosition = [projectPositionSection.values objectAtIndex:[row integerValue]-1];
            [selectedProjectPosition addObject:projectPosition];
        }
        [projectsDictionary setObject:selectedProjectPosition forKey:kSelectedProjectPosition];
    }
    
    return projectsDictionary;
}


-(NSMutableDictionary *)getProjectsDictionary
{
    
    NSMutableDictionary *projectsDictionary = [NSMutableDictionary new];
    
    //Selected Reporting Month
    ETGSectionInfo *reportingMonthSection = [self.sectionInfoArray objectAtIndex:kREPORTINGPERIOD];
    NSDate *selectedReportingMonth = [reportingMonthSection.selectedRows objectAtIndex:0];
    [projectsDictionary setObject:selectedReportingMonth forKey:kSelectedReportingMonth];
    
    // Selected year
    NSMutableArray *selectedyear = [[NSMutableArray alloc] init];
    ETGSectionInfo *yearSection = [self.sectionInfoArray objectAtIndex:kYEAR];
    for (NSNumber *row in yearSection.selectedRows)
    {
        ETGYear *year = [yearSection.values objectAtIndex:[row integerValue]-1];
        [selectedyear addObject:year];
    }
    [projectsDictionary setObject:selectedyear forKey:kSelectedYear];
    
    // Selected department
    NSMutableArray *selectedDepartment = [[NSMutableArray alloc] init];
    ETGSectionInfo *departmentSection = [self.sectionInfoArray objectAtIndex:kDEPARTMENT];
    for (NSNumber *row in departmentSection.selectedRows)
    {
        ETGDepartment *department = [departmentSection.values objectAtIndex:[row integerValue]-1];
        [selectedDepartment addObject:department];
    }
    [projectsDictionary setObject:selectedDepartment forKey:kSelectedDepartment];
    
    // Selected section
    NSMutableArray *selectedSection = [[NSMutableArray alloc] init];
    ETGSectionInfo *sectionSection = [self.sectionInfoArray objectAtIndex:kSECTION];
    for (NSNumber *row in sectionSection.selectedRows)
    {
        ETGSection *section = [sectionSection.values objectAtIndex:[row integerValue]-1];
        [selectedSection addObject:section];
    }
    [projectsDictionary setObject:selectedSection forKey:kSelectedSection];
    
    // Selected region
    NSMutableArray *selectedRegion = [[NSMutableArray alloc] init];
    ETGSectionInfo *regionSection = [self.sectionInfoArray objectAtIndex:kREGION];
    for (NSNumber *row in regionSection.selectedRows)
    {
        ETGMpRegion *region = [regionSection.values objectAtIndex:[row integerValue]-1];
        [selectedRegion addObject:region];
    }
    [projectsDictionary setObject:selectedRegion forKey:kSelectedRegion];
    
    // Selected cluster
    NSMutableArray *selectedCluster = [[NSMutableArray alloc] init];
    ETGSectionInfo *clusterSection = [self.sectionInfoArray objectAtIndex:kCLUSTER];
    for (NSNumber *row in clusterSection.selectedRows)
    {
        ETGMpCluster *cluster = [clusterSection.values objectAtIndex:[row integerValue]-1];
        [selectedCluster addObject:cluster];
    }
    [projectsDictionary setObject:selectedCluster forKey:kSelectedCluster];
    
    // Selected project
    NSMutableArray *selectedProject = [[NSMutableArray alloc] init];
    ETGSectionInfo *projectSection = [self.sectionInfoArray objectAtIndex:kPROJECT];
    for (NSNumber *row in projectSection.selectedRows)
    {
        ETGMpProject *project = [projectSection.values objectAtIndex:[row integerValue]-1];
        [selectedProject addObject:project];
    }
    [projectsDictionary setObject:selectedProject forKey:kSelectedProject];

    
    // Selected project position
    NSMutableArray *selectedProjectPosition = [[NSMutableArray alloc] init];
    ETGSectionInfo *projectPositionSection = [self.sectionInfoArray objectAtIndex:kPROJECTPOSITION];
    for (NSNumber *row in projectPositionSection.selectedRows)
    {
        ETGProjectPosition *projectPosition = [projectPositionSection.values objectAtIndex:[row integerValue]-1];
        [selectedProjectPosition addObject:projectPosition];
    }
    [projectsDictionary setObject:selectedProjectPosition forKey:kSelectedProjectPosition];
    
    return projectsDictionary;
}

-(void)updateAllSections
{
    [self updateYearSection];
    [self updateDepartmentSection];
    [self updateSectionSection];
    
    [self updateRegionSection];
    [self updateClusterSection];
    [self updateProjectSection];
    [self updateProjectPositionSection];
    
}

-(void)updateYearSection
{
    ETGSectionInfo *yearSection = self.sectionInfoArray[kYEAR];
    [self clearAllValueOfSection:yearSection];
    
    NSArray *fetchedObjects = [self filterYearList];
    if ([fetchedObjects count] > 0) {
        [yearSection.values addObjectsFromArray:fetchedObjects];
        // Only set selected year
        NSDate *selectedReportingMonth = [self getSelectedDate];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY"];
        NSString *year = [formatter stringFromDate:selectedReportingMonth];
        for (NSInteger i = 0; i < [yearSection.values count]; i++) {
            ETGYear *etgYear = yearSection.values[i];
            if([etgYear.name isEqualToString:year])
            {
                [yearSection.selectedRows addObject:@(i +1)];
                break;
            }
        }
        //[self setDefaultSelectionForDisciplineSection:yearSection];
    }
    
    [self reloadSectionAtIndex:kYEAR];
}

-(void)updateDepartmentSection
{
    ETGSectionInfo *departmentSection = self.sectionInfoArray[kDEPARTMENT];
    [self clearAllValueOfSection:departmentSection];
    
    NSArray *fetchedObjects = [self filterDepartmentList];
    if ([fetchedObjects count] > 0) {
        [departmentSection.values addObjectsFromArray:fetchedObjects];
        [self setDefaultSelectionForAnySection:departmentSection];
    }
    
    [self reloadSectionAtIndex:kDEPARTMENT];
}

-(void)updateSectionSection
{
    ETGSectionInfo *sectionSection = self.sectionInfoArray[kSECTION];
    [self clearAllValueOfSection:sectionSection];
    
    NSArray *fetchedObjects = [self filterSectionList];
    if ([fetchedObjects count] > 0) {
        [sectionSection.values addObjectsFromArray:fetchedObjects];
        [self setDefaultSelectionForAnySection:sectionSection];
    }
    
    [self reloadSectionAtIndex:kSECTION];
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

-(void)updateProjectSection
{
    ETGSectionInfo *projectSection = self.sectionInfoArray[kPROJECT];
    [self clearAllValueOfSection:projectSection];
    
    NSArray *fetchedObjects = [self LRfilterProjectList];
    if ([fetchedObjects count] > 0) {
        [projectSection.values addObjectsFromArray:fetchedObjects];
        [self setDefaultSelectionForAnySection:projectSection];
    }
    
    [self reloadSectionAtIndex:kPROJECT];
}

-(void)updateProjectPositionSection
{
    ETGSectionInfo *projectPositionSection = self.sectionInfoArray[kPROJECTPOSITION];
    [self clearAllValueOfSection:projectPositionSection];
    
    NSArray *fetchedObjects = [self filterProjectPositionList];
    if ([fetchedObjects count] > 0) {
        [projectPositionSection.values addObjectsFromArray:fetchedObjects];
        [self setDefaultSelectionForAnySection:projectPositionSection];
    }
    
    [self reloadSectionAtIndex:kPROJECTPOSITION];
}

-(NSArray *)filterYearList
{
    NSArray *results = [[ETGFilterModelController sharedController] fetchYearsBasedOnReportingPeriod:[self getSelectedDate] andFilterName:kManpowerFilterLRRootKey];
    return results;
}

-(NSArray *)filterDivisionList {
    
    NSArray *results = [[ETGFilterModelController sharedController] fetchDivisionsBasedOnReportingPeriod:[self getSelectedDate] andFilterName:kManpowerFilterLRRootKey];
    
    return results;
}

-(NSArray *)filterCountriesList {
    
    NSArray *results = [[ETGFilterModelController sharedController] fetchCountriesBasedOnReportingPeriod:[self getSelectedDate] andFilterName:kManpowerFilterLRRootKey];
    
    return results;
}

-(NSArray *)filterProjectList {
    
    ETGSectionInfo *reportingMonthSection = self.sectionInfoArray[kREPORTINGPERIOD];
    NSDate *reportingMonth = reportingMonthSection.selectedRows[0];
    
    [self updateAllSections];
    
    NSArray *fetchedProjectObjects =  [[ETGFilterModelController sharedController] fetchDivisionsBasedOnReportingPeriod:reportingMonth andFilterName:kManpowerFilterAHCRootKey];
    
    //Update Apply bar button
    self.navigationItem.rightBarButtonItem.enabled = fetchedProjectObjects.count > 0 ? YES : NO;
    
    return fetchedProjectObjects;

}

//Need this one to avoid eating up the CPU
-(NSArray *)LRfilterProjectList {
    
    NSMutableArray *selectedClusterKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *clusterSection = [self.sectionInfoArray objectAtIndex:kCLUSTER];
    for (NSNumber *row in clusterSection.selectedRows) {
        ETGMpCluster *selectedCluster = [clusterSection.values objectAtIndex:[row integerValue] - 1];
        [selectedClusterKeys addObject:selectedCluster.key];
    }
    
    NSMutableArray *selectedRegionKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *regionSection = [self.sectionInfoArray objectAtIndex:kREGION];
    for (NSNumber *row in regionSection.selectedRows) {
        ETGMpRegion *selectedRegion = [regionSection.values objectAtIndex:[row integerValue] - 1];
        [selectedRegionKeys addObject:selectedRegion.key];
    }
    
    NSArray *fetchedObjects =  [[ETGFilterModelController sharedController] fetchProjectBasedOnClusters:selectedClusterKeys regions:selectedRegionKeys reportingPeriod:[self getSelectedDate] andFilterName:kManpowerFilterLRRootKey];
    
    return fetchedObjects;
}

-(NSArray *)filterDepartmentList
{
    NSArray *results = [[ETGFilterModelController sharedController] fetchDepartmentsBasedOnReportingPeriod:[self getSelectedDate] andFilterName:kManpowerFilterLRRootKey];
    
    return results;

}

-(NSArray *)filterSectionList
{
    NSMutableArray *selectedDepartmentKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *departmentSection = [self.sectionInfoArray objectAtIndex:kDEPARTMENT];
    for (NSNumber *row in departmentSection.selectedRows) {
        ETGDepartment *selectedDepartment = [departmentSection.values objectAtIndex:[row integerValue] - 1];
        [selectedDepartmentKeys addObject:selectedDepartment.key];
    }
    NSArray *fetchedObjects =  [[ETGFilterModelController sharedController] fetchSectionsBasedOnDepartments:selectedDepartmentKeys reportingPeriod:[self getSelectedDate] andFilterName:kManpowerFilterLRRootKey];
    return fetchedObjects;
}

-(NSArray *)filterRegionList
{
    NSArray *fetchedObjects =  [[ETGFilterModelController sharedController] fetchRegionsBasedOnReportingPeriod:[self getSelectedDate] andFilterName:kManpowerFilterLRRootKey];
    return fetchedObjects;
}

-(NSArray *)filterClusterList
{
    NSMutableArray *selectedRegionKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *regionSection = [self.sectionInfoArray objectAtIndex:kREGION];
    for (NSNumber *row in regionSection.selectedRows) {
        ETGMpRegion *selectedRegion = [regionSection.values objectAtIndex:[row integerValue] - 1];
        [selectedRegionKeys addObject:selectedRegion.key];
    }
    NSArray *fetchedObjects =  [[ETGFilterModelController sharedController] fetchClustersBasedOnRegions:selectedRegionKeys reportingPeriod:[self getSelectedDate] andFilterName:kManpowerFilterLRRootKey];
    return fetchedObjects;
}


-(NSArray *)filterProjectPositionList
{
    NSMutableArray *selectedProjectKeys = [[NSMutableArray alloc] init];
    ETGSectionInfo *projectSection = [self.sectionInfoArray objectAtIndex:kPROJECT];
    for (NSNumber *row in projectSection.selectedRows) {
        ETGMpProject *selectedProject = [projectSection.values objectAtIndex:[row integerValue] - 1];
        [selectedProjectKeys addObject:selectedProject.key];
    }
    NSArray *results = [[ETGFilterModelController sharedController] fetchProjectPositionsBasedOnProjects:selectedProjectKeys reportingPeriod:[self getSelectedDate] andFilterName:kManpowerFilterLRRootKey];
    return results;
}

-(void)setDefaultSelectionForDisciplineSection:(ETGSectionInfo *)section
{
    
    for (NSInteger i = 0; i < [section.values count]; i++) {
        [section.selectedRows addObject:@(i + 1)];
    }
}

-(NSDate*)getSelectedDate
{
    ETGSectionInfo *reportingMonthSection = [self.sectionInfoArray objectAtIndex:kREPORTINGPERIOD];
    NSDate *selectedReportingMonth = [reportingMonthSection.selectedRows objectAtIndex:0];
    return selectedReportingMonth;
}

-(int)getDepartmentSection
{
    return kDEPARTMENT;
}

-(int)getYearSection
{
    return kYEAR;
}

-(int)getReportingPeriodSection
{
    return kREPORTINGPERIOD;
}

-(int)getSectionSection
{
    return kSECTION;
}

-(int)getRegionSection
{
    return kREGION;
}

-(int)getClusterSection
{
    return kCLUSTER;
}
-(int)getProjectSection
{
    return kPROJECT;
}
-(int)getProjectPositionSection
{
    return kPROJECTPOSITION;
}


@end