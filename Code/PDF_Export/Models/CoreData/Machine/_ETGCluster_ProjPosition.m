// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCluster_ProjPosition.m instead.

#import "_ETGCluster_ProjPosition.h"

const struct ETGCluster_ProjPositionAttributes ETGCluster_ProjPositionAttributes = {
	.filterName = @"filterName",
	.key = @"key",
	.reportingPeriod = @"reportingPeriod",
};

const struct ETGCluster_ProjPositionRelationships ETGCluster_ProjPositionRelationships = {
	.projectPositions = @"projectPositions",
};

const struct ETGCluster_ProjPositionFetchedProperties ETGCluster_ProjPositionFetchedProperties = {
};

@implementation ETGCluster_ProjPositionID
@end

@implementation _ETGCluster_ProjPosition

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGCluster_ProjPosition" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGCluster_ProjPosition";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGCluster_ProjPosition" inManagedObjectContext:moc_];
}

- (ETGCluster_ProjPositionID*)objectID {
	return (ETGCluster_ProjPositionID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"keyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"key"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic filterName;






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





@dynamic reportingPeriod;






@dynamic projectPositions;

	
- (NSMutableSet*)projectPositionsSet {
	[self willAccessValueForKey:@"projectPositions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projectPositions"];
  
	[self didAccessValueForKey:@"projectPositions"];
	return result;
}
	






@end
