// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMpRegion.m instead.

#import "_ETGMpRegion.h"

const struct ETGMpRegionAttributes ETGMpRegionAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGMpRegionRelationships ETGMpRegionRelationships = {
	.clusters = @"clusters",
	.projects = @"projects",
	.reportingPeriods = @"reportingPeriods",
};

const struct ETGMpRegionFetchedProperties ETGMpRegionFetchedProperties = {
};

@implementation ETGMpRegionID
@end

@implementation _ETGMpRegion

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMpRegion" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMpRegion";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMpRegion" inManagedObjectContext:moc_];
}

- (ETGMpRegionID*)objectID {
	return (ETGMpRegionID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"keyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"key"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic key;



- (int32_t)keyValue {
	NSNumber *result = [self key];
	return [result intValue];
}

- (void)setKeyValue:(int32_t)value_ {
	[self setKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveKeyValue {
	NSNumber *result = [self primitiveKey];
	return [result intValue];
}

- (void)setPrimitiveKeyValue:(int32_t)value_ {
	[self setPrimitiveKey:[NSNumber numberWithInt:value_]];
}





@dynamic name;






@dynamic clusters;

	
- (NSMutableSet*)clustersSet {
	[self willAccessValueForKey:@"clusters"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"clusters"];
  
	[self didAccessValueForKey:@"clusters"];
	return result;
}
	

@dynamic projects;

	
- (NSMutableSet*)projectsSet {
	[self willAccessValueForKey:@"projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projects"];
  
	[self didAccessValueForKey:@"projects"];
	return result;
}
	

@dynamic reportingPeriods;

	
- (NSMutableSet*)reportingPeriodsSet {
	[self willAccessValueForKey:@"reportingPeriods"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"reportingPeriods"];
  
	[self didAccessValueForKey:@"reportingPeriods"];
	return result;
}
	






@end
