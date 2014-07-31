// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGFdp.m instead.

#import "_ETGFdp.h"

const struct ETGFdpAttributes ETGFdpAttributes = {
	.afc = @"afc",
	.fia = @"fia",
	.indicator = @"indicator",
	.tpFipFdp = @"tpFipFdp",
	.variance = @"variance",
	.vowd = @"vowd",
};

const struct ETGFdpRelationships ETGFdpRelationships = {
	.scorecard = @"scorecard",
};

const struct ETGFdpFetchedProperties ETGFdpFetchedProperties = {
};

@implementation ETGFdpID
@end

@implementation _ETGFdp

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGFDP" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGFDP";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGFDP" inManagedObjectContext:moc_];
}

- (ETGFdpID*)objectID {
	return (ETGFdpID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic afc;






@dynamic fia;






@dynamic indicator;






@dynamic tpFipFdp;






@dynamic variance;






@dynamic vowd;






@dynamic scorecard;

	






@end
