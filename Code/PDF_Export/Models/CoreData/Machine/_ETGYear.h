// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGYear.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGYearAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGYearAttributes;

extern const struct ETGYearRelationships {
	__unsafe_unretained NSString *reportingPeriods;
} ETGYearRelationships;

extern const struct ETGYearFetchedProperties {
} ETGYearFetchedProperties;

@class ETGReportingPeriod;




@interface ETGYearID : NSManagedObjectID {}
@end

@interface _ETGYear : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGYearID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* reportingPeriods;

- (NSMutableSet*)reportingPeriodsSet;





@end

@interface _ETGYear (CoreDataGeneratedAccessors)

- (void)addReportingPeriods:(NSSet*)value_;
- (void)removeReportingPeriods:(NSSet*)value_;
- (void)addReportingPeriodsObject:(ETGReportingPeriod*)value_;
- (void)removeReportingPeriodsObject:(ETGReportingPeriod*)value_;

@end

@interface _ETGYear (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveReportingPeriods;
- (void)setPrimitiveReportingPeriods:(NSMutableSet*)value;


@end
