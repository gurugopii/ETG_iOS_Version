// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGScorecard.m instead.

#import "_ETGScorecard.h"

const struct ETGScorecardAttributes ETGScorecardAttributes = {
	.costPcsb = @"costPcsb",
	.costPmu = @"costPmu",
	.hse = @"hse",
	.manningHeadCount = @"manningHeadCount",
	.production = @"production",
	.projectKey = @"projectKey",
	.reportMonth = @"reportMonth",
	.schedule = @"schedule",
};

const struct ETGScorecardRelationships ETGScorecardRelationships = {
	.baselineTypes = @"baselineTypes",
	.etgAfeTable_Projects = @"etgAfeTable_Projects",
	.etgApcPortfolios = @"etgApcPortfolios",
	.etgCpbPortfolios = @"etgCpbPortfolios",
	.etgFirstHydrocarbon_Projects = @"etgFirstHydrocarbon_Projects",
	.etgHseTable_Projects = @"etgHseTable_Projects",
	.etgKeyMilestone_ProjectPhase = @"etgKeyMilestone_ProjectPhase",
	.etgManpowerTable_Projects = @"etgManpowerTable_Projects",
	.etgScheduleProgress_Projects = @"etgScheduleProgress_Projects",
	.fdp = @"fdp",
	.platform = @"platform",
	.productions = @"productions",
	.project = @"project",
	.reportingMonth = @"reportingMonth",
	.wpbCostPMUs = @"wpbCostPMUs",
};

const struct ETGScorecardFetchedProperties ETGScorecardFetchedProperties = {
};

@implementation ETGScorecardID
@end

@implementation _ETGScorecard

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGScorecard" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGScorecard";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGScorecard" inManagedObjectContext:moc_];
}

- (ETGScorecardID*)objectID {
	return (ETGScorecardID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"projectKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic costPcsb;






@dynamic costPmu;






@dynamic hse;






@dynamic manningHeadCount;






@dynamic production;






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






@dynamic schedule;






@dynamic baselineTypes;

	
- (NSMutableSet*)baselineTypesSet {
	[self willAccessValueForKey:@"baselineTypes"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"baselineTypes"];
  
	[self didAccessValueForKey:@"baselineTypes"];
	return result;
}
	

@dynamic etgAfeTable_Projects;

	
- (NSMutableSet*)etgAfeTable_ProjectsSet {
	[self willAccessValueForKey:@"etgAfeTable_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgAfeTable_Projects"];
  
	[self didAccessValueForKey:@"etgAfeTable_Projects"];
	return result;
}
	

@dynamic etgApcPortfolios;

	
- (NSMutableSet*)etgApcPortfoliosSet {
	[self willAccessValueForKey:@"etgApcPortfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgApcPortfolios"];
  
	[self didAccessValueForKey:@"etgApcPortfolios"];
	return result;
}
	

@dynamic etgCpbPortfolios;

	
- (NSMutableSet*)etgCpbPortfoliosSet {
	[self willAccessValueForKey:@"etgCpbPortfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgCpbPortfolios"];
  
	[self didAccessValueForKey:@"etgCpbPortfolios"];
	return result;
}
	

@dynamic etgFirstHydrocarbon_Projects;

	
- (NSMutableSet*)etgFirstHydrocarbon_ProjectsSet {
	[self willAccessValueForKey:@"etgFirstHydrocarbon_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgFirstHydrocarbon_Projects"];
  
	[self didAccessValueForKey:@"etgFirstHydrocarbon_Projects"];
	return result;
}
	

@dynamic etgHseTable_Projects;

	
- (NSMutableSet*)etgHseTable_ProjectsSet {
	[self willAccessValueForKey:@"etgHseTable_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgHseTable_Projects"];
  
	[self didAccessValueForKey:@"etgHseTable_Projects"];
	return result;
}
	

@dynamic etgKeyMilestone_ProjectPhase;

	

@dynamic etgManpowerTable_Projects;

	
- (NSMutableSet*)etgManpowerTable_ProjectsSet {
	[self willAccessValueForKey:@"etgManpowerTable_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgManpowerTable_Projects"];
  
	[self didAccessValueForKey:@"etgManpowerTable_Projects"];
	return result;
}
	

@dynamic etgScheduleProgress_Projects;

	
- (NSMutableSet*)etgScheduleProgress_ProjectsSet {
	[self willAccessValueForKey:@"etgScheduleProgress_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgScheduleProgress_Projects"];
  
	[self didAccessValueForKey:@"etgScheduleProgress_Projects"];
	return result;
}
	

@dynamic fdp;

	
- (NSMutableSet*)fdpSet {
	[self willAccessValueForKey:@"fdp"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fdp"];
  
	[self didAccessValueForKey:@"fdp"];
	return result;
}
	

@dynamic platform;

	
- (NSMutableSet*)platformSet {
	[self willAccessValueForKey:@"platform"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"platform"];
  
	[self didAccessValueForKey:@"platform"];
	return result;
}
	

@dynamic productions;

	
- (NSMutableSet*)productionsSet {
	[self willAccessValueForKey:@"productions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"productions"];
  
	[self didAccessValueForKey:@"productions"];
	return result;
}
	

@dynamic project;

	

@dynamic reportingMonth;

	

@dynamic wpbCostPMUs;

	
- (NSMutableSet*)wpbCostPMUsSet {
	[self willAccessValueForKey:@"wpbCostPMUs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wpbCostPMUs"];
  
	[self didAccessValueForKey:@"wpbCostPMUs"];
	return result;
}
	






@end
