// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGRevision.m instead.

#import "_ETGRevision.h"

const struct ETGRevisionAttributes ETGRevisionAttributes = {
	.number = @"number",
};

const struct ETGRevisionRelationships ETGRevisionRelationships = {
	.baselinetype = @"baselinetype",
	.keyMilestones = @"keyMilestones",
};

const struct ETGRevisionFetchedProperties ETGRevisionFetchedProperties = {
};

@implementation ETGRevisionID
@end

@implementation _ETGRevision

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGRevision" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGRevision";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGRevision" inManagedObjectContext:moc_];
}

- (ETGRevisionID*)objectID {
	return (ETGRevisionID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic number;



- (int32_t)numberValue {
	NSNumber *result = [self number];
	return [result intValue];
}

- (void)setNumberValue:(int32_t)value_ {
	[self setNumber:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveNumberValue {
	NSNumber *result = [self primitiveNumber];
	return [result intValue];
}

- (void)setPrimitiveNumberValue:(int32_t)value_ {
	[self setPrimitiveNumber:[NSNumber numberWithInt:value_]];
}





@dynamic baselinetype;

	

@dynamic keyMilestones;

	
- (NSMutableSet*)keyMilestonesSet {
	[self willAccessValueForKey:@"keyMilestones"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"keyMilestones"];
  
	[self didAccessValueForKey:@"keyMilestones"];
	return result;
}
	






@end
