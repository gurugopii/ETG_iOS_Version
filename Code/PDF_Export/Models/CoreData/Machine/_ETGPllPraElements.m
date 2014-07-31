// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllPraElements.m instead.

#import "_ETGPllPraElements.h"

const struct ETGPllPraElementsAttributes ETGPllPraElementsAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGPllPraElementsRelationships ETGPllPraElementsRelationships = {
};

const struct ETGPllPraElementsFetchedProperties ETGPllPraElementsFetchedProperties = {
};

@implementation ETGPllPraElementsID
@end

@implementation _ETGPllPraElements

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPllPraElements" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPllPraElements";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPllPraElements" inManagedObjectContext:moc_];
}

- (ETGPllPraElementsID*)objectID {
	return (ETGPllPraElementsID*)[super objectID];
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
