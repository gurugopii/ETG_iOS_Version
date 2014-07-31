// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCostAllocation.m instead.

#import "_ETGCostAllocation.h"

const struct ETGCostAllocationAttributes ETGCostAllocationAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGCostAllocationRelationships ETGCostAllocationRelationships = {
	.budgetPerformances = @"budgetPerformances",
	.cpbs = @"cpbs",
	.projects = @"projects",
};

const struct ETGCostAllocationFetchedProperties ETGCostAllocationFetchedProperties = {
};

@implementation ETGCostAllocationID
@end

@implementation _ETGCostAllocation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGCostAllocation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGCostAllocation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGCostAllocation" inManagedObjectContext:moc_];
}

- (ETGCostAllocationID*)objectID {
	return (ETGCostAllocationID*)[super objectID];
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






@dynamic budgetPerformances;

	
- (NSMutableSet*)budgetPerformancesSet {
	[self willAccessValueForKey:@"budgetPerformances"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"budgetPerformances"];
  
	[self didAccessValueForKey:@"budgetPerformances"];
	return result;
}
	

@dynamic cpbs;

	
- (NSMutableSet*)cpbsSet {
	[self willAccessValueForKey:@"cpbs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"cpbs"];
  
	[self didAccessValueForKey:@"cpbs"];
	return result;
}
	

@dynamic projects;

	
- (NSMutableSet*)projectsSet {
	[self willAccessValueForKey:@"projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projects"];
  
	[self didAccessValueForKey:@"projects"];
	return result;
}
	






@end
