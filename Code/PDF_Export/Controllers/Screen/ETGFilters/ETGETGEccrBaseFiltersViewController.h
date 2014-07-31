//
//  ETGETGEccrBaseFiltersViewController.h
//  ETG
//
//  Created by Tan Aik Keong on 1/28/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGFiltersViewController.h"
#import "ETGProject.h"
#import "ETGFilterModelController.h"
#import "ETGEccrViewController.h"

@interface ETGETGEccrBaseFiltersViewController : ETGFiltersViewController
- (void)initEccrSectionInfoValues;
-(int)getRegionSection;
-(int)getProjectSection;
-(int)getBudgetHolderSection;
-(int)getOperatorShipSection;
-(int)getReportingMonthSection;
-(void)updateProjectSection;
-(NSArray *)filterProjectList;
- (void)getProjectBaseFiltersDataForReportingMonth:(NSTimer *)sender;
- (void)setDefaultSelectionForOtherSection;
-(NSMutableDictionary *)getProjectsDictionary;
-(void)updateDisplayAccordingToConnection;
@end