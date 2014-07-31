// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMapsPEM.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMapsPEMAttributes {
	__unsafe_unretained NSString *exedifferentMM;
	__unsafe_unretained NSString *fdpdifferentMM;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *projectName;
	__unsafe_unretained NSString *psc;
	__unsafe_unretained NSString *pscKey;
	__unsafe_unretained NSString *region;
	__unsafe_unretained NSString *regionKey;
	__unsafe_unretained NSString *riskCategory;
	__unsafe_unretained NSString *riskCategoryKey;
	__unsafe_unretained NSString *status;
	__unsafe_unretained NSString *statusKey;
} ETGMapsPEMAttributes;

extern const struct ETGMapsPEMRelationships {
	__unsafe_unretained NSString *etgMap;
} ETGMapsPEMRelationships;

extern const struct ETGMapsPEMFetchedProperties {
} ETGMapsPEMFetchedProperties;

@class ETGMap;















@interface ETGMapsPEMID : NSManagedObjectID {}
@end

@interface _ETGMapsPEM : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMapsPEMID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* exedifferentMM;


//- (BOOL)validateExedifferentMM:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* fdpdifferentMM;


//- (BOOL)validateFdpdifferentMM:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectName;


//- (BOOL)validateProjectName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* psc;


//- (BOOL)validatePsc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* pscKey;


@property int32_t pscKeyValue;
- (int32_t)pscKeyValue;
- (void)setPscKeyValue:(int32_t)value_;

//- (BOOL)validatePscKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* region;


//- (BOOL)validateRegion:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* regionKey;


@property int32_t regionKeyValue;
- (int32_t)regionKeyValue;
- (void)setRegionKeyValue:(int32_t)value_;

//- (BOOL)validateRegionKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* riskCategory;


//- (BOOL)validateRiskCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* riskCategoryKey;


@property int32_t riskCategoryKeyValue;
- (int32_t)riskCategoryKeyValue;
- (void)setRiskCategoryKeyValue:(int32_t)value_;

//- (BOOL)validateRiskCategoryKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* status;


//- (BOOL)validateStatus:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* statusKey;


@property int32_t statusKeyValue;
- (int32_t)statusKeyValue;
- (void)setStatusKeyValue:(int32_t)value_;

//- (BOOL)validateStatusKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGMap* etgMap;

//- (BOOL)validateEtgMap:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGMapsPEM (CoreDataGeneratedAccessors)

@end

@interface _ETGMapsPEM (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveExedifferentMM;
- (void)setPrimitiveExedifferentMM:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveFdpdifferentMM;
- (void)setPrimitiveFdpdifferentMM:(NSDecimalNumber*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSString*)primitiveProjectName;
- (void)setPrimitiveProjectName:(NSString*)value;




- (NSString*)primitivePsc;
- (void)setPrimitivePsc:(NSString*)value;




- (NSNumber*)primitivePscKey;
- (void)setPrimitivePscKey:(NSNumber*)value;

- (int32_t)primitivePscKeyValue;
- (void)setPrimitivePscKeyValue:(int32_t)value_;




- (NSString*)primitiveRegion;
- (void)setPrimitiveRegion:(NSString*)value;




- (NSNumber*)primitiveRegionKey;
- (void)setPrimitiveRegionKey:(NSNumber*)value;

- (int32_t)primitiveRegionKeyValue;
- (void)setPrimitiveRegionKeyValue:(int32_t)value_;




- (NSString*)primitiveRiskCategory;
- (void)setPrimitiveRiskCategory:(NSString*)value;




- (NSNumber*)primitiveRiskCategoryKey;
- (void)setPrimitiveRiskCategoryKey:(NSNumber*)value;

- (int32_t)primitiveRiskCategoryKeyValue;
- (void)setPrimitiveRiskCategoryKeyValue:(int32_t)value_;




- (NSString*)primitiveStatus;
- (void)setPrimitiveStatus:(NSString*)value;




- (NSNumber*)primitiveStatusKey;
- (void)setPrimitiveStatusKey:(NSNumber*)value;

- (int32_t)primitiveStatusKeyValue;
- (void)setPrimitiveStatusKeyValue:(int32_t)value_;





- (ETGMap*)primitiveEtgMap;
- (void)setPrimitiveEtgMap:(ETGMap*)value;


@end
