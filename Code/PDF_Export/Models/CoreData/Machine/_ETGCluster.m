// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCluster.m instead.

#import "_ETGCluster.h"

const struct ETGClusterAttributes ETGClusterAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGClusterRelationships ETGClusterRelationships = {
	.projects = @"projects",
	.region = @"region",
};

const struct ETGClusterFetchedProperties ETGClusterFetchedProperties = {
};

@implementation ETGClusterID
@end

@implementation _ETGCluster

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGCluster" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGCluster";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGCluster" inManagedObjectContext:moc_];
}

- (ETGClusterID*)objectID {
	return (ETGClusterID*)[super objectID];
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






@dynamic projects;

	
- (NSMutableSet*)projectsSet {
	[self willAccessValueForKey:@"projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projects"];
  
	[self didAccessValueForKey:@"projects"];
	return result;
}
	

@dynamic region;

	
- (NSMutableSet*)regionSet {
	[self willAccessValueForKey:@"region"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"region"];
  
	[self didAccessValueForKey:@"region"];
	return result;
}
	






@end
