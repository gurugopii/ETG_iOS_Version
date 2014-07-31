// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMonthlyKeyHighlight.m instead.

#import "_ETGMonthlyKeyHighlight.h"

const struct ETGMonthlyKeyHighlightAttributes ETGMonthlyKeyHighlightAttributes = {
	.activity = @"activity",
	.desc = @"desc",
	.mitigationPlan = @"mitigationPlan",
};

const struct ETGMonthlyKeyHighlightRelationships ETGMonthlyKeyHighlightRelationships = {
	.keyHighlight = @"keyHighlight",
};

const struct ETGMonthlyKeyHighlightFetchedProperties ETGMonthlyKeyHighlightFetchedProperties = {
};

@implementation ETGMonthlyKeyHighlightID
@end

@implementation _ETGMonthlyKeyHighlight

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMonthlyKeyHighlight" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMonthlyKeyHighlight";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMonthlyKeyHighlight" inManagedObjectContext:moc_];
}

- (ETGMonthlyKeyHighlightID*)objectID {
	return (ETGMonthlyKeyHighlightID*)[super objectID];
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
