// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllDisciplines.m instead.

#import "_ETGPllDisciplines.h"

const struct ETGPllDisciplinesAttributes ETGPllDisciplinesAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGPllDisciplinesRelationships ETGPllDisciplinesRelationships = {
	.area = @"area",
};

const struct ETGPllDisciplinesFetchedProperties ETGPllDisciplinesFetchedProperties = {
};

@implementation ETGPllDisciplinesID
@end

@implementation _ETGPllDisciplines

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPllDisciplines" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPllDisciplines";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPllDisciplines" inManagedObjectContext:moc_];
}

- (ETGPllDisciplinesID*)objectID {
	return (ETGPllDisciplinesID*)[super objectID];
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






@dynamic area;

	






@end
