// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjetComplexities.m instead.

#import "_ETGProjetComplexities.h"

const struct ETGProjetComplexitiesAttributes ETGProjetComplexitiesAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGProjetComplexitiesRelationships ETGProjetComplexitiesRelationships = {
	.project = @"project",
};

const struct ETGProjetComplexitiesFetchedProperties ETGProjetComplexitiesFetchedProperties = {
};

@implementation ETGProjetComplexitiesID
@end

@implementation _ETGProjetComplexities

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProjetComplexities" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProjetComplexities";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProjetComplexities" inManagedObjectContext:moc_];
}

- (ETGProjetComplexitiesID*)objectID {
	return (ETGProjetComplexitiesID*)[super objectID];
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
