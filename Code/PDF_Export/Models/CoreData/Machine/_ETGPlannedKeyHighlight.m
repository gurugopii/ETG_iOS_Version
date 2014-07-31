// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPlannedKeyHighlight.m instead.

#import "_ETGPlannedKeyHighlight.h"

const struct ETGPlannedKeyHighlightAttributes ETGPlannedKeyHighlightAttributes = {
	.activity = @"activity",
	.desc = @"desc",
	.mitigationPlan = @"mitigationPlan",
};

const struct ETGPlannedKeyHighlightRelationships ETGPlannedKeyHighlightRelationships = {
	.keyHighlight = @"keyHighlight",
};

const struct ETGPlannedKeyHighlightFetchedProperties ETGPlannedKeyHighlightFetchedProperties = {
};

@implementation ETGPlannedKeyHighlightID
@end

@implementation _ETGPlannedKeyHighlight

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPlannedKeyHighlight" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPlannedKeyHighlight";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPlannedKeyHighlight" inManagedObjectContext:moc_];
}

- (ETGPlannedKeyHighlightID*)objectID {
	return (ETGPlannedKeyHighlightID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic activity;






@dynamic desc;






@dynamic mitigationPlan;






@dynamic keyHighlight;

	






@end
