// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllAreasDisciplines.m instead.

#import "_ETGPllAreasDisciplines.h"

const struct ETGPllAreasDisciplinesAttributes ETGPllAreasDisciplinesAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGPllAreasDisciplinesRelationships ETGPllAreasDisciplinesRelationships = {
	.disciplines = @"disciplines",
};

const struct ETGPllAreasDisciplinesFetchedProperties ETGPllAreasDisciplinesFetchedProperties = {
};

@implementation ETGPllAreasDisciplinesID
@end

@implementation _ETGPllAreasDisciplines

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPllAreasDisciplines" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPllAreasDisciplines";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPllAreasDisciplines" inManagedObjectContext:moc_];
}

- (ETGPllAreasDisciplinesID*)objectID {
	return (ETGPllAreasDisciplinesID*)[super objectID];
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






@dynamic disciplines;

	
- (NSMutableSet*)disciplinesSet {
	[self willAccessValueForKey:@"disciplines"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"disciplines"];
  
	[self didAccessValueForKey:@"disciplines"];
	return result;
}
	






@end
