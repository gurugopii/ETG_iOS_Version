// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMpProject.m instead.

#import "_ETGMpProject.h"

const struct ETGMpProjectAttributes ETGMpProjectAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGMpProjectRelationships ETGMpProjectRelationships = {
	.cluster = @"cluster",
	.projectPositions = @"projectPositions",
	.region = @"region",
	.reportingPeriods = @"reportingPeriods",
};

const struct ETGMpProjectFetchedProperties ETGMpProjectFetchedProperties = {
};

@implementation ETGMpProjectID
@end

@implementation _ETGMpProject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMpProject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMpProject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMpProject" inManagedObjectContext:moc_];
}

- (ETGMpProjectID*)objectID {
	return (ETGMpProjectID*)[super objectID];
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






@dynamic cluster;

	

@dynamic projectPositions;

	
- (NSMutableSet*)projectPositionsSet {
	[self willAccessValueForKey:@"projectPositions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projectPositions"];
  
	[self didAccessValueForKey:@"projectPositions"];
	return result;
}
	

@dynamic region;

	

@dynamic reportingPeriods;

	
- (NSMutableSet*)reportingPeriodsSet {
	[self willAccessValueForKey:@"reportingPeriods"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"reportingPeriods"];
  
	[self didAccessValueForKey:@"reportingPeriods"];
	return result;
}
	






@end
