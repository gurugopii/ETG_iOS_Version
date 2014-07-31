// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsWpbDetail.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpsWpbDetailAttributes {
	__unsafe_unretained NSString *activityKey;
	__unsafe_unretained NSString *activityName;
	__unsafe_unretained NSString *approvedABR;
	__unsafe_unretained NSString *approvedCO;
	__unsafe_unretained NSString *budgetItemKey;
	__unsafe_unretained NSString *budgetItemName;
	__unsafe_unretained NSString *currentMonthYEP;
	__unsafe_unretained NSString *currentMonthYTDActual;
	__unsafe_unretained NSString *gInd;
	__unsafe_unretained NSString *latestWPB;
	__unsafe_unretained NSString *originalWPB;
	__unsafe_unretained NSString *sequence;
	__unsafe_unretained NSString *structureKey;
	__unsafe_unretained NSString *structureName;
	__unsafe_unretained NSString *variance;
	__unsafe_unretained NSString *wbsId;
	__unsafe_unretained NSString *wbsKey;
} ETGEccrCpsWpbDetailAttributes;

extern const struct ETGEccrCpsWpbDetailRelationships {
	__unsafe_unretained NSString *wpbForCapex;
	__unsafe_unretained NSString *wpbForOpex;
} ETGEccrCpsWpbDetailRelationships;

extern const struct ETGEccrCpsWpbDetailFetchedProperties {
} ETGEccrCpsWpbDetailFetchedProperties;

@class ETGEccrCpsWpb;
@class ETGEccrCpsWpb;



















@interface ETGEccrCpsWpbDetailID : NSManagedObjectID {}
@end

@interface _ETGEccrCpsWpbDetail : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpsWpbDetailID*)objectID;




@property (nonatomic, strong) NSNumber* activityKey;


@property int32_t activityKeyValue;
- (int32_t)activityKeyValue;
- (void)setActivityKeyValue:(int32_t)value_;

//- (BOOL)validateActivityKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* activityName;


//- (BOOL)validateActivityName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* approvedABR;


//- (BOOL)validateApprovedABR:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* approvedCO;


//- (BOOL)validateApprovedCO:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* budgetItemKey;


@property int32_t budgetItemKeyValue;
- (int32_t)budgetItemKeyValue;
- (void)setBudgetItemKeyValue:(int32_t)value_;

//- (BOOL)validateBudgetItemKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* budgetItemName;


//- (BOOL)validateBudgetItemName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* currentMonthYEP;


//- (BOOL)validateCurrentMonthYEP:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* currentMonthYTDActual;


//- (BOOL)validateCurrentMonthYTDActual:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* gInd;


//- (BOOL)validateGInd:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* latestWPB;


//- (BOOL)validateLatestWPB:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* originalWPB;


//- (BOOL)validateOriginalWPB:(id*)value_ error:(NSError**)error_;




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




@property (nonatomic, strong) NSString* wbsId;


//- (BOOL)validateWbsId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* wbsKey;


@property int32_t wbsKeyValue;
- (int32_t)wbsKeyValue;
- (void)setWbsKeyValue:(int32_t)value_;

//- (BOOL)validateWbsKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGEccrCpsWpb* wpbForCapex;

//- (BOOL)validateWpbForCapex:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsWpb* wpbForOpex;

//- (BOOL)validateWpbForOpex:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGEccrCpsWpbDetail (CoreDataGeneratedAccessors)

@end

@interface _ETGEccrCpsWpbDetail (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveActivityKey;
- (void)setPrimitiveActivityKey:(NSNumber*)value;

- (int32_t)primitiveActivityKeyValue;
- (void)setPrimitiveActivityKeyValue:(int32_t)value_;




- (NSString*)primitiveActivityName;
- (void)setPrimitiveActivityName:(NSString*)value;




- (NSDecimalNumber*)primitiveApprovedABR;
- (void)setPrimitiveApprovedABR:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveApprovedCO;
- (void)setPrimitiveApprovedCO:(NSDecimalNumber*)value;




- (NSNumber*)primitiveBudgetItemKey;
- (void)setPrimitiveBudgetItemKey:(NSNumber*)value;

- (int32_t)primitiveBudgetItemKeyValue;
- (void)setPrimitiveBudgetItemKeyValue:(int32_t)value_;




- (NSString*)primitiveBudgetItemName;
- (void)setPrimitiveBudgetItemName:(NSString*)value;




- (NSDecimalNumber*)primitiveCurrentMonthYEP;
- (void)setPrimitiveCurrentMonthYEP:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveCurrentMonthYTDActual;
- (void)setPrimitiveCurrentMonthYTDActual:(NSDecimalNumber*)value;




- (NSString*)primitiveGInd;
- (void)setPrimitiveGInd:(NSString*)value;




- (NSDecimalNumber*)primitiveLatestWPB;
- (void)setPrimitiveLatestWPB:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveOriginalWPB;
- (void)setPrimitiveOriginalWPB:(NSDecimalNumber*)value;




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




- (NSString*)primitiveWbsId;
- (void)setPrimitiveWbsId:(NSString*)value;




- (NSNumber*)primitiveWbsKey;
- (void)setPrimitiveWbsKey:(NSNumber*)value;

- (int32_t)primitiveWbsKeyValue;
- (void)setPrimitiveWbsKeyValue:(int32_t)value_;





- (ETGEccrCpsWpb*)primitiveWpbForCapex;
- (void)setPrimitiveWpbForCapex:(ETGEccrCpsWpb*)value;



- (ETGEccrCpsWpb*)primitiveWpbForOpex;
- (void)setPrimitiveWpbForOpex:(ETGEccrCpsWpb*)value;


@end
