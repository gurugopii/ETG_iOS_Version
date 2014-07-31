// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGManpowerTable_Project.m instead.

#import "_ETGManpowerTable_Project.h"

const struct ETGManpowerTable_ProjectAttributes ETGManpowerTable_ProjectAttributes = {
	.indicatorTotalCriticalBar = @"indicatorTotalCriticalBar",
	.indicatorTotalRequirementBar = @"indicatorTotalRequirementBar",
	.totalCritical = @"totalCritical",
	.totalRequirement = @"totalRequirement",
};

const struct ETGManpowerTable_ProjectRelationships ETGManpowerTable_ProjectRelationships = {
	.projectSummary = @"projectSummary",
	.scorecard = @"scorecard",
};

const struct ETGManpowerTable_ProjectFetchedProperties ETGManpowerTable_ProjectFetchedProperties = {
};

@implementation ETGManpowerTable_ProjectID
@end

@implementation _ETGManpowerTable_Project

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGManpowerTable_Project" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGManpowerTable_Project";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGManpowerTable_Project" inManagedObjectContext:moc_];
}

- (ETGManpowerTable_ProjectID*)objectID {
	return (ETGManpowerTable_ProjectID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"totalCriticalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"totalCritical"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"totalRequirementValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"totalRequirement"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic indicatorTotalCriticalBar;






@dynamic indicatorTotalRequirementBar;






@dynamic totalCritical;



- (int32_t)totalCriticalValue {
	NSNumber *result = [self totalCritical];
	return [result intValue];
}

- (void)setTotalCriticalValue:(int32_t)value_ {
	[self setTotalCritical:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveTotalCriticalValue {
	NSNumber *result = [self primitiveTotalCritical];
	return [result intValue];
}

- (void)setPrimitiveTotalCriticalValue:(int32_t)value_ {
	[self setPrimitiveTotalCritical:[NSNumber numberWithInt:value_]];
}





@dynamic totalRequirement;



- (int32_t)totalRequirementValue {
	NSNumber *result = [self totalRequirement];
	return [result intValue];
}

- (void)setTotalRequirementValue:(int32_t)value_ {
	[self setTotalRequirement:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveTotalRequirementValue {
	NSNumber *result = [self primitiveTotalRequirement];
	return [result intValue];
}

- (void)setPrimitiveTotalRequirementValue:(int32_t)value_ {
	[self setPrimitiveTotalRequirement:[NSNumber numberWithInt:value_]];
}





@dynamic projectSummary;

	

@dynamic scorecard;

	






@end
