// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPpaKeyHighlight.m instead.

#import "_ETGPpaKeyHighlight.h"

const struct ETGPpaKeyHighlightAttributes ETGPpaKeyHighlightAttributes = {
	.activity = @"activity",
	.desc = @"desc",
	.mitigationPlan = @"mitigationPlan",
};

const struct ETGPpaKeyHighlightRelationships ETGPpaKeyHighlightRelationships = {
	.keyHighlight = @"keyHighlight",
};

const struct ETGPpaKeyHighlightFetchedProperties ETGPpaKeyHighlightFetchedProperties = {
};

@implementation ETGPpaKeyHighlightID
@end

@implementation _ETGPpaKeyHighlight

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPpaKeyHighlight" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPpaKeyHighlight";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPpaKeyHighlight" inManagedObjectContext:moc_];
}

- (ETGPpaKeyHighlightID*)objectID {
	return (ETGPpaKeyHighlightID*)[super objectID];
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
