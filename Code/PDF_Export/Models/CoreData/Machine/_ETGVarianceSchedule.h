// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGVarianceSchedule.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGVarianceScheduleAttributes {
	__unsafe_unretained NSString *actual;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *planned;
	__unsafe_unretained NSString *variance;
} ETGVarianceScheduleAttributes;

extern const struct ETGVarianceScheduleRelationships {
	__unsafe_unretained NSString *scheduleScorecard;
} ETGVarianceScheduleRelationships;

extern const struct ETGVarianceScheduleFetchedProperties {
} ETGVarianceScheduleFetchedProperties;

@class ;






@interface ETGVarianceScheduleID : NSManagedObjectID {}
@end

@interface _ETGVarianceSchedule : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGVarianceScheduleID*)objectID;





@property (nonatomic, strong) NSDecimalNumber* actual;



//- (BOOL)validateActual:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* indicator;



//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDecimalNumber* planned;



//- (BOOL)validatePlanned:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDecimalNumber* variance;



//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong)  *scheduleScorecard;

//- (BOOL)validateScheduleScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGVarianceSchedule (CoreDataGeneratedAccessors)

@end

@interface _ETGVarianceSchedule (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveActual;
- (void)setPrimitiveActual:(NSDecimalNumber*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDecimalNumber*)primitivePlanned;
- (void)setPrimitivePlanned:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveVariance;
- (void)setPrimitiveVariance:(NSDecimalNumber*)value;





- (*)primitiveScheduleScorecard;
- (void)setPrimitiveScheduleScorecard:(*)value;


@end
