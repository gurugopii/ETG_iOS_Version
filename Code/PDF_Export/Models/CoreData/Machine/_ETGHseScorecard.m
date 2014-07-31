// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGHseScorecard.m instead.

#import "_ETGHseScorecard.h"

const struct ETGHseScorecardAttributes ETGHseScorecardAttributes = {
	.indicator = @"indicator",
	.ytdCriteria = @"ytdCriteria",
	.ytdCriteriaValue = @"ytdCriteriaValue",
};

const struct ETGHseScorecardRelationships ETGHseScorecardRelationships = {
	.scorecard = @"scorecard",
};

const struct ETGHseScorecardFetchedProperties ETGHseScorecardFetchedProperties = {
};

@implementation ETGHseScorecardID
@end

@implementation _ETGHseScorecard

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGHseScorecard" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGHseScorecard";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGHseScorecard" inManagedObjectContext:moc_];
}

- (ETGHseScorecardID*)objectID {
	return (ETGHseScorecardID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic indicator;






@dynamic ytdCriteria;






@dynamic ytdCriteriaValue;






@dynamic scorecard;

	






@end
