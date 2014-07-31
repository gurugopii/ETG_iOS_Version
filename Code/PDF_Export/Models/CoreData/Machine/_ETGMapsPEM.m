// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMapsPEM.m instead.

#import "_ETGMapsPEM.h"

const struct ETGMapsPEMAttributes ETGMapsPEMAttributes = {
	.exedifferentMM = @"exedifferentMM",
	.fdpdifferentMM = @"fdpdifferentMM",
	.indicator = @"indicator",
	.projectKey = @"projectKey",
	.projectName = @"projectName",
	.psc = @"psc",
	.pscKey = @"pscKey",
	.region = @"region",
	.regionKey = @"regionKey",
	.riskCategory = @"riskCategory",
	.riskCategoryKey = @"riskCategoryKey",
	.status = @"status",
	.statusKey = @"statusKey",
};

const struct ETGMapsPEMRelationships ETGMapsPEMRelationships = {
	.etgMap = @"etgMap",
};

const struct ETGMapsPEMFetchedProperties ETGMapsPEMFetchedProperties = {
};

@implementation ETGMapsPEMID
@end

@implementation _ETGMapsPEM

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMapsPEM" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMapsPEM";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMapsPEM" inManagedObjectContext:moc_];
}

- (ETGMapsPEMID*)objectID {
	return (ETGMapsPEMID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"projectKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"pscKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pscKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"regionKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"regionKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"riskCategoryKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"riskCategoryKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"statusKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"statusKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic exedifferentMM;






@dynamic fdpdifferentMM;






@dynamic indicator;






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





@dynamic projectName;






@dynamic psc;






@dynamic pscKey;



- (int32_t)pscKeyValue {
	NSNumber *result = [self pscKey];
	return [result intValue];
}

- (void)setPscKeyValue:(int32_t)value_ {
	[self setPscKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePscKeyValue {
	NSNumber *result = [self primitivePscKey];
	return [result intValue];
}

- (void)setPrimitivePscKeyValue:(int32_t)value_ {
	[self setPrimitivePscKey:[NSNumber numberWithInt:value_]];
}





@dynamic region;






@dynamic regionKey;



- (int32_t)regionKeyValue {
	NSNumber *result = [self regionKey];
	return [result intValue];
}

- (void)setRegionKeyValue:(int32_t)value_ {
	[self setRegionKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveRegionKeyValue {
	NSNumber *result = [self primitiveRegionKey];
	return [result intValue];
}

- (void)setPrimitiveRegionKeyValue:(int32_t)value_ {
	[self setPrimitiveRegionKey:[NSNumber numberWithInt:value_]];
}





@dynamic riskCategory;






@dynamic riskCategoryKey;



- (int32_t)riskCategoryKeyValue {
	NSNumber *result = [self riskCategoryKey];
	return [result intValue];
}

- (void)setRiskCategoryKeyValue:(int32_t)value_ {
	[self setRiskCategoryKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveRiskCategoryKeyValue {
	NSNumber *result = [self primitiveRiskCategoryKey];
	return [result intValue];
}

- (void)setPrimitiveRiskCategoryKeyValue:(int32_t)value_ {
	[self setPrimitiveRiskCategoryKey:[NSNumber numberWithInt:value_]];
}





@dynamic status;






@dynamic statusKey;



- (int32_t)statusKeyValue {
	NSNumber *result = [self statusKey];
	return [result intValue];
}

- (void)setStatusKeyValue:(int32_t)value_ {
	[self setStatusKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveStatusKeyValue {
	NSNumber *result = [self primitiveStatusKey];
	return [result intValue];
}

- (void)setPrimitiveStatusKeyValue:(int32_t)value_ {
	[self setPrimitiveStatusKey:[NSNumber numberWithInt:value_]];
}





@dynamic etgMap;

	






@end
