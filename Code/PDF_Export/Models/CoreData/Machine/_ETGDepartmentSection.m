// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGDepartmentSection.m instead.

#import "_ETGDepartmentSection.h"

const struct ETGDepartmentSectionAttributes ETGDepartmentSectionAttributes = {
	.filterName = @"filterName",
	.key = @"key",
	.reportingPeriod = @"reportingPeriod",
};

const struct ETGDepartmentSectionRelationships ETGDepartmentSectionRelationships = {
	.sections = @"sections",
};

const struct ETGDepartmentSectionFetchedProperties ETGDepartmentSectionFetchedProperties = {
};

@implementation ETGDepartmentSectionID
@end

@implementation _ETGDepartmentSection

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGDepartmentSection" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGDepartmentSection";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGDepartmentSection" inManagedObjectContext:moc_];
}

- (ETGDepartmentSectionID*)objectID {
	return (ETGDepartmentSectionID*)[super objectID];
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






@dynamic sections;

	
- (NSMutableSet*)sectionsSet {
	[self willAccessValueForKey:@"sections"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"sections"];
  
	[self didAccessValueForKey:@"sections"];
	return result;
}
	






@end
