// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyHighlight.m instead.

#import "_ETGKeyHighlight.h"

const struct ETGKeyHighlightAttributes ETGKeyHighlightAttributes = {
	.overallPpa = @"overallPpa",
	.projectKey = @"projectKey",
	.reportMonth = @"reportMonth",
};

const struct ETGKeyHighlightRelationships ETGKeyHighlightRelationships = {
	.issuesAndConcerns = @"issuesAndConcerns",
	.keyhighlightsProgress = @"keyhighlightsProgress",
	.monthlyKeyHighlights = @"monthlyKeyHighlights",
	.plannedActivitiesforNextMonth = @"plannedActivitiesforNextMonth",
	.ppa = @"ppa",
	.project = @"project",
	.reportingMonth = @"reportingMonth",
};

const struct ETGKeyHighlightFetchedProperties ETGKeyHighlightFetchedProperties = {
};

@implementation ETGKeyHighlightID
@end

@implementation _ETGKeyHighlight

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGKeyHighlight" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGKeyHighlight";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGKeyHighlight" inManagedObjectContext:moc_];
}

- (ETGKeyHighlightID*)objectID {
	return (ETGKeyHighlightID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"projectKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic overallPpa;






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






@dynamic issuesAndConcerns;

	
- (NSMutableSet*)issuesAndConcernsSet {
	[self willAccessValueForKey:@"issuesAndConcerns"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"issuesAndConcerns"];
  
	[self didAccessValueForKey:@"issuesAndConcerns"];
	return result;
}
	

@dynamic keyhighlightsProgress;

	
- (NSMutableSet*)keyhighlightsProgressSet {
	[self willAccessValueForKey:@"keyhighlightsProgress"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"keyhighlightsProgress"];
  
	[self didAccessValueForKey:@"keyhighlightsProgress"];
	return result;
}
	

@dynamic monthlyKeyHighlights;

	
- (NSMutableSet*)monthlyKeyHighlightsSet {
	[self willAccessValueForKey:@"monthlyKeyHighlights"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"monthlyKeyHighlights"];
  
	[self didAccessValueForKey:@"monthlyKeyHighlights"];
	return result;
}
	

@dynamic plannedActivitiesforNextMonth;

	
- (NSMutableSet*)plannedActivitiesforNextMonthSet {
	[self willAccessValueForKey:@"plannedActivitiesforNextMonth"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"plannedActivitiesforNextMonth"];
  
	[self didAccessValueForKey:@"plannedActivitiesforNextMonth"];
	return result;
}
	

@dynamic ppa;

	
- (NSMutableSet*)ppaSet {
	[self willAccessValueForKey:@"ppa"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"ppa"];
  
	[self didAccessValueForKey:@"ppa"];
	return result;
}
	

@dynamic project;

	

@dynamic reportingMonth;

	






@end
