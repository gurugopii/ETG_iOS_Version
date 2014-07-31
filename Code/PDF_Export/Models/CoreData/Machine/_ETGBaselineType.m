// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGBaselineType.m instead.

#import "_ETGBaselineType.h"

const struct ETGBaselineTypeAttributes ETGBaselineTypeAttributes = {
	.createdTime = @"createdTime",
	.key = @"key",
	.name = @"name",
	.projectKey = @"projectKey",
	.reportMonth = @"reportMonth",
};

const struct ETGBaselineTypeRelationships ETGBaselineTypeRelationships = {
	.projectSummary = @"projectSummary",
	.projectSummaryForMap = @"projectSummaryForMap",
	.revisions = @"revisions",
	.scorecard = @"scorecard",
};

const struct ETGBaselineTypeFetchedProperties ETGBaselineTypeFetchedProperties = {
};

@implementation ETGBaselineTypeID
@end

@implementation _ETGBaselineType

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGBaselineType" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGBaselineType";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGBaselineType" inManagedObjectContext:moc_];
}

- (ETGBaselineTypeID*)objectID {
	return (ETGBaselineTypeID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"keyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"key"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"projectKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic createdTime;






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






@dynamic projectKey;



- (int32_t)projectKeyValue {
	NSNumber *result = [self projectKey];
	return [result intValue];
}

- (void)setProjectKeyValue:(int32_t)value_ {
	[self setProjectKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveProjectKeyValue {
	NSNumber *result = [self primitiveProjectKey];
	return [result intValue];
}

- (void)setPrimitiveProjectKeyValue:(int32_t)value_ {
	[self setPrimitiveProjectKey:[NSNumber numberWithInt:value_]];
}





@dynamic reportMonth;






@dynamic projectSummary;

	

@dynamic projectSummaryForMap;

	

@dynamic revisions;

	
- (NSMutableSet*)revisionsSet {
	[self willAccessValueForKey:@"revisions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"revisions"];
  
	[self didAccessValueForKey:@"revisions"];
	return result;
}
	

@dynamic scorecard;

	






@end
