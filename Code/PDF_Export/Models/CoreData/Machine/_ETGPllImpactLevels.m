// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllImpactLevels.m instead.

#import "_ETGPllImpactLevels.h"

const struct ETGPllImpactLevelsAttributes ETGPllImpactLevelsAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGPllImpactLevelsRelationships ETGPllImpactLevelsRelationships = {
};

const struct ETGPllImpactLevelsFetchedProperties ETGPllImpactLevelsFetchedProperties = {
};

@implementation ETGPllImpactLevelsID
@end

@implementation _ETGPllImpactLevels

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPllImpactLevels" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPllImpactLevels";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPllImpactLevels" inManagedObjectContext:moc_];
}

- (ETGPllImpactLevelsID*)objectID {
	return (ETGPllImpactLevelsID*)[super objectID];
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
