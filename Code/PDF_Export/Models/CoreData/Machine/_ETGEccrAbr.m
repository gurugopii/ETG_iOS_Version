// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrAbr.m instead.

#import "_ETGEccrAbr.h"

const struct ETGEccrAbrAttributes ETGEccrAbrAttributes = {
	.approvedABR = @"approvedABR",
	.dataTimeNm = @"dataTimeNm",
	.indicator = @"indicator",
	.projectCostCategoryKey = @"projectCostCategoryKey",
	.projectKey = @"projectKey",
	.regionKey = @"regionKey",
	.submittedABR = @"submittedABR",
};

const struct ETGEccrAbrRelationships ETGEccrAbrRelationships = {
	.reportingMonth = @"reportingMonth",
};

const struct ETGEccrAbrFetchedProperties ETGEccrAbrFetchedProperties = {
};

@implementation ETGEccrAbrID
@end

@implementation _ETGEccrAbr

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrAbr" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrAbr";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrAbr" inManagedObjectContext:moc_];
}

- (ETGEccrAbrID*)objectID {
	return (ETGEccrAbrID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"approvedABRValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"approvedABR"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"projectCostCategoryKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectCostCategoryKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"projectKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"regionKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"regionKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"submittedABRValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"submittedABR"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic approvedABR;



- (int32_t)approvedABRValue {
	NSNumber *result = [self approvedABR];
	return [result intValue];
}

- (void)setApprovedABRValue:(int32_t)value_ {
	[self setApprovedABR:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveApprovedABRValue {
	NSNumber *result = [self primitiveApprovedABR];
	return [result intValue];
}

- (void)setPrimitiveApprovedABRValue:(int32_t)value_ {
	[self setPrimitiveApprovedABR:[NSNumber numberWithInt:value_]];
}





@dynamic dataTimeNm;






@dynamic indicator;






@dynamic projectCostCategoryKey;



- (int32_t)projectCostCategoryKeyValue {
	NSNumber *result = [self projectCostCategoryKey];
	return [result intValue];
}

- (void)setProjectCostCategoryKeyValue:(int32_t)value_ {
	[self setProjectCostCategoryKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveProjectCostCategoryKeyValue {
	NSNumber *result = [self primitiveProjectCostCategoryKey];
	return [result intValue];
}

- (void)setPrimitiveProjectCostCategoryKeyValue:(int32_t)value_ {
	[self setPrimitiveProjectCostCategoryKey:[NSNumber numberWithInt:value_]];
}





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





@dynamic submittedABR;



- (int32_t)submittedABRValue {
	NSNumber *result = [self submittedABR];
	return [result intValue];
}

- (void)setSubmittedABRValue:(int32_t)value_ {
	[self setSubmittedABR:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveSubmittedABRValue {
	NSNumber *result = [self primitiveSubmittedABR];
	return [result intValue];
}

- (void)setPrimitiveSubmittedABRValue:(int32_t)value_ {
	[self setPrimitiveSubmittedABR:[NSNumber numberWithInt:value_]];
}





@dynamic reportingMonth;

	






@end
