// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMpRegion.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMpRegionAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGMpRegionAttributes;

extern const struct ETGMpRegionRelationships {
	__unsafe_unretained NSString *clusters;
	__unsafe_unretained NSString *projects;
	__unsafe_unretained NSString *reportingPeriods;
} ETGMpRegionRelationships;

extern const struct ETGMpRegionFetchedProperties {
} ETGMpRegionFetchedProperties;

@class ETGMpCluster;
@class ETGMpProject;
@class ETGReportingPeriod;




@interface ETGMpRegionID : NSManagedObjectID {}
@end

@interface _ETGMpRegion : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMpRegionID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* clusters;

- (NSMutableSet*)clustersSet;




@property (nonatomic, strong) NSSet* projects;

- (NSMutableSet*)projectsSet;




@property (nonatomic, strong) NSSet* reportingPeriods;

- (NSMutableSet*)reportingPeriodsSet;





@end

@interface _ETGMpRegion (CoreDataGeneratedAccessors)

- (void)addClusters:(NSSet*)value_;
- (void)removeClusters:(NSSet*)value_;
- (void)addClustersObject:(ETGMpCluster*)value_;
- (void)removeClustersObject:(ETGMpCluster*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(ETGMpProject*)value_;
- (void)removeProjectsObject:(ETGMpProject*)value_;

- (void)addReportingPeriods:(NSSet*)value_;
- (void)removeReportingPeriods:(NSSet*)value_;
- (void)addReportingPeriodsObject:(ETGReportingPeriod*)value_;
- (void)removeReportingPeriodsObject:(ETGReportingPeriod*)value_;

@end

@interface _ETGMpRegion (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveClusters;
- (void)setPrimitiveClusters:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveReportingPeriods;
- (void)setPrimitiveReportingPeriods:(NSMutableSet*)value;


@end
