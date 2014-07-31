// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCountries.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGCountriesAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGCountriesAttributes;

extern const struct ETGCountriesRelationships {
	__unsafe_unretained NSString *regions;
	__unsafe_unretained NSString *reportingPeriods;
} ETGCountriesRelationships;

extern const struct ETGCountriesFetchedProperties {
} ETGCountriesFetchedProperties;

@class ETGRegion;
@class ETGReportingPeriod;




@interface ETGCountriesID : NSManagedObjectID {}
@end

@interface _ETGCountries : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGCountriesID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* regions;

- (NSMutableSet*)regionsSet;




@property (nonatomic, strong) NSSet* reportingPeriods;

- (NSMutableSet*)reportingPeriodsSet;





@end

@interface _ETGCountries (CoreDataGeneratedAccessors)

- (void)addRegions:(NSSet*)value_;
- (void)removeRegions:(NSSet*)value_;
- (void)addRegionsObject:(ETGRegion*)value_;
- (void)removeRegionsObject:(ETGRegion*)value_;

- (void)addReportingPeriods:(NSSet*)value_;
- (void)removeReportingPeriods:(NSSet*)value_;
- (void)addReportingPeriodsObject:(ETGReportingPeriod*)value_;
- (void)removeReportingPeriodsObject:(ETGReportingPeriod*)value_;

@end

@interface _ETGCountries (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveRegions;
- (void)setPrimitiveRegions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveReportingPeriods;
- (void)setPrimitiveReportingPeriods:(NSMutableSet*)value;


@end
