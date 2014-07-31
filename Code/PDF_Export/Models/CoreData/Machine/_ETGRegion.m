// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGRegion.m instead.

#import "_ETGRegion.h"

const struct ETGRegionAttributes ETGRegionAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGRegionRelationships ETGRegionRelationships = {
	.clusters = @"clusters",
	.country = @"country",
	.projects = @"projects",
};

const struct ETGRegionFetchedProperties ETGRegionFetchedProperties = {
};

@implementation ETGRegionID
@end

@implementation _ETGRegion

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGRegion" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGRegion";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGRegion" inManagedObjectContext:moc_];
}

- (ETGRegionID*)objectID {
	return (ETGRegionID*)[super objectID];
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
	

@dynamic country;

	

@dynamic projects;

	
- (NSMutableSet*)projectsSet {
	[self willAccessValueForKey:@"projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projects"];
  
	[self didAccessValueForKey:@"projects"];
	return result;
}
	






@end
