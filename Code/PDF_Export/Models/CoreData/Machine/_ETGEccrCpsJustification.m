// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsJustification.m instead.

#import "_ETGEccrCpsJustification.h"

const struct ETGEccrCpsJustificationAttributes ETGEccrCpsJustificationAttributes = {
	.activityKey = @"activityKey",
	.activityName = @"activityName",
	.budgetItemKey = @"budgetItemKey",
	.budgetItemName = @"budgetItemName",
	.justificationDesc = @"justificationDesc",
	.structureKey = @"structureKey",
	.structureName = @"structureName",
	.varianceAmt = @"varianceAmt",
	.varianceReasonName = @"varianceReasonName",
};

const struct ETGEccrCpsJustificationRelationships ETGEccrCpsJustificationRelationships = {
	.apc = @"apc",
	.cpb = @"cpb",
	.fdp = @"fdp",
	.wpb = @"wpb",
};

const struct ETGEccrCpsJustificationFetchedProperties ETGEccrCpsJustificationFetchedProperties = {
};

@implementation ETGEccrCpsJustificationID
@end

@implementation _ETGEccrCpsJustification

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpsJustification" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpsJustification";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpsJustification" inManagedObjectContext:moc_];
}

- (ETGEccrCpsJustificationID*)objectID {
	return (ETGEccrCpsJustificationID*)[super objectID];
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
	if ([key isEqualToString:@"structureKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"structureKey"];
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






@dynamic justificationDesc;






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






@dynamic varianceAmt;






@dynamic varianceReasonName;






@dynamic apc;

	

@dynamic cpb;

	

@dynamic fdp;

	

@dynamic wpb;

	






@end
