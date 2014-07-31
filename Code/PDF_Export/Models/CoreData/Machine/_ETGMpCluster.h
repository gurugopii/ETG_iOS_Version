// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMpCluster.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMpClusterAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGMpClusterAttributes;

extern const struct ETGMpClusterRelationships {
	__unsafe_unretained NSString *projectPositions;
	__unsafe_unretained NSString *projects;
	__unsafe_unretained NSString *regions;
	__unsafe_unretained NSString *reportingPeriods;
} ETGMpClusterRelationships;

extern const struct ETGMpClusterFetchedProperties {
} ETGMpClusterFetchedProperties;

@class ETGProjectPosition;
@class ETGMpProject;
@class ETGMpRegion;
@class ETGReportingPeriod;




@interface ETGMpClusterID : NSManagedObjectID {}
@end

@interface _ETGMpCluster : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMpClusterID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* projectPositions;

- (NSMutableSet*)projectPositionsSet;




@property (nonatomic, strong) NSSet* projects;

- (NSMutableSet*)projectsSet;




@property (nonatomic, strong) NSSet* regions;

- (NSMutableSet*)regionsSet;




@property (nonatomic, strong) NSSet* reportingPeriods;

- (NSMutableSet*)reportingPeriodsSet;





@end

@interface _ETGMpCluster (CoreDataGeneratedAccessors)

- (void)addProjectPositions:(NSSet*)value_;
- (void)removeProjectPositions:(NSSet*)value_;
- (void)addProjectPositionsObject:(ETGProjectPosition*)value_;
- (void)removeProjectPositionsObject:(ETGProjectPosition*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(ETGMpProject*)value_;
- (void)removeProjectsObject:(ETGMpProject*)value_;

- (void)addRegions:(NSSet*)value_;
- (void)removeRegions:(NSSet*)value_;
- (void)addRegionsObject:(ETGMpRegion*)value_;
- (void)removeRegionsObject:(ETGMpRegion*)value_;

- (void)addReportingPeriods:(NSSet*)value_;
- (void)removeReportingPeriods:(NSSet*)value_;
- (void)addReportingPeriodsObject:(ETGReportingPeriod*)value_;
- (void)removeReportingPeriodsObject:(ETGReportingPeriod*)value_;

@end

@interface _ETGMpCluster (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveProjectPositions;
- (void)setPrimitiveProjectPositions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveRegions;
- (void)setPrimitiveRegions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveReportingPeriods;
- (void)setPrimitiveReportingPeriods:(NSMutableSet*)value;


@end
