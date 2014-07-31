// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectPosition.m instead.

#import "_ETGProjectPosition.h"

const struct ETGProjectPositionAttributes ETGProjectPositionAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGProjectPositionRelationships ETGProjectPositionRelationships = {
	.clusters = @"clusters",
	.projPosition_cluster = @"projPosition_cluster",
	.projPosition_project = @"projPosition_project",
	.projects = @"projects",
	.reportingPeriods = @"reportingPeriods",
};

const struct ETGProjectPositionFetchedProperties ETGProjectPositionFetchedProperties = {
};

@implementation ETGProjectPositionID
@end

@implementation _ETGProjectPosition

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProjectPosition" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProjectPosition";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProjectPosition" inManagedObjectContext:moc_];
}

- (ETGProjectPositionID*)objectID {
	return (ETGProjectPositionID*)[super objectID];
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
	

@dynamic projPosition_cluster;

	
- (NSMutableSet*)projPosition_clusterSet {
	[self willAccessValueForKey:@"projPosition_cluster"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projPosition_cluster"];
  
	[self didAccessValueForKey:@"projPosition_cluster"];
	return result;
}
	

@dynamic projPosition_project;

	
- (NSMutableSet*)projPosition_projectSet {
	[self willAccessValueForKey:@"projPosition_project"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projPosition_project"];
  
	[self didAccessValueForKey:@"projPosition_project"];
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
