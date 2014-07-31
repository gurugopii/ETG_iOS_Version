// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectStatus.m instead.

#import "_ETGProjectStatus.h"

const struct ETGProjectStatusAttributes ETGProjectStatusAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGProjectStatusRelationships ETGProjectStatusRelationships = {
	.project = @"project",
};

const struct ETGProjectStatusFetchedProperties ETGProjectStatusFetchedProperties = {
};

@implementation ETGProjectStatusID
@end

@implementation _ETGProjectStatus

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProjectStatus" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProjectStatus";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProjectStatus" inManagedObjectContext:moc_];
}

- (ETGProjectStatusID*)objectID {
	return (ETGProjectStatusID*)[super objectID];
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
