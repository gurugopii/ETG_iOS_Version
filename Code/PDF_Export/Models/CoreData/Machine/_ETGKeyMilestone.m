// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyMilestone.m instead.

#import "_ETGKeyMilestone.h"

const struct ETGKeyMilestoneAttributes ETGKeyMilestoneAttributes = {
	.actualDate = @"actualDate",
	.baselineNum = @"baselineNum",
	.indicator = @"indicator",
	.mileStone = @"mileStone",
	.plannedDate = @"plannedDate",
};

const struct ETGKeyMilestoneRelationships ETGKeyMilestoneRelationships = {
	.revisions = @"revisions",
};

const struct ETGKeyMilestoneFetchedProperties ETGKeyMilestoneFetchedProperties = {
};

@implementation ETGKeyMilestoneID
@end

@implementation _ETGKeyMilestone

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGKeyMilestone" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGKeyMilestone";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGKeyMilestone" inManagedObjectContext:moc_];
}

- (ETGKeyMilestoneID*)objectID {
	return (ETGKeyMilestoneID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"baselineNumValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"baselineNum"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic actualDate;






@dynamic baselineNum;



- (int32_t)baselineNumValue {
	NSNumber *result = [self baselineNum];
	return [result intValue];
}

- (void)setBaselineNumValue:(int32_t)value_ {
	[self setBaselineNum:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveBaselineNumValue {
	NSNumber *result = [self primitiveBaselineNum];
	return [result intValue];
}

- (void)setPrimitiveBaselineNumValue:(int32_t)value_ {
	[self setPrimitiveBaselineNum:[NSNumber numberWithInt:value_]];
}





@dynamic indicator;






@dynamic mileStone;






@dynamic plannedDate;






@dynamic revisions;

	






@end
