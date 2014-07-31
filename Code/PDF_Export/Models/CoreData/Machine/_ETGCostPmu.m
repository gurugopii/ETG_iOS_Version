// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCostPmu.m instead.

#import "_ETGCostPmu.h"

const struct ETGCostPmuAttributes ETGCostPmuAttributes = {
};

const struct ETGCostPmuRelationships ETGCostPmuRelationships = {
	.apc = @"apc",
	.cpbs = @"cpbs",
	.scorecards = @"scorecards",
};

const struct ETGCostPmuFetchedProperties ETGCostPmuFetchedProperties = {
};

@implementation ETGCostPmuID
@end

@implementation _ETGCostPmu

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGCostPmu" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGCostPmu";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGCostPmu" inManagedObjectContext:moc_];
}

- (ETGCostPmuID*)objectID {
	return (ETGCostPmuID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic apc;

	

@dynamic cpbs;

	
- (NSMutableSet*)cpbsSet {
	[self willAccessValueForKey:@"cpbs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"cpbs"];
  
	[self didAccessValueForKey:@"cpbs"];
	return result;
}
	

@dynamic scorecards;

	






@end
