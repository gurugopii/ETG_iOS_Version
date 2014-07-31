// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProduction.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGProductionAttributes {
	__unsafe_unretained NSString *facilityName;
} ETGProductionAttributes;

extern const struct ETGProductionRelationships {
	__unsafe_unretained NSString *scorecard;
	__unsafe_unretained NSString *wellDetails;
} ETGProductionRelationships;

extern const struct ETGProductionFetchedProperties {
} ETGProductionFetchedProperties;

@class ;
@class ;



@interface ETGProductionID : NSManagedObjectID {}
@end

@interface _ETGProduction : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGProductionID*)objectID;





@property (nonatomic, strong) NSString* facilityName;



//- (BOOL)validateFacilityName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong)  *scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *wellDetails;

- (NSMutableSet*)wellDetailsSet;





@end

@interface _ETGProduction (CoreDataGeneratedAccessors)

- (void)addWellDetails:(NSSet*)value_;
- (void)removeWellDetails:(NSSet*)value_;
- (void)addWellDetailsObject:(*)value_;
- (void)removeWellDetailsObject:(*)value_;

@end

@interface _ETGProduction (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveFacilityName;
- (void)setPrimitiveFacilityName:(NSString*)value;





- (*)primitiveScorecard;
- (void)setPrimitiveScorecard:(*)value;



- (NSMutableSet*)primitiveWellDetails;
- (void)setPrimitiveWellDetails:(NSMutableSet*)value;


@end
