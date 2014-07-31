// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProduction.m instead.

#import "_ETGProduction.h"

const struct ETGProductionAttributes ETGProductionAttributes = {
	.facilityName = @"facilityName",
};

const struct ETGProductionRelationships ETGProductionRelationships = {
	.scorecard = @"scorecard",
	.wellDetails = @"wellDetails",
};

const struct ETGProductionFetchedProperties ETGProductionFetchedProperties = {
};

@implementation ETGProductionID
@end

@implementation _ETGProduction

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProduction" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProduction";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProduction" inManagedObjectContext:moc_];
}

- (ETGProductionID*)objectID {
	return (ETGProductionID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic facilityName;






@dynamic scorecard;

	

@dynamic wellDetails;

	
- (NSMutableSet*)wellDetailsSet {
	[self willAccessValueForKey:@"wellDetails"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wellDetails"];
  
	[self didAccessValueForKey:@"wellDetails"];
	return result;
}
	






@end
