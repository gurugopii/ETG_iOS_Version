// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMpProject.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMpProjectAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGMpProjectAttributes;

extern const struct ETGMpProjectRelationships {
	__unsafe_unretained NSString *cluster;
	__unsafe_unretained NSString *projectPositions;
	__unsafe_unretained NSString *region;
	__unsafe_unretained NSString *reportingPeriods;
} ETGMpProjectRelationships;

extern const struct ETGMpProjectFetchedProperties {
} ETGMpProjectFetchedProperties;

@class ETGMpCluster;
@class ETGProjectPosition;
@class ETGMpRegion;
@class ETGReportingPeriod;




@interface ETGMpProjectID : NSManagedObjectID {}
@end

@interface _ETGMpProject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMpProjectID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGMpCluster* cluster;

//- (BOOL)validateCluster:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* projectPositions;

- (NSMutableSet*)projectPositionsSet;




@property (nonatomic, strong) ETGMpRegion* region;

//- (BOOL)validateRegion:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* reportingPeriods;

- (NSMutableSet*)reportingPeriodsSet;





@end

@interface _ETGMpProject (CoreDataGeneratedAccessors)

- (void)addProjectPositions:(NSSet*)value_;
- (void)removeProjectPositions:(NSSet*)value_;
- (void)addProjectPositionsObject:(ETGProjectPosition*)value_;
- (void)removeProjectPositionsObject:(ETGProjectPosition*)value_;

- (void)addReportingPeriods:(NSSet*)value_;
- (void)removeReportingPeriods:(NSSet*)value_;
- (void)addReportingPeriodsObject:(ETGReportingPeriod*)value_;
- (void)removeReportingPeriodsObject:(ETGReportingPeriod*)value_;

@end

@interface _ETGMpProject (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (ETGMpCluster*)primitiveCluster;
- (void)setPrimitiveCluster:(ETGMpCluster*)value;



- (NSMutableSet*)primitiveProjectPositions;
- (void)setPrimitiveProjectPositions:(NSMutableSet*)value;



- (ETGMpRegion*)primitiveRegion;
- (void)setPrimitiveRegion:(ETGMpRegion*)value;



- (NSMutableSet*)primitiveReportingPeriods;
- (void)setPrimitiveReportingPeriods:(NSMutableSet*)value;


@end
