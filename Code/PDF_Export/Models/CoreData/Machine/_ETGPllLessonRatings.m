// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllLessonRatings.m instead.

#import "_ETGPllLessonRatings.h"

const struct ETGPllLessonRatingsAttributes ETGPllLessonRatingsAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGPllLessonRatingsRelationships ETGPllLessonRatingsRelationships = {
};

const struct ETGPllLessonRatingsFetchedProperties ETGPllLessonRatingsFetchedProperties = {
};

@implementation ETGPllLessonRatingsID
@end

@implementation _ETGPllLessonRatings

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPllLessonRatings" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPllLessonRatings";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPllLessonRatings" inManagedObjectContext:moc_];
}

- (ETGPllLessonRatingsID*)objectID {
	return (ETGPllLessonRatingsID*)[super objectID];
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
