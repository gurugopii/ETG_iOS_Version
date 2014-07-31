// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectSummaryForMap.m instead.

#import "_ETGProjectSummaryForMap.h"

const struct ETGProjectSummaryForMapAttributes ETGProjectSummaryForMapAttributes = {
	.projectKey = @"projectKey",
	.reportMonth = @"reportMonth",
};

const struct ETGProjectSummaryForMapRelationships ETGProjectSummaryForMapRelationships = {
	.baselineTypes = @"baselineTypes",
	.etgFirstHydrocarbon_Projects = @"etgFirstHydrocarbon_Projects",
	.etgKeyMilestone_ProjectPhase = @"etgKeyMilestone_ProjectPhase",
	.project = @"project",
	.reportingMonth = @"reportingMonth",
};

const struct ETGProjectSummaryForMapFetchedProperties ETGProjectSummaryForMapFetchedProperties = {
};

@implementation ETGProjectSummaryForMapID
@end

@implementation _ETGProjectSummaryForMap

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProjectSummaryForMap" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProjectSummaryForMap";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProjectSummaryForMap" inManagedObjectContext:moc_];
}

- (ETGProjectSummaryForMapID*)objectID {
	return (ETGProjectSummaryForMapID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"projectKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




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





@dynamic reportMonth;






@dynamic baselineTypes;

	
- (NSMutableSet*)baselineTypesSet {
	[self willAccessValueForKey:@"baselineTypes"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"baselineTypes"];
  
	[self didAccessValueForKey:@"baselineTypes"];
	return result;
}
	

@dynamic etgFirstHydrocarbon_Projects;

	
- (NSMutableSet*)etgFirstHydrocarbon_ProjectsSet {
	[self willAccessValueForKey:@"etgFirstHydrocarbon_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgFirstHydrocarbon_Projects"];
  
	[self didAccessValueForKey:@"etgFirstHydrocarbon_Projects"];
	return result;
}
	

@dynamic etgKeyMilestone_ProjectPhase;

	

@dynamic project;

	

@dynamic reportingMonth;

	






@end
