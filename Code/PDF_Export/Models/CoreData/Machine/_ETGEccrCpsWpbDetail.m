// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsWpbDetail.m instead.

#import "_ETGEccrCpsWpbDetail.h"

const struct ETGEccrCpsWpbDetailAttributes ETGEccrCpsWpbDetailAttributes = {
	.activityKey = @"activityKey",
	.activityName = @"activityName",
	.approvedABR = @"approvedABR",
	.approvedCO = @"approvedCO",
	.budgetItemKey = @"budgetItemKey",
	.budgetItemName = @"budgetItemName",
	.currentMonthYEP = @"currentMonthYEP",
	.currentMonthYTDActual = @"currentMonthYTDActual",
	.gInd = @"gInd",
	.latestWPB = @"latestWPB",
	.originalWPB = @"originalWPB",
	.sequence = @"sequence",
	.structureKey = @"structureKey",
	.structureName = @"structureName",
	.variance = @"variance",
	.wbsId = @"wbsId",
	.wbsKey = @"wbsKey",
};

const struct ETGEccrCpsWpbDetailRelationships ETGEccrCpsWpbDetailRelationships = {
	.wpbForCapex = @"wpbForCapex",
	.wpbForOpex = @"wpbForOpex",
};

const struct ETGEccrCpsWpbDetailFetchedProperties ETGEccrCpsWpbDetailFetchedProperties = {
};

@implementation ETGEccrCpsWpbDetailID
@end

@implementation _ETGEccrCpsWpbDetail

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpsWpbDetail" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpsWpbDetail";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpsWpbDetail" inManagedObjectContext:moc_];
}

- (ETGEccrCpsWpbDetailID*)objectID {
	return (ETGEccrCpsWpbDetailID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"activityKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"activityKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"budgetItemKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"budgetItemKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"sequenceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sequence"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"structureKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"structureKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"wbsKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"wbsKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic activityKey;



- (int32_t)activityKeyValue {
	NSNumber *result = [self activityKey];
	return [result intValue];
}

- (void)setActivityKeyValue:(int32_t)value_ {
	[self setActivityKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveActivityKeyValue {
	NSNumber *result = [self primitiveActivityKey];
	return [result intValue];
}

- (void)setPrimitiveActivityKeyValue:(int32_t)value_ {
	[self setPrimitiveActivityKey:[NSNumber numberWithInt:value_]];
}





@dynamic activityName;






@dynamic approvedABR;






@dynamic approvedCO;






@dynamic budgetItemKey;



- (int32_t)budgetItemKeyValue {
	NSNumber *result = [self budgetItemKey];
	return [result intValue];
}

- (void)setBudgetItemKeyValue:(int32_t)value_ {
	[self setBudgetItemKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveBudgetItemKeyValue {
	NSNumber *result = [self primitiveBudgetItemKey];
	return [result intValue];
}

- (void)setPrimitiveBudgetItemKeyValue:(int32_t)value_ {
	[self setPrimitiveBudgetItemKey:[NSNumber numberWithInt:value_]];
}





@dynamic budgetItemName;






@dynamic currentMonthYEP;






@dynamic currentMonthYTDActual;






@dynamic gInd;






@dynamic latestWPB;






@dynamic originalWPB;






@dynamic sequence;



- (int32_t)sequenceValue {
	NSNumber *result = [self sequence];
	return [result intValue];
}

- (void)setSequenceValue:(int32_t)value_ {
	[self setSequence:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveSequenceValue {
	NSNumber *result = [self primitiveSequence];
	return [result intValue];
}

- (void)setPrimitiveSequenceValue:(int32_t)value_ {
	[self setPrimitiveSequence:[NSNumber numberWithInt:value_]];
}





@dynamic structureKey;



- (int32_t)structureKeyValue {
	NSNumber *result = [self structureKey];
	return [result intValue];
}

- (void)setStructureKeyValue:(int32_t)value_ {
	[self setStructureKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveStructureKeyValue {
	NSNumber *result = [self primitiveStructureKey];
	return [result intValue];
}

- (void)setPrimitiveStructureKeyValue:(int32_t)value_ {
	[self setPrimitiveStructureKey:[NSNumber numberWithInt:value_]];
}





@dynamic structureName;






@dynamic variance;






@dynamic wbsId;






@dynamic wbsKey;



- (int32_t)wbsKeyValue {
	NSNumber *result = [self wbsKey];
	return [result intValue];
}

- (void)setWbsKeyValue:(int32_t)value_ {
	[self setWbsKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveWbsKeyValue {
	NSNumber *result = [self primitiveWbsKey];
	return [result intValue];
}

- (void)setPrimitiveWbsKeyValue:(int32_t)value_ {
	[self setPrimitiveWbsKey:[NSNumber numberWithInt:value_]];
}





@dynamic wpbForCapex;

	

@dynamic wpbForOpex;

	






@end
