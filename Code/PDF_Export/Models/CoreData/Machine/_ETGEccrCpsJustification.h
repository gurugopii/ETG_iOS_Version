// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsJustification.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpsJustificationAttributes {
	__unsafe_unretained NSString *activityKey;
	__unsafe_unretained NSString *activityName;
	__unsafe_unretained NSString *budgetItemKey;
	__unsafe_unretained NSString *budgetItemName;
	__unsafe_unretained NSString *justificationDesc;
	__unsafe_unretained NSString *structureKey;
	__unsafe_unretained NSString *structureName;
	__unsafe_unretained NSString *varianceAmt;
	__unsafe_unretained NSString *varianceReasonName;
} ETGEccrCpsJustificationAttributes;

extern const struct ETGEccrCpsJustificationRelationships {
	__unsafe_unretained NSString *apc;
	__unsafe_unretained NSString *cpb;
	__unsafe_unretained NSString *fdp;
	__unsafe_unretained NSString *wpb;
} ETGEccrCpsJustificationRelationships;

extern const struct ETGEccrCpsJustificationFetchedProperties {
} ETGEccrCpsJustificationFetchedProperties;

@class ETGEccrCpsApc;
@class ETGEccrCpsCpb;
@class ETGEccrCpsFdp;
@class ETGEccrCpsWpb;











@interface ETGEccrCpsJustificationID : NSManagedObjectID {}
@end

@interface _ETGEccrCpsJustification : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpsJustificationID*)objectID;




@property (nonatomic, strong) NSNumber* activityKey;


@property int32_t activityKeyValue;
- (int32_t)activityKeyValue;
- (void)setActivityKeyValue:(int32_t)value_;

//- (BOOL)validateActivityKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* activityName;


//- (BOOL)validateActivityName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* budgetItemKey;


@property int32_t budgetItemKeyValue;
- (int32_t)budgetItemKeyValue;
- (void)setBudgetItemKeyValue:(int32_t)value_;

//- (BOOL)validateBudgetItemKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* budgetItemName;


//- (BOOL)validateBudgetItemName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* justificationDesc;


//- (BOOL)validateJustificationDesc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* structureKey;


@property int32_t structureKeyValue;
- (int32_t)structureKeyValue;
- (void)setStructureKeyValue:(int32_t)value_;

//- (BOOL)validateStructureKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* structureName;


//- (BOOL)validateStructureName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* varianceAmt;


//- (BOOL)validateVarianceAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* varianceReasonName;


//- (BOOL)validateVarianceReasonName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGEccrCpsApc* apc;

//- (BOOL)validateApc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsCpb* cpb;

//- (BOOL)validateCpb:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsFdp* fdp;

//- (BOOL)validateFdp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsWpb* wpb;

//- (BOOL)validateWpb:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGEccrCpsJustification (CoreDataGeneratedAccessors)

@end

@interface _ETGEccrCpsJustification (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveActivityKey;
- (void)setPrimitiveActivityKey:(NSNumber*)value;

- (int32_t)primitiveActivityKeyValue;
- (void)setPrimitiveActivityKeyValue:(int32_t)value_;




- (NSString*)primitiveActivityName;
- (void)setPrimitiveActivityName:(NSString*)value;




- (NSNumber*)primitiveBudgetItemKey;
- (void)setPrimitiveBudgetItemKey:(NSNumber*)value;

- (int32_t)primitiveBudgetItemKeyValue;
- (void)setPrimitiveBudgetItemKeyValue:(int32_t)value_;




- (NSString*)primitiveBudgetItemName;
- (void)setPrimitiveBudgetItemName:(NSString*)value;




- (NSString*)primitiveJustificationDesc;
- (void)setPrimitiveJustificationDesc:(NSString*)value;




- (NSNumber*)primitiveStructureKey;
- (void)setPrimitiveStructureKey:(NSNumber*)value;

- (int32_t)primitiveStructureKeyValue;
- (void)setPrimitiveStructureKeyValue:(int32_t)value_;




- (NSString*)primitiveStructureName;
- (void)setPrimitiveStructureName:(NSString*)value;




- (NSDecimalNumber*)primitiveVarianceAmt;
- (void)setPrimitiveVarianceAmt:(NSDecimalNumber*)value;




- (NSString*)primitiveVarianceReasonName;
- (void)setPrimitiveVarianceReasonName:(NSString*)value;





- (ETGEccrCpsApc*)primitiveApc;
- (void)setPrimitiveApc:(ETGEccrCpsApc*)value;



- (ETGEccrCpsCpb*)primitiveCpb;
- (void)setPrimitiveCpb:(ETGEccrCpsCpb*)value;



- (ETGEccrCpsFdp*)primitiveFdp;
- (void)setPrimitiveFdp:(ETGEccrCpsFdp*)value;



- (ETGEccrCpsWpb*)primitiveWpb;
- (void)setPrimitiveWpb:(ETGEccrCpsWpb*)value;


@end
