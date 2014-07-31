// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCpbCostPmu.m instead.

#import "_ETGCpbCostPmu.h"

const struct ETGCpbCostPmuAttributes ETGCpbCostPmuAttributes = {
	.abrApproved = @"abrApproved",
	.indicator = @"indicator",
	.latestWpb = @"latestWpb",
	.originalWpb = @"originalWpb",
	.section = @"section",
	.variance = @"variance",
	.yepG = @"yepG",
	.yercoApproved = @"yercoApproved",
};

const struct ETGCpbCostPmuRelationships ETGCpbCostPmuRelationships = {
	.costPmu = @"costPmu",
};

const struct ETGCpbCostPmuFetchedProperties ETGCpbCostPmuFetchedProperties = {
};

@implementation ETGCpbCostPmuID
@end

@implementation _ETGCpbCostPmu

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGCpbCostPmu" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGCpbCostPmu";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGCpbCostPmu" inManagedObjectContext:moc_];
}

- (ETGCpbCostPmuID*)objectID {
	return (ETGCpbCostPmuID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic abrApproved;






@dynamic indicator;






@dynamic latestWpb;






@dynamic originalWpb;






@dynamic section;






@dynamic variance;






@dynamic yepG;






@dynamic yercoApproved;






@dynamic costPmu;

	
- (NSMutableSet*)costPmuSet {
	[self willAccessValueForKey:@"costPmu"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"costPmu"];
  
	[self didAccessValueForKey:@"costPmu"];
	return result;
}
	






@end
