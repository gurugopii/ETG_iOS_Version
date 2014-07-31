// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyHighlightProgress.m instead.

#import "_ETGKeyHighlightProgress.h"

const struct ETGKeyHighlightProgressAttributes ETGKeyHighlightProgressAttributes = {
	.activityID = @"activityID",
	.activityName = @"activityName",
	.currActualProgress = @"currActualProgress",
	.currPlanProgress = @"currPlanProgress",
	.currVariance = @"currVariance",
	.indicator = @"indicator",
	.prevActualProgress = @"prevActualProgress",
	.prevPlanProgress = @"prevPlanProgress",
	.prevVariance = @"prevVariance",
	.weightage = @"weightage",
};

const struct ETGKeyHighlightProgressRelationships ETGKeyHighlightProgressRelationships = {
	.keyhighlightsProgressOverall = @"keyhighlightsProgressOverall",
};

const struct ETGKeyHighlightProgressFetchedProperties ETGKeyHighlightProgressFetchedProperties = {
};

@implementation ETGKeyHighlightProgressID
@end

@implementation _ETGKeyHighlightProgress

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGKeyHighlightProgress" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGKeyHighlightProgress";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGKeyHighlightProgress" inManagedObjectContext:moc_];
}

- (ETGKeyHighlightProgressID*)objectID {
	return (ETGKeyHighlightProgressID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"activityIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"activityID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic activityID;



- (int32_t)activityIDValue {
	NSNumber *result = [self activityID];
	return [result intValue];
}

- (void)setActivityIDValue:(int32_t)value_ {
	[self setActivityID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveActivityIDValue {
	NSNumber *result = [self primitiveActivityID];
	return [result intValue];
}

- (void)setPrimitiveActivityIDValue:(int32_t)value_ {
	[self setPrimitiveActivityID:[NSNumber numberWithInt:value_]];
}





@dynamic activityName;






@dynamic currActualProgress;






@dynamic currPlanProgress;






@dynamic currVariance;






@dynamic indicator;






@dynamic prevActualProgress;






@dynamic prevPlanProgress;






@dynamic prevVariance;






@dynamic weightage;






@dynamic keyhighlightsProgressOverall;

	






@end
