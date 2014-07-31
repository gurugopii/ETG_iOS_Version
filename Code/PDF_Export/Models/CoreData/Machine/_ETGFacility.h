// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGFacility.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGFacilityAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *reportMonth;
} ETGFacilityAttributes;

extern const struct ETGFacilityRelationships {
	__unsafe_unretained NSString *scorecard;
	__unsafe_unretained NSString *wellDetails;
} ETGFacilityRelationships;

extern const struct ETGFacilityFetchedProperties {
} ETGFacilityFetchedProperties;

@class ETGScorecard;
@class ETGWellDetails;





@interface ETGFacilityID : NSManagedObjectID {}
@end

@interface _ETGFacility : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGFacilityID*)objectID;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* reportMonth;


//- (BOOL)validateReportMonth:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* wellDetails;

- (NSMutableSet*)wellDetailsSet;





@end

@interface _ETGFacility (CoreDataGeneratedAccessors)

- (void)addWellDetails:(NSSet*)value_;
- (void)removeWellDetails:(NSSet*)value_;
- (void)addWellDetailsObject:(ETGWellDetails*)value_;
- (void)removeWellDetailsObject:(ETGWellDetails*)value_;

@end

@interface _ETGFacility (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSDate*)primitiveReportMonth;
- (void)setPrimitiveReportMonth:(NSDate*)value;





- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;



- (NSMutableSet*)primitiveWellDetails;
- (void)setPrimitiveWellDetails:(NSMutableSet*)value;


@end
