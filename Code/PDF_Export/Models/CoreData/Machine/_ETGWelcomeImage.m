// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGWelcomeImage.m instead.

#import "_ETGWelcomeImage.h"

const struct ETGWelcomeImageAttributes ETGWelcomeImageAttributes = {
	.data = @"data",
	.key = @"key",
};

const struct ETGWelcomeImageRelationships ETGWelcomeImageRelationships = {
};

const struct ETGWelcomeImageFetchedProperties ETGWelcomeImageFetchedProperties = {
};

@implementation ETGWelcomeImageID
@end

@implementation _ETGWelcomeImage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGWelcomeImage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGWelcomeImage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGWelcomeImage" inManagedObjectContext:moc_];
}

- (ETGWelcomeImageID*)objectID {
	return (ETGWelcomeImageID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"keyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"key"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic data;






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










@end
