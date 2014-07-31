// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGSchedule.m instead.

#import "_ETGSchedule.h"

const struct ETGScheduleAttributes ETGScheduleAttributes = {
};

const struct ETGScheduleRelationships ETGScheduleRelationships = {
	.keyMileStones = @"keyMileStones",
	.platformSchedules = @"platformSchedules",
	.scheduleVariance = @"scheduleVariance",
	.scorecards = @"scorecards",
};

const struct ETGScheduleFetchedProperties ETGScheduleFetchedProperties = {
};

@implementation ETGScheduleID
@end

@implementation _ETGSchedule

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGSchedule" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGSchedule";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGSchedule" inManagedObjectContext:moc_];
}

- (ETGScheduleID*)objectID {
	return (ETGScheduleID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic keyMileStones;

	
- (NSMutableSet*)keyMileStonesSet {
	[self willAccessValueForKey:@"keyMileStones"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"keyMileStones"];
  
	[self didAccessValueForKey:@"keyMileStones"];
	return result;
}
	

@dynamic platformSchedules;

	
- (NSMutableSet*)platformSchedulesSet {
	[self willAccessValueForKey:@"platformSchedules"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"platformSchedules"];
  
	[self didAccessValueForKey:@"platformSchedules"];
	return result;
}
	

@dynamic scheduleVariance;

	

@dynamic scorecards;

	






@end
