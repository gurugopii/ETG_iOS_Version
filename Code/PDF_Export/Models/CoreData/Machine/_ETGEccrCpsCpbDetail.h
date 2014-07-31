// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsCpbDetail.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpsCpbDetailAttributes {
	__unsafe_unretained NSString *activityID;
	__unsafe_unretained NSString *activityKey;
	__unsafe_unretained NSString *activityName;
	__unsafe_unretained NSString *costItemKey;
	__unsafe_unretained NSString *costItemame;
	__unsafe_unretained NSString *cpbAmt;
	__unsafe_unretained NSString *facilityKey;
	__unsafe_unretained NSString *facilityName;
	__unsafe_unretained NSString *gInd;
	__unsafe_unretained NSString *latestCPBAmt;
	__unsafe_unretained NSString *pInd;
	__unsafe_unretained NSString *sequence;
	__unsafe_unretained NSString *structureKey;
	__unsafe_unretained NSString *structureName;
	__unsafe_unretained NSString *variance;
	__unsafe_unretained NSString *yep;
	__unsafe_unretained NSString *ytdActual;
	__unsafe_unretained NSString *ytdPlan;
} ETGEccrCpsCpbDetailAttributes;

extern const struct ETGEccrCpsCpbDetailRelationships {
	__unsafe_unretained NSString *cpbForCapex;
	__unsafe_unretained NSString *cpbForOpex;
} ETGEccrCpsCpbDetailRelationships;

extern const struct ETGEccrCpsCpbDetailFetchedProperties {
} ETGEccrCpsCpbDetailFetchedProperties;

@class ETGEccrCpsCpb;
@class ETGEccrCpsCpb;




















@interface ETGEccrCpsCpbDetailID : NSManagedObjectID {}
@end

@interface _ETGEccrCpsCpbDetail : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpsCpbDetailID*)objectID;




@property (nonatomic, strong) NSNumber* activityID;


@property int32_t activityIDValue;
- (int32_t)activityIDValue;
- (void)setActivityIDValue:(int32_t)value_;

//- (BOOL)validateActivityID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* activityKey;


@property int32_t activityKeyValue;
- (int32_t)activityKeyValue;
- (void)setActivityKeyValue:(int32_t)value_;

//- (BOOL)validateActivityKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* activityName;


//- (BOOL)validateActivityName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* costItemKey;


@property int32_t costItemKeyValue;
- (int32_t)costItemKeyValue;
- (void)setCostItemKeyValue:(int32_t)value_;

//- (BOOL)validateCostItemKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* costItemame;


//- (BOOL)validateCostItemame:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* cpbAmt;


//- (BOOL)validateCpbAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* facilityKey;


@property int32_t facilityKeyValue;
- (int32_t)facilityKeyValue;
- (void)setFacilityKeyValue:(int32_t)value_;

//- (BOOL)validateFacilityKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* facilityName;


//- (BOOL)validateFacilityName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* gInd;


//- (BOOL)validateGInd:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* latestCPBAmt;


//- (BOOL)validateLatestCPBAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* pInd;


//- (BOOL)validatePInd:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* sequence;


@property int32_t sequenceValue;
- (int32_t)sequenceValue;
- (void)setSequenceValue:(int32_t)value_;

//- (BOOL)validateSequence:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* structureKey;


@property int32_t structureKeyValue;
- (int32_t)structureKeyValue;
- (void)setStructureKeyValue:(int32_t)value_;

//- (BOOL)validateStructureKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* structureName;


//- (BOOL)validateStructureName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* variance;


//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* yep;


//- (BOOL)validateYep:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* ytdActual;


//- (BOOL)validateYtdActual:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* ytdPlan;


//- (BOOL)validateYtdPlan:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGEccrCpsCpb* cpbForCapex;

//- (BOOL)validateCpbForCapex:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsCpb* cpbForOpex;

//- (BOOL)validateCpbForOpex:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGEccrCpsCpbDetail (CoreDataGeneratedAccessors)

@end

@interface _ETGEccrCpsCpbDetail (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveActivityID;
- (void)setPrimitiveActivityID:(NSNumber*)value;

- (int32_t)primitiveActivityIDValue;
- (void)setPrimitiveActivityIDValue:(int32_t)value_;




- (NSNumber*)primitiveActivityKey;
- (void)setPrimitiveActivityKey:(NSNumber*)value;

- (int32_t)primitiveActivityKeyValue;
- (void)setPrimitiveActivityKeyValue:(int32_t)value_;




- (NSString*)primitiveActivityName;
- (void)setPrimitiveActivityName:(NSString*)value;




- (NSNumber*)primitiveCostItemKey;
- (void)setPrimitiveCostItemKey:(NSNumber*)value;

- (int32_t)primitiveCostItemKeyValue;
- (void)setPrimitiveCostItemKeyValue:(int32_t)value_;




- (NSString*)primitiveCostItemame;
- (void)setPrimitiveCostItemame:(NSString*)value;




- (NSDecimalNumber*)primitiveCpbAmt;
- (void)setPrimitiveCpbAmt:(NSDecimalNumber*)value;




- (NSNumber*)primitiveFacilityKey;
- (void)setPrimitiveFacilityKey:(NSNumber*)value;

- (int32_t)primitiveFacilityKeyValue;
- (void)setPrimitiveFacilityKeyValue:(int32_t)value_;




- (NSString*)primitiveFacilityName;
- (void)setPrimitiveFacilityName:(NSString*)value;




- (NSString*)primitiveGInd;
- (void)setPrimitiveGInd:(NSString*)value;




- (NSDecimalNumber*)primitiveLatestCPBAmt;
- (void)setPrimitiveLatestCPBAmt:(NSDecimalNumber*)value;




- (NSString*)primitivePInd;
- (void)setPrimitivePInd:(NSString*)value;




- (NSNumber*)primitiveSequence;
- (void)setPrimitiveSequence:(NSNumber*)value;

- (int32_t)primitiveSequenceValue;
- (void)setPrimitiveSequenceValue:(int32_t)value_;




- (NSNumber*)primitiveStructureKey;
- (void)setPrimitiveStructureKey:(NSNumber*)value;

- (int32_t)primitiveStructureKeyValue;
- (void)setPrimitiveStructureKeyValue:(int32_t)value_;




- (NSString*)primitiveStructureName;
- (void)setPrimitiveStructureName:(NSString*)value;




- (NSDecimalNumber*)primitiveVariance;
- (void)setPrimitiveVariance:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveYep;
- (void)setPrimitiveYep:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveYtdActual;
- (void)setPrimitiveYtdActual:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveYtdPlan;
- (void)setPrimitiveYtdPlan:(NSDecimalNumber*)value;





- (ETGEccrCpsCpb*)primitiveCpbForCapex;
- (void)setPrimitiveCpbForCapex:(ETGEccrCpsCpb*)value;



- (ETGEccrCpsCpb*)primitiveCpbForOpex;
- (void)setPrimitiveCpbForOpex:(ETGEccrCpsCpb*)value;


@end
