//
//  ETGEccrCpsFiltersViewController.m
//  ETG
//
//  Created by Tan Aik Keong on 1/28/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGEccrCpsFiltersViewController.h"
enum section {
    kPROJECT,
    kREPORTINGPERIOD,
};

@interface ETGEccrCpsFiltersViewController ()

@end

@implementation ETGEccrCpsFiltersViewController

- (void)initEccrSectionInfoValues
{
    ETGSectionInfo *projectSectionInfo = [[ETGSectionInfo alloc] init];
    projectSectionInfo.name = @"Project";
    projectSectionInfo.singleChoice = YES;
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
    [self.sectionInfoArray addObject:projectSectionInfo];
    [self.sectionInfoArray addObject:reportingPeriodSectionInfo];
    self.openSectionIndex = [self getReportingMonthSection];
    
    //Set selected rows for others
    if ([self.selectedRowsInFilter count] > 0)
    {
        //set last selected rows in sections
        [reportingPeriodSectionInfo.selectedRows addObjectsFromArray:self.selectedRowsInFilter[kREPORTINGPERIOD]];
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
    if(projectSectionInfo.selectedRows.count == 0)
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
    [reportingPeriodSection.selectedRows addObject:[CommonMethods latestReportingMonth]];
}

-(NSArray *)filterProjectList
{
    ETGSectionInfo *reportingMonthSection = self.sectionInfoArray[kREPORTINGPERIOD];
    NSDate *reportingMonth = reportingMonthSection.selectedRows[0];
    NSString *reportingMonthString = [self.dateFormatter stringFromDate:reportingMonth];
    
    NSArray *fetchedProjectObjects = [[ETGFilterModelController sharedController] fetchEccrProjectsBaseOnReportingMonth:reportingMonthString];
    
    //Update Apply bar button
    self.navigationItem.rightBarButtonItem.enabled = fetchedProjectObjects.count > 0 ? YES : NO;
    [self updateDisplayAccordingToConnection];
    
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
        ETGProject *selectedProject = [projectSection.values objectAtIndex:[row integerValue]];
        [selectedProjects addObject:selectedProject];
    }
    [projectsDictionary setObject:selectedProjects forKey:kSelectedProjects];
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

@end
