// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMapsPGD.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMapsPGDAttributes {
	__unsafe_unretained NSString *currentPhase;
	__unsafe_unretained NSString *duration;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *phaseName;
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *projectName;
	__unsafe_unretained NSString *psc;
	__unsafe_unretained NSString *pscKey;
	__unsafe_unretained NSString *region;
	__unsafe_unretained NSString *regionKey;
	__unsafe_unretained NSString *x;
	__unsafe_unretained NSString *y;
} ETGMapsPGDAttributes;

extern const struct ETGMapsPGDRelationships {
	__unsafe_unretained NSString *etgMap;
} ETGMapsPGDRelationships;

extern const struct ETGMapsPGDFetchedProperties {
} ETGMapsPGDFetchedProperties;

@class ETGMap;














@interface ETGMapsPGDID : NSManagedObjectID {}
@end

@interface _ETGMapsPGD : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMapsPGDID*)objectID;




@property (nonatomic, strong) NSNumber* currentPhase;


@property int32_t currentPhaseValue;
- (int32_t)currentPhaseValue;
- (void)setCurrentPhaseValue:(int32_t)value_;

//- (BOOL)validateCurrentPhase:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* duration;


//- (BOOL)validateDuration:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* phaseName;


//- (BOOL)validatePhaseName:(id*)value_ error:(NSError**)error_;




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




@property (nonatomic, strong) NSDecimalNumber* x;


//- (BOOL)validateX:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* y;


//- (BOOL)validateY:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGMap* etgMap;

//- (BOOL)validateEtgMap:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGMapsPGD (CoreDataGeneratedAccessors)

@end

@interface _ETGMapsPGD (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCurrentPhase;
- (void)setPrimitiveCurrentPhase:(NSNumber*)value;

- (int32_t)primitiveCurrentPhaseValue;
- (void)setPrimitiveCurrentPhaseValue:(int32_t)value_;




- (NSDecimalNumber*)primitiveDuration;
- (void)setPrimitiveDuration:(NSDecimalNumber*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSString*)primitivePhaseName;
- (void)setPrimitivePhaseName:(NSString*)value;




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




- (NSDecimalNumber*)primitiveX;
- (void)setPrimitiveX:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveY;
- (void)setPrimitiveY:(NSDecimalNumber*)value;





- (ETGMap*)primitiveEtgMap;
- (void)setPrimitiveEtgMap:(ETGMap*)value;


@end
