// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMpCluster.m instead.

#import "_ETGMpCluster.h"

const struct ETGMpClusterAttributes ETGMpClusterAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGMpClusterRelationships ETGMpClusterRelationships = {
	.projectPositions = @"projectPositions",
	.projects = @"projects",
	.regions = @"regions",
	.reportingPeriods = @"reportingPeriods",
};

const struct ETGMpClusterFetchedProperties ETGMpClusterFetchedProperties = {
};

@implementation ETGMpClusterID
@end

@implementation _ETGMpCluster

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMpCluster" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMpCluster";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMpCluster" inManagedObjectContext:moc_];
}

- (ETGMpClusterID*)objectID {
	return (ETGMpClusterID*)[super objectID];
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






@dynamic projectPositions;

	
- (NSMutableSet*)projectPositionsSet {
	[self willAccessValueForKey:@"projectPositions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projectPositions"];
  
	[self didAccessValueForKey:@"projectPositions"];
	return result;
}
	

@dynamic projects;

	
- (NSMutableSet*)projectsSet {
	[self willAccessValueForKey:@"projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projects"];
  
	[self didAccessValueForKey:@"projects"];
	return result;
}
	

@dynamic regions;

	
- (NSMutableSet*)regionsSet {
	[self willAccessValueForKey:@"regions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"regions"];
  
	[self didAccessValueForKey:@"regions"];
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
