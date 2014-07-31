// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPlatformSchedule.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPlatformScheduleAttributes {
	__unsafe_unretained NSString *actualDt;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *plannedDt;
	__unsafe_unretained NSString *platform;
} ETGPlatformScheduleAttributes;

extern const struct ETGPlatformScheduleRelationships {
	__unsafe_unretained NSString *scheduleScorecard;
} ETGPlatformScheduleRelationships;

extern const struct ETGPlatformScheduleFetchedProperties {
} ETGPlatformScheduleFetchedProperties;

@class ;






@interface ETGPlatformScheduleID : NSManagedObjectID {}
@end

@interface _ETGPlatformSchedule : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPlatformScheduleID*)objectID;





@property (nonatomic, strong) NSString* actualDt;



//- (BOOL)validateActualDt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* indicator;



//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* plannedDt;



//- (BOOL)validatePlannedDt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* platform;



//- (BOOL)validatePlatform:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong)  *scheduleScorecard;

//- (BOOL)validateScheduleScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGPlatformSchedule (CoreDataGeneratedAccessors)

@end

@interface _ETGPlatformSchedule (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveActualDt;
- (void)setPrimitiveActualDt:(NSString*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSString*)primitivePlannedDt;
- (void)setPrimitivePlannedDt:(NSString*)value;




- (NSString*)primitivePlatform;
- (void)setPrimitivePlatform:(NSString*)value;





- (*)primitiveScheduleScorecard;
- (void)setPrimitiveScheduleScorecard:(*)value;


@end
