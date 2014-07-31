// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllLessons.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPllLessonsAttributes {
	__unsafe_unretained NSString *activity;
	__unsafe_unretained NSString *approvalStatus;
	__unsafe_unretained NSString *areaName;
	__unsafe_unretained NSString *baselineDesc;
	__unsafe_unretained NSString *causeDesc;
	__unsafe_unretained NSString *createDttm;
	__unsafe_unretained NSString *createUserId;
	__unsafe_unretained NSString *currencyName;
	__unsafe_unretained NSString *disciplineName;
	__unsafe_unretained NSString *impactDesc;
	__unsafe_unretained NSString *lessonDesc;
	__unsafe_unretained NSString *potentialValue;
	__unsafe_unretained NSString *potentialValueBasis;
	__unsafe_unretained NSString *potentialValueConverted;
	__unsafe_unretained NSString *projectLessonDetailKey;
	__unsafe_unretained NSString *projectLessonImpactNm;
	__unsafe_unretained NSString *projectLessonRatingNm;
	__unsafe_unretained NSString *projectName;
	__unsafe_unretained NSString *recommendationDesc;
	__unsafe_unretained NSString *replicateInd;
	__unsafe_unretained NSString *reviewItemName;
	__unsafe_unretained NSString *riskCategoryName;
	__unsafe_unretained NSString *totalLikeNo;
	__unsafe_unretained NSString *updateDttm;
	__unsafe_unretained NSString *updateUserId;
	__unsafe_unretained NSString *usdRate;
} ETGPllLessonsAttributes;

extern const struct ETGPllLessonsRelationships {
} ETGPllLessonsRelationships;

extern const struct ETGPllLessonsFetchedProperties {
} ETGPllLessonsFetchedProperties;





























@interface ETGPllLessonsID : NSManagedObjectID {}
@end

@interface _ETGPllLessons : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPllLessonsID*)objectID;




@property (nonatomic, strong) NSString* activity;


//- (BOOL)validateActivity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* approvalStatus;


//- (BOOL)validateApprovalStatus:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* areaName;


//- (BOOL)validateAreaName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* baselineDesc;


//- (BOOL)validateBaselineDesc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* causeDesc;


//- (BOOL)validateCauseDesc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* createDttm;


//- (BOOL)validateCreateDttm:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* createUserId;


//- (BOOL)validateCreateUserId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* currencyName;


//- (BOOL)validateCurrencyName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* disciplineName;


//- (BOOL)validateDisciplineName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* impactDesc;


//- (BOOL)validateImpactDesc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* lessonDesc;


//- (BOOL)validateLessonDesc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* potentialValue;


@property int32_t potentialValueValue;
- (int32_t)potentialValueValue;
- (void)setPotentialValueValue:(int32_t)value_;

//- (BOOL)validatePotentialValue:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* potentialValueBasis;


//- (BOOL)validatePotentialValueBasis:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* potentialValueConverted;


@property double potentialValueConvertedValue;
- (double)potentialValueConvertedValue;
- (void)setPotentialValueConvertedValue:(double)value_;

//- (BOOL)validatePotentialValueConverted:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectLessonDetailKey;


@property int32_t projectLessonDetailKeyValue;
- (int32_t)projectLessonDetailKeyValue;
- (void)setProjectLessonDetailKeyValue:(int32_t)value_;

//- (BOOL)validateProjectLessonDetailKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectLessonImpactNm;


//- (BOOL)validateProjectLessonImpactNm:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectLessonRatingNm;


//- (BOOL)validateProjectLessonRatingNm:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectName;


//- (BOOL)validateProjectName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* recommendationDesc;


//- (BOOL)validateRecommendationDesc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* replicateInd;


//- (BOOL)validateReplicateInd:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* reviewItemName;


//- (BOOL)validateReviewItemName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* riskCategoryName;


//- (BOOL)validateRiskCategoryName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* totalLikeNo;


@property int32_t totalLikeNoValue;
- (int32_t)totalLikeNoValue;
- (void)setTotalLikeNoValue:(int32_t)value_;

//- (BOOL)validateTotalLikeNo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* updateDttm;


//- (BOOL)validateUpdateDttm:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* updateUserId;


//- (BOOL)validateUpdateUserId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* usdRate;


//- (BOOL)validateUsdRate:(id*)value_ error:(NSError**)error_;






@end

@interface _ETGPllLessons (CoreDataGeneratedAccessors)

@end

@interface _ETGPllLessons (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveActivity;
- (void)setPrimitiveActivity:(NSString*)value;




- (NSString*)primitiveApprovalStatus;
- (void)setPrimitiveApprovalStatus:(NSString*)value;




- (NSString*)primitiveAreaName;
- (void)setPrimitiveAreaName:(NSString*)value;




- (NSString*)primitiveBaselineDesc;
- (void)setPrimitiveBaselineDesc:(NSString*)value;




- (NSString*)primitiveCauseDesc;
- (void)setPrimitiveCauseDesc:(NSString*)value;




- (NSDate*)primitiveCreateDttm;
- (void)setPrimitiveCreateDttm:(NSDate*)value;




- (NSString*)primitiveCreateUserId;
- (void)setPrimitiveCreateUserId:(NSString*)value;




- (NSString*)primitiveCurrencyName;
- (void)setPrimitiveCurrencyName:(NSString*)value;




- (NSString*)primitiveDisciplineName;
- (void)setPrimitiveDisciplineName:(NSString*)value;




- (NSString*)primitiveImpactDesc;
- (void)setPrimitiveImpactDesc:(NSString*)value;




- (NSString*)primitiveLessonDesc;
- (void)setPrimitiveLessonDesc:(NSString*)value;




- (NSNumber*)primitivePotentialValue;
- (void)setPrimitivePotentialValue:(NSNumber*)value;

- (int32_t)primitivePotentialValueValue;
- (void)setPrimitivePotentialValueValue:(int32_t)value_;




- (NSString*)primitivePotentialValueBasis;
- (void)setPrimitivePotentialValueBasis:(NSString*)value;




- (NSNumber*)primitivePotentialValueConverted;
- (void)setPrimitivePotentialValueConverted:(NSNumber*)value;

- (double)primitivePotentialValueConvertedValue;
- (void)setPrimitivePotentialValueConvertedValue:(double)value_;




- (NSNumber*)primitiveProjectLessonDetailKey;
- (void)setPrimitiveProjectLessonDetailKey:(NSNumber*)value;

- (int32_t)primitiveProjectLessonDetailKeyValue;
- (void)setPrimitiveProjectLessonDetailKeyValue:(int32_t)value_;




- (NSString*)primitiveProjectLessonImpactNm;
- (void)setPrimitiveProjectLessonImpactNm:(NSString*)value;




- (NSString*)primitiveProjectLessonRatingNm;
- (void)setPrimitiveProjectLessonRatingNm:(NSString*)value;




- (NSString*)primitiveProjectName;
- (void)setPrimitiveProjectName:(NSString*)value;




- (NSString*)primitiveRecommendationDesc;
- (void)setPrimitiveRecommendationDesc:(NSString*)value;




- (NSString*)primitiveReplicateInd;
- (void)setPrimitiveReplicateInd:(NSString*)value;




- (NSString*)primitiveReviewItemName;
- (void)setPrimitiveReviewItemName:(NSString*)value;




- (NSString*)primitiveRiskCategoryName;
- (void)setPrimitiveRiskCategoryName:(NSString*)value;




- (NSNumber*)primitiveTotalLikeNo;
- (void)setPrimitiveTotalLikeNo:(NSNumber*)value;

- (int32_t)primitiveTotalLikeNoValue;
- (void)setPrimitiveTotalLikeNoValue:(int32_t)value_;




- (NSDate*)primitiveUpdateDttm;
- (void)setPrimitiveUpdateDttm:(NSDate*)value;




- (NSString*)primitiveUpdateUserId;
- (void)setPrimitiveUpdateUserId:(NSString*)value;




- (NSString*)primitiveUsdRate;
- (void)setPrimitiveUsdRate:(NSString*)value;




@end
