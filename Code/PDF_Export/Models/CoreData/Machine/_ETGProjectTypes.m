// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectTypes.m instead.

#import "_ETGProjectTypes.h"

const struct ETGProjectTypesAttributes ETGProjectTypesAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGProjectTypesRelationships ETGProjectTypesRelationships = {
	.project = @"project",
};

const struct ETGProjectTypesFetchedProperties ETGProjectTypesFetchedProperties = {
};

@implementation ETGProjectTypesID
@end

@implementation _ETGProjectTypes

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProjectTypes" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProjectTypes";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProjectTypes" inManagedObjectContext:moc_];
}

- (ETGProjectTypesID*)objectID {
	return (ETGProjectTypesID*)[super objectID];
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






@dynamic project;

	
- (NSMutableSet*)projectSet {
	[self willAccessValueForKey:@"project"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"project"];
  
	[self didAccessValueForKey:@"project"];
	return result;
}
	






@end
