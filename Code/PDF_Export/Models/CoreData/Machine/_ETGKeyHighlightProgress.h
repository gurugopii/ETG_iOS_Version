// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyHighlightProgress.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGKeyHighlightProgressAttributes {
	__unsafe_unretained NSString *activityID;
	__unsafe_unretained NSString *activityName;
	__unsafe_unretained NSString *currActualProgress;
	__unsafe_unretained NSString *currPlanProgress;
	__unsafe_unretained NSString *currVariance;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *prevActualProgress;
	__unsafe_unretained NSString *prevPlanProgress;
	__unsafe_unretained NSString *prevVariance;
	__unsafe_unretained NSString *weightage;
} ETGKeyHighlightProgressAttributes;

extern const struct ETGKeyHighlightProgressRelationships {
	__unsafe_unretained NSString *keyhighlightsProgressOverall;
} ETGKeyHighlightProgressRelationships;

extern const struct ETGKeyHighlightProgressFetchedProperties {
} ETGKeyHighlightProgressFetchedProperties;

@class ETGKeyHighlightProgressOverall;












@interface ETGKeyHighlightProgressID : NSManagedObjectID {}
@end

@interface _ETGKeyHighlightProgress : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGKeyHighlightProgressID*)objectID;




@property (nonatomic, strong) NSNumber* activityID;


@property int32_t activityIDValue;
- (int32_t)activityIDValue;
- (void)setActivityIDValue:(int32_t)value_;

//- (BOOL)validateActivityID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* activityName;


//- (BOOL)validateActivityName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* currActualProgress;


//- (BOOL)validateCurrActualProgress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* currPlanProgress;


//- (BOOL)validateCurrPlanProgress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* currVariance;


//- (BOOL)validateCurrVariance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* prevActualProgress;


//- (BOOL)validatePrevActualProgress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* prevPlanProgress;


//- (BOOL)validatePrevPlanProgress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* prevVariance;


//- (BOOL)validatePrevVariance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* weightage;


//- (BOOL)validateWeightage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGKeyHighlightProgressOverall* keyhighlightsProgressOverall;

//- (BOOL)validateKeyhighlightsProgressOverall:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGKeyHighlightProgress (CoreDataGeneratedAccessors)

@end

@interface _ETGKeyHighlightProgress (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveActivityID;
- (void)setPrimitiveActivityID:(NSNumber*)value;

- (int32_t)primitiveActivityIDValue;
- (void)setPrimitiveActivityIDValue:(int32_t)value_;




- (NSString*)primitiveActivityName;
- (void)setPrimitiveActivityName:(NSString*)value;




- (NSDecimalNumber*)primitiveCurrActualProgress;
- (void)setPrimitiveCurrActualProgress:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveCurrPlanProgress;
- (void)setPrimitiveCurrPlanProgress:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveCurrVariance;
- (void)setPrimitiveCurrVariance:(NSDecimalNumber*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDecimalNumber*)primitivePrevActualProgress;
- (void)setPrimitivePrevActualProgress:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitivePrevPlanProgress;
- (void)setPrimitivePrevPlanProgress:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitivePrevVariance;
- (void)setPrimitivePrevVariance:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveWeightage;
- (void)setPrimitiveWeightage:(NSDecimalNumber*)value;





- (ETGKeyHighlightProgressOverall*)primitiveKeyhighlightsProgressOverall;
- (void)setPrimitiveKeyhighlightsProgressOverall:(ETGKeyHighlightProgressOverall*)value;


@end
