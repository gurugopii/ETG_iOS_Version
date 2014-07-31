// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCpb.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGCpbAttributes {
	__unsafe_unretained NSString *fyYep;
	__unsafe_unretained NSString *fyYtd;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *latestCpb;
	__unsafe_unretained NSString *originalCpb;
	__unsafe_unretained NSString *reportingDate;
	__unsafe_unretained NSString *variance;
} ETGCpbAttributes;

extern const struct ETGCpbRelationships {
	__unsafe_unretained NSString *costAllocation;
	__unsafe_unretained NSString *portfolio;
	__unsafe_unretained NSString *scorecard;
} ETGCpbRelationships;

extern const struct ETGCpbFetchedProperties {
} ETGCpbFetchedProperties;

@class ETGCostAllocation;
@class ETGPortfolio;
@class ETGScorecard;









@interface ETGCpbID : NSManagedObjectID {}
@end

@interface _ETGCpb : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGCpbID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* fyYep;


//- (BOOL)validateFyYep:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* fyYtd;


//- (BOOL)validateFyYtd:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* latestCpb;


//- (BOOL)validateLatestCpb:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* originalCpb;


//- (BOOL)validateOriginalCpb:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* reportingDate;


//- (BOOL)validateReportingDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* variance;


//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGCostAllocation* costAllocation;

//- (BOOL)validateCostAllocation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGPortfolio* portfolio;

//- (BOOL)validatePortfolio:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGCpb (CoreDataGeneratedAccessors)

@end

@interface _ETGCpb (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveFyYep;
- (void)setPrimitiveFyYep:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveFyYtd;
- (void)setPrimitiveFyYtd:(NSDecimalNumber*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDecimalNumber*)primitiveLatestCpb;
- (void)setPrimitiveLatestCpb:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveOriginalCpb;
- (void)setPrimitiveOriginalCpb:(NSDecimalNumber*)value;




- (NSDate*)primitiveReportingDate;
- (void)setPrimitiveReportingDate:(NSDate*)value;




- (NSDecimalNumber*)primitiveVariance;
- (void)setPrimitiveVariance:(NSDecimalNumber*)value;





- (ETGCostAllocation*)primitiveCostAllocation;
- (void)setPrimitiveCostAllocation:(ETGCostAllocation*)value;



- (ETGPortfolio*)primitivePortfolio;
- (void)setPrimitivePortfolio:(ETGPortfolio*)value;



- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
