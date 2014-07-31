// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGApc.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGApcAttributes {
	__unsafe_unretained NSString *afc;
	__unsafe_unretained NSString *apc;
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *categoryRange;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *itd;
	__unsafe_unretained NSString *phase;
	__unsafe_unretained NSString *remark;
	__unsafe_unretained NSString *variance;
} ETGApcAttributes;

extern const struct ETGApcRelationships {
	__unsafe_unretained NSString *portfolio;
	__unsafe_unretained NSString *scorecard;
} ETGApcRelationships;

extern const struct ETGApcFetchedProperties {
} ETGApcFetchedProperties;

@class ETGPortfolio;
@class ETGScorecard;











@interface ETGApcID : NSManagedObjectID {}
@end

@interface _ETGApc : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGApcID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* afc;


//- (BOOL)validateAfc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* apc;


//- (BOOL)validateApc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* category;


//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* categoryRange;


//- (BOOL)validateCategoryRange:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* itd;


//- (BOOL)validateItd:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* phase;


//- (BOOL)validatePhase:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* remark;


//- (BOOL)validateRemark:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* variance;


//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGPortfolio* portfolio;

//- (BOOL)validatePortfolio:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGApc (CoreDataGeneratedAccessors)

@end

@interface _ETGApc (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveAfc;
- (void)setPrimitiveAfc:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveApc;
- (void)setPrimitiveApc:(NSDecimalNumber*)value;




- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;




- (NSString*)primitiveCategoryRange;
- (void)setPrimitiveCategoryRange:(NSString*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDecimalNumber*)primitiveItd;
- (void)setPrimitiveItd:(NSDecimalNumber*)value;




- (NSString*)primitivePhase;
- (void)setPrimitivePhase:(NSString*)value;




- (NSString*)primitiveRemark;
- (void)setPrimitiveRemark:(NSString*)value;




- (NSDecimalNumber*)primitiveVariance;
- (void)setPrimitiveVariance:(NSDecimalNumber*)value;





- (ETGPortfolio*)primitivePortfolio;
- (void)setPrimitivePortfolio:(ETGPortfolio*)value;



- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
