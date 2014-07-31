// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGWpbScorecard.m instead.

#import "_ETGWpbScorecard.h"

const struct ETGWpbScorecardAttributes ETGWpbScorecardAttributes = {
	.abrApproved = @"abrApproved",
	.indicator = @"indicator",
	.latestWpb = @"latestWpb",
	.originalWpb = @"originalWpb",
	.section = @"section",
	.variance = @"variance",
	.yepG = @"yepG",
	.yercoApproved = @"yercoApproved",
};

const struct ETGWpbScorecardRelationships ETGWpbScorecardRelationships = {
	.scorecard = @"scorecard",
};

const struct ETGWpbScorecardFetchedProperties ETGWpbScorecardFetchedProperties = {
};

@implementation ETGWpbScorecardID
@end

@implementation _ETGWpbScorecard

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGWPBCostPMU" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGWPBCostPMU";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGWPBCostPMU" inManagedObjectContext:moc_];
}

- (ETGWpbScorecardID*)objectID {
	return (ETGWpbScorecardID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
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






@dynamic scorecard;

	






@end
