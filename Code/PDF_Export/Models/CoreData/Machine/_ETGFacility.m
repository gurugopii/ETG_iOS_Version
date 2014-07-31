// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGFacility.m instead.

#import "_ETGFacility.h"

const struct ETGFacilityAttributes ETGFacilityAttributes = {
	.name = @"name",
	.projectKey = @"projectKey",
	.reportMonth = @"reportMonth",
};

const struct ETGFacilityRelationships ETGFacilityRelationships = {
	.scorecard = @"scorecard",
	.wellDetails = @"wellDetails",
};

const struct ETGFacilityFetchedProperties ETGFacilityFetchedProperties = {
};

@implementation ETGFacilityID
@end

@implementation _ETGFacility

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGFacility" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGFacility";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGFacility" inManagedObjectContext:moc_];
}

- (ETGFacilityID*)objectID {
	return (ETGFacilityID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"projectKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
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






@dynamic scorecard;

	

@dynamic wellDetails;

	
- (NSMutableSet*)wellDetailsSet {
	[self willAccessValueForKey:@"wellDetails"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wellDetails"];
  
	[self didAccessValueForKey:@"wellDetails"];
	return result;
}
	






@end
