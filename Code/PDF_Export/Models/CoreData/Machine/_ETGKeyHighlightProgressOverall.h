// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyHighlightProgressOverall.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGKeyHighlightProgressOverallAttributes {
	__unsafe_unretained NSString *overallCurrActualProgress;
	__unsafe_unretained NSString *overallCurrPlanProgress;
	__unsafe_unretained NSString *overallCurrVariance;
	__unsafe_unretained NSString *overallPrevActualProgress;
	__unsafe_unretained NSString *overallPrevPlanProgress;
	__unsafe_unretained NSString *overallPrevVariance;
} ETGKeyHighlightProgressOverallAttributes;

extern const struct ETGKeyHighlightProgressOverallRelationships {
	__unsafe_unretained NSString *keyHighLightsTable;
	__unsafe_unretained NSString *keyhighlight;
} ETGKeyHighlightProgressOverallRelationships;

extern const struct ETGKeyHighlightProgressOverallFetchedProperties {
} ETGKeyHighlightProgressOverallFetchedProperties;

@class ETGKeyHighlightProgress;
@class ETGKeyHighlight;








@interface ETGKeyHighlightProgressOverallID : NSManagedObjectID {}
@end

@interface _ETGKeyHighlightProgressOverall : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGKeyHighlightProgressOverallID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* overallCurrActualProgress;


//- (BOOL)validateOverallCurrActualProgress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* overallCurrPlanProgress;


//- (BOOL)validateOverallCurrPlanProgress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* overallCurrVariance;


//- (BOOL)validateOverallCurrVariance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* overallPrevActualProgress;


//- (BOOL)validateOverallPrevActualProgress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* overallPrevPlanProgress;


//- (BOOL)validateOverallPrevPlanProgress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* overallPrevVariance;


//- (BOOL)validateOverallPrevVariance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* keyHighLightsTable;

- (NSMutableSet*)keyHighLightsTableSet;




@property (nonatomic, strong) ETGKeyHighlight* keyhighlight;

//- (BOOL)validateKeyhighlight:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGKeyHighlightProgressOverall (CoreDataGeneratedAccessors)

- (void)addKeyHighLightsTable:(NSSet*)value_;
- (void)removeKeyHighLightsTable:(NSSet*)value_;
- (void)addKeyHighLightsTableObject:(ETGKeyHighlightProgress*)value_;
- (void)removeKeyHighLightsTableObject:(ETGKeyHighlightProgress*)value_;

@end

@interface _ETGKeyHighlightProgressOverall (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveOverallCurrActualProgress;
- (void)setPrimitiveOverallCurrActualProgress:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveOverallCurrPlanProgress;
- (void)setPrimitiveOverallCurrPlanProgress:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveOverallCurrVariance;
- (void)setPrimitiveOverallCurrVariance:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveOverallPrevActualProgress;
- (void)setPrimitiveOverallPrevActualProgress:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveOverallPrevPlanProgress;
- (void)setPrimitiveOverallPrevPlanProgress:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveOverallPrevVariance;
- (void)setPrimitiveOverallPrevVariance:(NSDecimalNumber*)value;





- (NSMutableSet*)primitiveKeyHighLightsTable;
- (void)setPrimitiveKeyHighLightsTable:(NSMutableSet*)value;



- (ETGKeyHighlight*)primitiveKeyhighlight;
- (void)setPrimitiveKeyhighlight:(ETGKeyHighlight*)value;


@end
