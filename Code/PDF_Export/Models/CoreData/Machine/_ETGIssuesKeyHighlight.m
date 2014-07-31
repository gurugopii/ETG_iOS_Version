// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGIssuesKeyHighlight.m instead.

#import "_ETGIssuesKeyHighlight.h"

const struct ETGIssuesKeyHighlightAttributes ETGIssuesKeyHighlightAttributes = {
	.activity = @"activity",
	.desc = @"desc",
	.mitigationPlan = @"mitigationPlan",
};

const struct ETGIssuesKeyHighlightRelationships ETGIssuesKeyHighlightRelationships = {
	.keyHighlights = @"keyHighlights",
};

const struct ETGIssuesKeyHighlightFetchedProperties ETGIssuesKeyHighlightFetchedProperties = {
};

@implementation ETGIssuesKeyHighlightID
@end

@implementation _ETGIssuesKeyHighlight

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGIssuesKeyHighlight" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGIssuesKeyHighlight";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGIssuesKeyHighlight" inManagedObjectContext:moc_];
}

- (ETGIssuesKeyHighlightID*)objectID {
	return (ETGIssuesKeyHighlightID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic activity;






@dynamic desc;






@dynamic mitigationPlan;






@dynamic keyHighlights;

	






@end
