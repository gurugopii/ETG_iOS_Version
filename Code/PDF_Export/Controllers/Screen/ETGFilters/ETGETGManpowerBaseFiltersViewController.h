//
//  ETGETGManpowerBaseFiltersViewController.h
//  ETG
//
//  Created by Helmi Hasan on 2/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGFiltersViewController.h"
#import "ETGProject.h"
#import "ETGFilterModelController.h"

@interface ETGETGManpowerBaseFiltersViewController : ETGFiltersViewController

- (void)getProjectBaseFiltersDataForReportingMonth:(NSTimer *)sender;

//abstract
-(int)getReportingPeriodSection;
-(int)getDepartmentSection;
-(int)getYearSection;
-(int)getSectionSection;
-(int)getProjectPositionSection;
-(int)getProjectSection;
-(int)getClusterSection;
-(int)getRegionSection;
-(void)updateDisplayAccordingToConnection;
-(void)updateSectionSection;
-(void)updateDepartmentSection;
-(void)updateYearSection;
-(void)updateProjectSection;
-(void)updateProjectPositionSection;
-(void)updateClusterSection;
-(void)updateRegionSection;
-(void)updateAllSections;


-(NSMutableDictionary *)getProjectsDictionary;
-(NSArray *)filterProjectList;
- (void)setDefaultSelectionForOtherSection;
- (void)initManpowerSectionInfoValues;


@end