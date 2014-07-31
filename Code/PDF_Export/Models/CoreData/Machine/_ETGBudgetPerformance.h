// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGBudgetPerformance.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGBudgetPerformanceAttributes {
	__unsafe_unretained NSString *forecastDescription;
	__unsafe_unretained NSString *forecastValue;
	__unsafe_unretained NSString *forecastVariance;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *planDescription;
	__unsafe_unretained NSString *planValue;
} ETGBudgetPerformanceAttributes;

extern const struct ETGBudgetPerformanceRelationships {
	__unsafe_unretained NSString *budgetHolder;
	__unsafe_unretained NSString *projectSummary;
} ETGBudgetPerformanceRelationships;

extern const struct ETGBudgetPerformanceFetchedProperties {
} ETGBudgetPerformanceFetchedProperties;

@class ETGCostAllocation;
@class ETGProjectSummary;








@interface ETGBudgetPerformanceID : NSManagedObjectID {}
@end

@interface _ETGBudgetPerformance : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGBudgetPerformanceID*)objectID;




@property (nonatomic, strong) NSString* forecastDescription;


//- (BOOL)validateForecastDescription:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* forecastValue;


//- (BOOL)validateForecastValue:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* forecastVariance;


//- (BOOL)validateForecastVariance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* planDescription;


//- (BOOL)validatePlanDescription:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* planValue;


//- (BOOL)validatePlanValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGCostAllocation* budgetHolder;

//- (BOOL)validateBudgetHolder:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGBudgetPerformance (CoreDataGeneratedAccessors)

@end

@interface _ETGBudgetPerformance (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveForecastDescription;
- (void)setPrimitiveForecastDescription:(NSString*)value;




- (NSDecimalNumber*)primitiveForecastValue;
- (void)setPrimitiveForecastValue:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveForecastVariance;
- (void)setPrimitiveForecastVariance:(NSDecimalNumber*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSString*)primitivePlanDescription;
- (void)setPrimitivePlanDescription:(NSString*)value;




- (NSDecimalNumber*)primitivePlanValue;
- (void)setPrimitivePlanValue:(NSDecimalNumber*)value;





- (ETGCostAllocation*)primitiveBudgetHolder;
- (void)setPrimitiveBudgetHolder:(ETGCostAllocation*)value;



- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;


@end
