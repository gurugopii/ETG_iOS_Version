// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsAfeDetail.m instead.

#import "_ETGEccrCpsAfeDetail.h"

const struct ETGEccrCpsAfeDetailAttributes ETGEccrCpsAfeDetailAttributes = {
	.afcAmt = @"afcAmt",
	.afeId = @"afeId",
	.afeKey = @"afeKey",
	.cumVowdAmt = @"cumVowdAmt",
	.gInd = @"gInd",
	.latestAfeAmt = @"latestAfeAmt",
	.originalAfeAmt = @"originalAfeAmt",
	.sequence = @"sequence",
	.variance = @"variance",
	.wbsId = @"wbsId",
	.wbsKey = @"wbsKey",
};

const struct ETGEccrCpsAfeDetailRelationships ETGEccrCpsAfeDetailRelationships = {
	.afeForCapex = @"afeForCapex",
	.afeForOpex = @"afeForOpex",
};

const struct ETGEccrCpsAfeDetailFetchedProperties ETGEccrCpsAfeDetailFetchedProperties = {
};

@implementation ETGEccrCpsAfeDetailID
@end

@implementation _ETGEccrCpsAfeDetail

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpsAfeDetail" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpsAfeDetail";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpsAfeDetail" inManagedObjectContext:moc_];
}

- (ETGEccrCpsAfeDetailID*)objectID {
	return (ETGEccrCpsAfeDetailID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"afeKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"afeKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"sequenceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sequence"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"wbsKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"wbsKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic afcAmt;






@dynamic afeId;






@dynamic afeKey;



- (int32_t)afeKeyValue {
	NSNumber *result = [self afeKey];
	return [result intValue];
}

- (void)setAfeKeyValue:(int32_t)value_ {
	[self setAfeKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveAfeKeyValue {
	NSNumber *result = [self primitiveAfeKey];
	return [result intValue];
}

- (void)setPrimitiveAfeKeyValue:(int32_t)value_ {
	[self setPrimitiveAfeKey:[NSNumber numberWithInt:value_]];
}





@dynamic cumVowdAmt;






@dynamic gInd;






@dynamic latestAfeAmt;






@dynamic originalAfeAmt;






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





@dynamic afeForCapex;

	

@dynamic afeForOpex;

	






@end
