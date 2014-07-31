// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyHighlightProgressOverall.m instead.

#import "_ETGKeyHighlightProgressOverall.h"

const struct ETGKeyHighlightProgressOverallAttributes ETGKeyHighlightProgressOverallAttributes = {
	.overallCurrActualProgress = @"overallCurrActualProgress",
	.overallCurrPlanProgress = @"overallCurrPlanProgress",
	.overallCurrVariance = @"overallCurrVariance",
	.overallPrevActualProgress = @"overallPrevActualProgress",
	.overallPrevPlanProgress = @"overallPrevPlanProgress",
	.overallPrevVariance = @"overallPrevVariance",
};

const struct ETGKeyHighlightProgressOverallRelationships ETGKeyHighlightProgressOverallRelationships = {
	.keyHighLightsTable = @"keyHighLightsTable",
	.keyhighlight = @"keyhighlight",
};

const struct ETGKeyHighlightProgressOverallFetchedProperties ETGKeyHighlightProgressOverallFetchedProperties = {
};

@implementation ETGKeyHighlightProgressOverallID
@end

@implementation _ETGKeyHighlightProgressOverall

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGKeyHighlightProgressOverall" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGKeyHighlightProgressOverall";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGKeyHighlightProgressOverall" inManagedObjectContext:moc_];
}

- (ETGKeyHighlightProgressOverallID*)objectID {
	return (ETGKeyHighlightProgressOverallID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic overallCurrActualProgress;






@dynamic overallCurrPlanProgress;






@dynamic overallCurrVariance;






@dynamic overallPrevActualProgress;






@dynamic overallPrevPlanProgress;






@dynamic overallPrevVariance;






@dynamic keyHighLightsTable;

	
- (NSMutableSet*)keyHighLightsTableSet {
	[self willAccessValueForKey:@"keyHighLightsTable"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"keyHighLightsTable"];
  
	[self didAccessValueForKey:@"keyHighLightsTable"];
	return result;
}
	

@dynamic keyhighlight;

	






@end
