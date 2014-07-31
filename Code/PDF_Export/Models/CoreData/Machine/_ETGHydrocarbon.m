// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGHydrocarbon.m instead.

#import "_ETGHydrocarbon.h"

const struct ETGHydrocarbonAttributes ETGHydrocarbonAttributes = {
	.actualforecast = @"actualforecast",
	.group = @"group",
	.indicator = @"indicator",
	.plan = @"plan",
};

const struct ETGHydrocarbonRelationships ETGHydrocarbonRelationships = {
	.portfolio = @"portfolio",
};

const struct ETGHydrocarbonFetchedProperties ETGHydrocarbonFetchedProperties = {
};

@implementation ETGHydrocarbonID
@end

@implementation _ETGHydrocarbon

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGHydrocarbon" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGHydrocarbon";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGHydrocarbon" inManagedObjectContext:moc_];
}

- (ETGHydrocarbonID*)objectID {
	return (ETGHydrocarbonID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic actualforecast;






@dynamic group;






@dynamic indicator;






@dynamic plan;






@dynamic portfolio;

	






@end
