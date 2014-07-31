//
//  ETGProjectTestOutput.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/19/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGProjectTestOutput.h"
//#import "ETGProjectModelController.h"

@implementation ETGProjectTestOutput

-(void) testProject {
    
    //For Portfolio
    ETGProjectModelController *projectModel = [ETGProjectModelController sharedModel];
    projectModel = nil;
    
    //    JSON for Project
    /*[projectModel syncProjectKeyMilestone];
     [projectModel getProjectKeyMilestoneForReportingMonth:@"20130301" withProjectKey:@"3" withPDFField:@"22" success:^(NSString* jsonData) {
     
     NSLog(@"Project JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project AFE
     [projectModel syncProjectAfe];
     [projectModel getProjectAfeForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project AFE JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project AFE Table
     [projectModel syncProjectAfeTable];
     [projectModel getProjectAfeTableForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project AFE Table JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project Budget Core Info
     [projectModel syncProjectBudgetCoreInfo];
     [projectModel getProjectBudgetCoreInfoForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project Budget Core Info JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project Budget Performance
     [projectModel syncProjectBudgetPerformance];
     [projectModel getProjectBudgetPerformanceForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project Budget Performance JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project First Hydrocarbon
     [projectModel syncProjectFirstHydrocarbon];
     [projectModel getProjectFirstHydrocarbonForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project First Hydrocarbon JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project HSE
     [projectModel syncProjectHse];
     [projectModel getProjectHseForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project HSE JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project HSE Table
     [projectModel syncProjectHseTable];
     [projectModel getProjectHseTableForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project HSE Table JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project Opportunity Impact
     [projectModel syncProjectOpportunityImpact];
     [projectModel getProjectOpportunityImpactForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project Opportunity Impact JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project Production and RTBD
     [projectModel syncProjectProductionRtbd];
     [projectModel getProjectProductionRtbdForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project Production and RTBD JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project Production and RTBD Table
     [projectModel syncProjectProductionRtbdTable];
     [projectModel getProjectProductionRtbdTableForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project Production and RTBD Table JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project Schedule Progress Core Info
     [projectModel syncProjectScheduleProgressCoreInfo];
     [projectModel getProjectScheduleProgressCoreInfoForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project Schedule Progress Core Info JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];*/
    
    //    JSON for Project Schedule Progress
    /*[projectModel syncProjectScheduleProgress];
     [projectModel getProjectScheduleProgressForReportingMonth:@"20130701" withProjectKey:@"115" withPDFField:@"22" success:^(NSString* jsonData) {
     //[projectModel getProjectScheduleProgressForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project Schedule Progress JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];*/
    
    /*//    JSON for Project Schedule Progress
     [projectModel syncProjectSummary];
     [projectModel getProjectSummaryForReportingMonth:@"20130501" withProjectKey:@"3" withPDFField:@"12" success:^(NSString* jsonData) {
     //[projectModel getProjectScheduleProgressForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
     
     NSLog(@"Project Schedule Progress JSON data: %@", jsonData);
     
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];
     
     //    JSON for Project Summary
     [projectModel syncProject];
     [projectModel getProjectForReportingMonth:@"20130601" withProjectKey:@"95" withPDFField:@"12" success:^(NSString* jsonData) {
     NSLog(@"Project Schedule Progress JSON data: %@", jsonData);
     } failure: ^(NSError * error) {
     NSLog(@"No data");
     }];*/
    
}

@end
