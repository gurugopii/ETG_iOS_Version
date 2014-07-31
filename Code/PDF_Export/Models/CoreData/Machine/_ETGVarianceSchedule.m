// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGVarianceSchedule.m instead.

#import "_ETGVarianceSchedule.h"

const struct ETGVarianceScheduleAttributes ETGVarianceScheduleAttributes = {
	.actual = @"actual",
	.indicator = @"indicator",
	.planned = @"planned",
	.variance = @"variance",
};

const struct ETGVarianceScheduleRelationships ETGVarianceScheduleRelationships = {
	.scheduleScorecard = @"scheduleScorecard",
};

const struct ETGVarianceScheduleFetchedProperties ETGVarianceScheduleFetchedProperties = {
};

@implementation ETGVarianceScheduleID
@end

@implementation _ETGVarianceSchedule

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGVarianceSchedule" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGVarianceSchedule";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGVarianceSchedule" inManagedObjectContext:moc_];
}

- (ETGVarianceScheduleID*)objectID {
	return (ETGVarianceScheduleID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic actual;






@dynamic indicator;






@dynamic planned;






@dynamic variance;






@dynamic scheduleScorecard;

	






@end
