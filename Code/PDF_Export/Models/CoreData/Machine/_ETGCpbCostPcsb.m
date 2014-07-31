// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCpbCostPcsb.m instead.

#import "_ETGCpbCostPcsb.h"

const struct ETGCpbCostPcsbAttributes ETGCpbCostPcsbAttributes = {
	.indicator = @"indicator",
	.latestCpb = @"latestCpb",
	.originalCpb = @"originalCpb",
	.performanceName = @"performanceName",
	.variance = @"variance",
	.yep_e = @"yep_e",
	.ytdActual = @"ytdActual",
};

const struct ETGCpbCostPcsbRelationships ETGCpbCostPcsbRelationships = {
	.costPcsb = @"costPcsb",
};

const struct ETGCpbCostPcsbFetchedProperties ETGCpbCostPcsbFetchedProperties = {
};

@implementation ETGCpbCostPcsbID
@end

@implementation _ETGCpbCostPcsb

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGCpbCostPcsb" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGCpbCostPcsb";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGCpbCostPcsb" inManagedObjectContext:moc_];
}

- (ETGCpbCostPcsbID*)objectID {
	return (ETGCpbCostPcsbID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"latestCpbValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latestCpb"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"originalCpbValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"originalCpb"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"varianceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"variance"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"yep_eValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"yep_e"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"ytdActualValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ytdActual"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic indicator;






@dynamic latestCpb;



- (float)latestCpbValue {
	NSNumber *result = [self latestCpb];
	return [result floatValue];
}

- (void)setLatestCpbValue:(float)value_ {
	[self setLatestCpb:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLatestCpbValue {
	NSNumber *result = [self primitiveLatestCpb];
	return [result floatValue];
}

- (void)setPrimitiveLatestCpbValue:(float)value_ {
	[self setPrimitiveLatestCpb:[NSNumber numberWithFloat:value_]];
}





@dynamic originalCpb;



- (float)originalCpbValue {
	NSNumber *result = [self originalCpb];
	return [result floatValue];
}

- (void)setOriginalCpbValue:(float)value_ {
	[self setOriginalCpb:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveOriginalCpbValue {
	NSNumber *result = [self primitiveOriginalCpb];
	return [result floatValue];
}

- (void)setPrimitiveOriginalCpbValue:(float)value_ {
	[self setPrimitiveOriginalCpb:[NSNumber numberWithFloat:value_]];
}





@dynamic performanceName;






@dynamic variance;



- (float)varianceValue {
	NSNumber *result = [self variance];
	return [result floatValue];
}

- (void)setVarianceValue:(float)value_ {
	[self setVariance:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveVarianceValue {
	NSNumber *result = [self primitiveVariance];
	return [result floatValue];
}

- (void)setPrimitiveVarianceValue:(float)value_ {
	[self setPrimitiveVariance:[NSNumber numberWithFloat:value_]];
}





@dynamic yep_e;



- (float)yep_eValue {
	NSNumber *result = [self yep_e];
	return [result floatValue];
}

- (void)setYep_eValue:(float)value_ {
	[self setYep_e:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveYep_eValue {
	NSNumber *result = [self primitiveYep_e];
	return [result floatValue];
}

- (void)setPrimitiveYep_eValue:(float)value_ {
	[self setPrimitiveYep_e:[NSNumber numberWithFloat:value_]];
}





@dynamic ytdActual;



- (float)ytdActualValue {
	NSNumber *result = [self ytdActual];
	return [result floatValue];
}

- (void)setYtdActualValue:(float)value_ {
	[self setYtdActual:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveYtdActualValue {
	NSNumber *result = [self primitiveYtdActual];
	return [result floatValue];
}

- (void)setPrimitiveYtdActualValue:(float)value_ {
	[self setPrimitiveYtdActual:[NSNumber numberWithFloat:value_]];
}





@dynamic costPcsb;

	






@end
