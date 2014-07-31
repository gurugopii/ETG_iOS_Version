// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGSchedule.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGScheduleAttributes {
} ETGScheduleAttributes;

extern const struct ETGScheduleRelationships {
	__unsafe_unretained NSString *keyMileStones;
	__unsafe_unretained NSString *platformSchedules;
	__unsafe_unretained NSString *scheduleVariance;
	__unsafe_unretained NSString *scorecards;
} ETGScheduleRelationships;

extern const struct ETGScheduleFetchedProperties {
} ETGScheduleFetchedProperties;

@class ETGKeyMilestoneSchedule;
@class ETGPlatformSchedule;
@class ETGVarianceSchedule;
@class ;


@interface ETGScheduleID : NSManagedObjectID {}
@end

@interface _ETGSchedule : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGScheduleID*)objectID;





@property (nonatomic, strong) NSSet *keyMileStones;

- (NSMutableSet*)keyMileStonesSet;




@property (nonatomic, strong) NSSet *platformSchedules;

- (NSMutableSet*)platformSchedulesSet;




@property (nonatomic, strong) ETGVarianceSchedule *scheduleVariance;

//- (BOOL)validateScheduleVariance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong)  *scorecards;

//- (BOOL)validateScorecards:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGSchedule (CoreDataGeneratedAccessors)

- (void)addKeyMileStones:(NSSet*)value_;
- (void)removeKeyMileStones:(NSSet*)value_;
- (void)addKeyMileStonesObject:(ETGKeyMilestoneSchedule*)value_;
- (void)removeKeyMileStonesObject:(ETGKeyMilestoneSchedule*)value_;

- (void)addPlatformSchedules:(NSSet*)value_;
- (void)removePlatformSchedules:(NSSet*)value_;
- (void)addPlatformSchedulesObject:(ETGPlatformSchedule*)value_;
- (void)removePlatformSchedulesObject:(ETGPlatformSchedule*)value_;

@end

@interface _ETGSchedule (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveKeyMileStones;
- (void)setPrimitiveKeyMileStones:(NSMutableSet*)value;



- (NSMutableSet*)primitivePlatformSchedules;
- (void)setPrimitivePlatformSchedules:(NSMutableSet*)value;



- (ETGVarianceSchedule*)primitiveScheduleVariance;
- (void)setPrimitiveScheduleVariance:(ETGVarianceSchedule*)value;



- (*)primitiveScorecards;
- (void)setPrimitiveScorecards:(*)value;


@end
