//
//  ETGAllProjects.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/19/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGAllProjects.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGToken.h"
#import "ETGNetworkConnection.h"
#import "ETGFilterModelController.h"
// Models
#import "ETGProjectSummary.h"
#import "ETGAfe.h"
#import "ETGAfeTable.h"
#import "ETGBudgetPerformance.h"
#import "ETGBudgetCoreInfo.h"
#import "ETGHseTable_Project.h"
#import "ETGKeyMilestone.h"
#import "ETGFirstHydrocarbon.h"
#import "ETGProductionRtbd_Project.h"
#import "ETGRiskOpportunity.h"
#import "ETGScheduleProgress.h"
#import "ETGPPMS.h"
#import "ETGBaselineType.h"
#import "ETGRevision.h"
#import "ETGHseProject.h"
#import "ETGKeyMilestoneProjectPhase.h"
#import "ETGKeyHighlight.h"
#import "ETGIssuesKeyHighlight.h"
#import "ETGPlannedKeyHighlight.h"
#import "ETGPpaKeyHighlight.h"
#import "ETGMonthlyKeyHighlight.h"
#import "ETGProjectBackground.h"
#import "ETGKeyHighlightProgress.h"
#import "ETGKeyHighlightProgressOverall.h"
#import "ETGCoreDataUtilities.h"
#import "ETGPhase.h"
#import "ETGCostAllocation.h"
#import "ETGMLProject.h"
#import "ETGJsonHelper.h"
// Relationships
#import "ETGRegion.h"
#import "ETGReportingMonth.h"

#import "ETGJSONKeyReplaceManipulation.h"
#import "ETGUserDefaultManipulation.h"
#import "NSString+ETGStringFormatter.h"
#import "NSDecimalNumber+ETGDecimalNumberFormatter.h"

#define kReportName @"dashboardItemName"
#define kReportDetailStatus @"dashboardPopupStatus"

#import "ETGFiltersViewController.h"

@interface ETGAllProjects ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) ETGWebService *webService;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;
@property (nonatomic) BOOL isEmpty;
@property (nonatomic) BOOL haveUAC;
@property (nonatomic) BOOL isFirstProject;
@property (nonatomic, strong) NSMutableArray *enableReports;

@end

@implementation ETGAllProjects

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupProjectMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupProjectMappings {
    // Attribute Mappings for Project Summary
    RKEntityMapping *projectSummaryMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProjectSummary entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectSummaryMapping addAttributeMappingsFromDictionary:@{
                                                                @"@metadata.projectKey"  : @"projectKey",
                                                                @"@metadata.reportingMonth"   : @"reportMonth"
                                                                }];
    projectSummaryMapping.identificationAttributes = @[@"projectKey", @"reportMonth"];
    
    // Attribute Mappings for ETGAfe
    RKEntityMapping *projectAFEMapping = [[RKEntityMapping alloc] initWithEntity:[ETGAfe entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectAFEMapping addAttributeMappingsFromDictionary:@{
                                                            @"totalAFECnt"     : @"afe",
                                                            @"indicator"       : @"indicator",
                                                            @"afeStatus"       : @"status"
                                                            }];
    
    // Attribute Mappings for ETGAfeTable
    RKEntityMapping *projectAFETableMapping = [[RKEntityMapping alloc] initWithEntity:[ETGAfeTable entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectAFETableMapping addAttributeMappingsFromDictionary:@{
                                                                 @"afeSection"      : @"afeDescription",
                                                                 @"afe_AFC"         : @"afc",
                                                                 @"afe_Indicator"   : @"indicator",
                                                                 @"afe_VOWD"        : @"itd",
                                                                 @"afe_Variance"    : @"variance",
                                                                 @"latestAFE"       : @"latestApprovedAfe"
                                                                 }];
    
    // Attribute Mappings for ETGBudgetCoreInfo
    RKEntityMapping *projectBudgetMapping = [[RKEntityMapping alloc] initWithEntity:[ETGBudgetCoreInfo entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectBudgetMapping addAttributeMappingsFromDictionary:@{
                                                               @"cumVOWD"         : @"cumVowd",
                                                               @"fdp"             : @"fdp",
                                                               @"ytdActual"       : @"ytdActual"
                                                               }];
    
    // Attribute Mappings for ETGBudgetPerformance
    RKEntityMapping *projectBudgetTableMapping = [[RKEntityMapping alloc] initWithEntity:[ETGBudgetPerformance entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectBudgetTableMapping addAttributeMappingsFromDictionary:@{
                                                                    @"forecastDescription" : @"forecastDescription",
                                                                    @"forecastValue"       : @"forecastValue",
                                                                    @"forecastVariance"    : @"forecastVariance",
                                                                    @"indicator"           : @"indicator",
                                                                    @"planDescription"     : @"planDescription",
                                                                    @"planValue"           : @"planValue"
                                                                    }];
    
    // Attribute Mappings for ETGCostAllocation
    RKEntityMapping *costAllocationMapping = [[RKEntityMapping alloc] initWithEntity:[ETGCostAllocation entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [costAllocationMapping addAttributeMappingsFromDictionary:@{
                                                                @"costAllocationKey"   : @"key",
                                                                @"costAllocation"      : @"name"
                                                                }];
    costAllocationMapping.identificationAttributes = @[@"key", @"name"];
    
    // Attribute Mappings for ETGHseProject
    RKEntityMapping *projectHSEMapping = [[RKEntityMapping alloc] initWithEntity:[ETGHseProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectHSEMapping addAttributeMappingsFromDictionary:@{
                                                            @"totalManhour"      : @"totalManHour"
                                                            }];
    
    // Attribute Mappings for ETGHseTable_Project
    RKEntityMapping *projectHSETableMapping = [[RKEntityMapping alloc] initWithEntity:[ETGHseTable_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectHSETableMapping addAttributeMappingsFromDictionary:@{
                                                                 @"hseDescription"      : @"hseDescription",
                                                                 @"hseID"               : @"hseId",
                                                                 @"indicator"           : @"indicator",
                                                                 @"kpi"                 : @"kpi",
                                                                 @"ytdCases"            : @"ytdCase",
                                                                 @"ytdFrequency"        : @"ytdFrequency"
                                                                 }];
    
    // Attribute Mappings for ETGFirstHydrocarbon
    RKEntityMapping *projectKeyMilestoneHydroMapping = [[RKEntityMapping alloc] initWithEntity:[ETGFirstHydrocarbon entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectKeyMilestoneHydroMapping addAttributeMappingsFromDictionary:@{
                                                                          @"estimateDate"        : @"actualDt",
                                                                          @"facilityKey"         : @"fieldKey",
                                                                          @"facilityName"        : @"field",
                                                                          @"planDate"            : @"plannedDt"
                                                                          }];
    
    // Attribute Mappings for ETGRiskOpportunity
    RKEntityMapping *projectROImpactMapping = [[RKEntityMapping alloc] initWithEntity:[ETGRiskOpportunity entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectROImpactMapping addAttributeMappingsFromDictionary:@{
                                                                 @"activity"            : @"activity",
                                                                 @"cluster"             : @"cluster",
                                                                 @"cost"                : @"cost",
                                                                 @"descriptions"        : @"descriptions",
                                                                 @"identifiedDate"      : @"identifiedDate",
                                                                 @"mitigation"          : @"mitigation",
                                                                 @"negativeImpact"      : @"negativeImpact",
                                                                 @"probability"         : @"probability",
                                                                 @"production"          : @"production",
                                                                 @"productionGas"       : @"productionGas",
                                                                 @"productionOil"       : @"productionOil",
                                                                 @"roType"              : @"type",
                                                                 @"schedule"            : @"schedule",
                                                                 @"status"              : @"status"
                                                                 }];
    
    // Attribute Mappings for ETGPPMS
    RKEntityMapping *projectPPMSMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPPMS entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectPPMSMapping addAttributeMappingsFromDictionary:@{
                                                             @"indicator"   : @"indicator",
                                                             @"percentage"  : @"percentage",
                                                             @"status"      : @"status"
                                                             }];
    
    // Attribute Mappings for ETGProductionRtbd_Project
    RKEntityMapping *projectRTBDMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProductionRtbd_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectRTBDMapping addAttributeMappingsFromDictionary:@{
                                                             @"category"            : @"category",
                                                             @"cpb"                 : @"cpb",
                                                             @"indicator"           : @"indicator",
                                                             @"hydroCarbonType"     : @"type",
                                                             @"yep"                 : @"yep"
                                                             }];
    
    // Attribute Mappings for ETGScheduleProgress
    RKEntityMapping *projectScheduleProgressMapping = [[RKEntityMapping alloc] initWithEntity:[ETGScheduleProgress entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectScheduleProgressMapping addAttributeMappingsFromDictionary:@{
                                                                         @"actual"              : @"actualProgress",
                                                                         @"indicator"           : @"indicator",
                                                                         @"originalBaseline"    : @"originalBaseline",
                                                                         @"planned"             : @"planProgress",
                                                                         @"variance"            : @"variance",
                                                                         @"reportingDate"       : @"reportingDate"
                                                                         }];
    
    // Attribute Mappings for ETGProjectBackground
    RKEntityMapping *projectBackgroundMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProjectBackground entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectBackgroundMapping addAttributeMappingsFromDictionary:@{
                                                                   @"clusterName"             : @"clusterName",
                                                                   @"country"                 : @"country",
                                                                   @"currencyName"            : @"currencyName",
                                                                   @"endDate"                 : @"endDate",
                                                                   @"equity"                  : @"equity",
                                                                   @"fdpAmt"                  : @"fdpAmt",
                                                                   @"fdpDate"                 : @"fdpDate",
                                                                   @"fdpStatus"               : @"fdpStatus",
                                                                   @"firAmt"                  : @"firAmt",
                                                                   @"firDate"                 : @"firDate",
                                                                   @"firStatus"               : @"firStatus",
                                                                   @"objective"               : @"objective",
                                                                   @"operatorship"        : @"operatorshipName",
                                                                   @"costCategory" : @"projectCostCategoryName",
                                                                   @"projectEndDate"          : @"projectEndDate",
                                                                   @"projectID"              : @"projectId",
                                                                   @"projectName"             : @"projectName",
                                                                   @"nature"       : @"projectNatureName",
                                                                   @"projectStartDate"        : @"projectStartDate",
                                                                   @"status"       : @"projectStatusName",
                                                                   @"type"         : @"projectTypeName",
                                                                   @"region"                  : @"region",
                                                                   @"startDate"               : @"startDate",
                                                                   @"projectImage"            : @"projectImage"
                                                                   }];
    
    //Attribute Mappings for ETGKeyMilestoneProjectPhase
    RKEntityMapping *keyMilestoneProjectPhaseMapping = [[RKEntityMapping alloc] initWithEntity:[ETGKeyMilestoneProjectPhase entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [keyMilestoneProjectPhaseMapping addAttributeMappingsFromDictionary:@{
                                                                          @"projectPhase"      : @"projectPhase"
                                                                          }];
    
    // Attribute Mappings for ETGMLProject
    RKEntityMapping *projectMlMapping = [[RKEntityMapping alloc] initWithEntity:[ETGMLProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectMlMapping addAttributeMappingsFromDictionary:@{
                                                    @"calendarMonthOfYear" :@"calendarMonthOfYear",
                                                    @"calendarYear" : @"calendarYear",
                                                    @"calendarYearEnglishMonth"            : @"calendarYearEnglishMonth",
                                                    @"fTELoading"    : @"fTELoading",
                                                    @"projectStaffingStatusName" : @"projectStaffingStatusName",
                                                    @"reportingTimeKey" : @"reportingTimeKey"
                                                    }];
    
    // Attribute Mappings for ETGBaselineType
    RKEntityMapping *projectKeyMilestoneBaseType = [[RKEntityMapping alloc] initWithEntity:[ETGBaselineType entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectKeyMilestoneBaseType addAttributeMappingsFromDictionary:@{
                                                                      @"baselineType"               : @"name",
                                                                      @"baselineTypeKey"            : @"key",
                                                                      @"createdTime"                : @"createdTime",
                                                                      @"@metadata.projectKey"       : @"projectKey",
                                                                      @"@metadata.reportingMonth"   : @"reportMonth"
                                                                      }];
    projectKeyMilestoneBaseType.identificationAttributes = @[@"key", @"projectKey", @"reportMonth"];
    
    // Attribute Mappings for ETGRevision
    RKEntityMapping *projectKeyMilestoneRevision = [[RKEntityMapping alloc] initWithEntity:[ETGRevision entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectKeyMilestoneRevision addAttributeMappingsFromDictionary:@{
                                                                      @"revisionNo"        : @"number"
                                                                      }];
    
    // Attribute Mappings for ETGKeyMilestone
    RKEntityMapping *projectKeyMilestoneMapping = [[RKEntityMapping alloc] initWithEntity:[ETGKeyMilestone entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectKeyMilestoneMapping addAttributeMappingsFromDictionary:@{
                                                                     @"actualDate"                 : @"actualDate",
                                                                     @"baseLineNum"                : @"baselineNum",
                                                                     @"mileStone"                  : @"mileStone",
                                                                     @"plannedDate"                : @"plannedDate",
                                                                     @"indicator"                  : @"indicator"
                                                                     }];
    
    // Attribute Mappings for ETGKeyHighlightProgressOverall
    RKEntityMapping *progressOverAllKeyhighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlightProgressOverall entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [progressOverAllKeyhighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                              @"overallCurrActualProgress" :@"overallCurrActualProgress",
                                                                              @"overallCurrPlanProgress"   :@"overallCurrPlanProgress",
                                                                              @"overallCurrVariance"       :@"overallCurrVariance",
                                                                              @"overallPrevActualProgress" :@"overallPrevActualProgress",
                                                                              @"overallPrevPlanProgress"   :@"overallPrevPlanProgress",
                                                                              @"overallPrevVariance"       :@"overallPrevVariance",
                                                                              }];
    
    // Attribute Mappings for ETGKeyHighlightProgress
    RKEntityMapping *progressKeyhighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlightProgress entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [progressKeyhighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                       @"activityID"         :@"activityID",
                                                                       @"activityName"       :@"activityName",
                                                                       @"currActualProgress" :@"currActualProgress",
                                                                       @"currPlanProgress"   :@"currPlanProgress",
                                                                       @"currVariance"       :@"currVariance",
                                                                       @"indicator"          :@"indicator",
                                                                       @"prevActualProgress" :@"prevActualProgress",
                                                                       @"prevPlanProgress"   :@"prevPlanProgress",
                                                                       @"prevVariance"       :@"prevVariance",
                                                                       @"weightage"          :@"weightage"
                                                                       }];
    
    // Attribute Mappings for ETGIssuesKeyHighlight
    RKEntityMapping *issuesKeyHighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGIssuesKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [issuesKeyHighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                     @"activity"      :@"activity",
                                                                     @"description"   :@"desc",
                                                                     @"mitigationPlan":@"mitigationPlan"
                                                                     }];
    
    // Attribute Mappings for ETGMonthlyKeyHighlight
    RKEntityMapping *monthlyKeyHighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGMonthlyKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [monthlyKeyHighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                      @"activity"      :@"activity",
                                                                      @"description"   :@"desc",
                                                                      @"mitigationPlan":@"mitigationPlan"
                                                                      }];
    
    // Attribute Mappings for ETGPlannedKeyHighlight
    RKEntityMapping *plannedKeyHighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPlannedKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [plannedKeyHighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                      @"activity"      :@"activity",
                                                                      @"description"   :@"desc",
                                                                      @"mitigationPlan":@"mitigationPlan"
                                                                      }];
    
    // Attribute Mappings for ETGPpaKeyHighlight
    RKEntityMapping *ppaKeyHighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPpaKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [ppaKeyHighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                  @"activity"      :@"activity",
                                                                  @"description"   :@"desc",
                                                                  @"mitigationPlan":@"mitigationPlan"
                                                                  }];
    
    // Attribute Mappings for ETGKeyHighlight
    RKEntityMapping *scorecardKeyHighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [scorecardKeyHighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                        @"overallPPA" : @"overallPpa",
                                                                        @"@metadata.projectKey"  : @"projectKey",
                                                                        @"@metadata.reportingMonth"   : @"reportMonth"
                                                                        }];
    scorecardKeyHighlightsMapping.identificationAttributes = @[@"projectKey", @"reportMonth"];
    
    
    // Attribute Mappings for ETGProject
    RKEntityMapping *projectMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectMapping addAttributeMappingsFromDictionary:@{
                                                         @"aboutProject.projectKey"  : @"key",
                                                         @"aboutProject.projectName" : @"name"
                                                         }];
    projectMapping.identificationAttributes = @[@"key", @"name"];
    
    
    // Attribute Mappings for ETGReportingMonth
    RKEntityMapping *reportingMonthMapping = [[RKEntityMapping alloc] initWithEntity:[ETGReportingMonth entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [reportingMonthMapping addAttributeMappingsFromDictionary:@{
                                                                @"@metadata.reportingMonth"   : @"name"
                                                                }];
    reportingMonthMapping.identificationAttributes = @[@"name"];
    
    // Relationship mapping of ETGAfe to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"afe.AFESummary" toKeyPath:@"etgAfe_Projects" withMapping:projectAFEMapping]];
    // Relationship mapping of ETGAfeTable to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"afe.AFEDetails" toKeyPath:@"etgAfeTable_Projects" withMapping:projectAFETableMapping]];
    // Relationship mapping of ETGBudgetCoreInfo to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"budgetPerformance.Summary" toKeyPath:@"etgBudgetCoreInfo_Projects" withMapping:projectBudgetMapping]];
    // Relationship mapping of ETGBudgetPerformance to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"budgetPerformance.Properties" toKeyPath:@"etgBudgetPerformance_Projects" withMapping:projectBudgetTableMapping]];
    // Relationship mapping of ETGHseProject to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"hse" toKeyPath:@"etgHse_Projects" withMapping:projectHSEMapping]];
    // Relationship mapping of ETGHseTable_Project to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"hse.hseDetails" toKeyPath:@"etgHseTable_Projects" withMapping:projectHSETableMapping]];
    // Relationship mapping of ETGFirstHydrocarbon to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyMilestone.FirstHydroCarbon" toKeyPath:@"etgFirstHydrocarbon_Projects" withMapping:projectKeyMilestoneHydroMapping]];
    // Relationship mapping of ETGRiskOpportunity to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"roImpact" toKeyPath:@"etgOpportunityImpact_Projects" withMapping:projectROImpactMapping]];
    // Relationship mapping of ETGPPMS to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ppmsReview" toKeyPath:@"etgPpms_Projects"  withMapping:projectPPMSMapping]];
    // Relationship mapping of ETGProductionRtbd_Project to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rtbd" toKeyPath:@"etgProductionRtbd_Projects" withMapping:projectRTBDMapping]];
    // Relationship mapping of ETGScheduleProgress to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"scheduleScurve" toKeyPath:@"etgScheduleProgress_Projects" withMapping:projectScheduleProgressMapping]];
    
    // Relationship mapping of ETGCostAllocation to ETGBudgetPerformance
    [projectBudgetTableMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"budgetHolder" withMapping:costAllocationMapping]];
    
    // Relationship mapping of ETGKeyMilestoneProjectPhase to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyMilestone" toKeyPath:@"etgKeyMilestone_ProjectPhase" withMapping:keyMilestoneProjectPhaseMapping]];
    
    // Relationship mapping of ETGMlProject to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"manpowerLoading" toKeyPath:@"etgMlProjects" withMapping:projectMlMapping]];

    
    // Relationship mapping of ETGBaselineType to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyMilestone.KeyMileStoneSummary" toKeyPath:@"baselineTypes" withMapping:projectKeyMilestoneBaseType]];
    // Relationship mapping of ETGRevision to ETGBaselineType
    RKRelationshipMapping* baselineTypeToRevision = [RKRelationshipMapping relationshipMappingFromKeyPath:@"revisions" toKeyPath:@"revisions" withMapping:projectKeyMilestoneRevision];
    // Set assignment policy to union so that it will append the new revisions to existing revisions
//    [baselineTypeToRevision setAssignmentPolicy:RKAssignmentPolicyUnion];
    [projectKeyMilestoneBaseType addPropertyMapping:baselineTypeToRevision];
    // Relationship mapping of ETGKeyMilestone to ETGRevision
    RKRelationshipMapping* revisionToKeymilestone = [RKRelationshipMapping relationshipMappingFromKeyPath:@"KeyMilestones" toKeyPath:@"keyMilestones" withMapping:projectKeyMilestoneMapping];
//    [revisionToKeymilestone setAssignmentPolicy:RKAssignmentPolicyUnion];
    [projectKeyMilestoneRevision addPropertyMapping:revisionToKeymilestone];
    
    // Relationship mapping of ETGIssuesKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"issuesConcerns" toKeyPath:@"issuesAndConcerns"  withMapping:issuesKeyHighlightsMapping]];
    
    // Relationship mapping of ETGKeyHighlightProgressOverall to ETGKeyHighlightProgress
    [progressOverAllKeyhighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyHighLightsTable" toKeyPath:@"keyHighLightsTable"  withMapping:progressKeyhighlightsMapping]];
    
    // Relationship mapping of ETGKeyHighlightProgressOverall to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"highLightsProgress" toKeyPath:@"keyhighlightsProgress"  withMapping:progressOverAllKeyhighlightsMapping]];
    
    // Relationship mapping of ETGMonthlyKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"monthlyHighLights" toKeyPath:@"monthlyKeyHighlights"  withMapping:monthlyKeyHighlightsMapping]];
    
    // Relationship mapping of ETGPlannedKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"plannedActivitiesforNextMonth" toKeyPath:@"plannedActivitiesforNextMonth"  withMapping:plannedKeyHighlightsMapping]];
    
    // Relationship mapping of ETGPpaKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ppa" toKeyPath:@"ppa"  withMapping:ppaKeyHighlightsMapping]];
    
    // Relationship mapping of ETGReportingMonth to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"reportingMonth"  withMapping:reportingMonthMapping]];
    
    // Relationship mapping of ETGKeyHighlight to ETGProject
    [projectMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyHighlight" toKeyPath:@"keyHighlights"  withMapping:scorecardKeyHighlightsMapping]];
    
    // Relationship mapping of ETGProjectBackground to ETGProject
    [projectMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"aboutProject" toKeyPath:@"projectBackground"  withMapping:projectBackgroundMapping]];
    // Relationship mapping of ETGProject to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"project" withMapping:projectMapping]];
    
    // Relationship mapping of ETGReportingMonth to ETGProjectSummary
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"reportingMonth" withMapping:reportingMonthMapping]];
    
    // Add ETGProductionRtbd_Portfolio to Response descriptor
    RKResponseDescriptor *projectDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:projectSummaryMapping method:RKRequestMethodPOST pathPattern:[NSString stringWithFormat:@"%@%@", kProjectService, ETG_PROJECT_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:projectDescriptor];
    
    _mapping = projectSummaryMapping;
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////
    // Inverse Attribute Mappings for Project Summary
    RKEntityMapping *projectSummaryMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGProjectSummary entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    
    // Inverse Attribute Mappings for ETGAfe
    RKEntityMapping *projectAFEMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGAfe entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectAFEMapping_ addAttributeMappingsFromDictionary:@{
                                                             @"AFE"          : @"afe",
                                                             @"Indicator"    : @"indicator",
                                                             @"Status"       : @"status"
                                                             }];
    
    // Inverse Attribute Mappings for ETGAfeTable
    RKEntityMapping *projectAFETableMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGAfeTable entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectAFETableMapping_ addAttributeMappingsFromDictionary:@{
                                                                  @"afeSection"      : @"afeDescription",
                                                                  @"afe_AFC"         : @"afc",
                                                                  @"afe_Indicator"   : @"indicator",
                                                                  @"afe_VOWD"        : @"itd",
                                                                  @"afe_Variance"    : @"variance",
                                                                  @"latestAFE"       : @"latestApprovedAfe"
                                                                  }];
    
    // Inverse Attribute Mappings for ETGBudgetCoreInfo
    RKEntityMapping *projectBudgetMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGBudgetCoreInfo entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectBudgetMapping_ addAttributeMappingsFromDictionary:@{
                                                                @"CUMVOWD"         : @"cumVowd",
                                                                @"FDP"             : @"fdp",
                                                                @"YTDActual"       : @"ytdActual"
                                                                }];
    
    // Inverse Attribute Mappings for ETGBudgetPerformance
    RKEntityMapping *projectBudgetTableMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGBudgetPerformance entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectBudgetTableMapping_ addAttributeMappingsFromDictionary:@{
                                                                     @"forecastdescription" : @"forecastDescription",
                                                                     @"forecastvalue"       : @"forecastValue",
                                                                     @"forecastvariance"    : @"forecastVariance",
                                                                     @"indicator"           : @"indicator",
                                                                     @"plandescription"     : @"planDescription",
                                                                     @"planvalue"           : @"planValue"
                                                                     }];
    
    // Attribute Mappings for ETGCostAllocation
    RKEntityMapping *costAllocationMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGCostAllocation entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [costAllocationMapping_ addAttributeMappingsFromDictionary:@{
                                                                 @"key"   : @"key",
                                                                 @"name"  : @"name"
                                                                 }];
    
    // Inverse Attribute Mappings for ETGHseProject
    RKEntityMapping *projectHSEMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGHseProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectHSEMapping_ addAttributeMappingsFromDictionary:@{
                                                             @"totalManHour"      : @"totalManHour"
                                                             }];
    
    // Inverse Attribute Mappings for ETGHseTable_Project
    RKEntityMapping *projectHSETableMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGHseTable_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectHSETableMapping_ addAttributeMappingsFromDictionary:@{
                                                                  @"hsecriteria"         : @"hseDescription",
                                                                  @"HSEID"               : @"hseId",
                                                                  @"indicator"           : @"indicator",
                                                                  @"kpi"                 : @"kpi",
                                                                  @"ytdcase"             : @"ytdCase",
                                                                  @"ytdfrequency"        : @"ytdFrequency"
                                                                  }];
    
    // Inverse Attribute Mappings for ETGFirstHydrocarbon
    RKEntityMapping *projectKeyMilestoneHydroMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGFirstHydrocarbon entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectKeyMilestoneHydroMapping_ addAttributeMappingsFromDictionary:@{
                                                                           @"estimateDate"        : @"actualDt",
                                                                           @"facilityKey"         : @"fieldKey",
                                                                           @"facilityName"        : @"field",
                                                                           @"planDate"            : @"plannedDt"
                                                                           }];
    
    // Inverse Attribute Mappings for ETGRiskOpportunity
    RKEntityMapping *projectROImpactMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGRiskOpportunity entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectROImpactMapping_ addAttributeMappingsFromDictionary:@{
                                                                  @"activity"            : @"activity",
                                                                  @"cluster"             : @"cluster",
                                                                  @"cost"                : @"cost",
                                                                  @"descriptions"        : @"descriptions",
                                                                  @"identifiedDate"      : @"identifiedDate",
                                                                  @"mitigation"          : @"mitigation",
                                                                  @"negativeImpact"      : @"negativeImpact",
                                                                  @"probability"         : @"probability",
                                                                  @"production"          : @"production",
                                                                  @"productionGas"       : @"productionGas",
                                                                  @"productionOil"       : @"productionOil",
                                                                  @"roType"              : @"type",
                                                                  @"schedule"            : @"schedule",
                                                                  @"status"              : @"status"
                                                                  }];
    
    // Inverse Attribute Mappings for ETGPPMS
    RKEntityMapping *projectPPMSMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGPPMS entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectPPMSMapping_ addAttributeMappingsFromDictionary:@{
                                                              @"Ind"         : @"indicator",
                                                              @"Percentage"  : @"percentage",
                                                              @"Status"      : @"status"
                                                              }];
    
    // Inverse Attribute Mappings for ETGProductionRtbd_Project
    RKEntityMapping *projectRTBDMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGProductionRtbd_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectRTBDMapping_ addAttributeMappingsFromDictionary:@{
                                                              @"category"            : @"category",
                                                              @"cpb"                 : @"cpb",
                                                              @"indicator"           : @"indicator",
                                                              @"type"                : @"type",
                                                              @"yep"                 : @"yep"
                                                              }];
    
    // Inverse Attribute Mappings for ETGScheduleProgress
    RKEntityMapping *projectScheduleProgressMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGScheduleProgress entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectScheduleProgressMapping_ addAttributeMappingsFromDictionary:@{
                                                                          @"actualProgress"      : @"actualProgress",
                                                                          @"indicator"           : @"indicator",
                                                                          @"original"            : @"originalBaseline",
                                                                          @"planProgress"        : @"planProgress",
                                                                          @"variance"            : @"variance",
                                                                          @"reportingDate"       : @"reportingDate"
                                                                          }];
    
    // Inverse Attribute Mappings for ETGProjectBackground
    RKEntityMapping *projectBackgroundMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGProjectBackground entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectBackgroundMapping_ addAttributeMappingsFromDictionary:@{
                                                                    @"clusterName"             : @"clusterName",
                                                                    @"country"                 : @"country",
                                                                    @"currencyName"            : @"currencyName",
                                                                    @"endDate"                 : @"endDate",
                                                                    @"equity"                  : @"equity",
                                                                    @"fdpAmt"                  : @"fdpAmt",
                                                                    @"fdpDate"                 : @"fdpDate",
                                                                    @"fdpStatus"               : @"fdpStatus",
                                                                    @"firAmt"                  : @"firAmt",
                                                                    @"firDate"                 : @"firDate",
                                                                    @"firStatus"               : @"firStatus",
                                                                    @"objective"               : @"objective",
                                                                    @"operatorshipName"        : @"operatorshipName",
                                                                    @"projectCostCategoryName" : @"projectCostCategoryName",
                                                                    @"projectEndDate"          : @"projectEndDate",
                                                                    @"projectId"               : @"projectId",
                                                                    @"projectName"             : @"projectName",
                                                                    @"projectNatureName"       : @"projectNatureName",
                                                                    @"projectStartDate"        : @"projectStartDate",
                                                                    @"projectStatusName"       : @"projectStatusName",
                                                                    @"projectTypeName"         : @"projectTypeName",
                                                                    @"region"                  : @"region",
                                                                    @"startDate"               : @"startDate",
                                                                    @"projectImage"            : @"projectImage"
                                                                    }];
    
    // Inverse Attribute Mappings for ETGMLProject
    RKEntityMapping *projectMlMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGMLProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectMlMapping_ addAttributeMappingsFromDictionary:@{
                                                            @"calendarMonthOfYear" :@"calendarMonthOfYear",
                                                            @"calendarYear" : @"calendarYear",
                                                            @"calendarYearEnglishMonth"            : @"calendarYearEnglishMonth",
                                                            @"fTELoading"    : @"fTELoading",
                                                            @"projectStaffingStatusName" : @"projectStaffingStatusName",
                                                            @"reportingTimeKey" : @"reportingTimeKey"
                                                            }];

    
    // Inverse Attribute Mappings for ETGKeyMilestoneProjectPhase
    RKEntityMapping *keyMilestoneProjectPhase_ = [[RKEntityMapping alloc] initWithEntity:[ETGKeyMilestoneProjectPhase entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [keyMilestoneProjectPhase_ addAttributeMappingsFromDictionary:@{
                                                                    @"projectPhase"      : @"projectPhase"
                                                                    }];
    
    // Inverse Attribute Mappings for ETGBaselineType
    RKEntityMapping *projectKeyMilestoneBaseType_ = [[RKEntityMapping alloc] initWithEntity:[ETGBaselineType entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectKeyMilestoneBaseType_ addAttributeMappingsFromDictionary:@{
                                                                       @"baselineType"        : @"name",
                                                                       @"baselineTypeKey"     : @"key",
                                                                       @"dataTime"            : @"createdTime",
                                                                       @"projectId"           : @"projectKey"
                                                                       }];
    projectKeyMilestoneBaseType_.identificationAttributes = @[@"key", @"projectKey"];
    
    // Inverse Attribute Mappings for ETGRevision
    RKEntityMapping *projectKeyMilestoneRevision_ = [[RKEntityMapping alloc] initWithEntity:[ETGRevision entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectKeyMilestoneRevision_ addAttributeMappingsFromDictionary:@{
                                                                       @"revisionNo"        : @"number"
                                                                       }];
    projectKeyMilestoneRevision_.identificationAttributes = @[@"number"];
    
    // Inverse Attribute Mappings for ETGKeyMilestone
    RKEntityMapping *projectKeyMilestoneMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGKeyMilestone entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectKeyMilestoneMapping_ addAttributeMappingsFromDictionary:@{
                                                                      @"actualDt"            : @"actualDate",
                                                                      @"baseLineNum"         : @"baselineNum",
                                                                      @"mileStone"           : @"mileStone",
                                                                      @"plannedDt"           : @"plannedDate",
                                                                      @"indicator"           : @"indicator",
                                                                      }];
    
    // Inverse Attribute Mappings for ETGKeyHighlightProgressOverall
    RKEntityMapping *progressOverAllKeyhighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlightProgressOverall entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [progressOverAllKeyhighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                               @"overallCurrActualProgress" :@"overallCurrActualProgress",
                                                                               @"overallCurrPlanProgress"   :@"overallCurrPlanProgress",
                                                                               @"overallCurrVariance"       :@"overallCurrVariance",
                                                                               @"overallPrevActualProgress" :@"overallPrevActualProgress",
                                                                               @"overallPrevPlanProgress"   :@"overallPrevPlanProgress",
                                                                               @"overallPrevVariance"       :@"overallPrevVariance",
                                                                               }];
    
    // Inverse Attribute Mappings for ETGKeyHighlightProgress
    RKEntityMapping *progressKeyhighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlightProgress entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [progressKeyhighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                        @"activityID"         :@"activityID",
                                                                        @"activityName"        :@"activityName",
                                                                        @"currActualProgress" :@"currActualProgress",
                                                                        @"currPlanProgress"   :@"currPlanProgress",
                                                                        @"currVariance"       :@"currVariance",
                                                                        @"indicator"           :@"indicator",
                                                                        @"prevActualProgress" :@"prevActualProgress",
                                                                        @"prevPlanProgress"   :@"prevPlanProgress",
                                                                        @"prevVariance"       :@"prevVariance",
                                                                        @"weightage"           :@"weightage"
                                                                        }];
    
    // Inverse Attribute Mappings for ETGIssuesKeyHighlight
    RKEntityMapping *issuesKeyHighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGIssuesKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [issuesKeyHighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                      @"activity"      : @"activity",
                                                                      @"desc"          :@"desc",
                                                                      @"mitigationPlan":@"mitigationPlan"
                                                                      }];
    
    // Inverse Attribute Mappings for ETGMonthlyKeyHighlight
    RKEntityMapping *monthlyKeyHighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGMonthlyKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [monthlyKeyHighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                       @"activity"      :@"activity",
                                                                       @"desc"   :@"desc",
                                                                       @"mitigationPlan":@"mitigationPlan"
                                                                       }];
    
    // Inverse Attribute Mappings for ETGPlannedKeyHighlight
    RKEntityMapping *plannedKeyHighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGPlannedKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [plannedKeyHighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                       @"activity"      : @"activity",
                                                                       @"desc"   :@"desc",
                                                                       @"mitigationPlan":@"mitigationPlan"
                                                                       }];
    
    // Inverse Attribute Mappings for ETGPpaKeyHighlight
    RKEntityMapping *ppaKeyHighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGPpaKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [ppaKeyHighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                   @"activity"      :@"activity",
                                                                   @"desc"   :@"desc",
                                                                   @"mitigationPlan":@"mitigationPlan"
                                                                   }];
    
    // Inverse Attribute Mappings for ETGKeyHighlight
    RKEntityMapping *scorecardKeyHighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [scorecardKeyHighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                         @"overallPpa" : @"overallPpa",
                                                                         }];
    
    
    // Inverse Attribute Mappings for ETGProject
    RKEntityMapping *projectMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectMapping_ addAttributeMappingsFromDictionary:@{
                                                          @"AboutProject.projectKey"  : @"key",
                                                          @"AboutProject.projectName" : @"name"
                                                          }];
    projectMapping_.identificationAttributes = @[@"key", @"name"];
    
    // Inverse Relationship mapping of ETGAfe to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"AFEReport_chartdata" toKeyPath:@"etgAfe_Projects" withMapping:projectAFEMapping_]];
    // Inverse Relationship mapping of ETGAfeTable to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"AFEReport_tabledata" toKeyPath:@"etgAfeTable_Projects" withMapping:projectAFETableMapping_]];
    // Inverse Relationship mapping of ETGBudgetCoreInfo to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"BudgetPerformanceReport_chartdata" toKeyPath:@"etgBudgetCoreInfo_Projects" withMapping:projectBudgetMapping_]];
    // Inverse Relationship mapping of ETGBudgetPerformance to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"BudgetPerformanceReport_tabledata" toKeyPath:@"etgBudgetPerformance_Projects" withMapping:projectBudgetTableMapping_]];
    [projectBudgetTableMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"budgetHolder" toKeyPath:@"budgetHolder" withMapping:costAllocationMapping_]];
    // Inverse Relationship mapping of ETGHseProject to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"totalManHour" toKeyPath:@"etgHse_Projects" withMapping:projectHSEMapping_]];
    // Inverse Relationship mapping of ETGHseTable_Project to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"HSEReport" toKeyPath:@"etgHseTable_Projects" withMapping:projectHSETableMapping_]];
    // Inverse Relationship mapping of ETGFirstHydrocarbon to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"KeyMileStoneReport_FirstHydroCarbon" toKeyPath:@"etgFirstHydrocarbon_Projects" withMapping:projectKeyMilestoneHydroMapping_]];
    // Inverse Relationship mapping of ETGRiskOpportunity to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ROImpactReport" toKeyPath:@"etgOpportunityImpact_Projects" withMapping:projectROImpactMapping_]];
    // Inverse Relationship mapping of ETGPPMS to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"PPMSReviewSummary" toKeyPath:@"etgPpms_Projects"  withMapping:projectPPMSMapping_]];
    // Inverse Relationship mapping of ETGProductionRtbd_Project to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ProductionRTBDReport" toKeyPath:@"etgProductionRtbd_Projects" withMapping:projectRTBDMapping_]];
    // Inverse Relationship mapping of ETGScheduleProgress to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ScheduleScurve" toKeyPath:@"etgScheduleProgress_Projects" withMapping:projectScheduleProgressMapping_]];
    
    
    // Inverse Relationship mapping of ETGKeyMilestoneProjectPhase to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"projectPhase" toKeyPath:@"etgKeyMilestone_ProjectPhase" withMapping:keyMilestoneProjectPhase_]];
    
    // Inverse Relationship mapping of ETGMLProject to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ManpowerLoadings" toKeyPath:@"etgMlProjects" withMapping:projectMlMapping_]];
    
    // Inverse Relationship mapping of ETGBaselineType to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"baselineTypes" toKeyPath:@"baselineTypes" withMapping:projectKeyMilestoneBaseType_]];
    // Inverse Relationship mapping of ETGRevision to ETGProjectSummary
    [projectKeyMilestoneBaseType_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"revisions" toKeyPath:@"revisions" withMapping:projectKeyMilestoneRevision_]];
    // Inverse Relationship mapping of ETGKeyMilestone to ETGBaselineType
    [projectKeyMilestoneRevision_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyMilestones" toKeyPath:@"keyMilestones" withMapping:projectKeyMilestoneMapping_]];
    // Inverse Relationship mapping of ETGIssuesKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"issuesConcerns" toKeyPath:@"issuesAndConcerns"  withMapping:issuesKeyHighlightsMapping_]];
    // Inverse Relationship mapping of ETGKeyHighlightProgressOverall to ETGKeyHighlightProgress
    [progressOverAllKeyhighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyhighLightsTable" toKeyPath:@"keyHighLightsTable" withMapping:progressKeyhighlightsMapping_]];
    // Inverse Relationship mapping of ETGKeyHighlightProgressOverall to ETGKeyHighlight
    [scorecardKeyHighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyhighlightsProgress" toKeyPath:@"keyhighlightsProgress"  withMapping:progressOverAllKeyhighlightsMapping_]];
    // Inverse Relationship mapping of ETGMonthlyKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"monthlyHighLights" toKeyPath:@"monthlyKeyHighlights"  withMapping:monthlyKeyHighlightsMapping_]];
    // Inverse Relationship mapping of ETGPlannedKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"plannedActivitiesforNextMonth" toKeyPath:@"plannedActivitiesforNextMonth"  withMapping:plannedKeyHighlightsMapping_]];
    // Inverse Relationship mapping of ETGPpaKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ppa" toKeyPath:@"ppa"  withMapping:ppaKeyHighlightsMapping_]];
    // Inverse Relationship mapping of ETGKeyHighlight to ETGProject
    [projectMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyHighLight" toKeyPath:@"keyHighlights"  withMapping:scorecardKeyHighlightsMapping_]];
    //    // Inverse Relationship mapping of ETGProjectBackground to ETGProject
    //    [projectMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"projectBackground"  withMapping:projectBackgroundMapping_]];
    // Inverse Relationship mapping of ETGProject to ETGProjectSummary
    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"AboutProject" toKeyPath:@"project.projectBackground" withMapping:projectBackgroundMapping_]];
    
    _inverseMapping = [projectSummaryMapping_ inverseMapping];
}

- (NSDictionary *)serializeObject:(NSManagedObject *)object reportingMonth:(NSString *)reportingMonth projectKey:(NSNumber *)projectKey {
    //Convert coredata to JSON
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    RKObjectMappingOperationDataSource *dataSource = [RKObjectMappingOperationDataSource new];
    RKMappingOperation *mappingOperation = [[RKMappingOperation alloc] initWithSourceObject:object
                                                                          destinationObject:json
                                                                                    mapping:_inverseMapping];
    mappingOperation.dataSource = dataSource;
    NSError *error = nil;
    [mappingOperation performMapping:&error];
    if (error) {
        DDLogError(@"%@%@", logErrorPrefix, [NSString stringWithFormat:serializationError, error]);
        return nil;
    }
    
    json = [self getRootName:json reportingMonth:reportingMonth projectKey:projectKey];
    
    return json;
}

-(NSMutableDictionary *) getRootName:(NSMutableDictionary*)json reportingMonth:(NSString *)reportingMonth projectKey:(NSNumber *)projectKey {
    
    NSMutableDictionary *rootDict = [[NSMutableDictionary alloc]init];
    NSNumberFormatter *intFormatter = [[NSNumberFormatter alloc] init];
    [intFormatter setNumberStyle:NSNumberFormatterNoStyle];
    NSString *reportName;
    NSString *strDisabled = @"disabled";
    
    //UAC
    reportName = @"AFE Governance";
    if ([self isPortfolioReportEnabledForReportName:reportName]) {
        
        if ([[json valueForKey:@"AFEReport_chartdata"] count] || [[json valueForKey:@"AFEReport_tabledata"] count]) {
            
            NSMutableDictionary *childDict = [[NSMutableDictionary alloc]init];
            
            for (NSMutableDictionary *afe in [json valueForKey:@"AFEReport_chartdata"]) {
                
                NSString *status = [afe valueForKey:@"Status"];
                status = [status stringByReplacingOccurrencesOfString:@">=" withString:@"&#8805"];
                status = [status stringByReplacingOccurrencesOfString:@"<=" withString:@"&#x2264"];
                
                [afe removeObjectForKey:@"Status"];
                [afe setObject:status forKey:@"Status"];
            }
            
            [childDict setValue:[json valueForKey:@"AFEReport_chartdata"] forKey:@"chartdata"];
            
            //Table Data
            NSMutableArray *tableDataArray = [[NSMutableArray alloc]init];
            
            if ([self isPortfolioTableReportEnabledForReportName:reportName]) {
                NSArray *filteredArray = [json valueForKey:@"AFEReport_tabledata"];
                
                for (int i = 0; i < filteredArray.count; i++) {
                    NSMutableDictionary *tableDataDict = [[NSMutableDictionary alloc] init];
                    [tableDataDict setValue:[[filteredArray valueForKey:@"afeSection"] objectAtIndex:i] forKey:@"AFEDescription"];
                    [tableDataDict setValue:[[filteredArray valueForKey:@"latestAFE"] objectAtIndex:i] forKey:@"latestapprovedafe"];
                    if ([[filteredArray valueForKey:@"afe_VOWD"] objectAtIndex:i]) {
                        [tableDataDict setValue:[[filteredArray valueForKey:@"afe_VOWD"] objectAtIndex:i] forKey:@"itd"];
                    }
                    
                    if ([[filteredArray valueForKey:@"afe_AFC"] objectAtIndex:i]) {
                        [tableDataDict setValue:[[filteredArray valueForKey:@"afe_AFC"] objectAtIndex:i] forKey:@"afc"];
                    }
                    
                    NSString *strVariance;
                    
                    if ([filteredArray valueForKey:@"afe_Variance"] != NULL) {
                        NSDecimalNumber *variance = [[filteredArray valueForKey:@"afe_Variance"] objectAtIndex:i];
                        if (![variance isKindOfClass:[NSNull class]]) {
                            strVariance = variance.decimalNumberToString;
                        }
                    }
                    
                    [tableDataDict setValue:strVariance forKey:@"variance"];
                    
                    [tableDataDict setValue:[[filteredArray valueForKey:@"afe_Indicator"] objectAtIndex:i] forKey:@"indicator"];
                    [tableDataArray addObject:tableDataDict];
                }
                
                [childDict setValue:tableDataArray forKey:@"tabledata"];
                
            } else {
                [childDict setValue:strDisabled forKey:@"tabledata"];
            }
            
            childDict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] detectNumericJSONByKeyValue:childDict];
            [rootDict setValue:childDict forKey:@"afe"];
        } else {
            [rootDict setValue:@"no data" forKey:@"afe"];
        }
    } else {
        [rootDict setValue:strDisabled forKey:@"afe"];
    }
    
    reportName = @"Budget Performance";
    if ([self isPortfolioReportEnabledForReportName:reportName]) {
        
        if ([[json valueForKey:@"BudgetPerformanceReport_chartdata"] count] || [[json valueForKey:@"BudgetPerformanceReport_tabledata"] count]) {
            
            NSMutableDictionary *childDict = [[NSMutableDictionary alloc]init];
            NSMutableDictionary *grandChildDict = [[NSMutableDictionary alloc]init];
            NSMutableArray *childArray = [NSMutableArray array];
            NSArray *seriesArray = [[NSArray alloc] init];
            NSMutableArray *series = [NSMutableArray array];

            //Core info
            if ([[json valueForKey:@"BudgetPerformanceReport_chartdata"] count]) {
                [grandChildDict setValue:[json valueForKey:@"BudgetPerformanceReport_chartdata"] forKey:@"coreinfo"];
            } else {
                [grandChildDict setValue:@"no data" forKey:@"coreinfo"];
            }
            
            seriesArray = [json valueForKey:@"BudgetPerformanceReport_tabledata"];
            
            //********************************
            // With Budget Holder
            //********************************
            
            NSMutableArray *listOfSelectedbudgetHolders = [NSMutableArray array];
            NSMutableArray *dataWithSelectedBudgetHolder = [NSMutableArray array];
            
            // Get the selected budget holder
//            NSLog(@"%@", [_filterDictionary valueForKeyPath:@"kSelectedBudgetHolder.key"]);
            NSMutableDictionary *selectedBudgetHolder = [NSMutableDictionary dictionary];
            [selectedBudgetHolder setValue:[_filterDictionary valueForKeyPath:@"kSelectedBudgetHolder.key"] forKey:@"key"];
            if (selectedBudgetHolder) {
                [listOfSelectedbudgetHolders addObject:selectedBudgetHolder];
            }
            
            // Get all CPB/Yep data
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"plandescription == %@ AND forecastdescription == %@", @"CPB", @"YEP"];
            NSArray *foundCpbYepData = [seriesArray filteredArrayUsingPredicate:predicate];
            
            // Check if the budget holder of found CPB/Yep data exist in the list of selected budget holder
            for (id record in foundCpbYepData) {
                id budgetHolderKey = [record valueForKeyPath:@"budgetHolder.key"];
                predicate = [NSPredicate predicateWithFormat:@"key == %@", budgetHolderKey];
                NSArray *withSelectedBudgetHolder = [listOfSelectedbudgetHolders filteredArrayUsingPredicate:predicate];
                
                if (withSelectedBudgetHolder.count) {
                    [dataWithSelectedBudgetHolder addObject:record];
                }
            }
            
            // Compute for the total
            NSDecimalNumber *totalPlanValue = [NSDecimalNumber decimalNumberWithString:@"0.0"];
            NSDecimalNumber *totalForecastValue = [NSDecimalNumber decimalNumberWithString:@"0.0"];
            NSDecimalNumber *totalForecastVariance = [NSDecimalNumber decimalNumberWithString:@"0.0"];
            
            if (dataWithSelectedBudgetHolder.count) {

                for (int i = 0; i < dataWithSelectedBudgetHolder.count; i++) {
                    
                    NSDecimalNumber *planValue = [[dataWithSelectedBudgetHolder valueForKey:@"planvalue"] objectAtIndex:i];
                    if (![planValue isKindOfClass:[NSNull class]]) {
                        totalPlanValue = [totalPlanValue decimalNumberByAdding:planValue];
                        
                    }
                    
                    NSDecimalNumber *forecastValue = [[dataWithSelectedBudgetHolder valueForKey:@"forecastvalue"] objectAtIndex:i];
                    if (![forecastValue isKindOfClass:[NSNull class]]) {
                        totalForecastValue = [totalForecastValue decimalNumberByAdding:forecastValue];
                    }
                    
                    NSDecimalNumber *forecastVariance = [[dataWithSelectedBudgetHolder valueForKey:@"forecastvariance"] objectAtIndex:i];
                    if (![forecastVariance isKindOfClass:[NSNull class]]) {
                        totalForecastVariance = [totalForecastVariance decimalNumberByAdding:forecastVariance];
                    }
                }
                
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                
                [dict setValue:[[dataWithSelectedBudgetHolder valueForKey:@"plandescription"] objectAtIndex:0] forKey:@"plandescription"];
                [dict setValue:totalPlanValue forKey:@"planvalue"];
                
                [dict setValue:[[dataWithSelectedBudgetHolder valueForKey:@"forecastdescription"] objectAtIndex:0] forKey:@"forecastdescription"];
                [dict setValue:totalForecastValue forKey:@"forecastvalue"];
                
                NSDecimalNumber *percentageDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:[@100 decimalValue]];
                NSDecimalNumber *forecastVariancePercentage = [totalForecastVariance decimalNumberByMultiplyingBy:percentageDecimalNumber];
                [dict setValue:forecastVariancePercentage forKey:@"forecastvariance"];
                
                [dict setValue:[[seriesArray valueForKey:@"indicator"] objectAtIndex:0] forKey:@"indicator"];
                [series addObject:dict];

            }
            
            //********************************
            // Without Budget Holder
            //********************************
            
            predicate = [NSPredicate predicateWithFormat:@"plandescription != %@ AND forecastdescription != %@", @"CPB", @"YEP"];
            NSArray *nonCpbYepData = [seriesArray filteredArrayUsingPredicate:predicate];

            //Chart data
            for (int i = 0; i < nonCpbYepData.count; i++) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                
                [dict setValue:[[nonCpbYepData valueForKey:@"plandescription"] objectAtIndex:i] forKey:@"plandescription"];
                NSDecimalNumber *planvalue = [[nonCpbYepData valueForKey:@"planvalue"] objectAtIndex:i];
                if (![planvalue isKindOfClass:[NSNull class]]) {
                    [dict setValue:planvalue forKey:@"planvalue"];
                }
                
                [dict setValue:[[nonCpbYepData valueForKey:@"forecastdescription"] objectAtIndex:i] forKey:@"forecastdescription"];
                NSDecimalNumber *forecastvalue = [[nonCpbYepData valueForKey:@"forecastvalue"] objectAtIndex:i];
                if (![forecastvalue isKindOfClass:[NSNull class]]) {
                    [dict setValue:forecastvalue forKey:@"forecastvalue"];
                }
                
                NSDecimalNumber *forecastvariance = [[nonCpbYepData valueForKey:@"forecastvariance"] objectAtIndex:i];
                if (![forecastvariance isKindOfClass:[NSNull class]]) {
                    NSDecimalNumber *percentageDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:[@100 decimalValue]];
                    NSDecimalNumber *forecastVariancePercentage = [forecastvariance decimalNumberByMultiplyingBy:percentageDecimalNumber];
                    [dict setValue:forecastVariancePercentage forKey:@"forecastvariance"];
                }
                
                [dict setValue:[[nonCpbYepData valueForKey:@"indicator"] objectAtIndex:i] forKey:@"indicator"];
                [series addObject:dict];
            }
            
            [grandChildDict setValue:series forKey:@"series"];
            
            [childArray addObject:grandChildDict];
            [childDict setValue:childArray forKey:@"chartdata"];
            
            //Table data
            if ([self isPortfolioTableReportEnabledForReportName:reportName]) {
                [childDict setValue:childArray forKey:@"tabledata"];
            } else {
                [childDict setValue:strDisabled forKey:@"tabledata"];
            }
            
            [rootDict setValue:childDict forKey:@"budget"];
        } else {
            [rootDict setValue:@"no data" forKey:@"budget"];
        }
    } else {
        [rootDict setValue:strDisabled forKey:@"budget"];
    }
    
    reportName = @"HSE Performance";
    if ([self isPortfolioReportEnabledForReportName:reportName]) {
        if ([[json valueForKey:@"HSEReport"] count]) {
            
            NSMutableDictionary *mainDict = [[NSMutableDictionary alloc]init];
            NSMutableDictionary *childDict = [[NSMutableDictionary alloc]init];
            NSMutableDictionary *seriesDict = [[NSMutableDictionary alloc]init];
            NSMutableDictionary *kpiDict = [[NSMutableDictionary alloc]init];
            NSMutableArray *arrChart = [[NSMutableArray alloc]init];
            NSMutableArray *arrTable = [[NSMutableArray alloc]init];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"HSEID == %@", @"FI"];
            NSArray *filteredArray = [[json valueForKeyPath:@"HSEReport.HSEDetails"] filteredArrayUsingPredicate:predicate];
            
            if ([filteredArray count]) {
                NSDecimalNumber *ytd = [[filteredArray valueForKey:@"ytdfrequency"] objectAtIndex:0];
                if (![ytd isKindOfClass:[NSNull class]]) {
                    [seriesDict setValue:ytd.decimalNumberInNumberFormat forKey:@"FIF"];
                }
                [kpiDict setValue:[[filteredArray valueForKey:@"kpi"] objectAtIndex:0] forKey:@"FIFkpi"];
            } else {
                [seriesDict setValue:[NSNumber numberWithDouble:0.00] forKey:@"FIF"];
                [kpiDict setValue:[NSNumber numberWithInt:0] forKey:@"FIFkpi"];
            }
            
            predicate = [NSPredicate predicateWithFormat:@"HSEID == %@", @"LTI"];
            filteredArray = [[json valueForKey:@"HSEReport"] filteredArrayUsingPredicate:predicate];
            
            if ([filteredArray count]) {
                NSDecimalNumber *ytd = [[filteredArray valueForKey:@"ytdfrequency"] objectAtIndex:0];
                if (![ytd isKindOfClass:[NSNull class]]) {
                    [seriesDict setValue:ytd.decimalNumberInNumberFormat forKey:@"LTIF"];
                }
                [kpiDict setValue:[[filteredArray valueForKey:@"kpi"] objectAtIndex:0] forKey:@"LTIFkpi"];
            } else {
                [seriesDict setValue:[NSNumber numberWithDouble:0.00] forKey:@"LTIF"];
                [kpiDict setValue:[NSNumber numberWithInt:0] forKey:@"LTIFkpi"];
            }
            
            predicate = [NSPredicate predicateWithFormat:@"HSEID == %@", @"TRC"];
            filteredArray = [[json valueForKey:@"HSEReport"] filteredArrayUsingPredicate:predicate];
            
            if ([filteredArray count]) {
                NSDecimalNumber *ytd = [[filteredArray valueForKey:@"ytdfrequency"] objectAtIndex:0];
                if (![ytd isKindOfClass:[NSNull class]]) {
                    [seriesDict setValue:ytd.decimalNumberInNumberFormat forKey:@"TRCF"];
                }
                [kpiDict setValue:[[filteredArray valueForKey:@"kpi"] objectAtIndex:0] forKey:@"TRCFkpi"];
            } else {
                [seriesDict setValue:[NSNumber numberWithDouble:0.00] forKey:@"TRCF"];
                [kpiDict setValue:[NSNumber numberWithInt:0] forKey:@"TRCFkpi"];
            }
            
            [childDict setValue:@4 forKey:@"fatalityCount"];
            [childDict setValue:seriesDict forKey:@"series"];
            [childDict setValue:kpiDict forKey:@"kpi"];
            NSNumber *totalManHour = [[json valueForKey:@"totalManHour"] valueForKey:@"totalManHour"];
            [childDict setValue:[intFormatter stringFromNumber:totalManHour] forKey:@"totalManHour"];
            
            for (int i = 0; i < [[json valueForKey:@"HSEReport"] count]; i++) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                
                [dict setValue:[[json valueForKeyPath:@"HSEReport.HSEID"] objectAtIndex:i] forKey:@"HSEID"];
                [dict setValue:[[json valueForKeyPath:@"HSEReport.hsecriteria"] objectAtIndex:i] forKey:@"hsecriteria"];
                [dict setValue:[[json valueForKeyPath:@"HSEReport.indicator"] objectAtIndex:i] forKey:@"indicator"];
                
                NSNumber *kpi = [[json valueForKeyPath:@"HSEReport.kpi"] objectAtIndex:i];
                NSNumber *ytdCase = [[json valueForKeyPath:@"HSEReport.ytdcase"] objectAtIndex:i];
                
                [dict setValue:[intFormatter stringFromNumber:kpi] forKey:@"kpi"];
                [dict setValue:[intFormatter stringFromNumber:ytdCase] forKey:@"ytdcase"];
                
                NSDecimalNumber *ytd = [[json valueForKeyPath:@"HSEReport.ytdfrequency"] objectAtIndex:i];
                [dict setValue:ytd forKey:@"ytdfrequency"];
                [arrTable addObject:dict];
            }
            
            [arrChart addObject:childDict];
            [mainDict setValue:arrChart forKey:@"chartdata"];
            [mainDict setValue:arrTable forKey:@"tabledata"];
            [rootDict setValue:mainDict forKey:@"hse"];
        } else {
            [rootDict setValue:@"no data" forKey:@"hse"];
        }
    } else {
        [rootDict setValue:strDisabled forKey:@"hse"];
    }
    
    reportName = @"Project Performance - Manpower Loading Histogram";
    if ([ETGJsonHelper canAccessInUac:kManpowerProjectPerformanceRequiredKey]) {
         if ([[json valueForKey:@"ManpowerLoadings"] count])
         {
             NSArray *jsonDict = [json valueForKey:@"ManpowerLoadings"];
             
             NSMutableDictionary *processedJSON = [NSMutableDictionary dictionary];
             NSMutableArray *chartData = [NSMutableArray arrayWithObject:[self aggregateDataForChartFrom:jsonDict reportingMonth:reportingMonth]];
             
             //take the data from chart
             NSArray *tableMonthlyArray  = [[[chartData objectAtIndex:0] valueForKey:@"categories"] objectAtIndex:0];
             NSArray *tableFilledArray  =[[[[[chartData objectAtIndex:0] valueForKey:@"series"] objectAtIndex:0] valueForKey:@"data"] objectAtIndex:1];
             NSArray *tableVacantArray =[[[[[chartData objectAtIndex:0] valueForKey:@"series"] objectAtIndex:0] valueForKey:@"data"] objectAtIndex:0];
             NSMutableArray *aggregateTableBody = [[NSMutableArray alloc] init];

             for (int i = 0; i < tableMonthlyArray.count; i++) {
                 NSMutableDictionary *monthlyDict = [NSMutableDictionary dictionary];
                 [monthlyDict setValue:[tableMonthlyArray objectAtIndex:i] forKey:@"name"];
                 [monthlyDict setValue:[tableFilledArray objectAtIndex:i] forKey:@"filled"];
                 [monthlyDict setValue:[tableVacantArray objectAtIndex:i] forKey:@"vacant"];
                 [aggregateTableBody addObject:monthlyDict];
                 
             }
             
             NSMutableDictionary *tableData = [NSMutableDictionary dictionaryWithDictionary:@{@"header": @"Month",
                                                                                              @"body" : aggregateTableBody}];
             
             [processedJSON setValue:tableData forKey:@"tabledata"];
             [processedJSON setValue:[[chartData objectAtIndex:0] objectAtIndex:0] forKey:@"chartdata"];
//             NSError *e;
//             NSString *path = [[NSBundle mainBundle] pathForResource:@"manpowerDataProject" ofType:@"json"];
//             NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//             NSDictionary *JSON =
//             [NSJSONSerialization JSONObjectWithData: [content dataUsingEncoding:NSUTF8StringEncoding]
//                                             options: NSJSONReadingMutableContainers
//                                               error: &e];
//             NSLog(@"PRocessedJSON :%@",processedJSON);
 
             [rootDict setValue:processedJSON forKey:@"mps"];
         }
         else {
             [rootDict setValue:@"no data" forKey:@"mps"];
         }
    } else {
       [rootDict setValue:strDisabled forKey:@"mps"];
    }
    
    reportName = @"PPMS Review Summary";
    if ([self isPortfolioReportEnabledForReportName:reportName]) {
        
        if ([[json valueForKey:@"PPMSReviewSummary"] count]) {
            NSMutableArray *childArray = [NSMutableArray array];
            
            for (int i = 0; i < [[json valueForKey:@"PPMSReviewSummary"] count]; i++) {
                NSMutableDictionary *childDict = [[NSMutableDictionary alloc]init];
                [childDict setValue:[[json valueForKeyPath:@"PPMSReviewSummary.Status"] objectAtIndex:i] forKey:@"Status"];
                [childDict setValue:[[json valueForKeyPath:@"PPMSReviewSummary.Ind"] objectAtIndex:i] forKey:@"Ind"];
                
                NSDecimalNumber *percentage = [[json valueForKeyPath:@"PPMSReviewSummary.Percentage"] objectAtIndex:i];
                NSString *ppmsPercentage = @"0%";
                if (![percentage isKindOfClass:[NSNull class]]) {
                    ppmsPercentage = [NSString stringWithFormat:@"%@%@", percentage.decimalNumberInStringFormat, @"%"];
                }
                
                [childDict setValue:ppmsPercentage forKey:@"Percentage"];
                [childArray addObject:childDict];
            }
            
            [rootDict setValue:childArray forKey:@"ppms"];
        } else {
            [rootDict setValue:@"no data" forKey:@"ppms"];
        }
    } else {
        [rootDict setValue:strDisabled forKey:@"ppms"];
    }
    
    
    reportName = @"Key Milestone";
    if ([self isPortfolioReportEnabledForReportName:reportName]){
        
        if ([[json valueForKey:@"baselineTypes"] count] > 0 || [[json valueForKey:@"KeyMileStoneReport_FirstHydroCarbon"] count] > 0)
        {
            // Chart Data
            NSMutableDictionary *chartData = [[NSMutableDictionary alloc] init];
            NSMutableArray *KeyMileStoneDetails = [NSMutableArray array];
            NSArray *chartDataArray = [[NSArray alloc]init];
            NSArray *KeyMileStoneDetailsArray = nil;
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", projectKey];
            ETGProject *project = [ETGProject findFirstWithPredicate:predicate];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            NSDate *dateReportingMonth = [dateFormatter dateFromString:reportingMonth];
            
            
            _keyMilestones = _filterDictionary[kSelectedKeyMilestone];
            if ([_keyMilestones count] == 0) {
                _keyMilestones = [[ETGFilterModelController sharedController] getLatestKeyMilestoneOfProject:project forReportingMonth:dateReportingMonth];
            }

            for (NSManagedObject *km in _keyMilestones) {
                
                NSArray *keys = [[[km entity] attributesByName] allKeys];
                NSDictionary *dict = [km dictionaryWithValuesForKeys:keys];
                NSMutableDictionary *dictKm = [NSMutableDictionary dictionaryWithDictionary:dict];
                
                [dictKm setValue:[dictKm valueForKey: @"actualDate"] forKey: @"actualDt"];
                [dictKm removeObjectForKey: @"actualDate"];
                [dictKm setValue:[dictKm valueForKey: @"plannedDate"] forKey: @"plannedDt"];
                [dictKm removeObjectForKey: @"plannedDate"];
                [dictKm setValue:[dictKm valueForKey: @"baselineNum"] forKey: @"baseLineNum"];
                [dictKm removeObjectForKey: @"baselineNum"];
                
                [KeyMileStoneDetails addObject:dictKm];
            }
            
            //Try to get value for projectPhase
            NSString *projectPhase = [[json valueForKey:@"projectPhase"] valueForKey:@"projectPhase"];
            
            KeyMileStoneDetailsArray = [NSArray arrayWithArray:KeyMileStoneDetails];
            chartDataArray = [self formatChartContents:KeyMileStoneDetailsArray];
            [chartData setValue:@"Key Milestone" forKey:@"chartTitle"];
            [chartData setValue:projectPhase forKey:@"chartSubtitle"];
            [chartData setValue:chartDataArray forKey:@"chartContents"];
            
            // First Hydro Carbon Data
            NSMutableDictionary *firstHydrocarbon = [[NSMutableDictionary alloc] init];
            NSMutableArray *hydrocarbonArray = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < [[json valueForKey:@"KeyMileStoneReport_FirstHydroCarbon"] count]; i++) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                
                [dict setValue:[[json valueForKeyPath:@"KeyMileStoneReport_FirstHydroCarbon.estimateDate"] objectAtIndex:i] forKey:@"forecast"];
                [dict setValue:[[json valueForKeyPath:@"KeyMileStoneReport_FirstHydroCarbon.facilityName"] objectAtIndex:i] forKey:@"field"];
                [dict setValue:[[json valueForKeyPath:@"KeyMileStoneReport_FirstHydroCarbon.planDate"] objectAtIndex:i] forKey:@"plan"];
                
                dict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateWithNSString:dict];
                [hydrocarbonArray addObject:dict];
            }
            [firstHydrocarbon setValue:hydrocarbonArray forKey:@"firstHydrocarbon"];
            
            // Table Data
            NSMutableDictionary *tableData = [[NSMutableDictionary alloc] init];
            NSMutableArray *tableArray = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < KeyMileStoneDetailsArray.count; i++) {
                
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                
                [dict setValue:[[KeyMileStoneDetailsArray valueForKey:@"plannedDt"] objectAtIndex:i] forKey:@"baseline"];
                [dict setValue:[[KeyMileStoneDetailsArray valueForKey:@"actualDt"] objectAtIndex:i] forKey:@"outlook"];
                [dict setValue:[[KeyMileStoneDetailsArray valueForKeyPath:@"mileStone"] objectAtIndex:i] forKey:@"milestone"];
                [dict setValue:[[KeyMileStoneDetailsArray valueForKeyPath:@"indicator"] objectAtIndex:i] forKey:@"indicator"];
                
                dict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateWithNSString:dict];
                
                [tableArray addObject:dict];
            }
            [tableData setValue:tableArray forKey:@"tabledata"];
            
            // Keymilestone assembly
            NSMutableDictionary *keyMilestone = [[NSMutableDictionary alloc] init];
            [keyMilestone setValue:chartData forKey:@"chartdata"];
            [keyMilestone setValue:hydrocarbonArray forKey:@"firstHydrocarbon"];
            [keyMilestone setValue:tableArray forKey:@"tabledata"];
            [rootDict setValue:keyMilestone forKey:@"keymilestone"];
        } else {
            [rootDict setValue:@"no data" forKey:@"keymilestone"];
        }
    } else {
        [rootDict setValue:strDisabled forKey:@"keymilestone"];
    }
    
    reportName = @"Production and RTBD Performance";
    if ([self isPortfolioReportEnabledForReportName:reportName]) {
        
        if ([[json valueForKey:@"ProductionRTBDReport"] count]) {
            
            NSMutableDictionary *childDict = [[NSMutableDictionary alloc]init];
            NSMutableDictionary *grandChildDict = [[NSMutableDictionary alloc]init];
            NSMutableDictionary *productionDict = [[NSMutableDictionary alloc]init];
            NSMutableDictionary *rtbdDict = [[NSMutableDictionary alloc]init];
            NSMutableArray *cpbDataArray = [NSMutableArray array];
            NSMutableArray *yepDataArray = [NSMutableArray array];
            NSMutableArray *prodArray = [NSMutableArray array];
            NSMutableArray *rtbdArray = [NSMutableArray array];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@ AND type == %@", @"Production", @"Oil"];
            NSArray *filteredArray = [[json valueForKey:@"ProductionRTBDReport"] filteredArrayUsingPredicate:predicate];
            
            if ([filteredArray count]) {
                NSDecimalNumber *cpb = [[filteredArray valueForKey:@"cpb"] objectAtIndex:0];
                if (![cpb isKindOfClass:[NSNull class]]) {
                    [cpbDataArray addObject:cpb.decimalNumberInNumberFormat];
                }
                
                NSDecimalNumber *yep = [[filteredArray valueForKey:@"yep"] objectAtIndex:0];
                if (![yep isKindOfClass:[NSNull class]]) {
                    [yepDataArray addObject:yep.decimalNumberInNumberFormat];
                }
            } else {
                [cpbDataArray addObject:[NSNumber numberWithDouble:0.00]];
                [yepDataArray addObject:[NSNumber numberWithDouble:0.00]];
            }
            
            predicate = [NSPredicate predicateWithFormat:@"category == %@ AND type == %@", @"Production", @"Gas"];
            filteredArray = [[json valueForKey:@"ProductionRTBDReport"] filteredArrayUsingPredicate:predicate];
            
            if ([filteredArray count]) {
                NSDecimalNumber *cpb = [[filteredArray valueForKey:@"cpb"] objectAtIndex:0];
                if (![cpb isKindOfClass:[NSNull class]]) {
                    [cpbDataArray addObject:cpb.decimalNumberInNumberFormat];
                }
                
                NSDecimalNumber *yep = [[filteredArray valueForKey:@"yep"] objectAtIndex:0];
                if (![yep isKindOfClass:[NSNull class]]) {
                    [yepDataArray addObject:yep.decimalNumberInNumberFormat];
                }
            } else {
                [cpbDataArray addObject:[NSNumber numberWithDouble:0.00]];
                [yepDataArray addObject:[NSNumber numberWithDouble:0.00]];
            }
            
            predicate = [NSPredicate predicateWithFormat:@"category == %@ AND type == %@", @"Production", @"Condy"];
            filteredArray = [[json valueForKey:@"ProductionRTBDReport"] filteredArrayUsingPredicate:predicate];
            
            if ([filteredArray count]) {
                NSDecimalNumber *cpb = [[filteredArray valueForKey:@"cpb"] objectAtIndex:0];
                if (![cpb isKindOfClass:[NSNull class]]) {
                    [cpbDataArray addObject:cpb.decimalNumberInNumberFormat];
                }
                
                NSDecimalNumber *yep = [[filteredArray valueForKey:@"yep"] objectAtIndex:0];
                if (![yep isKindOfClass:[NSNull class]]) {
                    [yepDataArray addObject:yep.decimalNumberInNumberFormat];
                }
            } else {
                [cpbDataArray addObject:[NSNumber numberWithDouble:0.00]];
                [yepDataArray addObject:[NSNumber numberWithDouble:0.00]];
            }
            
            [cpbDataArray addObject:[NSNull null]];
            [yepDataArray addObject:[NSNull null]];
            
            [productionDict setValue:@"CPB" forKey:@"name"];
            [productionDict setValue:cpbDataArray forKey:@"data"];
            [prodArray addObject:productionDict];
            
            productionDict = [NSMutableDictionary dictionary];
            [productionDict setValue:@"YEP" forKey:@"name"];
            [productionDict setValue:yepDataArray forKey:@"data"];
            [prodArray addObject:productionDict];
            [grandChildDict setValue:prodArray forKey:@"newproduction"];
            
            cpbDataArray = [NSMutableArray array];
            yepDataArray = [NSMutableArray array];
            
            predicate = [NSPredicate predicateWithFormat:@"category == %@", @"RTBD"];
            filteredArray = [[json valueForKey:@"ProductionRTBDReport"] filteredArrayUsingPredicate:predicate];
            [cpbDataArray addObject:[NSNull null]];
            [yepDataArray addObject:[NSNull null]];
            [cpbDataArray addObject:[NSNull null]];
            [yepDataArray addObject:[NSNull null]];
            [cpbDataArray addObject:[NSNull null]];
            [yepDataArray addObject:[NSNull null]];
            [cpbDataArray addObject:[filteredArray valueForKeyPath:@"@sum.cpb"]];
            [yepDataArray addObject:[filteredArray valueForKeyPath:@"@sum.yep"]];
            
            [rtbdDict setValue:@"CPB" forKey:@"name"];
            [rtbdDict setValue:cpbDataArray forKey:@"data"];
            [rtbdArray addObject:rtbdDict];
            rtbdDict = [NSMutableDictionary dictionary];
            [rtbdDict setValue:@"YEP" forKey:@"name"];
            [rtbdDict setValue:yepDataArray forKey:@"data"];
            [rtbdArray addObject:rtbdDict];
            [grandChildDict setValue:rtbdArray forKey:@"rtbd"];
            [childDict setValue:grandChildDict forKey:@"chartdata"];
            
            // Table Data
            NSMutableArray *tableDataArray = [[NSMutableArray alloc]init];
            filteredArray = [json valueForKey:@"ProductionRTBDReport"];
            for (int i = 0; i < filteredArray.count; i++) {
                NSMutableDictionary *tableDataDict = [[NSMutableDictionary alloc] init];
                [tableDataDict setValue:[[filteredArray valueForKey:@"category"] objectAtIndex:i] forKey:@"category"];
                [tableDataDict setValue:[[filteredArray valueForKey:@"type"] objectAtIndex:i] forKey:@"hydrocarbonType"];
                
                NSDecimalNumber *cpb = [[filteredArray valueForKey:@"cpb"] objectAtIndex:i];
                if (![cpb isKindOfClass:[NSNull class]]) {
                    [tableDataDict setValue:cpb.decimalNumberInStringFormat forKey:@"cpb"];
                }
                
                NSDecimalNumber *yep = [[filteredArray valueForKey:@"yep"] objectAtIndex:i];
                if (![yep isKindOfClass:[NSNull class]]) {
                    [tableDataDict setValue:yep.decimalNumberInStringFormat forKey:@"yep"];
                }
                
                [tableDataDict setValue:[[filteredArray valueForKey:@"indicator"] objectAtIndex:i] forKey:@"indicator"];
                [tableDataArray addObject:tableDataDict];
            }
            
            [childDict setValue:tableDataArray forKey:@"tabledata"];
            childDict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] detectNumericJSONByKeyValue:childDict];
            [rootDict setValue:childDict forKey:@"rtbd"];
        } else {
            [rootDict setValue:@"no data" forKey:@"rtbd"];
        }
    } else {
        [rootDict setValue:strDisabled forKey:@"rtbd"];
    }
    
    reportName = @"Risk and Opportunity";
    if ([self isPortfolioReportEnabledForReportName:reportName]) {
        
        if ([[json valueForKey:@"ROImpactReport"] count]) {
            // Table Data
            NSMutableArray *risk = [[NSMutableArray alloc]init];
            NSMutableArray *opportunity = [[NSMutableArray alloc]init];
            NSMutableDictionary *tableDict = [[NSMutableDictionary alloc] init];
            
            // Risk Table Data
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"roType == %@", @"R"];
            NSArray *filteredArray = [[json valueForKey:@"ROImpactReport"] filteredArrayUsingPredicate:predicate];
            for (int i = 0; i < filteredArray.count; i++) {
                NSMutableDictionary *riskDataDict = [[NSMutableDictionary alloc] init];
                [riskDataDict setValue:[[filteredArray valueForKey:@"cluster"] objectAtIndex:i] forKey:@"cluster"];
                [riskDataDict setValue:[[filteredArray valueForKey:@"descriptions"] objectAtIndex:i] forKey:@"riskDescription"];
                [riskDataDict setValue:[[filteredArray valueForKey:@"activity"] objectAtIndex:i] forKey:@"activity"];
                [riskDataDict setValue:[[filteredArray valueForKey:@"negativeImpact"] objectAtIndex:i] forKey:@"negativeImpact"];
                [riskDataDict setValue:[[filteredArray valueForKey:@"probability"] objectAtIndex:i] forKey:@"probability"];
                
                NSString *mitigationPlan = [[filteredArray valueForKey:@"mitigation"] objectAtIndex:i];
                if (mitigationPlan != nil && (mitigationPlan != (id)[NSNull null] ) && mitigationPlan.length != 0 ) {
                    
                    mitigationPlan = [mitigationPlan stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
                }
                
                
                [riskDataDict setValue:mitigationPlan forKey:@"mitigationPlan"];
                //            [riskDataDict setValue:[[filteredArray valueForKey:@"mitigation"] objectAtIndex:i] forKey:@"mitigationPlan"];
                [riskDataDict setValue:[[filteredArray valueForKey:@"status"] objectAtIndex:i] forKey:@"status"];
                [riskDataDict setValue:[[filteredArray valueForKey:@"identifiedDate"] objectAtIndex:i] forKey:@"identifiedDate"];
                
                riskDataDict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateWithNSString:riskDataDict];
                [risk addObject:riskDataDict];
            }
            
            // Opportunity Table Data
            predicate = [NSPredicate predicateWithFormat:@"roType == %@", @"O"];
            filteredArray = [[json valueForKey:@"ROImpactReport"] filteredArrayUsingPredicate:predicate];
            for (int i = 0; i < filteredArray.count; i++) {
                NSMutableDictionary *opportunityDataDict = [[NSMutableDictionary alloc] init];
                [opportunityDataDict setValue:[[filteredArray valueForKey:@"cluster"] objectAtIndex:i] forKey:@"cluster"];
                [opportunityDataDict setValue:[[filteredArray valueForKey:@"descriptions"] objectAtIndex:i] forKey:@"opportunityDescription"];
                [opportunityDataDict setValue:[[filteredArray valueForKey:@"activity"] objectAtIndex:i] forKey:@"activity"];
                [opportunityDataDict setValue:[[filteredArray valueForKey:@"negativeImpact"] objectAtIndex:i] forKey:@"negativeImpact"];
                [opportunityDataDict setValue:[[filteredArray valueForKey:@"probability"] objectAtIndex:i] forKey:@"probability"];
                [opportunityDataDict setValue:[[filteredArray valueForKey:@"mitigation"] objectAtIndex:i] forKey:@"mitigationPlan"];
                [opportunityDataDict setValue:[[filteredArray valueForKey:@"status"] objectAtIndex:i] forKey:@"status"];
                [opportunityDataDict setValue:[[filteredArray valueForKey:@"identifiedDate"] objectAtIndex:i] forKey:@"identifiedDate"];
                
                opportunityDataDict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateWithNSString:opportunityDataDict];
                [opportunity addObject:opportunityDataDict];
            }
            
            [tableDict setValue:risk forKey:@"risk"];
            [tableDict setValue:opportunity forKey:@"opportunity"];
            
            // Chart Data
            NSMutableArray *riskChart = [[NSMutableArray alloc]init];
            NSMutableArray *opportunityChart = [[NSMutableArray alloc]init];
            NSMutableDictionary *chartDict = [[NSMutableDictionary alloc] init];
            
            // Risk Chart Data
            predicate = [NSPredicate predicateWithFormat:@"roType == %@", @"R"];
            filteredArray = [[json valueForKey:@"ROImpactReport"] filteredArrayUsingPredicate:predicate];
            for (int i = 0; i < filteredArray.count; i++) {
                NSMutableDictionary *riskDataDict = [[NSMutableDictionary alloc] init];
                [riskDataDict setValue:[[filteredArray valueForKey:@"cluster"] objectAtIndex:i] forKey:@"Cluster"];
                
                NSDecimalNumber *cost = [[filteredArray valueForKey:@"cost"] objectAtIndex:i];
                //            if (!valueToBeConverted) {
                if (![cost isKindOfClass:[NSNull class]]) {
                    [riskDataDict setValue:cost.decimalNumberInStringFormat forKey:@"Cost"];
                }
                //            } else {
                //                [riskDataDict setValue:@"N/A" forKey:@"Cost"];
                //            }
                
                NSDecimalNumber *production = [[filteredArray valueForKey:@"production"] objectAtIndex:i];
                //            if (!valueToBeConverted) {
                if (![production isKindOfClass:[NSNull class]]) {
                    [riskDataDict setValue:production.decimalNumberInStringFormat forKey:@"Prod"];
                }
                //            } else {
                //                [riskDataDict setValue:@"N/A" forKey:@"Prod"];
                //            }
                
                [riskChart addObject:riskDataDict];
            }
            
            // Opportunity Chart Data
            predicate = [NSPredicate predicateWithFormat:@"roType == %@", @"O"];
            filteredArray = [[json valueForKey:@"ROImpactReport"] filteredArrayUsingPredicate:predicate];
            for (int i = 0; i < filteredArray.count; i++) {
                NSMutableDictionary *opportunityDataDict = [[NSMutableDictionary alloc] init];
                [opportunityDataDict setValue:[[filteredArray valueForKey:@"cluster"] objectAtIndex:i] forKey:@"Clust"];
                
                NSDecimalNumber *cost = [[filteredArray valueForKey:@"cost"] objectAtIndex:i];
                if (![cost isKindOfClass:[NSNull class]]) {
                    [opportunityDataDict setValue:cost.decimalNumberInStringFormat forKey:@"Cst"];
                }
                
                NSDecimalNumber *production = [[filteredArray valueForKey:@"production"] objectAtIndex:i];
                if (![production isKindOfClass:[NSNull class]]) {
                    [opportunityDataDict setValue:production.decimalNumberInStringFormat forKey:@"Prd"];
                }
                
                [opportunityChart addObject:opportunityDataDict];
            }
            [chartDict setValue:riskChart forKey:@"risk"];
            [chartDict setValue:opportunityChart forKey:@"opportunity"];
            
            NSMutableDictionary *riskOpportunityDict = [[NSMutableDictionary alloc] init];
            [riskOpportunityDict setValue:tableDict forKey:@"tabledata"];
            [riskOpportunityDict setValue:chartDict forKey:@"chartdata"];
            [rootDict setValue:riskOpportunityDict forKey:@"riskOpportunity"];
        } else {
            [rootDict setValue:@"no data" forKey:@"riskOpportunity"];
        }
    } else {
        [rootDict setValue:strDisabled forKey:@"riskOpportunity"];
    }
    
    reportName = @"Schedule Progress S-Curve";
    if ([self isPortfolioReportEnabledForReportName:reportName]) {
        
        if ([[json valueForKey:@"ScheduleScurve"] count] > 0) {
            
            NSMutableArray *actualArray = [NSMutableArray array];
            NSMutableArray *originalArray = [NSMutableArray array];
            NSMutableArray *planArray = [NSMutableArray array];
            NSMutableArray *tableArray = [NSMutableArray array];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd MMM yyyy"];
            
            NSDate *dateFromString = [[NSDate alloc] init];
            for (int i = 0; i < [[json valueForKey:@"ScheduleScurve"] count]; i++) {
                dateFromString = [[json valueForKeyPath:@"ScheduleScurve.reportingDate"] objectAtIndex:i];
                [[[json valueForKey:@"ScheduleScurve"] objectAtIndex:i] setValue:dateFromString forKey:@"date"];
            }
            
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                                         ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray;
            
            sortedArray = [[json valueForKeyPath:@"ScheduleScurve"] sortedArrayUsingDescriptors:sortDescriptors];
            
            NSMutableDictionary *childDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *coreinfoDict = [NSMutableDictionary dictionary];
            
            NSString *planStr;
            NSString *actualStr;
            NSString *varianceStr;
            
            for (int i = 0; i < [sortedArray count]; i++) {
                
                NSMutableDictionary *tableDict = [NSMutableDictionary dictionary];
                
                NSDecimalNumber *actual;
                NSDecimalNumber *original;
                NSDecimalNumber *plan;
                NSDecimalNumber *variance;
                
                actual = [[sortedArray objectAtIndex:i] valueForKey:@"actualProgress"];
                original = [[sortedArray objectAtIndex:i] valueForKey:@"original"];
                plan = [[sortedArray objectAtIndex:i] valueForKey:@"planProgress"];
                variance = [[sortedArray objectAtIndex:i] valueForKey:@"variance"];
                
                // Table Data
                [tableDict setValue:[[sortedArray valueForKey:@"reportingDate"] objectAtIndex:i] forKey:@"reportingDate"];
                
                if (![actual isKindOfClass:[NSNull class]]) {
                    [tableDict setValue:[NSString stringWithFormat:@"%@%@",actual.decimalNumberInStringFormat, @"%"] forKey:@"actualProgress"];
                } else {
                    [tableDict setValue:@"0%" forKey:@"actualProgress"];
                }
                
                if (![original isKindOfClass:[NSNull class]]) {
                    [tableDict setValue:[NSString stringWithFormat:@"%@%@",original.decimalNumberInStringFormat, @"%"] forKey:@"originalBaseline"];
                } else {
                    [tableDict setValue:@"0%" forKey:@"originalBaseline"];
                }
                
                if (![plan isKindOfClass:[NSNull class]]) {
                    [tableDict setValue:[NSString stringWithFormat:@"%@%@",plan.decimalNumberInStringFormat, @"%"] forKey:@"planProgress"];
                } else {
                    [tableDict setValue:[NSString stringWithFormat:@"%@%@",plan.decimalNumberInStringFormat, @"%"] forKey:@"planProgress"];
                }
                
                if (![variance isKindOfClass:[NSNull class]]) {
                    [tableDict setValue:[NSString stringWithFormat:@"%@%@",variance.decimalNumberInStringFormat, @"%"] forKey:@"variance"];
                } else {
                    [tableDict setValue:[NSString stringWithFormat:@"%@%@",variance.decimalNumberInStringFormat, @"%"] forKey:@"variance"];
                }
                
                [tableDict setValue:[[sortedArray valueForKey:@"indicator"] objectAtIndex:i] forKey:@"indicator"];
                tableDict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateWithNSString:tableDict];
                [tableArray addObject:tableDict];
                
                NSString *value = [NSString stringWithFormat:@"%@", [[sortedArray objectAtIndex:i] valueForKey:@"date"]];
                NSString *stringFromDate;
                
                if ([value rangeOfString:@"null"].location == NSNotFound) {
                    stringFromDate = [NSString stringWithFormat:@"%@%@", [value substringWithRange:NSMakeRange(0, 10)], @"T00:00:00"];


                } else {
                    stringFromDate = [NSString stringWithFormat:@"%@",value];


                }

                [[sortedArray objectAtIndex:i] setValue:stringFromDate forKey:@"reportingDate"];
                [[sortedArray objectAtIndex:i] removeObjectForKey:@"date"];
                
                NSArray *actualDataArray = [NSArray array];
                NSArray *originalDataArray = [NSArray array];
                NSArray *planDataArray = [NSArray array];
                
                actualDataArray = [NSArray arrayWithObjects:[[sortedArray valueForKeyPath:@"reportingDate"] objectAtIndex:i], actual, nil];
                originalDataArray = [NSArray arrayWithObjects:[[sortedArray valueForKeyPath:@"reportingDate"] objectAtIndex:i], original, nil];
                planDataArray = [NSArray arrayWithObjects:[[sortedArray valueForKeyPath:@"reportingDate"] objectAtIndex:i], plan, nil];
                
                [actualArray addObject:actualDataArray];
                [originalArray addObject:originalDataArray];
                [planArray addObject:planDataArray];
                
                // Gray Bar
                if ([value rangeOfString:@"null"].location == NSNotFound) {
                 
                    NSString *stringYear = [stringFromDate substringWithRange:NSMakeRange(0,4)];
                    NSString *stringMonth = [stringFromDate substringWithRange:NSMakeRange(5,2)];
                    NSString *stringDay = [stringFromDate substringWithRange:NSMakeRange(8,2)];
                    NSString *compareMonth = [NSString stringWithFormat:@"%@%@%@", stringYear, stringMonth, stringDay];
                    
                    if ([reportingMonth isEqualToString:compareMonth]){
                        planStr = [NSString stringWithFormat:@"%@", [[sortedArray objectAtIndex:i] valueForKey:@"planProgress"]];
                        actualStr = [NSString stringWithFormat:@"%@", [[sortedArray objectAtIndex:i] valueForKey:@"actualProgress"]];
                        varianceStr = [NSString stringWithFormat:@"%@", [[sortedArray objectAtIndex:i] valueForKey:@"variance"]];
                    }
                }
            }
            
            NSMutableDictionary *actualDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *originalDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *planDict = [NSMutableDictionary dictionary];
            
            [actualDict setValue:actualArray forKey:@"data"];
            [actualDict setValue:@"Actual Progress" forKey:@"name"];
            [originalDict setValue:originalArray forKey:@"data"];
            [originalDict setValue:@"Original Baseline" forKey:@"name"];
            [planDict setValue:planArray forKey:@"data"];
            [planDict setValue:@"Plan" forKey:@"name"];
            
            actualDict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateWithNSString:actualDict];
            originalDict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateWithNSString:originalDict];
            planDict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateWithNSString:planDict];

            NSArray *chartArray = [NSArray arrayWithObjects:actualDict, originalDict, planDict, nil];
            
            [childDict setValue:chartArray forKey:@"chartdata"];
            [coreinfoDict setValue:planStr forKey:@"plan"];
            [coreinfoDict setValue:actualStr forKey:@"actual"];
            [coreinfoDict setValue:varianceStr forKey:@"variance"];
            [childDict setValue:coreinfoDict forKey:@"coreinfo"];
            [childDict setValue:tableArray forKey:@"tabledata"];
            [rootDict setValue:childDict forKey:@"schedule"];
        } else {
            [rootDict setValue:@"no data" forKey:@"schedule"];
        }
    } else {
        [rootDict setValue:strDisabled forKey:@"schedule"];
    }
    
    // Top Screen
    if ([[json valueForKey:@"AboutProject"] count]){
        NSMutableDictionary *aboutProject = [[NSMutableDictionary alloc] initWithDictionary:[json valueForKey:@"AboutProject"] copyItems:YES];
        if (aboutProject) {
            NSMutableDictionary *childDict = [[NSMutableDictionary alloc] init];
            [childDict setValue:[aboutProject valueForKey:@"projectName"]  forKey:@"reportName"];
            [childDict setValue:reportingMonth forKey:@"reportingMonth"];
            [childDict setValue:[aboutProject valueForKey:@"currencyName"] forKey:@"currency"];
            [childDict setValue:[aboutProject valueForKey:@"projectStatusName"] forKey:@"status"];
            [childDict setValue:[aboutProject valueForKey:@"startDate"] forKey:@"startDate"];
            [childDict setValue:[aboutProject valueForKey:@"endDate"] forKey:@"endDate"];
            
            NSDate *update = [[ETGCoreDataUtilities sharedCoreDataUtilities] retrieveTimeStampForModule:@"Project" withReportingMonth:reportingMonth];
            NSString *updateStr = @"";
            
            if (update) {
                updateStr = [update toChartDateString];
            } else {
                updateStr = [[NSDate date] toChartDateString];
            }
            
            [childDict setValue:updateStr forKey:@"update"];
            
            // Get phase
            NSString* query = [NSString stringWithFormat:@"(SUBQUERY(project, $project, ANY $project.key == %@).@count !=0)", projectKey];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
            ETGPhase *phase = [ETGPhase findFirstWithPredicate:predicate];
            [childDict setValue:phase.name forKey:@"phase"];
            
            childDict = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] replaceNSDateWithNSString:childDict];
            [rootDict setValue:childDict forKey:@"projectDetails"];
        }
    } else {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(key == %@)", projectKey];
        ETGProject *project = [ETGProject findFirstWithPredicate:predicate inContext:[NSManagedObjectContext defaultContext]];
        
        NSString *reportName = [project valueForKeyPath:@"name"];
        NSString *currency = [project valueForKeyPath:@"projectBackground.currencyName"];
        NSString *phase = [project valueForKeyPath:@"phase.name"];
        NSString *status = [project valueForKeyPath:@"projectBackground.projectStatusName"];
        NSDate *update = [[ETGCoreDataUtilities sharedCoreDataUtilities] retrieveTimeStampForModule:@"Project" withReportingMonth:reportingMonth];
        NSString *updateStr = @"";
        
        if (update) {
            updateStr = [update toChartDateString];
        } else {
            updateStr = [[NSDate date] toChartDateString];
        }
        
        if (!currency) {
            currency = @"No Data";
        }
        
        if (!status) {
            status = @"No Data";
        }

        if (!phase) {
            phase = @"No Data";
        }

        NSMutableDictionary *childDict = [NSMutableDictionary dictionary];
        
        [childDict setValue:reportName forKey:@"reportName"];
        [childDict setValue:reportingMonth forKey:@"reportingMonth"];
        [childDict setValue:currency forKey:@"currency"];
        [childDict setValue:status forKey:@"status"];
        [childDict setValue:updateStr forKey:@"update"];
        [childDict setValue:phase forKey:@"phase"];
        [rootDict setValue:childDict forKey:@"projectDetails"];
    }
    
    return rootDict;
    
}

/**Format Chart Contents to Determine if data is Actual Progress, Plan or Original Baseline**/
-(NSArray *)formatChartContents:(NSArray *)chartContents {
    NSMutableArray *outlookBehind = [NSMutableArray array]; // Outlook Behind Schedule
    NSMutableArray *outlookOn = [NSMutableArray array];      // Outlook On Schedule
    NSMutableArray *baseline = [NSMutableArray array];       // Baseline
    
    for (NSArray *rec in chartContents) {
        //Define the date and mutable dictionary
        NSDate *plannedDt;
        NSDate *actualDt;
        NSMutableDictionary *planData;
        NSMutableDictionary *actualData;
        
        if ([rec valueForKey:@"plannedDt"]!= [NSNull null]) {
            //Define the planned date in Date format
            plannedDt = [rec valueForKey:@"plannedDt"];
            //Prepopulate the plannedDt into dictionary
            planData = [NSMutableDictionary dictionary];
            NSString *plannedDtStr = [NSString stringWithFormat:@"%@", plannedDt];
            NSString *value = [plannedDtStr substringWithRange:NSMakeRange(0, 10)];
            plannedDtStr = [NSString stringWithFormat:@"%@%@", value, @"T00:00:00"];
            [planData setValue:[rec valueForKey:@"mileStone"] forKey:@"name"];
            [planData setValue:plannedDtStr forKey:@"x"];
            [planData setValue:[rec valueForKey:@"baseLineNum"] forKey:@"y"];
        }
        if ([rec valueForKey:@"actualDt"]!= [NSNull null]) {
            //Define the actual date in Date format
            actualDt = [rec valueForKey:@"actualDt"];
            //Prepopulate the actualDt into dictionary
            actualData = [NSMutableDictionary dictionary];
            NSString *actualDtStr = [NSString stringWithFormat:@"%@", actualDt];
            NSString *value = [actualDtStr substringWithRange:NSMakeRange(0, 10)];
            actualDtStr = [NSString stringWithFormat:@"%@%@", value, @"T00:00:00"];
            [actualData setValue:[rec valueForKey:@"mileStone"] forKey:@"name"];
            [actualData setValue:actualDtStr forKey:@"x"];
            [actualData setValue:[rec valueForKey:@"baseLineNum"] forKey:@"y"];
        }
        
        //If plannedDt not null
        if ([rec valueForKey:@"plannedDt"]!= [NSNull null]) {
            //Can store the plannedDt in planned array to show for Original Baseline
            [baseline addObject:planData];
            
            //If actualDt is not null
            if ([rec valueForKey:@"actualDt"]!= [NSNull null]) {
                //Depending on whether actual date before or after planned Date
                if ([actualDt compare:plannedDt] == NSOrderedDescending) {
                    //IF actualDt > plannedDt, put the actualDt in actualProgress array
                    [outlookBehind addObject:actualData];
                } else {
                    //If actualDt <= plannedDt, put the it in original array
                    [outlookOn addObject:actualData];
                }
            }
            //If actualDt is null
            else {
                //Dont do anything
            }
            
        }
        //If plannedDt is null
        else {
            //If actualDt is not null
            if ([rec valueForKey:@"actualDt"]!= [NSNull null]) {
                //Put the actualDt in actual array
                [outlookBehind addObject:actualData];
            }
            //If actualDt is null
            else {
                //Dont do anything
            }
        }
    }
    
    chartContents = @[@{@"name": @"Actual Progress", @"data": outlookBehind}, @{@"name": @"Original Baseline", @"data": baseline}, @{@"name": @"Plan", @"data": outlookOn}];
    
    return chartContents;
}

- (RKManagedObjectRequestOperation*)sendRequestWithReportingMonth:(NSString *)reportingMonth
                                                       projectKey:(NSNumber *)projectKey
                                            withKeyMilestonesData:(NSArray*)keyMilestones
                                               withProjectReports:(NSDictionary*)enabledReports
                                                          success:(void (^)(NSString *projectData))success
                                                          failure:(void (^)(NSError *error))failure {
    @try {
        
        _keyMilestones = keyMilestones;
        [self populateEnableReportsArray:enabledReports];
        
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        
        if (_appDelegate.isNetworkServerAvailable == YES) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:reportingMonth forKey:@"inpReportingMonth"];
            [params setObject:[projectKey stringValue] forKey:@"inpProjectKey"];
            NSString *repMonth = reportingMonth;
            
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];
            
            NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kProjectService, ETG_PROJECT_PATH];
            NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
            [request setHTTPBody:jsonData];
            
            // changed to 3mins
            [request setTimeoutInterval:120];
            
            RKManagedObjectRequestOperation *projectSummaryOperation = [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:[[ETGWebService sharedWebService] managedObjectContext] success:^(RKObjectRequestOperation *projectSummaryOperation, RKMappingResult *mappingResult) {
                
                // Save to persistent store
                NSError* error = nil;
                [[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
                
                [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStamp:repMonth moduleName:@"Project"];

                if(_isFirstProject == YES){
                    // Create Core Data to JSON mapping
                    NSMutableArray *jsonDict = [NSMutableArray array];
                    for (ETGProjectSummary* card in [mappingResult set]) {
                        NSDictionary* json = [self serializeObject:card reportingMonth:repMonth projectKey:[params valueForKey:@"inpProjectKey"]];
                        if (!json) {
                            //An error occurred
                            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                            [errorDetail setValue:coreDataToJSONError forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:@"ETG" code:100 userInfo:errorDetail];
                            DDLogError(@"%@%@", logErrorPrefix,error.description);
                        } else {
                            [jsonDict addObject:json];
                            
                        }
                    }
                    
                    if (error) {
                        failure(error);
                        DDLogError(@"%@%@", logErrorPrefix,error.description);
                    } else {
                        if ([jsonDict count]) {
                            
                            NSError *parsingError;
                            NSData *data = [RKMIMETypeSerialization dataFromObject:[jsonDict objectAtIndex:0] MIMEType:RKMIMETypeJSON error:&parsingError];
                            
                            if (parsingError) {
                                failure(parsingError);
                                DDLogError(@"%@%@", logErrorPrefix,parsingError.description);
                            } else {
                                NSString *jsonString = [[NSString alloc] initWithData:data
                                                                             encoding:NSUTF8StringEncoding];
                                success(jsonString);
                            }
                        } else {
                            
                            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                            [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
                            NSError *noDataerror = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
                            failure(noDataerror);
                            DDLogError(@"%@%@", logErrorPrefix,noDataerror.description);
                        }
                    }
                } else {
                    NSString *inputData = nil;
                    success(inputData);
                }
            } failure:^(RKObjectRequestOperation *projectSummaryOperation, NSError *error) {
                
                NSHTTPURLResponse *response = [[projectSummaryOperation HTTPRequestOperation] response];
                NSDictionary *responseHeadersDict = [response allHeaderFields];
                //        NSString *strXErrorMsg = [responseHeadersDict valueForKey:@"X-Message"];
                DDLogWarn(@"%@%@ - %@",logWarnPrefix,projectModulePrefix, webServiceFetchError);
                //        DDLogError(@"%@", strXErrorMsg);
                DDLogError(@"%@%@", logErrorPrefix,responseHeadersDict);
                
                [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];
                
                [self fetchOfflineDataWithReportingMonth:reportingMonth projectKey:projectKey withKeyMilestonesData:keyMilestones withProjectReports:enabledReports success:^(NSString *projectData) {
                    success (projectData);
                    
                } failure:^(NSError *error) {
                    failure(error);
                }];
            }];
            //Set mapping metada
            NSDictionary* metadata = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [reportingMonth toDate], @"reportingMonth",
                                      projectKey, @"projectKey", nil];
            [projectSummaryOperation setMappingMetadata:metadata];
            return projectSummaryOperation;
        }
        else {
            DDLogWarn(@"%@%@ - %@",logWarnPrefix,projectModulePrefix, webServiceFetchError);
            
            // Offline mode
            [self fetchOfflineDataWithReportingMonth:reportingMonth projectKey:projectKey withKeyMilestonesData:keyMilestones withProjectReports:enabledReports success:^(NSString *projectData) {
                success (projectData);
                
            } failure:^(NSError *error) {
//                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
//                [errorDetail setValue:serverCannotBeReachedAlert forKey:NSLocalizedDescriptionKey];
//                NSError *serverCannotBeReachedError = [NSError errorWithDomain:@"ETG" code:105 userInfo:errorDetail];
                failure(error);
            }];
        }
    }
    @catch (NSException *ex) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",ex]
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return nil;
    }
}

- (void)fetchOfflineDataWithReportingMonth:(NSString *)reportingMonth
                                projectKey:(NSNumber *)projectKey
                     withKeyMilestonesData:(NSArray*)keyMilestones
                        withProjectReports:(NSDictionary*)enabledReports
                                   success:(void (^)(NSString *projectData))success
                                   failure:(void (^)(NSError *error))failure {
    
    _keyMilestones = keyMilestones;
    [self populateEnableReportsArray:enabledReports];
    NSError *error;

    // Fetch or insert ETGReportingMonth from paramater
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    //TODO: Verify date conversion
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(project, $project, ANY $project.key == %@).@count != 0) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)", projectKey, [reportingMonth toDate]];
    NSArray *foundProject = [ETGProjectSummary findAllWithPredicate:predicate inContext:context];
    
    NSMutableArray *jsonDict = [NSMutableArray array];
    
    if ([foundProject count]) {
        // Create Core Data to JSON mapping
        for (ETGProjectSummary* card in foundProject) {
            NSDictionary* json = [self serializeObject:card reportingMonth:reportingMonth projectKey:projectKey];
            if (!json) {
                //An error occurred
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:coreDataToJSONError forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:@"ETG" code:100 userInfo:errorDetail];
                DDLogError(@"%@%@", logErrorPrefix, error.description);
            } else {
                [jsonDict addObject:json];
                
            }
        }
        
        if (error) {
            failure(error);
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        } else {
            if ([jsonDict count]) {
                
                NSError *parsingError;
                NSData *data = [RKMIMETypeSerialization dataFromObject:[jsonDict objectAtIndex:0] MIMEType:RKMIMETypeJSON error:&parsingError];
                
                if (parsingError) {
                    DDLogError(@"%@%@", logErrorPrefix, parsingError.description);
                    failure(parsingError);
                } else {
                    NSString *jsonString = [[NSString alloc] initWithData:data
                                                                 encoding:NSUTF8StringEncoding];
                    success(jsonString);
                }
            } else {
                
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
                NSError *noDataError = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
                DDLogError(@"%@%@", logErrorPrefix, noDataError.description);
                failure(noDataError);
            }
        }
    } else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:serverCannotBeReachedAlert forKey:NSLocalizedDescriptionKey];
        NSError *serverCannotBeReachedError = [NSError errorWithDomain:@"ETG" code:105 userInfo:errorDetail];
        failure(serverCannotBeReachedError);
    }
}

- (BOOL)uacCanSeeReport:(NSString *)reportingMonth{
    _haveUAC = YES;
    return _haveUAC;
}

- (BOOL)entityIsEmpty{
    _isEmpty = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasEntriesForEntityName:@"ETGProject"];
    return _isEmpty;
}

- (void)setBaseFilters{
    // Put code to set base filters here...
    //DDLogInfo(@"%@%@", logInfoPrefix, @"Set Base filter");
}

- (NSArray *)aggregateDataForChartFrom:(NSArray *)dataArray reportingMonth:(NSString*)reportingMonth {
    
//    NSArray *dataArray = [[NSArray alloc] initWithArray:cachedData.allObjects];
    NSSortDescriptor *monthSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"calendarMonthOfYear"
                                                                          ascending:YES
                                             ];
    NSSortDescriptor *yearSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"calendarYear"
                                                                         ascending:YES
                                            ];
    //    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"calendarYear" ascending:YES];
    dataArray= [dataArray sortedArrayUsingDescriptors:@[yearSortDescriptor,monthSortDescriptor]];
    
    NSArray *uniqueMonths = [[NSArray alloc] initWithArray:[dataArray valueForKeyPath:@"@distinctUnionOfObjects.calendarYearEnglishMonth"]];
    NSMutableArray *aggregatedTotal = [[NSMutableArray alloc] init];
    
    //NSLog(@"Unique month count: %d and month %@",[uniqueMonths count],uniqueMonths );
    
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"ddMMMyyyy"];
    
    for (int i = 0; i < [uniqueMonths count]; i++) {
        
        NSMutableArray *results = [NSMutableArray array];
        NSMutableDictionary *aggregatedDict = [[NSMutableDictionary alloc] init];
        
        for (int j = 0; j < dataArray.count; j++) {
            //NSDate *dateUniqueMonth = [dateFormatter dateFromString:[uniqueMonths objectAtIndex:i]];
            //NSDate *dateReportingDate = [dateFormatter dateFromString:[[dataArray objectAtIndex:j] valueForKey:@"reportingDate"]];
            NSString *stringUniqueMonth = [uniqueMonths objectAtIndex:i];
            NSString *stringReportingDate = [[dataArray objectAtIndex:j] valueForKey:@"calendarYearEnglishMonth"];
            
            if ([stringUniqueMonth isEqualToString:stringReportingDate]) {
                [results addObject:[dataArray objectAtIndex:j]];
            }
        }
        
        if ([results count]) {
            
            NSPredicate *vacantPredicate = [NSPredicate predicateWithFormat:@"projectStaffingStatusName == 'Vacant'"];
            NSPredicate *filledPredicate = [NSPredicate predicateWithFormat:@"projectStaffingStatusName == 'Filled'"];
            NSPredicate *nullPredicate = [NSPredicate predicateWithFormat:@"fTELoading == %@",nil];
            
            // Filled
            NSArray *filledArray = [results filteredArrayUsingPredicate:filledPredicate];
            NSArray *nullFilledArray = [filledArray filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalFilledFTELoading;
            
            
            if ([results count] == [nullFilledArray count]) {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalFilledFTELoading"];
            }else {
                totalFilledFTELoading = [NSNumber numberWithFloat:[[filledArray valueForKeyPath:@"@sum.fTELoading"] floatValue]];
                [aggregatedDict setValue:totalFilledFTELoading forKey:@"totalFilledFTELoading"];
            }
            
            // Vacant
            NSArray *vacantArray = [results filteredArrayUsingPredicate:vacantPredicate];
            NSArray *nullVacantArray = [vacantArray filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalVacantFTELoading;
            
            if ([results count] == [nullVacantArray count]) {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalVacantFTELoading"];
            }else {
                totalVacantFTELoading = [NSNumber numberWithFloat:[[vacantArray valueForKeyPath:@"@sum.fTELoading"] floatValue]];
                [aggregatedDict setValue:totalVacantFTELoading forKey:@"totalVacantFTELoading"];
            }
            
//            [aggregatedDict setValue:[[NSString stringWithFormat:@"%@",[uniqueMonths objectAtIndex:i]] toDate] forKey:@"month"];
            [aggregatedTotal addObject:aggregatedDict];
        } else {
            NSNumber *totalFilledFTELoading = NULL;
            NSNumber *totalVacantFTELoading = NULL;
            
            [aggregatedDict setValue:totalFilledFTELoading forKey:@"totalFilledFTELoading"];
            [aggregatedDict setValue:totalVacantFTELoading forKey:@"totalVacantFTELoading"];
//            [aggregatedDict setValue:[[NSString stringWithFormat:@"%@",[uniqueMonths objectAtIndex:i]] toDate] forKey:@"month"];
            [aggregatedTotal addObject:aggregatedDict];
        }
    }
    
    //    aggregatedTotal = [aggregatedTotal toConsecutiveMonthsForMLH:reportingMonth];
    
    NSMutableDictionary *processedtotalFilledFTELoading = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                                          @"name":@"Filled",
                                                                                                          @"data":[aggregatedTotal valueForKey:@"totalFilledFTELoading"]}];
    NSMutableDictionary *processedtotalVacantFTELoading = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                                          @"name":@"Vacant",
                                                                                                          @"data":[aggregatedTotal valueForKey:@"totalVacantFTELoading"]}];
    
    NSMutableDictionary *chartDictData = [NSMutableDictionary dictionaryWithDictionary:@{@"categories": uniqueMonths,
                                                                                         @"yLabel" : @"Headcount",
                                                                                         @"series" :@[processedtotalFilledFTELoading,processedtotalVacantFTELoading]}];
    
    NSArray *processedJSON = [NSArray arrayWithObjects:chartDictData, nil];
    
    return [self sortChartByDateOfJSON:processedJSON];
    
//    return processedJSON;
}

-(NSMutableArray*)sortChartByDateOfJSON:(NSArray*)json
{
    //NSLog(@"json %@",json);
    NSMutableArray *unsortedCategories = [[json objectAtIndex:0] objectForKey:@"categories"];
    NSMutableArray *unsortedSeries = [[json objectAtIndex:0] objectForKey:@"series"];
    
    NSMutableArray *unsortedVacant = [[unsortedSeries objectAtIndex:0] objectForKey:@"data"];
    NSMutableArray *unsortedFilled = [[unsortedSeries objectAtIndex:1] objectForKey:@"data"];
    
    NSMutableArray *sortedCategories = [NSMutableArray array];
    NSMutableArray *sortedVacant = [NSMutableArray array];
    NSMutableArray *sortedFilled = [NSMutableArray array];
    
    
    for (int i =0; i< [unsortedCategories count] ; i++)
    {
        NSString *dateString = [unsortedCategories objectAtIndex:i];
        NSString *vacant = [unsortedVacant objectAtIndex:i];
        NSString *filled = [unsortedFilled objectAtIndex:i];
        
//        if (![self isSameYearWithDate1:[dateString toDate] date2:[reportingMonth toDate]])
//        {
//            continue;
//        }
        
        if ([sortedCategories count]==0)
        {
            [sortedCategories addObject:dateString];
            [sortedVacant addObject:vacant];
            [sortedFilled addObject:filled];
            
        }
        else {
            //check date one by one
            BOOL isNewer =NO;
            BOOL isOlder = NO;
            
            for (int j =0; j< [sortedCategories count]; j++)
            {
                NSString *dateString2 = [sortedCategories objectAtIndex:j];
                
                //check if newwest than before
                //if newest, then keep loading.
                if ([[dateString toDate] compare:[dateString2 toDate]] == NSOrderedDescending)
                {
                    isNewer=YES;
                    
                    //last array
                    if (j == [sortedCategories count]-1)
                    {
                        [sortedCategories addObject:dateString];
                        [sortedFilled addObject:filled];
                        [sortedVacant addObject:vacant];
                        
                        break;
                    }
                }
                //check if oldest than before.
                else{
                    isOlder = YES;
                    
                    if (isNewer)
                    {
                        [sortedCategories insertObject:dateString atIndex:j];
                        [sortedFilled insertObject:filled atIndex:j];
                        [sortedVacant insertObject:vacant atIndex:j];
                        
                        break;
                    }
                    //add at last array
                    else{
                        [sortedCategories insertObject:dateString atIndex:0];
                        [sortedFilled insertObject:filled atIndex:0];
                        [sortedVacant insertObject:vacant atIndex:0];
                        
                        break;
                    }
                    
                }
            }
        }
    }
    
    NSMutableArray *series = [NSMutableArray arrayWithObjects:
                              @{@"name" : [[unsortedSeries objectAtIndex:1] objectForKey:@"name"], @"data" : sortedFilled},
  @{@"name" : [[unsortedSeries objectAtIndex:0] objectForKey:@"name"], @"data" : sortedVacant},  nil];
    NSMutableArray *parent = [NSMutableArray arrayWithObjects:
                              @{@"categories": sortedCategories, @"series": series},
                              @{@"yLabel" : [[json objectAtIndex:0] objectForKey:@"yLabel"]}, nil];
    
    
    return parent;
}

- (void)collectReportJSON:(NSString *)reportingMonth
               projectKey:(NSNumber *)projectKey
                 PDFField:(NSString*)PDFField
                  success:(void (^)(NSString *projectData))success
                  failure:(void (^)(NSError *error))failure {
    NSError *error;
    
    // Fetch or insert ETGReportingMonth from paramater
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    //TODO: Verify date conversion
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(project, $project, ANY $project.key == %@).@count != 0) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)", projectKey, [reportingMonth toDate]];
    NSArray *foundProject = [ETGProjectSummary findAllWithPredicate:predicate inContext:context];
    
    NSMutableArray *jsonDict = [NSMutableArray array];
    if ([foundProject count]) {
        // Create Core Data to JSON mapping
        for (ETGProjectSummary* card in foundProject) {
            NSDictionary* json = [self serializeObject:card reportingMonth:reportingMonth projectKey:projectKey];
            if (!json) {
                //An error occurred
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:coreDataToJSONError forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:@"ETG" code:100 userInfo:errorDetail];
                DDLogError(@"%@%@", logErrorPrefix, error.description);
            } else {
                [jsonDict addObject:json];
                
            }
        }
        
        if (error) {
            failure(error);
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        } else {
            if ([jsonDict count]) {
                
                NSError *parsingError;
                NSData *data = [RKMIMETypeSerialization dataFromObject:[jsonDict objectAtIndex:0] MIMEType:RKMIMETypeJSON error:&parsingError];
                
                if (parsingError) {
                    DDLogError(@"%@%@", logErrorPrefix, parsingError.description);
                    failure(parsingError);
                } else {
                    NSString *jsonString = [[NSString alloc] initWithData:data
                                                                 encoding:NSUTF8StringEncoding];
                    //                    NSString *jsonString = [jsonString2 stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                    success(jsonString);
                }
            } else {
                
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
                NSError *noDataError = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
                DDLogError(@"%@%@", logErrorPrefix, noDataError.description);
                failure(noDataError);
            }
        }
        
    }
}

-(void)setFirstProjectBoolValue:(BOOL)boolValue{
    _isFirstProject = boolValue;
}

//UAC
- (void)populateEnableReportsArray:(NSDictionary *)enablePortfolioReports {
    _enableReports = [NSMutableArray array];
    
    for(NSDictionary *rec in enablePortfolioReports) {
        [_enableReports addObject:rec];
    }
}

- (BOOL)isPortfolioReportEnabledForReportName:(NSString *)reportName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", reportName];
    NSArray *foundReport = [_enableReports filteredArrayUsingPredicate:predicate];
    
    if ([foundReport count]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isPortfolioTableReportEnabledForReportName:(NSString *)reportName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", reportName];
    NSArray *foundReport = [_enableReports filteredArrayUsingPredicate:predicate];
    
    if ([foundReport count]) {
        if ([[foundReport valueForKeyPath:@"popup.status"] objectAtIndex:0] != [NSNull null]){
            NSArray *arrayResult = [NSArray arrayWithArray:[[foundReport valueForKeyPath:@"popup.status"] objectAtIndex:0]];
            
            NSString *strResult = [NSString stringWithFormat:@"%@", [arrayResult objectAtIndex:0] ];
            if ([strResult isEqualToString:@"I"]) {
                return NO;
            } else {
                return YES;
            }
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

@end
