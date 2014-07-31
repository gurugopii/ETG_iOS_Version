//
//  ETGScoreCardTableSummary.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGWebServiceCommonImports.h"
#import "ETGScoreCardTableSummary.h"
#import "ETGNetworkConnection.h"
// Models
#import "ETGScorecard.h"
//#import "ETGScorecardSummary.h"
#import "ETGRegion.h"
#import "ETGKeyMilestoneProjectPhase.h"
#import "ETGFacility.h"
#import "ETGWellDetails.h"
#import "ETGFdp.h"
#import "ETGWPBCostPMU.h"
// Relationships
#import "ETGReportingMonth.h"
//#import "ETGPortfolioForScorecard.h"
#import "ETGApc.h"
#import "ETGCpb.h"
#import "ETGCostAllocation.h"
//#import "ETGProjectSummary.h"
#import "ETGFirstHydrocarbon.h"
#import "ETGScheduleProgress.h"
#import "ETGHseTable_Project.h"
#import "ETGAfeTable.h"
#import "ETGBaselineType.h"
#import "ETGRevision.h"
#import "ETGKeyMilestone.h"
#import "ETGFirstHydrocarbon.h"
//#import "ETGPlatform.h"
#import "ETGManpowerTable_Project.h"

@interface ETGScoreCardTableSummary ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

//Properties required for pagination
@property (nonatomic,strong) RKPaginator *paginator;
@property (nonatomic,strong) NSMutableArray *objects;
@property (nonatomic,assign) BOOL isPaginatorLoading;

@property (nonatomic,strong) NSMutableDictionary *filteredProjectsDictionary;
@property (nonatomic,strong) NSString *scorecardJSON;

@end

@implementation ETGScoreCardTableSummary

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupMappings {
    
    //**********************************************
    // Attribute Mappings
    //**********************************************
    // Scorecard
    //***********************
    
#pragma mark - Scorecard Attributes
    // Attribute Mappings for ETGScorecard
    RKEntityMapping *scorecardMapping = [[RKEntityMapping alloc] initWithEntity:[ETGScorecard entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [scorecardMapping addAttributeMappingsFromDictionary:@{
                                                           @"pcsb.overallIndicator"         : @"costPcsb",
                                                           @"pmu.overallIndicator"          : @"costPmu",
                                                           @"hse.overallIndicator"          : @"hse",
                                                           @"manningHeadCount.overallIndicator"    : @"manningHeadCount",
                                                           @"production.overallIndicator"   : @"production",
                                                           @"schedule.overallIndicator"     : @"schedule",
                                                           @"projectKey"                    : @"projectKey",
                                                           @"@metadata.reportingMonth"      : @"reportMonth"
                                                           }];
    scorecardMapping.identificationAttributes = @[@"projectKey", @"reportMonth"];
    
    // Attribute Mappings for ETGProject
    RKEntityMapping *projectMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectMapping addAttributeMappingsFromDictionary:@{
                                                         @"projectKey"  : @"key",
                                                         @"projectName" : @"name"
                                                         }];
    projectMapping.identificationAttributes = @[@"name"];
    
    // Attribute Mappings for ETGRegion
    RKEntityMapping *regionMapping = [[RKEntityMapping alloc] initWithEntity:[ETGRegion entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [regionMapping addAttributeMappingsFromDictionary:@{
                                                        @"region"  : @"name"
                                                        }];
    regionMapping.identificationAttributes = @[@"name"];
    
    // Attribute Mappings for ETGReportingMonth
    RKEntityMapping *reportingMonthMapping = [[RKEntityMapping alloc] initWithEntity:[ETGReportingMonth entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [reportingMonthMapping addAttributeMappingsFromDictionary:@{
                                                                @"@metadata.reportingMonth"   : @"name"
                                                                }];
    reportingMonthMapping.identificationAttributes = @[@"name"];
    
#pragma mark - Portfolio Attributes
    // Attribute Mappings for ETGPortfolio
//    RKEntityMapping *portfolioMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPortfolioForScorecard entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
//    [portfolioMapping addAttributeMappingsFromDictionary:@{
//                                                           @"projectKey"                 : @"projectKey",
//                                                           @"@metadata.reportingMonth"   : @"reportMonth"
//                                                           }];
//    portfolioMapping.identificationAttributes = @[@"projectKey", @"reportMonth"];
    
#pragma mark - Project Attributes
    // Attribute Mappings for ETGProjectSummary
//    RKEntityMapping *projectSummaryMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProjectSummary entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
//    [projectSummaryMapping addAttributeMappingsFromDictionary:@{
//                                                                @"projectKey"                 : @"projectKey",
//                                                                @"@metadata.reportingMonth"   : @"reportMonth"
//                                                                }];
//    projectSummaryMapping.identificationAttributes = @[@"projectKey", @"reportMonth"];
    
#pragma mark - Cost PCSB Attributes
    // Attribute Mappings for ETGApc
    RKEntityMapping *apcMapping = [[RKEntityMapping alloc] initWithEntity:[ETGApc entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [apcMapping addAttributeMappingsFromDictionary:@{
                                                     @"afcAmt"          : @"afc",
                                                     @"gInd"            : @"indicator",
                                                     @"apcAmt"          : @"apc",
                                                     @"variance"        : @"variance",
                                                     @"cumVOWDAmt"      : @"itd",
                                                     }];
    
    // Attribute Mappings for ETGAfeTable
    RKEntityMapping *afeMapping = [[RKEntityMapping alloc] initWithEntity:[ETGAfeTable entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [afeMapping addAttributeMappingsFromDictionary:@{
                                                     @"afeId"         : @"afeDescription",
                                                     @"afcAmt"        : @"afc",
                                                     @"gInd"          : @"indicator",
                                                     @"cumVowdAmt"    : @"itd",
                                                     @"variance"      : @"variance",
                                                     @"latestAfeAmt"  : @"latestApprovedAfe",
                                                     }];
    
    // Attribute Mappings for ETGCpb
    RKEntityMapping *cpbMapping = [[RKEntityMapping alloc] initWithEntity:[ETGCpb entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [cpbMapping addAttributeMappingsFromDictionary:@{
                                                     @"indicator"      : @"indicator",
                                                     @"originalCPB"    : @"originalCpb",
                                                     @"latestCPB"      : @"latestCpb",
                                                     @"variance"       : @"variance",
                                                     @"fyyep"          : @"fyYep",
                                                     @"fyytd"          : @"fyYtd",
                                                     @"reportingdate"  : @"reportingDate",
                                                     }];
    
    // Attribute Mappings for ETGCostAllocation
    RKEntityMapping *costAllocationMapping = [[RKEntityMapping alloc] initWithEntity:[ETGCostAllocation entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [costAllocationMapping addAttributeMappingsFromDictionary:@{
                                                                @"costAllocationKey"    : @"key",
                                                                @"costAllocation"       : @"name"
                                                                }];
    costAllocationMapping.identificationAttributes = @[@"name"];
    
#pragma mark - Cost PMU Attributes
    // Attribute Mappings for ETGFdp
    RKEntityMapping *fdpMapping = [[RKEntityMapping alloc] initWithEntity:[ETGFdp entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [fdpMapping addAttributeMappingsFromDictionary:@{
                                                     @"afcAmt"       : @"afc",
                                                     @"fiaAmt"       : @"fia",
                                                     @"gInd"         : @"indicator",
                                                     @"fdpAmt"       : @"tpFipFdp",
                                                     @"variance"     : @"variance",
                                                     @"cumVOWDAmt"   : @"vowd"
                                                     }];
    
    // Attribute Mappings for ETGWPBCostPMU
    RKEntityMapping *wpbMapping = [[RKEntityMapping alloc] initWithEntity:[ETGWPBCostPMU entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [wpbMapping addAttributeMappingsFromDictionary:@{
                                                     @"approvedABR"     : @"abrApproved",
                                                     //@"indicator"       : @"indicator",
                                                     @"gInd"       : @"indicator",
                                                     @"latestWPB"       : @"latestWpb",
                                                     @"originalWPB"     : @"originalWpb",
                                                     @"budgetItemName"  : @"section",
                                                     @"budgetItemKey"   : @"sectionKey",
                                                     @"variance"        : @"variance",
                                                     @"currentMonthYEP" : @"yepG",
                                                     @"approvedCO"      : @"yercoApproved",
                                                     }];
    
#pragma mark - HSE Attributes
    // Attribute Mappings for ETGHseTable_Project
    RKEntityMapping *hseMapping = [[RKEntityMapping alloc] initWithEntity:[ETGHseTable_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [hseMapping addAttributeMappingsFromDictionary:@{
                                                     @"hseID"       : @"hseId",
                                                     @"indicator"   : @"indicator",
                                                     @"ytdCases"    : @"ytdCase"
                                                     }];
    
#pragma mark - Manpower Attributes
    // Attribute Mappings for ETGHseTable_Project
    RKEntityMapping *manpowerMapping = [[RKEntityMapping alloc] initWithEntity:[ETGManpowerTable_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [manpowerMapping addAttributeMappingsFromDictionary:@{
                                                     @"indicatorTotalCriticalBar"       : @"indicatorTotalCriticalBar",
                                                     @"indicatorTotalRequirementBar"   : @"indicatorTotalRequirementBar",
                                                     @"totalCritical"    : @"totalCritical",
                                                     @"totalRequirement" : @"totalRequirement"
                                                     }];

    
#pragma mark - Production Attributes
    // Attribute Mappings for ETGProduction
    RKEntityMapping *productionMapping = [[RKEntityMapping alloc] initWithEntity:[ETGFacility entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [productionMapping addAttributeMappingsFromDictionary:@{
                                                            @"facilityName"                 : @"name",
                                                            @"@root.projectKey"             : @"projectKey",
                                                            @"@metadata.reportingMonth"     : @"reportMonth"
                                                            }];
    productionMapping.identificationAttributes = @[@"name", @"projectKey", @"reportMonth"];

    // Attribute Mappings for ETGWellDetails
    RKEntityMapping *wellDetailsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGWellDetails entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [wellDetailsMapping addAttributeMappingsFromDictionary:@{
                                                             @"condyIndicator"  : @"condyIndicator",
                                                             @"condyOutlook"    : @"condyOutlook",
                                                             @"condyPlanned"    : @"condyPlanned",
                                                             @"dataTimeKey"     : @"dataTimeKey",
                                                             @"gasIndicator"    : @"gasIndicator",
                                                             @"gasOutlook"      : @"gasOutlook",
                                                             @"gasPlanned"      : @"gasPlanned",
                                                             @"oilIndicator"    : @"oilIndicator",
                                                             @"oilOutlook"      : @"oilOutlook",
                                                             @"oilPlanned"      : @"oilPlanned",
                                                             @"rtbdIndicator"   : @"rtbdIndicator",
                                                             @"rtbdOutlook"     : @"rtbdOutlook",
                                                             @"rtbdPlanned"     : @"rtbdPlanned",
                                                             @"sort"            : @"sort",
                                                             @"wellName"        : @"wellName",
                                                             }];
    
#pragma mark - Schedule Attributes
    //Attribute Mappings for ETGKeyMilestoneProjectPhase
    RKEntityMapping *projectPhaseMapping = [[RKEntityMapping alloc] initWithEntity:[ETGKeyMilestoneProjectPhase entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectPhaseMapping addAttributeMappingsFromDictionary:@{
                                                              @"projectPhase"      : @"projectPhase"
                                                              }];
    
    // Attribute Mappings for ETGBaselineType
    RKEntityMapping *baselineTypeMapping = [[RKEntityMapping alloc] initWithEntity:[ETGBaselineType entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [baselineTypeMapping addAttributeMappingsFromDictionary:@{
                                                              @"baselineType"               : @"name",
                                                              @"baselineTypeKey"            : @"key",
                                                              @"createdTime"                : @"createdTime",
                                                              @"@root.projectKey"           : @"projectKey",
                                                              @"@metadata.reportingMonth"   : @"reportMonth"
                                                              }];
    baselineTypeMapping.identificationAttributes = @[@"key", @"projectKey", @"reportMonth"];
    
    // Attribute Mappings for ETGRevision
    RKEntityMapping *revisionMapping = [[RKEntityMapping alloc] initWithEntity:[ETGRevision entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [revisionMapping addAttributeMappingsFromDictionary:@{
                                                          @"revisionNo"        : @"number"
                                                          }];
    
    // Attribute Mappings for ETGKeyMilestone
    RKEntityMapping *keyMilestoneMapping = [[RKEntityMapping alloc] initWithEntity:[ETGKeyMilestone entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [keyMilestoneMapping addAttributeMappingsFromDictionary:@{
                                                              @"actualDate"      : @"actualDate",
                                                              @"baseLineNum"     : @"baselineNum",
                                                              @"mileStone"       : @"mileStone",
                                                              @"plannedDate"     : @"plannedDate",
                                                              @"indicator"       : @"indicator"
                                                              }];
    
    // Attribute Mappings for ETGPlatform
    RKEntityMapping *platformMapping = [[RKEntityMapping alloc] initWithEntity:[ETGFirstHydrocarbon entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [platformMapping addAttributeMappingsFromDictionary:@{
                                                          @"estimateDate"       : @"actualDt",
                                                          @"indicator"          : @"indicator",
                                                          @"planDate"           : @"plannedDt",
                                                          @"facilityName"       : @"field"
                                                          }];
    
    // Attribute Mappings for ETGScheduleProgress
    RKEntityMapping *scheduleMapping = [[RKEntityMapping alloc] initWithEntity:[ETGScheduleProgress entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [scheduleMapping addAttributeMappingsFromDictionary:@{
                                                          @"actual"              : @"actualProgress",
                                                          @"indicator"           : @"indicator",
                                                          @"planned"             : @"planProgress",
                                                          @"variance"            : @"variance",
                                                          //Web Service Updates
                                                          @"reportingDate"       : @"reportingDate",
                                                          }];
    
    //**********************************************
    // Relationship Mappings
    //**********************************************
    // Scorecard
    //***********************
    
#pragma mark - Scorecard Relationships
    // Relationship mapping of ETGRegion to ETGProject
    [projectMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"region" withMapping:regionMapping]];

    // Relationship mapping of ETGProject to ETGScorecard
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"project" withMapping:projectMapping]];
    // Relationship mapping of ETGReportingMonth to ETGScorecard
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"reportingMonth" withMapping:reportingMonthMapping]];
    
//    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"portfolio" withMapping:portfolioMapping]];

//    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"projectSummary" withMapping:projectSummaryMapping]];
    
#pragma mark - Portfolio Relationships
    // Relationship mapping of ETGProject to ETGPortfolio
//    [portfolioMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"project" withMapping:projectMapping]];
//
//    [portfolioMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"reportingMonth" withMapping:reportingMonthMapping]];
    
#pragma mark - Project Relationships
    // Relationship mapping of ETGProject to ETGProjectSummary
//    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"project" withMapping:projectMapping]];
//
//    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"reportingMonth" withMapping:reportingMonthMapping]];
    
#pragma mark - Cost PCSB Relationships
    
    // Relationship mapping of ETGApc to ETGPortfolio
//    [portfolioMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pcsb.apc.capex" toKeyPath:@"etgApcPortfolios" withMapping:apcMapping]];
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pcsb.apc.capex" toKeyPath:@"etgApcPortfolios" withMapping:apcMapping]];
    
    // Relationship mapping of ETGCostAllocation to ETGCpb
    [cpbMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"costAllocation" withMapping:costAllocationMapping]];

    // Relationship mapping of ETGCpb to ETGPortfolio
//    [portfolioMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pcsb.cpb.capex" toKeyPath:@"etgCpbPortfolios" withMapping:cpbMapping]];
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pcsb.cpb.capex" toKeyPath:@"etgCpbPortfolios" withMapping:cpbMapping]];

    // Relationship mapping of ETGAfeTable to ETGProjectSummary
//    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pcsb.afe.capex" toKeyPath:@"etgAfeTable_Projects" withMapping:afeMapping]];
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pcsb.afe.capex" toKeyPath:@"etgAfeTable_Projects" withMapping:afeMapping]];

#pragma mark - Cost PMU Relationships
    
    // Relationship mapping of ETGFdp to ETGScorecard
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pmu.fdp.capex" toKeyPath:@"fdp" withMapping:fdpMapping]];
    
    // Relationship mapping of ETGWpbScorecard to ETGScorecard
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pmu.wpb.capex" toKeyPath:@"wpbCostPMUs" withMapping:wpbMapping]];

#pragma mark - HSE Relationships
//    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"hse.hseDetails" toKeyPath:@"etgHseTable_Projects" withMapping:hseMapping]];
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"hse.hseDetails" toKeyPath:@"etgHseTable_Projects" withMapping:hseMapping]];

#pragma mark - Manpower Relationships
    /* OLD Manpower mapping
    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"manningHeadCount" toKeyPath:@"etgManpowerTable_Projects" withMapping:manpowerMapping]]; */
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"manningHeadCount" toKeyPath:@"etgManpowerTable_Projects" withMapping:manpowerMapping]];
    
#pragma mark - Production Relationships
    // Relationship mapping of ETGProduction to ETGScorecard
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"production.production" toKeyPath:@"productions" withMapping:productionMapping]];

    // Relationship mapping of ETGWellDetails to ETGProduction
    [productionMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"wellDetails" toKeyPath:@"wellDetails" withMapping:wellDetailsMapping]];
    
#pragma mark - Schedule Relationships

    // Relationship mapping of ETGKeyMilestoneProjectPhase to ETGProjectSummary
//    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"etgKeyMilestone_ProjectPhase" withMapping:projectPhaseMapping]];
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"etgKeyMilestone_ProjectPhase" withMapping:projectPhaseMapping]];

    // Relationship mapping of ETGBaselineType to ETGProjectSummary
//    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schedule.schedule.KeyMileStoneSummary" toKeyPath:@"baselineTypes" withMapping:baselineTypeMapping]];
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schedule.schedule.KeyMileStoneSummary" toKeyPath:@"baselineTypes" withMapping:baselineTypeMapping]];
    
    // Relationship mapping of ETGRevision to ETGBaselineType
    RKRelationshipMapping* baselineTypeToRevision = [RKRelationshipMapping relationshipMappingFromKeyPath:@"revisions" toKeyPath:@"revisions" withMapping:revisionMapping];
    [baselineTypeMapping addPropertyMapping:baselineTypeToRevision];
    
    // Relationship mapping of ETGKeyMilestone to ETGRevision
    RKRelationshipMapping* revisionToKeymilestone = [RKRelationshipMapping relationshipMappingFromKeyPath:@"KeyMilestones" toKeyPath:@"keyMilestones" withMapping:keyMilestoneMapping];
    [revisionMapping addPropertyMapping:revisionToKeymilestone];
    
    // Relationship mapping of ETGScheduleProgress to ETGProjectSummary
//    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schedule.schedule.scheduleSCurve" toKeyPath:@"etgScheduleProgress_Projects" withMapping:scheduleMapping]];
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schedule.schedule.scheduleSCurve" toKeyPath:@"etgScheduleProgress_Projects" withMapping:scheduleMapping]];
    
    // Relationship mapping of ETGPlatform to ETGScorecard
//    [projectSummaryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schedule.schedule.FirstHydrocarbon" toKeyPath:@"etgFirstHydrocarbon_Projects" withMapping:platformMapping]];
    [scorecardMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schedule.schedule.FirstHydrocarbon" toKeyPath:@"etgFirstHydrocarbon_Projects" withMapping:platformMapping]];
    
#pragma mark - Descriptor
    RKResponseDescriptor *scoreCardTableSummaryDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:scorecardMapping method:RKRequestMethodPOST pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_SCORECARD_TABLE_SUMMARY_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:scoreCardTableSummaryDescriptor];
    
    // Pagination mapping
    RKObjectMapping *paginationMapping = [RKObjectMapping mappingForClass:[RKPaginator class]];
    
    [paginationMapping addAttributeMappingsFromDictionary:@{
                                                            @"pagination.per_page": @"perPage",
                                                            @"pagination.total_pages": @"pageCount",
                                                            @"pagination.total_objects": @"objectCount",
                                                            }];
    [_managedObject setPaginationMapping:paginationMapping];
    
#pragma mark - Inverse Mapping
    //****************************************************
    // Attribute Mappings from core data to webview(html)
    //****************************************************
    
    // Inverse Attribute Mappings for ETGScorecard
    RKEntityMapping *scorecardMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGScorecard entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [scorecardMapping_ addAttributeMappingsFromDictionary:@{
     @"costPCSB"    : @"costPcsb",
     @"costPMU"     : @"costPmu",
     @"hse"         : @"hse",
     @"manpower"    : @"manpower",
     @"production"  : @"production",
     @"schedule"    : @"schedule",
     }];

    [scorecardMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"projectKey" toKeyPath:@"project.key"]];
    [scorecardMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"projectName" toKeyPath:@"project.name"]];
    [scorecardMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"region" toKeyPath:@"project.region.name"]];

    _inverseMapping = [scorecardMapping_ inverseMapping];
    
}

- (NSDictionary*)serializeObject:(NSManagedObject*)object
{
    
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    RKObjectMappingOperationDataSource *dataSource = [RKObjectMappingOperationDataSource new];
    RKMappingOperation *mappingOperation = [[RKMappingOperation alloc] initWithSourceObject:object destinationObject:json mapping:_inverseMapping];
    
    mappingOperation.dataSource = dataSource;
    NSError *error = nil;
    
    [mappingOperation performMapping:&error];
    if (error) {
        DDLogError(@"%@%@", logErrorPrefix, [NSString stringWithFormat:serializationError, error]);
        return nil;
    }
    
    return json;
}

- (NSString *)parseDataToJson:(NSSet *)mappingResult {
    
    NSError *error;

    // Create Core Data to JSON mapping
    NSMutableArray *jsonDict = [NSMutableArray array];
    for (ETGScorecard* card in mappingResult) {
        NSDictionary* json = [self serializeObject:card];
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
        //failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    } else {
        if ([jsonDict count]) {
            
            NSError *parsingError;
            NSData *data = [RKMIMETypeSerialization dataFromObject:jsonDict MIMEType:RKMIMETypeJSON error:&parsingError];
            
            if (parsingError) {
                //failure(parsingError);
                DDLogError(@"%@%@", logErrorPrefix,parsingError.description);
            } else {
                NSString *jsonString = [[NSString alloc] initWithData:data
                                                             encoding:NSUTF8StringEncoding];
                return (jsonString);
            }
        } else {
            
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
            NSError *noDataerror = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
            //failure(noDataerror);
            DDLogError(@"%@%@", logErrorPrefix,noDataerror.description);
        }
    }

    return 0;
}

- (void)sendRequestWithReportingMonth:(NSString*)reportingMonth
                             pageSize:(int)pageSize
                           pageNumber:(int)pageNumber
             isSelectedReportingMonth:(BOOL)isSelectedReportingMonth
                   filteredDictionary:(NSMutableDictionary*)filteredDictionary
                              success:(void (^)(NSString* scorecards))success
                              failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"inpReportingMonth"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"inpPageSize"];
    [params setObject:[NSNumber numberWithInt:pageNumber] forKey:@"inpPageNumber"];

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_SCORECARD_TABLE_SUMMARY_PATH];
    NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    // Set to 3 Mins
    [request setTimeoutInterval:180];

    RKManagedObjectRequestOperation *operation = [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:[[ETGWebService sharedWebService] managedObjectContext] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        
        if ([mappingResult count] < pageSize) {
            [self.delegate appendJSONOfLastPageToInterface:[mappingResult set]];
        } else {
            //NSLog(@"Success = %d", pageNumber);
                [self.delegate appendJSONToInterface:[mappingResult set]];
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        DDLogError(@"%@%@", logErrorPrefix, error.description);
        [self.delegate appendJSONOfCurrentPageToInterface:nil withError:error];
        
    }];
    NSDictionary* metadata = [NSDictionary dictionaryWithObjectsAndKeys:
                              [reportingMonth toDate], @"reportingMonth", nil];
    [operation setMappingMetadata:metadata];
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [_managedObject enqueueObjectRequestOperation:operation];
    
}

@end
