// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMapsPGD.m instead.

#import "_ETGMapsPGD.h"

const struct ETGMapsPGDAttributes ETGMapsPGDAttributes = {
	.currentPhase = @"currentPhase",
	.duration = @"duration",
	.indicator = @"indicator",
	.phaseName = @"phaseName",
	.projectKey = @"projectKey",
	.projectName = @"projectName",
	.psc = @"psc",
	.pscKey = @"pscKey",
	.region = @"region",
	.regionKey = @"regionKey",
	.x = @"x",
	.y = @"y",
};

const struct ETGMapsPGDRelationships ETGMapsPGDRelationships = {
	.etgMap = @"etgMap",
};

const struct ETGMapsPGDFetchedProperties ETGMapsPGDFetchedProperties = {
};

@implementation ETGMapsPGDID
@end

@implementation _ETGMapsPGD

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMapsPGD" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMapsPGD";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMapsPGD" inManagedObjectContext:moc_];
}

- (ETGMapsPGDID*)objectID {
	return (ETGMapsPGDID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"currentPhaseValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"currentPhase"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"projectKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"pscKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pscKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"regionKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"regionKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic currentPhase;



- (int32_t)currentPhaseValue {
	NSNumber *result = [self currentPhase];
	return [result intValue];
}

- (void)setCurrentPhaseValue:(int32_t)value_ {
	[self setCurrentPhase:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCurrentPhaseValue {
	NSNumber *result = [self primitiveCurrentPhase];
	return [result intValue];
}

- (void)setPrimitiveCurrentPhaseValue:(int32_t)value_ {
	[self setPrimitiveCurrentPhase:[NSNumber numberWithInt:value_]];
}





@dynamic duration;






@dynamic indicator;






@dynamic phaseName;






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





@dynamic projectName;






@dynamic psc;






@dynamic pscKey;



- (int32_t)pscKeyValue {
	NSNumber *result = [self pscKey];
	return [result intValue];
}

- (void)setPscKeyValue:(int32_t)value_ {
	[self setPscKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePscKeyValue {
	NSNumber *result = [self primitivePscKey];
	return [result intValue];
}

- (void)setPrimitivePscKeyValue:(int32_t)value_ {
	[self setPrimitivePscKey:[NSNumber numberWithInt:value_]];
}





@dynamic region;






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





@dynamic x;






@dynamic y;






@dynamic etgMap;

	






@end
