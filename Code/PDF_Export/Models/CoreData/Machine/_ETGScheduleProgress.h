// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGScheduleProgress.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGScheduleProgressAttributes {
	__unsafe_unretained NSString *actualProgress;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *originalBaseline;
	__unsafe_unretained NSString *planProgress;
	__unsafe_unretained NSString *reportingDate;
	__unsafe_unretained NSString *variance;
} ETGScheduleProgressAttributes;

extern const struct ETGScheduleProgressRelationships {
	__unsafe_unretained NSString *projectSummary;
	__unsafe_unretained NSString *scorecard;
} ETGScheduleProgressRelationships;

extern const struct ETGScheduleProgressFetchedProperties {
} ETGScheduleProgressFetchedProperties;

@class ETGProjectSummary;
@class ETGScorecard;








@interface ETGScheduleProgressID : NSManagedObjectID {}
@end

@interface _ETGScheduleProgress : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGScheduleProgressID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* actualProgress;


//- (BOOL)validateActualProgress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* originalBaseline;


//- (BOOL)validateOriginalBaseline:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* planProgress;


//- (BOOL)validatePlanProgress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* reportingDate;


//- (BOOL)validateReportingDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* variance;


//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGScheduleProgress (CoreDataGeneratedAccessors)

@end

@interface _ETGScheduleProgress (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveActualProgress;
- (void)setPrimitiveActualProgress:(NSDecimalNumber*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDecimalNumber*)primitiveOriginalBaseline;
- (void)setPrimitiveOriginalBaseline:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitivePlanProgress;
- (void)setPrimitivePlanProgress:(NSDecimalNumber*)value;




- (NSDate*)primitiveReportingDate;
- (void)setPrimitiveReportingDate:(NSDate*)value;




- (NSDecimalNumber*)primitiveVariance;
- (void)setPrimitiveVariance:(NSDecimalNumber*)value;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;



- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
