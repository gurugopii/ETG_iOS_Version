// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProject_ProjPosition.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGProject_ProjPositionAttributes {
	__unsafe_unretained NSString *filterName;
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *reportingPeriod;
} ETGProject_ProjPositionAttributes;

extern const struct ETGProject_ProjPositionRelationships {
	__unsafe_unretained NSString *projectPositions;
} ETGProject_ProjPositionRelationships;

extern const struct ETGProject_ProjPositionFetchedProperties {
} ETGProject_ProjPositionFetchedProperties;

@class ETGProjectPosition;





@interface ETGProject_ProjPositionID : NSManagedObjectID {}
@end

@interface _ETGProject_ProjPosition : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGProject_ProjPositionID*)objectID;




@property (nonatomic, strong) NSString* filterName;


//- (BOOL)validateFilterName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* reportingPeriod;


//- (BOOL)validateReportingPeriod:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* projectPositions;

- (NSMutableSet*)projectPositionsSet;





@end

@interface _ETGProject_ProjPosition (CoreDataGeneratedAccessors)

- (void)addProjectPositions:(NSSet*)value_;
- (void)removeProjectPositions:(NSSet*)value_;
- (void)addProjectPositionsObject:(ETGProjectPosition*)value_;
- (void)removeProjectPositionsObject:(ETGProjectPosition*)value_;

@end

@interface _ETGProject_ProjPosition (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveFilterName;
- (void)setPrimitiveFilterName:(NSString*)value;




- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSDate*)primitiveReportingPeriod;
- (void)setPrimitiveReportingPeriod:(NSDate*)value;





- (NSMutableSet*)primitiveProjectPositions;
- (void)setPrimitiveProjectPositions:(NSMutableSet*)value;


@end
