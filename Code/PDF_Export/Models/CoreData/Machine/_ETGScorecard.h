// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGScorecard.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGScorecardAttributes {
	__unsafe_unretained NSString *costPcsb;
	__unsafe_unretained NSString *costPmu;
	__unsafe_unretained NSString *hse;
	__unsafe_unretained NSString *manningHeadCount;
	__unsafe_unretained NSString *production;
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *reportMonth;
	__unsafe_unretained NSString *schedule;
} ETGScorecardAttributes;

extern const struct ETGScorecardRelationships {
	__unsafe_unretained NSString *baselineTypes;
	__unsafe_unretained NSString *etgAfeTable_Projects;
	__unsafe_unretained NSString *etgApcPortfolios;
	__unsafe_unretained NSString *etgCpbPortfolios;
	__unsafe_unretained NSString *etgFirstHydrocarbon_Projects;
	__unsafe_unretained NSString *etgHseTable_Projects;
	__unsafe_unretained NSString *etgKeyMilestone_ProjectPhase;
	__unsafe_unretained NSString *etgManpowerTable_Projects;
	__unsafe_unretained NSString *etgScheduleProgress_Projects;
	__unsafe_unretained NSString *fdp;
	__unsafe_unretained NSString *platform;
	__unsafe_unretained NSString *productions;
	__unsafe_unretained NSString *project;
	__unsafe_unretained NSString *reportingMonth;
	__unsafe_unretained NSString *wpbCostPMUs;
} ETGScorecardRelationships;

extern const struct ETGScorecardFetchedProperties {
} ETGScorecardFetchedProperties;

@class ETGBaselineType;
@class ETGAfeTable;
@class ETGApc;
@class ETGCpb;
@class ETGFirstHydrocarbon;
@class ETGHseTable_Project;
@class ETGKeyMilestoneProjectPhase;
@class ETGManpowerTable_Project;
@class ETGScheduleProgress;
@class ETGFdp;
@class ETGPlatform;
@class ETGFacility;
@class ETGProject;
@class ETGReportingMonth;
@class ETGWPBCostPMU;










@interface ETGScorecardID : NSManagedObjectID {}
@end

@interface _ETGScorecard : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGScorecardID*)objectID;




@property (nonatomic, strong) NSString* costPcsb;


//- (BOOL)validateCostPcsb:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* costPmu;


//- (BOOL)validateCostPmu:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* hse;


//- (BOOL)validateHse:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* manningHeadCount;


//- (BOOL)validateManningHeadCount:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* production;


//- (BOOL)validateProduction:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* reportMonth;


//- (BOOL)validateReportMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* schedule;


//- (BOOL)validateSchedule:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* baselineTypes;

- (NSMutableSet*)baselineTypesSet;




@property (nonatomic, strong) NSSet* etgAfeTable_Projects;

- (NSMutableSet*)etgAfeTable_ProjectsSet;




@property (nonatomic, strong) NSSet* etgApcPortfolios;

- (NSMutableSet*)etgApcPortfoliosSet;




@property (nonatomic, strong) NSSet* etgCpbPortfolios;

- (NSMutableSet*)etgCpbPortfoliosSet;




@property (nonatomic, strong) NSSet* etgFirstHydrocarbon_Projects;

- (NSMutableSet*)etgFirstHydrocarbon_ProjectsSet;




@property (nonatomic, strong) NSSet* etgHseTable_Projects;

- (NSMutableSet*)etgHseTable_ProjectsSet;




@property (nonatomic, strong) ETGKeyMilestoneProjectPhase* etgKeyMilestone_ProjectPhase;

//- (BOOL)validateEtgKeyMilestone_ProjectPhase:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* etgManpowerTable_Projects;

- (NSMutableSet*)etgManpowerTable_ProjectsSet;




@property (nonatomic, strong) NSSet* etgScheduleProgress_Projects;

- (NSMutableSet*)etgScheduleProgress_ProjectsSet;




@property (nonatomic, strong) NSSet* fdp;

- (NSMutableSet*)fdpSet;




@property (nonatomic, strong) NSSet* platform;

- (NSMutableSet*)platformSet;




@property (nonatomic, strong) NSSet* productions;

- (NSMutableSet*)productionsSet;




@property (nonatomic, strong) ETGProject* project;

//- (BOOL)validateProject:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* wpbCostPMUs;

- (NSMutableSet*)wpbCostPMUsSet;





@end

@interface _ETGScorecard (CoreDataGeneratedAccessors)

- (void)addBaselineTypes:(NSSet*)value_;
- (void)removeBaselineTypes:(NSSet*)value_;
- (void)addBaselineTypesObject:(ETGBaselineType*)value_;
- (void)removeBaselineTypesObject:(ETGBaselineType*)value_;

- (void)addEtgAfeTable_Projects:(NSSet*)value_;
- (void)removeEtgAfeTable_Projects:(NSSet*)value_;
- (void)addEtgAfeTable_ProjectsObject:(ETGAfeTable*)value_;
- (void)removeEtgAfeTable_ProjectsObject:(ETGAfeTable*)value_;

- (void)addEtgApcPortfolios:(NSSet*)value_;
- (void)removeEtgApcPortfolios:(NSSet*)value_;
- (void)addEtgApcPortfoliosObject:(ETGApc*)value_;
- (void)removeEtgApcPortfoliosObject:(ETGApc*)value_;

- (void)addEtgCpbPortfolios:(NSSet*)value_;
- (void)removeEtgCpbPortfolios:(NSSet*)value_;
- (void)addEtgCpbPortfoliosObject:(ETGCpb*)value_;
- (void)removeEtgCpbPortfoliosObject:(ETGCpb*)value_;

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

- (void)addEtgScheduleProgress_Projects:(NSSet*)value_;
- (void)removeEtgScheduleProgress_Projects:(NSSet*)value_;
- (void)addEtgScheduleProgress_ProjectsObject:(ETGScheduleProgress*)value_;
- (void)removeEtgScheduleProgress_ProjectsObject:(ETGScheduleProgress*)value_;

- (void)addFdp:(NSSet*)value_;
- (void)removeFdp:(NSSet*)value_;
- (void)addFdpObject:(ETGFdp*)value_;
- (void)removeFdpObject:(ETGFdp*)value_;

- (void)addPlatform:(NSSet*)value_;
- (void)removePlatform:(NSSet*)value_;
- (void)addPlatformObject:(ETGPlatform*)value_;
- (void)removePlatformObject:(ETGPlatform*)value_;

- (void)addProductions:(NSSet*)value_;
- (void)removeProductions:(NSSet*)value_;
- (void)addProductionsObject:(ETGFacility*)value_;
- (void)removeProductionsObject:(ETGFacility*)value_;

- (void)addWpbCostPMUs:(NSSet*)value_;
- (void)removeWpbCostPMUs:(NSSet*)value_;
- (void)addWpbCostPMUsObject:(ETGWPBCostPMU*)value_;
- (void)removeWpbCostPMUsObject:(ETGWPBCostPMU*)value_;

@end

@interface _ETGScorecard (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCostPcsb;
- (void)setPrimitiveCostPcsb:(NSString*)value;




- (NSString*)primitiveCostPmu;
- (void)setPrimitiveCostPmu:(NSString*)value;




- (NSString*)primitiveHse;
- (void)setPrimitiveHse:(NSString*)value;




- (NSString*)primitiveManningHeadCount;
- (void)setPrimitiveManningHeadCount:(NSString*)value;




- (NSString*)primitiveProduction;
- (void)setPrimitiveProduction:(NSString*)value;




- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSDate*)primitiveReportMonth;
- (void)setPrimitiveReportMonth:(NSDate*)value;




- (NSString*)primitiveSchedule;
- (void)setPrimitiveSchedule:(NSString*)value;





- (NSMutableSet*)primitiveBaselineTypes;
- (void)setPrimitiveBaselineTypes:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgAfeTable_Projects;
- (void)setPrimitiveEtgAfeTable_Projects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgApcPortfolios;
- (void)setPrimitiveEtgApcPortfolios:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgCpbPortfolios;
- (void)setPrimitiveEtgCpbPortfolios:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgFirstHydrocarbon_Projects;
- (void)setPrimitiveEtgFirstHydrocarbon_Projects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgHseTable_Projects;
- (void)setPrimitiveEtgHseTable_Projects:(NSMutableSet*)value;



- (ETGKeyMilestoneProjectPhase*)primitiveEtgKeyMilestone_ProjectPhase;
- (void)setPrimitiveEtgKeyMilestone_ProjectPhase:(ETGKeyMilestoneProjectPhase*)value;



- (NSMutableSet*)primitiveEtgManpowerTable_Projects;
- (void)setPrimitiveEtgManpowerTable_Projects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgScheduleProgress_Projects;
- (void)setPrimitiveEtgScheduleProgress_Projects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveFdp;
- (void)setPrimitiveFdp:(NSMutableSet*)value;



- (NSMutableSet*)primitivePlatform;
- (void)setPrimitivePlatform:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProductions;
- (void)setPrimitiveProductions:(NSMutableSet*)value;



- (ETGProject*)primitiveProject;
- (void)setPrimitiveProject:(ETGProject*)value;



- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;



- (NSMutableSet*)primitiveWpbCostPMUs;
- (void)setPrimitiveWpbCostPMUs:(NSMutableSet*)value;


@end
