// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsFdpDetail.m instead.

#import "_ETGEccrCpsFdpDetail.h"

const struct ETGEccrCpsFdpDetailAttributes ETGEccrCpsFdpDetailAttributes = {
	.activityID = @"activityID",
	.activityKey = @"activityKey",
	.activityName = @"activityName",
	.afcAmt = @"afcAmt",
	.costItemKey = @"costItemKey",
	.costItemame = @"costItemame",
	.cumVOWDAmt = @"cumVOWDAmt",
	.facilityKey = @"facilityKey",
	.facilityName = @"facilityName",
	.fdpAmt = @"fdpAmt",
	.fiaAmt = @"fiaAmt",
	.gInd = @"gInd",
	.sequence = @"sequence",
	.structureKey = @"structureKey",
	.structureName = @"structureName",
	.variance = @"variance",
};

const struct ETGEccrCpsFdpDetailRelationships ETGEccrCpsFdpDetailRelationships = {
	.fdpForCapex = @"fdpForCapex",
	.fdpForOpex = @"fdpForOpex",
};

const struct ETGEccrCpsFdpDetailFetchedProperties ETGEccrCpsFdpDetailFetchedProperties = {
};

@implementation ETGEccrCpsFdpDetailID
@end

@implementation _ETGEccrCpsFdpDetail

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpsFdpDetail" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpsFdpDetail";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpsFdpDetail" inManagedObjectContext:moc_];
}

- (ETGEccrCpsFdpDetailID*)objectID {
	return (ETGEccrCpsFdpDetailID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"activityIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"activityID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"activityKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"activityKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"costItemKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"costItemKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"facilityKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"facilityKey"];
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

	return keyPaths;
}




@dynamic activityID;



- (int32_t)activityIDValue {
	NSNumber *result = [self activityID];
	return [result intValue];
}

- (void)setActivityIDValue:(int32_t)value_ {
	[self setActivityID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveActivityIDValue {
	NSNumber *result = [self primitiveActivityID];
	return [result intValue];
}

- (void)setPrimitiveActivityIDValue:(int32_t)value_ {
	[self setPrimitiveActivityID:[NSNumber numberWithInt:value_]];
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






@dynamic afcAmt;






@dynamic costItemKey;



- (int32_t)costItemKeyValue {
	NSNumber *result = [self costItemKey];
	return [result intValue];
}

- (void)setCostItemKeyValue:(int32_t)value_ {
	[self setCostItemKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCostItemKeyValue {
	NSNumber *result = [self primitiveCostItemKey];
	return [result intValue];
}

- (void)setPrimitiveCostItemKeyValue:(int32_t)value_ {
	[self setPrimitiveCostItemKey:[NSNumber numberWithInt:value_]];
}





@dynamic costItemame;






@dynamic cumVOWDAmt;






@dynamic facilityKey;



- (int32_t)facilityKeyValue {
	NSNumber *result = [self facilityKey];
	return [result intValue];
}

- (void)setFacilityKeyValue:(int32_t)value_ {
	[self setFacilityKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFacilityKeyValue {
	NSNumber *result = [self primitiveFacilityKey];
	return [result intValue];
}

- (void)setPrimitiveFacilityKeyValue:(int32_t)value_ {
	[self setPrimitiveFacilityKey:[NSNumber numberWithInt:value_]];
}





@dynamic facilityName;






@dynamic fdpAmt;






@dynamic fiaAmt;






@dynamic gInd;






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






@dynamic fdpForCapex;

	

@dynamic fdpForOpex;

	






@end
