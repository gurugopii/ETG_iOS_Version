// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllPpmsActivity.m instead.

#import "_ETGPllPpmsActivity.h"

const struct ETGPllPpmsActivityAttributes ETGPllPpmsActivityAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGPllPpmsActivityRelationships ETGPllPpmsActivityRelationships = {
};

const struct ETGPllPpmsActivityFetchedProperties ETGPllPpmsActivityFetchedProperties = {
};

@implementation ETGPllPpmsActivityID
@end

@implementation _ETGPllPpmsActivity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPllPpmsActivity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPllPpmsActivity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPllPpmsActivity" inManagedObjectContext:moc_];
}

- (ETGPllPpmsActivityID*)objectID {
	return (ETGPllPpmsActivityID*)[super objectID];
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
