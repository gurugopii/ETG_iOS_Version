// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCostPcsb.m instead.

#import "_ETGCostPcsb.h"

const struct ETGCostPcsbAttributes ETGCostPcsbAttributes = {
};

const struct ETGCostPcsbRelationships ETGCostPcsbRelationships = {
	.afes = @"afes",
	.apc = @"apc",
	.cpb = @"cpb",
	.scorecards = @"scorecards",
};

const struct ETGCostPcsbFetchedProperties ETGCostPcsbFetchedProperties = {
};

@implementation ETGCostPcsbID
@end

@implementation _ETGCostPcsb

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGCostPcsb" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGCostPcsb";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGCostPcsb" inManagedObjectContext:moc_];
}

- (ETGCostPcsbID*)objectID {
	return (ETGCostPcsbID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic afes;

	
- (NSMutableSet*)afesSet {
	[self willAccessValueForKey:@"afes"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"afes"];
  
	[self didAccessValueForKey:@"afes"];
	return result;
}
	

@dynamic apc;

	

@dynamic cpb;

	

@dynamic scorecards;

	






@end
