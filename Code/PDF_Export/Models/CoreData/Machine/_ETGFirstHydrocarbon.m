// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGFirstHydrocarbon.m instead.

#import "_ETGFirstHydrocarbon.h"

const struct ETGFirstHydrocarbonAttributes ETGFirstHydrocarbonAttributes = {
	.actualDt = @"actualDt",
	.field = @"field",
	.fieldKey = @"fieldKey",
	.indicator = @"indicator",
	.plannedDt = @"plannedDt",
};

const struct ETGFirstHydrocarbonRelationships ETGFirstHydrocarbonRelationships = {
	.projectSummary = @"projectSummary",
	.projectSummaryForMap = @"projectSummaryForMap",
	.scorecard = @"scorecard",
};

const struct ETGFirstHydrocarbonFetchedProperties ETGFirstHydrocarbonFetchedProperties = {
};

@implementation ETGFirstHydrocarbonID
@end

@implementation _ETGFirstHydrocarbon

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGFirstHydrocarbon" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGFirstHydrocarbon";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGFirstHydrocarbon" inManagedObjectContext:moc_];
}

- (ETGFirstHydrocarbonID*)objectID {
	return (ETGFirstHydrocarbonID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"fieldKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fieldKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic actualDt;






@dynamic field;






@dynamic fieldKey;



- (int32_t)fieldKeyValue {
	NSNumber *result = [self fieldKey];
	return [result intValue];
}

- (void)setFieldKeyValue:(int32_t)value_ {
	[self setFieldKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFieldKeyValue {
	NSNumber *result = [self primitiveFieldKey];
	return [result intValue];
}

- (void)setPrimitiveFieldKeyValue:(int32_t)value_ {
	[self setPrimitiveFieldKey:[NSNumber numberWithInt:value_]];
}





@dynamic indicator;






@dynamic plannedDt;






@dynamic projectSummary;

	

@dynamic projectSummaryForMap;

	

@dynamic scorecard;

	






@end
