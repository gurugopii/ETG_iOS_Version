// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProject.m instead.

#import "_ETGProject.h"

const struct ETGProjectAttributes ETGProjectAttributes = {
	.endDate = @"endDate",
	.isUsedByMap = @"isUsedByMap",
	.key = @"key",
	.name = @"name",
	.startDate = @"startDate",
};

const struct ETGProjectRelationships ETGProjectRelationships = {
	.budgetHolders = @"budgetHolders",
	.cluster = @"cluster",
	.complexities = @"complexities",
	.costCategory = @"costCategory",
	.keyHighlights = @"keyHighlights",
	.maps = @"maps",
	.natures = @"natures",
	.operatorship = @"operatorship",
	.phase = @"phase",
	.portfolios = @"portfolios",
	.projectBackground = @"projectBackground",
	.projectStatus = @"projectStatus",
	.projects = @"projects",
	.projectsForMap = @"projectsForMap",
	.region = @"region",
	.reportingMonths = @"reportingMonths",
	.scorecards = @"scorecards",
	.types = @"types",
};

const struct ETGProjectFetchedProperties ETGProjectFetchedProperties = {
};

@implementation ETGProjectID
@end

@implementation _ETGProject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProject" inManagedObjectContext:moc_];
}

- (ETGProjectID*)objectID {
	return (ETGProjectID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"endDateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"endDate"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"isUsedByMapValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isUsedByMap"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"keyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"key"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"startDateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"startDate"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic endDate;



- (int32_t)endDateValue {
	NSNumber *result = [self endDate];
	return [result intValue];
}

- (void)setEndDateValue:(int32_t)value_ {
	[self setEndDate:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveEndDateValue {
	NSNumber *result = [self primitiveEndDate];
	return [result intValue];
}

- (void)setPrimitiveEndDateValue:(int32_t)value_ {
	[self setPrimitiveEndDate:[NSNumber numberWithInt:value_]];
}





@dynamic isUsedByMap;



- (BOOL)isUsedByMapValue {
	NSNumber *result = [self isUsedByMap];
	return [result boolValue];
}

- (void)setIsUsedByMapValue:(BOOL)value_ {
	[self setIsUsedByMap:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsUsedByMapValue {
	NSNumber *result = [self primitiveIsUsedByMap];
	return [result boolValue];
}

- (void)setPrimitiveIsUsedByMapValue:(BOOL)value_ {
	[self setPrimitiveIsUsedByMap:[NSNumber numberWithBool:value_]];
}





@dynamic key;



- (int32_t)keyValue {
	NSNumber *result = [self key];
	return [result intValue];
}

- (void)setKeyValue:(int32_t)value_ {
	[self setKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveKeyValue {
	NSNumber *result = [self primitiveKey];
	return [result intValue];
}

- (void)setPrimitiveKeyValue:(int32_t)value_ {
	[self setPrimitiveKey:[NSNumber numberWithInt:value_]];
}





@dynamic name;






@dynamic startDate;



- (int32_t)startDateValue {
	NSNumber *result = [self startDate];
	return [result intValue];
}

- (void)setStartDateValue:(int32_t)value_ {
	[self setStartDate:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveStartDateValue {
	NSNumber *result = [self primitiveStartDate];
	return [result intValue];
}

- (void)setPrimitiveStartDateValue:(int32_t)value_ {
	[self setPrimitiveStartDate:[NSNumber numberWithInt:value_]];
}





@dynamic budgetHolders;

	
- (NSMutableSet*)budgetHoldersSet {
	[self willAccessValueForKey:@"budgetHolders"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"budgetHolders"];
  
	[self didAccessValueForKey:@"budgetHolders"];
	return result;
}
	

@dynamic cluster;

	

@dynamic complexities;

	

@dynamic costCategory;

	

@dynamic keyHighlights;

	
- (NSMutableSet*)keyHighlightsSet {
	[self willAccessValueForKey:@"keyHighlights"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"keyHighlights"];
  
	[self didAccessValueForKey:@"keyHighlights"];
	return result;
}
	

@dynamic maps;

	
- (NSMutableSet*)mapsSet {
	[self willAccessValueForKey:@"maps"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"maps"];
  
	[self didAccessValueForKey:@"maps"];
	return result;
}
	

@dynamic natures;

	

@dynamic operatorship;

	

@dynamic phase;

	

@dynamic portfolios;

	
- (NSMutableSet*)portfoliosSet {
	[self willAccessValueForKey:@"portfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"portfolios"];
  
	[self didAccessValueForKey:@"portfolios"];
	return result;
}
	

@dynamic projectBackground;

	

@dynamic projectStatus;

	

@dynamic projects;

	
- (NSMutableSet*)projectsSet {
	[self willAccessValueForKey:@"projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projects"];
  
	[self didAccessValueForKey:@"projects"];
	return result;
}
	

@dynamic projectsForMap;

	

@dynamic region;

	

@dynamic reportingMonths;

	
- (NSMutableSet*)reportingMonthsSet {
	[self willAccessValueForKey:@"reportingMonths"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"reportingMonths"];
  
	[self didAccessValueForKey:@"reportingMonths"];
	return result;
}
	

@dynamic scorecards;

	
- (NSMutableSet*)scorecardsSet {
	[self willAccessValueForKey:@"scorecards"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"scorecards"];
  
	[self didAccessValueForKey:@"scorecards"];
	return result;
}
	

@dynamic types;

	






@end
