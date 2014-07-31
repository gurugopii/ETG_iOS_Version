// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGApcCostPcsb.m instead.

#import "_ETGApcCostPcsb.h"

const struct ETGApcCostPcsbAttributes ETGApcCostPcsbAttributes = {
	.afc = @"afc",
	.apcIndicator = @"apcIndicator",
	.apcVariance = @"apcVariance",
	.latestApc = @"latestApc",
	.vowd = @"vowd",
};

const struct ETGApcCostPcsbRelationships ETGApcCostPcsbRelationships = {
	.costPcsb = @"costPcsb",
};

const struct ETGApcCostPcsbFetchedProperties ETGApcCostPcsbFetchedProperties = {
};

@implementation ETGApcCostPcsbID
@end

@implementation _ETGApcCostPcsb

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGApcCostPcsb" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGApcCostPcsb";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGApcCostPcsb" inManagedObjectContext:moc_];
}

- (ETGApcCostPcsbID*)objectID {
	return (ETGApcCostPcsbID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"afcValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"afc"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"apcVarianceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"apcVariance"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"latestApcValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latestApc"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"vowdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"vowd"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic afc;



- (float)afcValue {
	NSNumber *result = [self afc];
	return [result floatValue];
}

- (void)setAfcValue:(float)value_ {
	[self setAfc:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveAfcValue {
	NSNumber *result = [self primitiveAfc];
	return [result floatValue];
}

- (void)setPrimitiveAfcValue:(float)value_ {
	[self setPrimitiveAfc:[NSNumber numberWithFloat:value_]];
}





@dynamic apcIndicator;






@dynamic apcVariance;



- (float)apcVarianceValue {
	NSNumber *result = [self apcVariance];
	return [result floatValue];
}

- (void)setApcVarianceValue:(float)value_ {
	[self setApcVariance:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveApcVarianceValue {
	NSNumber *result = [self primitiveApcVariance];
	return [result floatValue];
}

- (void)setPrimitiveApcVarianceValue:(float)value_ {
	[self setPrimitiveApcVariance:[NSNumber numberWithFloat:value_]];
}





@dynamic latestApc;



- (float)latestApcValue {
	NSNumber *result = [self latestApc];
	return [result floatValue];
}

- (void)setLatestApcValue:(float)value_ {
	[self setLatestApc:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLatestApcValue {
	NSNumber *result = [self primitiveLatestApc];
	return [result floatValue];
}

- (void)setPrimitiveLatestApcValue:(float)value_ {
	[self setPrimitiveLatestApc:[NSNumber numberWithFloat:value_]];
}





@dynamic vowd;



- (float)vowdValue {
	NSNumber *result = [self vowd];
	return [result floatValue];
}

- (void)setVowdValue:(float)value_ {
	[self setVowd:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveVowdValue {
	NSNumber *result = [self primitiveVowd];
	return [result floatValue];
}

- (void)setPrimitiveVowdValue:(float)value_ {
	[self setPrimitiveVowd:[NSNumber numberWithFloat:value_]];
}





@dynamic costPcsb;

	






@end
