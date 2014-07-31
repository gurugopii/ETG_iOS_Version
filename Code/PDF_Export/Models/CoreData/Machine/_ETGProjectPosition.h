// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectPosition.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGProjectPositionAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGProjectPositionAttributes;

extern const struct ETGProjectPositionRelationships {
	__unsafe_unretained NSString *clusters;
	__unsafe_unretained NSString *projPosition_cluster;
	__unsafe_unretained NSString *projPosition_project;
	__unsafe_unretained NSString *projects;
	__unsafe_unretained NSString *reportingPeriods;
} ETGProjectPositionRelationships;

extern const struct ETGProjectPositionFetchedProperties {
} ETGProjectPositionFetchedProperties;

@class ETGMpCluster;
@class ETGCluster_ProjPosition;
@class ETGProject_ProjPosition;
@class ETGMpProject;
@class ETGReportingPeriod;




@interface ETGProjectPositionID : NSManagedObjectID {}
@end

@interface _ETGProjectPosition : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGProjectPositionID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* clusters;

- (NSMutableSet*)clustersSet;




@property (nonatomic, strong) NSSet* projPosition_cluster;

- (NSMutableSet*)projPosition_clusterSet;




@property (nonatomic, strong) NSSet* projPosition_project;

- (NSMutableSet*)projPosition_projectSet;




@property (nonatomic, strong) NSSet* projects;

- (NSMutableSet*)projectsSet;




@property (nonatomic, strong) NSSet* reportingPeriods;

- (NSMutableSet*)reportingPeriodsSet;





@end

@interface _ETGProjectPosition (CoreDataGeneratedAccessors)

- (void)addClusters:(NSSet*)value_;
- (void)removeClusters:(NSSet*)value_;
- (void)addClustersObject:(ETGMpCluster*)value_;
- (void)removeClustersObject:(ETGMpCluster*)value_;

- (void)addProjPosition_cluster:(NSSet*)value_;
- (void)removeProjPosition_cluster:(NSSet*)value_;
- (void)addProjPosition_clusterObject:(ETGCluster_ProjPosition*)value_;
- (void)removeProjPosition_clusterObject:(ETGCluster_ProjPosition*)value_;

- (void)addProjPosition_project:(NSSet*)value_;
- (void)removeProjPosition_project:(NSSet*)value_;
- (void)addProjPosition_projectObject:(ETGProject_ProjPosition*)value_;
- (void)removeProjPosition_projectObject:(ETGProject_ProjPosition*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(ETGMpProject*)value_;
- (void)removeProjectsObject:(ETGMpProject*)value_;

- (void)addReportingPeriods:(NSSet*)value_;
- (void)removeReportingPeriods:(NSSet*)value_;
- (void)addReportingPeriodsObject:(ETGReportingPeriod*)value_;
- (void)removeReportingPeriodsObject:(ETGReportingPeriod*)value_;

@end

@interface _ETGProjectPosition (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveClusters;
- (void)setPrimitiveClusters:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjPosition_cluster;
- (void)setPrimitiveProjPosition_cluster:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjPosition_project;
- (void)setPrimitiveProjPosition_project:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveReportingPeriods;
- (void)setPrimitiveReportingPeriods:(NSMutableSet*)value;


@end
