// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGWellDetails.m instead.

#import "_ETGWellDetails.h"

const struct ETGWellDetailsAttributes ETGWellDetailsAttributes = {
	.condyIndicator = @"condyIndicator",
	.condyOutlook = @"condyOutlook",
	.condyPlanned = @"condyPlanned",
	.dataTimeKey = @"dataTimeKey",
	.gasIndicator = @"gasIndicator",
	.gasOutlook = @"gasOutlook",
	.gasPlanned = @"gasPlanned",
	.oilIndicator = @"oilIndicator",
	.oilOutlook = @"oilOutlook",
	.oilPlanned = @"oilPlanned",
	.rtbdIndicator = @"rtbdIndicator",
	.rtbdOutlook = @"rtbdOutlook",
	.rtbdPlanned = @"rtbdPlanned",
	.sort = @"sort",
	.wellName = @"wellName",
};

const struct ETGWellDetailsRelationships ETGWellDetailsRelationships = {
	.facility = @"facility",
};

const struct ETGWellDetailsFetchedProperties ETGWellDetailsFetchedProperties = {
};

@implementation ETGWellDetailsID
@end

@implementation _ETGWellDetails

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGWellDetail" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGWellDetail";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGWellDetail" inManagedObjectContext:moc_];
}

- (ETGWellDetailsID*)objectID {
	return (ETGWellDetailsID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"condyOutlookValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"condyOutlook"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"condyPlannedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"condyPlanned"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"gasOutlookValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"gasOutlook"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"gasPlannedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"gasPlanned"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"oilOutlookValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"oilOutlook"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"oilPlannedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"oilPlanned"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"rtbdOutlookValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rtbdOutlook"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"rtbdPlannedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rtbdPlanned"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"sortValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sort"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic condyIndicator;






@dynamic condyOutlook;



- (double)condyOutlookValue {
	NSNumber *result = [self condyOutlook];
	return [result doubleValue];
}

- (void)setCondyOutlookValue:(double)value_ {
	[self setCondyOutlook:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveCondyOutlookValue {
	NSNumber *result = [self primitiveCondyOutlook];
	return [result doubleValue];
}

- (void)setPrimitiveCondyOutlookValue:(double)value_ {
	[self setPrimitiveCondyOutlook:[NSNumber numberWithDouble:value_]];
}





@dynamic condyPlanned;



- (double)condyPlannedValue {
	NSNumber *result = [self condyPlanned];
	return [result doubleValue];
}

- (void)setCondyPlannedValue:(double)value_ {
	[self setCondyPlanned:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveCondyPlannedValue {
	NSNumber *result = [self primitiveCondyPlanned];
	return [result doubleValue];
}

- (void)setPrimitiveCondyPlannedValue:(double)value_ {
	[self setPrimitiveCondyPlanned:[NSNumber numberWithDouble:value_]];
}





@dynamic dataTimeKey;






@dynamic gasIndicator;






@dynamic gasOutlook;



- (double)gasOutlookValue {
	NSNumber *result = [self gasOutlook];
	return [result doubleValue];
}

- (void)setGasOutlookValue:(double)value_ {
	[self setGasOutlook:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveGasOutlookValue {
	NSNumber *result = [self primitiveGasOutlook];
	return [result doubleValue];
}

- (void)setPrimitiveGasOutlookValue:(double)value_ {
	[self setPrimitiveGasOutlook:[NSNumber numberWithDouble:value_]];
}





@dynamic gasPlanned;



- (double)gasPlannedValue {
	NSNumber *result = [self gasPlanned];
	return [result doubleValue];
}

- (void)setGasPlannedValue:(double)value_ {
	[self setGasPlanned:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveGasPlannedValue {
	NSNumber *result = [self primitiveGasPlanned];
	return [result doubleValue];
}

- (void)setPrimitiveGasPlannedValue:(double)value_ {
	[self setPrimitiveGasPlanned:[NSNumber numberWithDouble:value_]];
}





@dynamic oilIndicator;






@dynamic oilOutlook;



- (double)oilOutlookValue {
	NSNumber *result = [self oilOutlook];
	return [result doubleValue];
}

- (void)setOilOutlookValue:(double)value_ {
	[self setOilOutlook:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveOilOutlookValue {
	NSNumber *result = [self primitiveOilOutlook];
	return [result doubleValue];
}

- (void)setPrimitiveOilOutlookValue:(double)value_ {
	[self setPrimitiveOilOutlook:[NSNumber numberWithDouble:value_]];
}





@dynamic oilPlanned;



- (double)oilPlannedValue {
	NSNumber *result = [self oilPlanned];
	return [result doubleValue];
}

- (void)setOilPlannedValue:(double)value_ {
	[self setOilPlanned:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveOilPlannedValue {
	NSNumber *result = [self primitiveOilPlanned];
	return [result doubleValue];
}

- (void)setPrimitiveOilPlannedValue:(double)value_ {
	[self setPrimitiveOilPlanned:[NSNumber numberWithDouble:value_]];
}





@dynamic rtbdIndicator;






@dynamic rtbdOutlook;



- (double)rtbdOutlookValue {
	NSNumber *result = [self rtbdOutlook];
	return [result doubleValue];
}

- (void)setRtbdOutlookValue:(double)value_ {
	[self setRtbdOutlook:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveRtbdOutlookValue {
	NSNumber *result = [self primitiveRtbdOutlook];
	return [result doubleValue];
}

- (void)setPrimitiveRtbdOutlookValue:(double)value_ {
	[self setPrimitiveRtbdOutlook:[NSNumber numberWithDouble:value_]];
}





@dynamic rtbdPlanned;



- (double)rtbdPlannedValue {
	NSNumber *result = [self rtbdPlanned];
	return [result doubleValue];
}

- (void)setRtbdPlannedValue:(double)value_ {
	[self setRtbdPlanned:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveRtbdPlannedValue {
	NSNumber *result = [self primitiveRtbdPlanned];
	return [result doubleValue];
}

- (void)setPrimitiveRtbdPlannedValue:(double)value_ {
	[self setPrimitiveRtbdPlanned:[NSNumber numberWithDouble:value_]];
}





@dynamic sort;



- (int32_t)sortValue {
	NSNumber *result = [self sort];
	return [result intValue];
}

- (void)setSortValue:(int32_t)value_ {
	[self setSort:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveSortValue {
	NSNumber *result = [self primitiveSort];
	return [result intValue];
}

- (void)setPrimitiveSortValue:(int32_t)value_ {
	[self setPrimitiveSort:[NSNumber numberWithInt:value_]];
}





@dynamic wellName;






@dynamic facility;

	






@end
