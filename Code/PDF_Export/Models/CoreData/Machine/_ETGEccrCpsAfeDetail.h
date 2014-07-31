// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsAfeDetail.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpsAfeDetailAttributes {
	__unsafe_unretained NSString *afcAmt;
	__unsafe_unretained NSString *afeId;
	__unsafe_unretained NSString *afeKey;
	__unsafe_unretained NSString *cumVowdAmt;
	__unsafe_unretained NSString *gInd;
	__unsafe_unretained NSString *latestAfeAmt;
	__unsafe_unretained NSString *originalAfeAmt;
	__unsafe_unretained NSString *sequence;
	__unsafe_unretained NSString *variance;
	__unsafe_unretained NSString *wbsId;
	__unsafe_unretained NSString *wbsKey;
} ETGEccrCpsAfeDetailAttributes;

extern const struct ETGEccrCpsAfeDetailRelationships {
	__unsafe_unretained NSString *afeForCapex;
	__unsafe_unretained NSString *afeForOpex;
} ETGEccrCpsAfeDetailRelationships;

extern const struct ETGEccrCpsAfeDetailFetchedProperties {
} ETGEccrCpsAfeDetailFetchedProperties;

@class ETGEccrCpsAfe;
@class ETGEccrCpsAfe;













@interface ETGEccrCpsAfeDetailID : NSManagedObjectID {}
@end

@interface _ETGEccrCpsAfeDetail : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpsAfeDetailID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* afcAmt;


//- (BOOL)validateAfcAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* afeId;


//- (BOOL)validateAfeId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* afeKey;


@property int32_t afeKeyValue;
- (int32_t)afeKeyValue;
- (void)setAfeKeyValue:(int32_t)value_;

//- (BOOL)validateAfeKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* cumVowdAmt;


//- (BOOL)validateCumVowdAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* gInd;


//- (BOOL)validateGInd:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* latestAfeAmt;


//- (BOOL)validateLatestAfeAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* originalAfeAmt;


//- (BOOL)validateOriginalAfeAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* sequence;


@property int32_t sequenceValue;
- (int32_t)sequenceValue;
- (void)setSequenceValue:(int32_t)value_;

//- (BOOL)validateSequence:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* variance;


//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* wbsId;


//- (BOOL)validateWbsId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* wbsKey;


@property int32_t wbsKeyValue;
- (int32_t)wbsKeyValue;
- (void)setWbsKeyValue:(int32_t)value_;

//- (BOOL)validateWbsKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGEccrCpsAfe* afeForCapex;

//- (BOOL)validateAfeForCapex:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsAfe* afeForOpex;

//- (BOOL)validateAfeForOpex:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGEccrCpsAfeDetail (CoreDataGeneratedAccessors)

@end

@interface _ETGEccrCpsAfeDetail (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveAfcAmt;
- (void)setPrimitiveAfcAmt:(NSDecimalNumber*)value;




- (NSString*)primitiveAfeId;
- (void)setPrimitiveAfeId:(NSString*)value;




- (NSNumber*)primitiveAfeKey;
- (void)setPrimitiveAfeKey:(NSNumber*)value;

- (int32_t)primitiveAfeKeyValue;
- (void)setPrimitiveAfeKeyValue:(int32_t)value_;




- (NSDecimalNumber*)primitiveCumVowdAmt;
- (void)setPrimitiveCumVowdAmt:(NSDecimalNumber*)value;




- (NSString*)primitiveGInd;
- (void)setPrimitiveGInd:(NSString*)value;




- (NSDecimalNumber*)primitiveLatestAfeAmt;
- (void)setPrimitiveLatestAfeAmt:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveOriginalAfeAmt;
- (void)setPrimitiveOriginalAfeAmt:(NSDecimalNumber*)value;




- (NSNumber*)primitiveSequence;
- (void)setPrimitiveSequence:(NSNumber*)value;

- (int32_t)primitiveSequenceValue;
- (void)setPrimitiveSequenceValue:(int32_t)value_;




- (NSDecimalNumber*)primitiveVariance;
- (void)setPrimitiveVariance:(NSDecimalNumber*)value;




- (NSString*)primitiveWbsId;
- (void)setPrimitiveWbsId:(NSString*)value;




- (NSNumber*)primitiveWbsKey;
- (void)setPrimitiveWbsKey:(NSNumber*)value;

- (int32_t)primitiveWbsKeyValue;
- (void)setPrimitiveWbsKeyValue:(int32_t)value_;





- (ETGEccrCpsAfe*)primitiveAfeForCapex;
- (void)setPrimitiveAfeForCapex:(ETGEccrCpsAfe*)value;



- (ETGEccrCpsAfe*)primitiveAfeForOpex;
- (void)setPrimitiveAfeForOpex:(ETGEccrCpsAfe*)value;


@end
