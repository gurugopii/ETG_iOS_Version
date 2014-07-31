// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGDivision.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGDivisionAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGDivisionAttributes;

extern const struct ETGDivisionRelationships {
	__unsafe_unretained NSString *departments;
	__unsafe_unretained NSString *reportingPeriods;
} ETGDivisionRelationships;

extern const struct ETGDivisionFetchedProperties {
} ETGDivisionFetchedProperties;

@class ETGDepartment;
@class ETGReportingPeriod;




@interface ETGDivisionID : NSManagedObjectID {}
@end

@interface _ETGDivision : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGDivisionID*)objectID;





@property (nonatomic, strong) NSNumber* key;



@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *departments;

- (NSMutableSet*)departmentsSet;




@property (nonatomic, strong) NSSet *reportingPeriods;

- (NSMutableSet*)reportingPeriodsSet;





@end

@interface _ETGDivision (CoreDataGeneratedAccessors)

- (void)addDepartments:(NSSet*)value_;
- (void)removeDepartments:(NSSet*)value_;
- (void)addDepartmentsObject:(ETGDepartment*)value_;
- (void)removeDepartmentsObject:(ETGDepartment*)value_;

- (void)addReportingPeriods:(NSSet*)value_;
- (void)removeReportingPeriods:(NSSet*)value_;
- (void)addReportingPeriodsObject:(ETGReportingPeriod*)value_;
- (void)removeReportingPeriodsObject:(ETGReportingPeriod*)value_;

@end

@interface _ETGDivision (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveDepartments;
- (void)setPrimitiveDepartments:(NSMutableSet*)value;



- (NSMutableSet*)primitiveReportingPeriods;
- (void)setPrimitiveReportingPeriods:(NSMutableSet*)value;


@end
