// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGDepartment.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGDepartmentAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGDepartmentAttributes;

extern const struct ETGDepartmentRelationships {
	__unsafe_unretained NSString *division;
	__unsafe_unretained NSString *reportingPeriods;
	__unsafe_unretained NSString *sections;
} ETGDepartmentRelationships;

extern const struct ETGDepartmentFetchedProperties {
} ETGDepartmentFetchedProperties;

@class ETGDivision;
@class ETGReportingPeriod;
@class ETGSection;




@interface ETGDepartmentID : NSManagedObjectID {}
@end

@interface _ETGDepartment : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGDepartmentID*)objectID;





@property (nonatomic, strong) NSNumber* key;



@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGDivision *division;

//- (BOOL)validateDivision:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *reportingPeriods;

- (NSMutableSet*)reportingPeriodsSet;




@property (nonatomic, strong) NSSet *sections;

- (NSMutableSet*)sectionsSet;





@end

@interface _ETGDepartment (CoreDataGeneratedAccessors)

- (void)addReportingPeriods:(NSSet*)value_;
- (void)removeReportingPeriods:(NSSet*)value_;
- (void)addReportingPeriodsObject:(ETGReportingPeriod*)value_;
- (void)removeReportingPeriodsObject:(ETGReportingPeriod*)value_;

- (void)addSections:(NSSet*)value_;
- (void)removeSections:(NSSet*)value_;
- (void)addSectionsObject:(ETGSection*)value_;
- (void)removeSectionsObject:(ETGSection*)value_;

@end

@interface _ETGDepartment (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (ETGDivision*)primitiveDivision;
- (void)setPrimitiveDivision:(ETGDivision*)value;



- (NSMutableSet*)primitiveReportingPeriods;
- (void)setPrimitiveReportingPeriods:(NSMutableSet*)value;



- (NSMutableSet*)primitiveSections;
- (void)setPrimitiveSections:(NSMutableSet*)value;


@end
