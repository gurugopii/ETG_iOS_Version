// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGAfeTable.m instead.

#import "_ETGAfeTable.h"

const struct ETGAfeTableAttributes ETGAfeTableAttributes = {
	.afc = @"afc",
	.afeDescription = @"afeDescription",
	.indicator = @"indicator",
	.itd = @"itd",
	.latestApprovedAfe = @"latestApprovedAfe",
	.variance = @"variance",
};

const struct ETGAfeTableRelationships ETGAfeTableRelationships = {
	.projectSummary = @"projectSummary",
	.scorecard = @"scorecard",
};

const struct ETGAfeTableFetchedProperties ETGAfeTableFetchedProperties = {
};

@implementation ETGAfeTableID
@end

@implementation _ETGAfeTable

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGAfeTable" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGAfeTable";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGAfeTable" inManagedObjectContext:moc_];
}

- (ETGAfeTableID*)objectID {
	return (ETGAfeTableID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic afc;






@dynamic afeDescription;






@dynamic indicator;






@dynamic itd;






@dynamic latestApprovedAfe;






@dynamic variance;






@dynamic projectSummary;

	

@dynamic scorecard;

	






@end
