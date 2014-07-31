// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpb.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpbAttributes {
	__unsafe_unretained NSString *additionalCAPEX;
	__unsafe_unretained NSString *afcAmt;
	__unsafe_unretained NSString *anticipatedCPB;
	__unsafe_unretained NSString *btOutofBudgetHolder;
	__unsafe_unretained NSString *budgetHolderKey;
	__unsafe_unretained NSString *isInternational;
	__unsafe_unretained NSString *latestCPBAmt;
	__unsafe_unretained NSString *newlySanctionAmt;
	__unsafe_unretained NSString *operatorShipKey;
	__unsafe_unretained NSString *originalCPBAmt;
	__unsafe_unretained NSString *plantoSanction;
	__unsafe_unretained NSString *potentialRisk;
	__unsafe_unretained NSString *potentialUnderSpending;
	__unsafe_unretained NSString *potentialYEP;
	__unsafe_unretained NSString *projectCostCategoryKey;
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *regionKey;
	__unsafe_unretained NSString *yep;
	__unsafe_unretained NSString *yepWithRisk;
} ETGEccrCpbAttributes;

extern const struct ETGEccrCpbRelationships {
	__unsafe_unretained NSString *reportingMonth;
} ETGEccrCpbRelationships;

extern const struct ETGEccrCpbFetchedProperties {
} ETGEccrCpbFetchedProperties;

@class ETGReportingMonth;





















@interface ETGEccrCpbID : NSManagedObjectID {}
@end

@interface _ETGEccrCpb : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpbID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* additionalCAPEX;


//- (BOOL)validateAdditionalCAPEX:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* afcAmt;


//- (BOOL)validateAfcAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* anticipatedCPB;


//- (BOOL)validateAnticipatedCPB:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* btOutofBudgetHolder;


//- (BOOL)validateBtOutofBudgetHolder:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* budgetHolderKey;


@property int32_t budgetHolderKeyValue;
- (int32_t)budgetHolderKeyValue;
- (void)setBudgetHolderKeyValue:(int32_t)value_;

//- (BOOL)validateBudgetHolderKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* isInternational;


//- (BOOL)validateIsInternational:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* latestCPBAmt;


//- (BOOL)validateLatestCPBAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* newlySanctionAmt;


//- (BOOL)validateNewlySanctionAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* operatorShipKey;


@property int32_t operatorShipKeyValue;
- (int32_t)operatorShipKeyValue;
- (void)setOperatorShipKeyValue:(int32_t)value_;

//- (BOOL)validateOperatorShipKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* originalCPBAmt;


//- (BOOL)validateOriginalCPBAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* plantoSanction;


//- (BOOL)validatePlantoSanction:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* potentialRisk;


//- (BOOL)validatePotentialRisk:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* potentialUnderSpending;


//- (BOOL)validatePotentialUnderSpending:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* potentialYEP;


//- (BOOL)validatePotentialYEP:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectCostCategoryKey;


@property int32_t projectCostCategoryKeyValue;
- (int32_t)projectCostCategoryKeyValue;
- (void)setProjectCostCategoryKeyValue:(int32_t)value_;

//- (BOOL)validateProjectCostCategoryKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* regionKey;


@property int32_t regionKeyValue;
- (int32_t)regionKeyValue;
- (void)setRegionKeyValue:(int32_t)value_;

//- (BOOL)validateRegionKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* yep;


//- (BOOL)validateYep:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* yepWithRisk;


//- (BOOL)validateYepWithRisk:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGEccrCpb (CoreDataGeneratedAccessors)

@end

@interface _ETGEccrCpb (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveAdditionalCAPEX;
- (void)setPrimitiveAdditionalCAPEX:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveAfcAmt;
- (void)setPrimitiveAfcAmt:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveAnticipatedCPB;
- (void)setPrimitiveAnticipatedCPB:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveBtOutofBudgetHolder;
- (void)setPrimitiveBtOutofBudgetHolder:(NSDecimalNumber*)value;




- (NSNumber*)primitiveBudgetHolderKey;
- (void)setPrimitiveBudgetHolderKey:(NSNumber*)value;

- (int32_t)primitiveBudgetHolderKeyValue;
- (void)setPrimitiveBudgetHolderKeyValue:(int32_t)value_;




- (NSString*)primitiveIsInternational;
- (void)setPrimitiveIsInternational:(NSString*)value;




- (NSDecimalNumber*)primitiveLatestCPBAmt;
- (void)setPrimitiveLatestCPBAmt:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveNewlySanctionAmt;
- (void)setPrimitiveNewlySanctionAmt:(NSDecimalNumber*)value;




- (NSNumber*)primitiveOperatorShipKey;
- (void)setPrimitiveOperatorShipKey:(NSNumber*)value;

- (int32_t)primitiveOperatorShipKeyValue;
- (void)setPrimitiveOperatorShipKeyValue:(int32_t)value_;




- (NSDecimalNumber*)primitiveOriginalCPBAmt;
- (void)setPrimitiveOriginalCPBAmt:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitivePlantoSanction;
- (void)setPrimitivePlantoSanction:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitivePotentialRisk;
- (void)setPrimitivePotentialRisk:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitivePotentialUnderSpending;
- (void)setPrimitivePotentialUnderSpending:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitivePotentialYEP;
- (void)setPrimitivePotentialYEP:(NSDecimalNumber*)value;




- (NSNumber*)primitiveProjectCostCategoryKey;
- (void)setPrimitiveProjectCostCategoryKey:(NSNumber*)value;

- (int32_t)primitiveProjectCostCategoryKeyValue;
- (void)setPrimitiveProjectCostCategoryKeyValue:(int32_t)value_;




- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSNumber*)primitiveRegionKey;
- (void)setPrimitiveRegionKey:(NSNumber*)value;

- (int32_t)primitiveRegionKeyValue;
- (void)setPrimitiveRegionKeyValue:(int32_t)value_;




- (NSDecimalNumber*)primitiveYep;
- (void)setPrimitiveYep:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveYepWithRisk;
- (void)setPrimitiveYepWithRisk:(NSDecimalNumber*)value;





- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;


@end
