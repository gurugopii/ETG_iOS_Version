// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPlatformSchedule.m instead.

#import "_ETGPlatformSchedule.h"

const struct ETGPlatformScheduleAttributes ETGPlatformScheduleAttributes = {
	.actualDt = @"actualDt",
	.indicator = @"indicator",
	.plannedDt = @"plannedDt",
	.platform = @"platform",
};

const struct ETGPlatformScheduleRelationships ETGPlatformScheduleRelationships = {
	.scheduleScorecard = @"scheduleScorecard",
};

const struct ETGPlatformScheduleFetchedProperties ETGPlatformScheduleFetchedProperties = {
};

@implementation ETGPlatformScheduleID
@end

@implementation _ETGPlatformSchedule

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPlatformSchedule" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPlatformSchedule";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPlatformSchedule" inManagedObjectContext:moc_];
}

- (ETGPlatformScheduleID*)objectID {
	return (ETGPlatformScheduleID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic actualDt;






@dynamic indicator;






@dynamic plannedDt;






@dynamic platform;






@dynamic scheduleScorecard;

	






@end
