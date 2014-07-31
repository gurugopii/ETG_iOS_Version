// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGAfeCostPcsb.m instead.

#import "_ETGAfeCostPcsb.h"

const struct ETGAfeCostPcsbAttributes ETGAfeCostPcsbAttributes = {
	.afeAfc = @"afeAfc",
	.afeIndicator = @"afeIndicator",
	.afeSection = @"afeSection",
	.afeVariance = @"afeVariance",
	.afeVowd = @"afeVowd",
	.latestAfe = @"latestAfe",
};

const struct ETGAfeCostPcsbRelationships ETGAfeCostPcsbRelationships = {
	.costPcsb = @"costPcsb",
};

const struct ETGAfeCostPcsbFetchedProperties ETGAfeCostPcsbFetchedProperties = {
};

@implementation ETGAfeCostPcsbID
@end

@implementation _ETGAfeCostPcsb

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGAfeCostPcsb" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGAfeCostPcsb";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGAfeCostPcsb" inManagedObjectContext:moc_];
}

- (ETGAfeCostPcsbID*)objectID {
	return (ETGAfeCostPcsbID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"afeAfcValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"afeAfc"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"afeVarianceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"afeVariance"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"afeVowdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"afeVowd"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"latestAfeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latestAfe"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic afeAfc;



- (float)afeAfcValue {
	NSNumber *result = [self afeAfc];
	return [result floatValue];
}

- (void)setAfeAfcValue:(float)value_ {
	[self setAfeAfc:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveAfeAfcValue {
	NSNumber *result = [self primitiveAfeAfc];
	return [result floatValue];
}

- (void)setPrimitiveAfeAfcValue:(float)value_ {
	[self setPrimitiveAfeAfc:[NSNumber numberWithFloat:value_]];
}





@dynamic afeIndicator;






@dynamic afeSection;






@dynamic afeVariance;



- (float)afeVarianceValue {
	NSNumber *result = [self afeVariance];
	return [result floatValue];
}

- (void)setAfeVarianceValue:(float)value_ {
	[self setAfeVariance:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveAfeVarianceValue {
	NSNumber *result = [self primitiveAfeVariance];
	return [result floatValue];
}

- (void)setPrimitiveAfeVarianceValue:(float)value_ {
	[self setPrimitiveAfeVariance:[NSNumber numberWithFloat:value_]];
}





@dynamic afeVowd;



- (float)afeVowdValue {
	NSNumber *result = [self afeVowd];
	return [result floatValue];
}

- (void)setAfeVowdValue:(float)value_ {
	[self setAfeVowd:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveAfeVowdValue {
	NSNumber *result = [self primitiveAfeVowd];
	return [result floatValue];
}

- (void)setPrimitiveAfeVowdValue:(float)value_ {
	[self setPrimitiveAfeVowd:[NSNumber numberWithFloat:value_]];
}





@dynamic latestAfe;



- (float)latestAfeValue {
	NSNumber *result = [self latestAfe];
	return [result floatValue];
}

- (void)setLatestAfeValue:(float)value_ {
	[self setLatestAfe:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLatestAfeValue {
	NSNumber *result = [self primitiveLatestAfe];
	return [result floatValue];
}

- (void)setPrimitiveLatestAfeValue:(float)value_ {
	[self setPrimitiveLatestAfe:[NSNumber numberWithFloat:value_]];
}





@dynamic costPcsb;

	






@end
