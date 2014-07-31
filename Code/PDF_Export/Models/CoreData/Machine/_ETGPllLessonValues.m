// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllLessonValues.m instead.

#import "_ETGPllLessonValues.h"

const struct ETGPllLessonValuesAttributes ETGPllLessonValuesAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGPllLessonValuesRelationships ETGPllLessonValuesRelationships = {
};

const struct ETGPllLessonValuesFetchedProperties ETGPllLessonValuesFetchedProperties = {
};

@implementation ETGPllLessonValuesID
@end

@implementation _ETGPllLessonValues

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPllLessonValues" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPllLessonValues";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPllLessonValues" inManagedObjectContext:moc_];
}

- (ETGPllLessonValuesID*)objectID {
	return (ETGPllLessonValuesID*)[super objectID];
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











@end
