// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGReportingPeriod.m instead.

#import "_ETGReportingPeriod.h"

const struct ETGReportingPeriodAttributes ETGReportingPeriodAttributes = {
	.date = @"date",
	.filterName = @"filterName",
};

const struct ETGReportingPeriodRelationships ETGReportingPeriodRelationships = {
	.clusters = @"clusters",
	.countries = @"countries",
	.departments = @"departments",
	.divisions = @"divisions",
	.projectPositions = @"projectPositions",
	.projects = @"projects",
	.regions = @"regions",
	.sections = @"sections",
	.years = @"years",
};

const struct ETGReportingPeriodFetchedProperties ETGReportingPeriodFetchedProperties = {
};

@implementation ETGReportingPeriodID
@end

@implementation _ETGReportingPeriod

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGReportingPeriod" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGReportingPeriod";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGReportingPeriod" inManagedObjectContext:moc_];
}

- (ETGReportingPeriodID*)objectID {
	return (ETGReportingPeriodID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic date;






@dynamic filterName;






@dynamic clusters;

	
- (NSMutableSet*)clustersSet {
	[self willAccessValueForKey:@"clusters"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"clusters"];
  
	[self didAccessValueForKey:@"clusters"];
	return result;
}
	

@dynamic countries;

	
- (NSMutableSet*)countriesSet {
	[self willAccessValueForKey:@"countries"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"countries"];
  
	[self didAccessValueForKey:@"countries"];
	return result;
}
	

@dynamic departments;

	
- (NSMutableSet*)departmentsSet {
	[self willAccessValueForKey:@"departments"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"departments"];
  
	[self didAccessValueForKey:@"departments"];
	return result;
}
	

@dynamic divisions;

	
- (NSMutableSet*)divisionsSet {
	[self willAccessValueForKey:@"divisions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"divisions"];
  
	[self didAccessValueForKey:@"divisions"];
	return result;
}
	

@dynamic projectPositions;

	
- (NSMutableSet*)projectPositionsSet {
	[self willAccessValueForKey:@"projectPositions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projectPositions"];
  
	[self didAccessValueForKey:@"projectPositions"];
	return result;
}
	

@dynamic projects;

	
- (NSMutableSet*)projectsSet {
	[self willAccessValueForKey:@"projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projects"];
  
	[self didAccessValueForKey:@"projects"];
	return result;
}
	

@dynamic regions;

	
- (NSMutableSet*)regionsSet {
	[self willAccessValueForKey:@"regions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"regions"];
  
	[self didAccessValueForKey:@"regions"];
	return result;
}
	

@dynamic sections;

	
- (NSMutableSet*)sectionsSet {
	[self willAccessValueForKey:@"sections"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"sections"];
  
	[self didAccessValueForKey:@"sections"];
	return result;
}
	

@dynamic years;

	
- (NSMutableSet*)yearsSet {
	[self willAccessValueForKey:@"years"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"years"];
  
	[self didAccessValueForKey:@"years"];
	return result;
}
	






@end
