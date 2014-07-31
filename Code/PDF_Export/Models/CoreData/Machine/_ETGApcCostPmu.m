// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGApcCostPmu.m instead.

#import "_ETGApcCostPmu.h"

const struct ETGApcCostPmuAttributes ETGApcCostPmuAttributes = {
	.afc = @"afc",
	.fia = @"fia",
	.indicator = @"indicator",
	.performanceName = @"performanceName",
	.tpFipFdp = @"tpFipFdp",
	.variance = @"variance",
	.vowd = @"vowd",
};

const struct ETGApcCostPmuRelationships ETGApcCostPmuRelationships = {
	.costPmu = @"costPmu",
};

const struct ETGApcCostPmuFetchedProperties ETGApcCostPmuFetchedProperties = {
};

@implementation ETGApcCostPmuID
@end

@implementation _ETGApcCostPmu

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGApcCostPmu" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGApcCostPmu";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGApcCostPmu" inManagedObjectContext:moc_];
}

- (ETGApcCostPmuID*)objectID {
	return (ETGApcCostPmuID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic afc;






@dynamic fia;






@dynamic indicator;






@dynamic performanceName;






@dynamic tpFipFdp;






@dynamic variance;






@dynamic vowd;






@dynamic costPmu;

	






@end
