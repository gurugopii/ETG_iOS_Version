// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCps.m instead.

#import "_ETGEccrCps.h"

const struct ETGEccrCpsAttributes ETGEccrCpsAttributes = {
};

const struct ETGEccrCpsRelationships ETGEccrCpsRelationships = {
	.afe = @"afe",
	.apc = @"apc",
	.cpb = @"cpb",
	.fdp = @"fdp",
	.projectSummary = @"projectSummary",
	.wpb = @"wpb",
};

const struct ETGEccrCpsFetchedProperties ETGEccrCpsFetchedProperties = {
};

@implementation ETGEccrCpsID
@end

@implementation _ETGEccrCps

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCps" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCps";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCps" inManagedObjectContext:moc_];
}

- (ETGEccrCpsID*)objectID {
	return (ETGEccrCpsID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic afe;

	

@dynamic apc;

	

@dynamic cpb;

	

@dynamic fdp;

	

@dynamic projectSummary;

	

@dynamic wpb;

	






@end
