// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectSummary.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGProjectSummaryAttributes {
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *reportMonth;
} ETGProjectSummaryAttributes;

extern const struct ETGProjectSummaryRelationships {
	__unsafe_unretained NSString *baselineTypes;
	__unsafe_unretained NSString *etgAfeTable_Projects;
	__unsafe_unretained NSString *etgAfe_Projects;
	__unsafe_unretained NSString *etgBudgetCoreInfo_Projects;
	__unsafe_unretained NSString *etgBudgetPerformance_Projects;
	__unsafe_unretained NSString *etgEccr_cps;
	__unsafe_unretained NSString *etgFirstHydrocarbon_Projects;
	__unsafe_unretained NSString *etgHseTable_Projects;
	__unsafe_unretained NSString *etgHse_Projects;
	__unsafe_unretained NSString *etgKeyMilestone_ProjectPhase;
	__unsafe_unretained NSString *etgManpowerTable_Projects;
	__unsafe_unretained NSString *etgMlProjects;
	__unsafe_unretained NSString *etgOpportunityImpact_Projects;
	__unsafe_unretained NSString *etgPpms_Projects;
	__unsafe_unretained NSString *etgProductionRtbd_Projects;
	__unsafe_unretained NSString *etgScheduleProgress_Projects;
	__unsafe_unretained NSString *project;
	__unsafe_unretained NSString *reportingMonth;
} ETGProjectSummaryRelationships;

extern const struct ETGProjectSummaryFetchedProperties {
} ETGProjectSummaryFetchedProperties;

@class ETGBaselineType;
@class ETGAfeTable;
@class ETGAfe;
@class ETGBudgetCoreInfo;
@class ETGBudgetPerformance;
@class ETGEccrCps;
@class ETGFirstHydrocarbon;
@class ETGHseTable_Project;
@class ETGHseProject;
@class ETGKeyMilestoneProjectPhase;
@class ETGManpowerTable_Project;
@class ETGMLProject;
@class ETGRiskOpportunity;
@class ETGPPMS;
@class ETGProductionRtbd_Project;
@class ETGScheduleProgress;
@class ETGProject;
@class ETGReportingMonth;




@interface ETGProjectSummaryID : NSManagedObjectID {}
@end

@interface _ETGProjectSummary : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGProjectSummaryID*)objectID;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* reportMonth;


//- (BOOL)validateReportMonth:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* baselineTypes;

- (NSMutableSet*)baselineTypesSet;




@property (nonatomic, strong) NSSet* etgAfeTable_Projects;

- (NSMutableSet*)etgAfeTable_ProjectsSet;




@property (nonatomic, strong) NSSet* etgAfe_Projects;

- (NSMutableSet*)etgAfe_ProjectsSet;




@property (nonatomic, strong) ETGBudgetCoreInfo* etgBudgetCoreInfo_Projects;

//- (BOOL)validateEtgBudgetCoreInfo_Projects:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* etgBudgetPerformance_Projects;

- (NSMutableSet*)etgBudgetPerformance_ProjectsSet;




@property (nonatomic, strong) ETGEccrCps* etgEccr_cps;

//- (BOOL)validateEtgEccr_cps:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* etgFirstHydrocarbon_Projects;

- (NSMutableSet*)etgFirstHydrocarbon_ProjectsSet;




@property (nonatomic, strong) NSSet* etgHseTable_Projects;

- (NSMutableSet*)etgHseTable_ProjectsSet;




@property (nonatomic, strong) ETGHseProject* etgHse_Projects;

//- (BOOL)validateEtgHse_Projects:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGKeyMilestoneProjectPhase* etgKeyMilestone_ProjectPhase;

//- (BOOL)validateEtgKeyMilestone_ProjectPhase:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* etgManpowerTable_Projects;

- (NSMutableSet*)etgManpowerTable_ProjectsSet;




@property (nonatomic, strong) NSSet* etgMlProjects;

- (NSMutableSet*)etgMlProjectsSet;




@property (nonatomic, strong) NSSet* etgOpportunityImpact_Projects;

- (NSMutableSet*)etgOpportunityImpact_ProjectsSet;




@property (nonatomic, strong) NSSet* etgPpms_Projects;

- (NSMutableSet*)etgPpms_ProjectsSet;




@property (nonatomic, strong) NSSet* etgProductionRtbd_Projects;

- (NSMutableSet*)etgProductionRtbd_ProjectsSet;




@property (nonatomic, strong) NSSet* etgScheduleProgress_Projects;

- (NSMutableSet*)etgScheduleProgress_ProjectsSet;




@property (nonatomic, strong) ETGProject* project;

//- (BOOL)validateProject:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGProjectSummary (CoreDataGeneratedAccessors)

- (void)addBaselineTypes:(NSSet*)value_;
- (void)removeBaselineTypes:(NSSet*)value_;
- (void)addBaselineTypesObject:(ETGBaselineType*)value_;
- (void)removeBaselineTypesObject:(ETGBaselineType*)value_;

- (void)addEtgAfeTable_Projects:(NSSet*)value_;
- (void)removeEtgAfeTable_Projects:(NSSet*)value_;
- (void)addEtgAfeTable_ProjectsObject:(ETGAfeTable*)value_;
- (void)removeEtgAfeTable_ProjectsObject:(ETGAfeTable*)value_;

- (void)addEtgAfe_Projects:(NSSet*)value_;
- (void)removeEtgAfe_Projects:(NSSet*)value_;
- (void)addEtgAfe_ProjectsObject:(ETGAfe*)value_;
- (void)removeEtgAfe_ProjectsObject:(ETGAfe*)value_;

- (void)addEtgBudgetPerformance_Projects:(NSSet*)value_;
- (void)removeEtgBudgetPerformance_Projects:(NSSet*)value_;
- (void)addEtgBudgetPerformance_ProjectsObject:(ETGBudgetPerformance*)value_;
- (void)removeEtgBudgetPerformance_ProjectsObject:(ETGBudgetPerformance*)value_;

- (void)addEtgFirstHydrocarbon_Projects:(NSSet*)value_;
- (void)removeEtgFirstHydrocarbon_Projects:(NSSet*)value_;
- (void)addEtgFirstHydrocarbon_ProjectsObject:(ETGFirstHydrocarbon*)value_;
- (void)removeEtgFirstHydrocarbon_ProjectsObject:(ETGFirstHydrocarbon*)value_;

- (void)addEtgHseTable_Projects:(NSSet*)value_;
- (void)removeEtgHseTable_Projects:(NSSet*)value_;
- (void)addEtgHseTable_ProjectsObject:(ETGHseTable_Project*)value_;
- (void)removeEtgHseTable_ProjectsObject:(ETGHseTable_Project*)value_;

- (void)addEtgManpowerTable_Projects:(NSSet*)value_;
- (void)removeEtgManpowerTable_Projects:(NSSet*)value_;
- (void)addEtgManpowerTable_ProjectsObject:(ETGManpowerTable_Project*)value_;
- (void)removeEtgManpowerTable_ProjectsObject:(ETGManpowerTable_Project*)value_;

- (void)addEtgMlProjects:(NSSet*)value_;
- (void)removeEtgMlProjects:(NSSet*)value_;
- (void)addEtgMlProjectsObject:(ETGMLProject*)value_;
- (void)removeEtgMlProjectsObject:(ETGMLProject*)value_;

- (void)addEtgOpportunityImpact_Projects:(NSSet*)value_;
- (void)removeEtgOpportunityImpact_Projects:(NSSet*)value_;
- (void)addEtgOpportunityImpact_ProjectsObject:(ETGRiskOpportunity*)value_;
- (void)removeEtgOpportunityImpact_ProjectsObject:(ETGRiskOpportunity*)value_;

- (void)addEtgPpms_Projects:(NSSet*)value_;
- (void)removeEtgPpms_Projects:(NSSet*)value_;
- (void)addEtgPpms_ProjectsObject:(ETGPPMS*)value_;
- (void)removeEtgPpms_ProjectsObject:(ETGPPMS*)value_;

- (void)addEtgProductionRtbd_Projects:(NSSet*)value_;
- (void)removeEtgProductionRtbd_Projects:(NSSet*)value_;
- (void)addEtgProductionRtbd_ProjectsObject:(ETGProductionRtbd_Project*)value_;
- (void)removeEtgProductionRtbd_ProjectsObject:(ETGProductionRtbd_Project*)value_;

- (void)addEtgScheduleProgress_Projects:(NSSet*)value_;
- (void)removeEtgScheduleProgress_Projects:(NSSet*)value_;
- (void)addEtgScheduleProgress_ProjectsObject:(ETGScheduleProgress*)value_;
- (void)removeEtgScheduleProgress_ProjectsObject:(ETGScheduleProgress*)value_;

@end

@interface _ETGProjectSummary (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSDate*)primitiveReportMonth;
- (void)setPrimitiveReportMonth:(NSDate*)value;





- (NSMutableSet*)primitiveBaselineTypes;
- (void)setPrimitiveBaselineTypes:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgAfeTable_Projects;
- (void)setPrimitiveEtgAfeTable_Projects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgAfe_Projects;
- (void)setPrimitiveEtgAfe_Projects:(NSMutableSet*)value;



- (ETGBudgetCoreInfo*)primitiveEtgBudgetCoreInfo_Projects;
- (void)setPrimitiveEtgBudgetCoreInfo_Projects:(ETGBudgetCoreInfo*)value;



- (NSMutableSet*)primitiveEtgBudgetPerformance_Projects;
- (void)setPrimitiveEtgBudgetPerformance_Projects:(NSMutableSet*)value;



- (ETGEccrCps*)primitiveEtgEccr_cps;
- (void)setPrimitiveEtgEccr_cps:(ETGEccrCps*)value;



- (NSMutableSet*)primitiveEtgFirstHydrocarbon_Projects;
- (void)setPrimitiveEtgFirstHydrocarbon_Projects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgHseTable_Projects;
- (void)setPrimitiveEtgHseTable_Projects:(NSMutableSet*)value;



- (ETGHseProject*)primitiveEtgHse_Projects;
- (void)setPrimitiveEtgHse_Projects:(ETGHseProject*)value;



- (ETGKeyMilestoneProjectPhase*)primitiveEtgKeyMilestone_ProjectPhase;
- (void)setPrimitiveEtgKeyMilestone_ProjectPhase:(ETGKeyMilestoneProjectPhase*)value;



- (NSMutableSet*)primitiveEtgManpowerTable_Projects;
- (void)setPrimitiveEtgManpowerTable_Projects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgMlProjects;
- (void)setPrimitiveEtgMlProjects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgOpportunityImpact_Projects;
- (void)setPrimitiveEtgOpportunityImpact_Projects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgPpms_Projects;
- (void)setPrimitiveEtgPpms_Projects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgProductionRtbd_Projects;
- (void)setPrimitiveEtgProductionRtbd_Projects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgScheduleProgress_Projects;
- (void)setPrimitiveEtgScheduleProgress_Projects:(NSMutableSet*)value;



- (ETGProject*)primitiveProject;
- (void)setPrimitiveProject:(ETGProject*)value;



- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;


@end
