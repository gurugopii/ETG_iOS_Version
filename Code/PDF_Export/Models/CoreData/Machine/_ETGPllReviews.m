// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllReviews.m instead.

#import "_ETGPllReviews.h"

const struct ETGPllReviewsAttributes ETGPllReviewsAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGPllReviewsRelationships ETGPllReviewsRelationships = {
};

const struct ETGPllReviewsFetchedProperties ETGPllReviewsFetchedProperties = {
};

@implementation ETGPllReviewsID
@end

@implementation _ETGPllReviews

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPllReviews" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPllReviews";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPllReviews" inManagedObjectContext:moc_];
}

- (ETGPllReviewsID*)objectID {
	return (ETGPllReviewsID*)[super objectID];
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
