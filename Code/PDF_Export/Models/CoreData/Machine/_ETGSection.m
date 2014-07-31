// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGSection.m instead.

#import "_ETGSection.h"

const struct ETGSectionAttributes ETGSectionAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGSectionRelationships ETGSectionRelationships = {
	.department = @"department",
	.departmentSection = @"departmentSection",
	.reportingPeriods = @"reportingPeriods",
};

const struct ETGSectionFetchedProperties ETGSectionFetchedProperties = {
};

@implementation ETGSectionID
@end

@implementation _ETGSection

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGSection" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGSection";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGSection" inManagedObjectContext:moc_];
}

- (ETGSectionID*)objectID {
	return (ETGSectionID*)[super objectID];
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






@dynamic department;

	
- (NSMutableSet*)departmentSet {
	[self willAccessValueForKey:@"department"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"department"];
  
	[self didAccessValueForKey:@"department"];
	return result;
}
	

@dynamic departmentSection;

	
- (NSMutableSet*)departmentSectionSet {
	[self willAccessValueForKey:@"departmentSection"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"departmentSection"];
  
	[self didAccessValueForKey:@"departmentSection"];
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
