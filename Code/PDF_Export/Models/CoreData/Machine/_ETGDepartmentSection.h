// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGDepartmentSection.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGDepartmentSectionAttributes {
	__unsafe_unretained NSString *filterName;
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *reportingPeriod;
} ETGDepartmentSectionAttributes;

extern const struct ETGDepartmentSectionRelationships {
	__unsafe_unretained NSString *sections;
} ETGDepartmentSectionRelationships;

extern const struct ETGDepartmentSectionFetchedProperties {
} ETGDepartmentSectionFetchedProperties;

@class ETGSection;





@interface ETGDepartmentSectionID : NSManagedObjectID {}
@end

@interface _ETGDepartmentSection : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGDepartmentSectionID*)objectID;





@property (nonatomic, strong) NSString* filterName;



//- (BOOL)validateFilterName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* key;



@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* reportingPeriod;



//- (BOOL)validateReportingPeriod:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *sections;

- (NSMutableSet*)sectionsSet;





@end

@interface _ETGDepartmentSection (CoreDataGeneratedAccessors)

- (void)addSections:(NSSet*)value_;
- (void)removeSections:(NSSet*)value_;
- (void)addSectionsObject:(ETGSection*)value_;
- (void)removeSectionsObject:(ETGSection*)value_;

@end

@interface _ETGDepartmentSection (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveFilterName;
- (void)setPrimitiveFilterName:(NSString*)value;




- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSDate*)primitiveReportingPeriod;
- (void)setPrimitiveReportingPeriod:(NSDate*)value;





- (NSMutableSet*)primitiveSections;
- (void)setPrimitiveSections:(NSMutableSet*)value;


@end
