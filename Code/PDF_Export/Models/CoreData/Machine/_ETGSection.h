// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGSection.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGSectionAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGSectionAttributes;

extern const struct ETGSectionRelationships {
	__unsafe_unretained NSString *department;
	__unsafe_unretained NSString *departmentSection;
	__unsafe_unretained NSString *reportingPeriods;
} ETGSectionRelationships;

extern const struct ETGSectionFetchedProperties {
} ETGSectionFetchedProperties;

@class NSManagedObject;
@class NSManagedObject;
@class ETGReportingPeriod;




@interface ETGSectionID : NSManagedObjectID {}
@end

@interface _ETGSection : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGSectionID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* department;

- (NSMutableSet*)departmentSet;




@property (nonatomic, strong) NSSet* departmentSection;

- (NSMutableSet*)departmentSectionSet;




@property (nonatomic, strong) NSSet* reportingPeriods;

- (NSMutableSet*)reportingPeriodsSet;





@end

@interface _ETGSection (CoreDataGeneratedAccessors)

- (void)addDepartment:(NSSet*)value_;
- (void)removeDepartment:(NSSet*)value_;
- (void)addDepartmentObject:(NSManagedObject*)value_;
- (void)removeDepartmentObject:(NSManagedObject*)value_;

- (void)addDepartmentSection:(NSSet*)value_;
- (void)removeDepartmentSection:(NSSet*)value_;
- (void)addDepartmentSectionObject:(NSManagedObject*)value_;
- (void)removeDepartmentSectionObject:(NSManagedObject*)value_;

- (void)addReportingPeriods:(NSSet*)value_;
- (void)removeReportingPeriods:(NSSet*)value_;
- (void)addReportingPeriodsObject:(ETGReportingPeriod*)value_;
- (void)removeReportingPeriodsObject:(ETGReportingPeriod*)value_;

@end

@interface _ETGSection (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveDepartment;
- (void)setPrimitiveDepartment:(NSMutableSet*)value;



- (NSMutableSet*)primitiveDepartmentSection;
- (void)setPrimitiveDepartmentSection:(NSMutableSet*)value;



- (NSMutableSet*)primitiveReportingPeriods;
- (void)setPrimitiveReportingPeriods:(NSMutableSet*)value;


@end
