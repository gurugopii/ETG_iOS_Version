// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectSummaryForMap.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGProjectSummaryForMapAttributes {
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *reportMonth;
} ETGProjectSummaryForMapAttributes;

extern const struct ETGProjectSummaryForMapRelationships {
	__unsafe_unretained NSString *baselineTypes;
	__unsafe_unretained NSString *etgFirstHydrocarbon_Projects;
	__unsafe_unretained NSString *etgKeyMilestone_ProjectPhase;
	__unsafe_unretained NSString *project;
	__unsafe_unretained NSString *reportingMonth;
} ETGProjectSummaryForMapRelationships;

extern const struct ETGProjectSummaryForMapFetchedProperties {
} ETGProjectSummaryForMapFetchedProperties;

@class ETGBaselineType;
@class ETGFirstHydrocarbon;
@class ETGKeyMilestoneProjectPhase;
@class ETGProject;
@class ETGReportingMonth;




@interface ETGProjectSummaryForMapID : NSManagedObjectID {}
@end

@interface _ETGProjectSummaryForMap : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGProjectSummaryForMapID*)objectID;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* reportMonth;


//- (BOOL)validateReportMonth:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* baselineTypes;

- (NSMutableSet*)baselineTypesSet;




@property (nonatomic, strong) NSSet* etgFirstHydrocarbon_Projects;

- (NSMutableSet*)etgFirstHydrocarbon_ProjectsSet;




@property (nonatomic, strong) ETGKeyMilestoneProjectPhase* etgKeyMilestone_ProjectPhase;

//- (BOOL)validateEtgKeyMilestone_ProjectPhase:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGProject* project;

//- (BOOL)validateProject:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGProjectSummaryForMap (CoreDataGeneratedAccessors)

- (void)addBaselineTypes:(NSSet*)value_;
- (void)removeBaselineTypes:(NSSet*)value_;
- (void)addBaselineTypesObject:(ETGBaselineType*)value_;
- (void)removeBaselineTypesObject:(ETGBaselineType*)value_;

- (void)addEtgFirstHydrocarbon_Projects:(NSSet*)value_;
- (void)removeEtgFirstHydrocarbon_Projects:(NSSet*)value_;
- (void)addEtgFirstHydrocarbon_ProjectsObject:(ETGFirstHydrocarbon*)value_;
- (void)removeEtgFirstHydrocarbon_ProjectsObject:(ETGFirstHydrocarbon*)value_;

@end

@interface _ETGProjectSummaryForMap (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSString*)primitiveReportMonth;
- (void)setPrimitiveReportMonth:(NSString*)value;





- (NSMutableSet*)primitiveBaselineTypes;
- (void)setPrimitiveBaselineTypes:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgFirstHydrocarbon_Projects;
- (void)setPrimitiveEtgFirstHydrocarbon_Projects:(NSMutableSet*)value;



- (ETGKeyMilestoneProjectPhase*)primitiveEtgKeyMilestone_ProjectPhase;
- (void)setPrimitiveEtgKeyMilestone_ProjectPhase:(ETGKeyMilestoneProjectPhase*)value;



- (ETGProject*)primitiveProject;
- (void)setPrimitiveProject:(ETGProject*)value;



- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;


@end
