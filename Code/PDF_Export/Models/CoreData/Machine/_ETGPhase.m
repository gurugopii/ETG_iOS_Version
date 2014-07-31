// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPhase.m instead.

#import "_ETGPhase.h"

const struct ETGPhaseAttributes ETGPhaseAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGPhaseRelationships ETGPhaseRelationships = {
	.project = @"project",
};

const struct ETGPhaseFetchedProperties ETGPhaseFetchedProperties = {
};

@implementation ETGPhaseID
@end

@implementation _ETGPhase

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPhase" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPhase";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPhase" inManagedObjectContext:moc_];
}

- (ETGPhaseID*)objectID {
	return (ETGPhaseID*)[super objectID];
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
