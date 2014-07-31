// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpb.m instead.

#import "_ETGEccrCpb.h"

const struct ETGEccrCpbAttributes ETGEccrCpbAttributes = {
	.additionalCAPEX = @"additionalCAPEX",
	.afcAmt = @"afcAmt",
	.anticipatedCPB = @"anticipatedCPB",
	.btOutofBudgetHolder = @"btOutofBudgetHolder",
	.budgetHolderKey = @"budgetHolderKey",
	.isInternational = @"isInternational",
	.latestCPBAmt = @"latestCPBAmt",
	.newlySanctionAmt = @"newlySanctionAmt",
	.operatorShipKey = @"operatorShipKey",
	.originalCPBAmt = @"originalCPBAmt",
	.plantoSanction = @"plantoSanction",
	.potentialRisk = @"potentialRisk",
	.potentialUnderSpending = @"potentialUnderSpending",
	.potentialYEP = @"potentialYEP",
	.projectCostCategoryKey = @"projectCostCategoryKey",
	.projectKey = @"projectKey",
	.regionKey = @"regionKey",
	.yep = @"yep",
	.yepWithRisk = @"yepWithRisk",
};

const struct ETGEccrCpbRelationships ETGEccrCpbRelationships = {
	.reportingMonth = @"reportingMonth",
};

const struct ETGEccrCpbFetchedProperties ETGEccrCpbFetchedProperties = {
};

@implementation ETGEccrCpbID
@end

@implementation _ETGEccrCpb

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpb" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpb";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpb" inManagedObjectContext:moc_];
}

- (ETGEccrCpbID*)objectID {
	return (ETGEccrCpbID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"budgetHolderKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"budgetHolderKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"operatorShipKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"operatorShipKey"];
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

	return keyPaths;
}




@dynamic additionalCAPEX;






@dynamic afcAmt;






@dynamic anticipatedCPB;






@dynamic btOutofBudgetHolder;






@dynamic budgetHolderKey;



- (int32_t)budgetHolderKeyValue {
	NSNumber *result = [self budgetHolderKey];
	return [result intValue];
}

- (void)setBudgetHolderKeyValue:(int32_t)value_ {
	[self setBudgetHolderKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveBudgetHolderKeyValue {
	NSNumber *result = [self primitiveBudgetHolderKey];
	return [result intValue];
}

- (void)setPrimitiveBudgetHolderKeyValue:(int32_t)value_ {
	[self setPrimitiveBudgetHolderKey:[NSNumber numberWithInt:value_]];
}





@dynamic isInternational;






@dynamic latestCPBAmt;






@dynamic newlySanctionAmt;






@dynamic operatorShipKey;



- (int32_t)operatorShipKeyValue {
	NSNumber *result = [self operatorShipKey];
	return [result intValue];
}

- (void)setOperatorShipKeyValue:(int32_t)value_ {
	[self setOperatorShipKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveOperatorShipKeyValue {
	NSNumber *result = [self primitiveOperatorShipKey];
	return [result intValue];
}

- (void)setPrimitiveOperatorShipKeyValue:(int32_t)value_ {
	[self setPrimitiveOperatorShipKey:[NSNumber numberWithInt:value_]];
}





@dynamic originalCPBAmt;






@dynamic plantoSanction;






@dynamic potentialRisk;






@dynamic potentialUnderSpending;






@dynamic potentialYEP;






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





@dynamic yep;






@dynamic yepWithRisk;






@dynamic reportingMonth;

	






@end
