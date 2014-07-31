// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGAfe.m instead.

#import "_ETGAfe.h"

const struct ETGAfeAttributes ETGAfeAttributes = {
	.afe = @"afe",
	.indicator = @"indicator",
	.status = @"status",
};

const struct ETGAfeRelationships ETGAfeRelationships = {
	.projectSummary = @"projectSummary",
};

const struct ETGAfeFetchedProperties ETGAfeFetchedProperties = {
};

@implementation ETGAfeID
@end

@implementation _ETGAfe

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGAfe" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGAfe";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGAfe" inManagedObjectContext:moc_];
}

- (ETGAfeID*)objectID {
	return (ETGAfeID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic afe;






@dynamic indicator;






@dynamic status;






@dynamic projectSummary;

	






@end
