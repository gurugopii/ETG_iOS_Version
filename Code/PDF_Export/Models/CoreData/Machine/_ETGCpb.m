// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCpb.m instead.

#import "_ETGCpb.h"

const struct ETGCpbAttributes ETGCpbAttributes = {
	.fyYep = @"fyYep",
	.fyYtd = @"fyYtd",
	.indicator = @"indicator",
	.latestCpb = @"latestCpb",
	.originalCpb = @"originalCpb",
	.reportingDate = @"reportingDate",
	.variance = @"variance",
};

const struct ETGCpbRelationships ETGCpbRelationships = {
	.costAllocation = @"costAllocation",
	.portfolio = @"portfolio",
	.scorecard = @"scorecard",
};

const struct ETGCpbFetchedProperties ETGCpbFetchedProperties = {
};

@implementation ETGCpbID
@end

@implementation _ETGCpb

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGCpb" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGCpb";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGCpb" inManagedObjectContext:moc_];
}

- (ETGCpbID*)objectID {
	return (ETGCpbID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic fyYep;






@dynamic fyYtd;






@dynamic indicator;






@dynamic latestCpb;






@dynamic originalCpb;






@dynamic reportingDate;






@dynamic variance;






@dynamic costAllocation;

	

@dynamic portfolio;

	

@dynamic scorecard;

	






@end
