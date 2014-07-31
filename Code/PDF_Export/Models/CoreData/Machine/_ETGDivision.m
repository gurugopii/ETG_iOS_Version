// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGDivision.m instead.

#import "_ETGDivision.h"

const struct ETGDivisionAttributes ETGDivisionAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGDivisionRelationships ETGDivisionRelationships = {
	.departments = @"departments",
	.reportingPeriods = @"reportingPeriods",
};

const struct ETGDivisionFetchedProperties ETGDivisionFetchedProperties = {
};

@implementation ETGDivisionID
@end

@implementation _ETGDivision

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGDivision" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGDivision";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGDivision" inManagedObjectContext:moc_];
}

- (ETGDivisionID*)objectID {
	return (ETGDivisionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"keyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"key"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
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






@dynamic departments;

	
- (NSMutableSet*)departmentsSet {
	[self willAccessValueForKey:@"departments"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"departments"];
  
	[self didAccessValueForKey:@"departments"];
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
