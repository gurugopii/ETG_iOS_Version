// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGScheduleProgress.m instead.

#import "_ETGScheduleProgress.h"

const struct ETGScheduleProgressAttributes ETGScheduleProgressAttributes = {
	.actualProgress = @"actualProgress",
	.indicator = @"indicator",
	.originalBaseline = @"originalBaseline",
	.planProgress = @"planProgress",
	.reportingDate = @"reportingDate",
	.variance = @"variance",
};

const struct ETGScheduleProgressRelationships ETGScheduleProgressRelationships = {
	.projectSummary = @"projectSummary",
	.scorecard = @"scorecard",
};

const struct ETGScheduleProgressFetchedProperties ETGScheduleProgressFetchedProperties = {
};

@implementation ETGScheduleProgressID
@end

@implementation _ETGScheduleProgress

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGScheduleProgress" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGScheduleProgress";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGScheduleProgress" inManagedObjectContext:moc_];
}

- (ETGScheduleProgressID*)objectID {
	return (ETGScheduleProgressID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic actualProgress;






@dynamic indicator;






@dynamic originalBaseline;






@dynamic planProgress;






@dynamic reportingDate;






@dynamic variance;






@dynamic projectSummary;

	

@dynamic scorecard;

	






@end
