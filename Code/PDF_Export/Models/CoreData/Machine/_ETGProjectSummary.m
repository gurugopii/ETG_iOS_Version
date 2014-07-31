// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectSummary.m instead.

#import "_ETGProjectSummary.h"

const struct ETGProjectSummaryAttributes ETGProjectSummaryAttributes = {
	.projectKey = @"projectKey",
	.reportMonth = @"reportMonth",
};

const struct ETGProjectSummaryRelationships ETGProjectSummaryRelationships = {
	.baselineTypes = @"baselineTypes",
	.etgAfeTable_Projects = @"etgAfeTable_Projects",
	.etgAfe_Projects = @"etgAfe_Projects",
	.etgBudgetCoreInfo_Projects = @"etgBudgetCoreInfo_Projects",
	.etgBudgetPerformance_Projects = @"etgBudgetPerformance_Projects",
	.etgEccr_cps = @"etgEccr_cps",
	.etgFirstHydrocarbon_Projects = @"etgFirstHydrocarbon_Projects",
	.etgHseTable_Projects = @"etgHseTable_Projects",
	.etgHse_Projects = @"etgHse_Projects",
	.etgKeyMilestone_ProjectPhase = @"etgKeyMilestone_ProjectPhase",
	.etgManpowerTable_Projects = @"etgManpowerTable_Projects",
	.etgMlProjects = @"etgMlProjects",
	.etgOpportunityImpact_Projects = @"etgOpportunityImpact_Projects",
	.etgPpms_Projects = @"etgPpms_Projects",
	.etgProductionRtbd_Projects = @"etgProductionRtbd_Projects",
	.etgScheduleProgress_Projects = @"etgScheduleProgress_Projects",
	.project = @"project",
	.reportingMonth = @"reportingMonth",
};

const struct ETGProjectSummaryFetchedProperties ETGProjectSummaryFetchedProperties = {
};

@implementation ETGProjectSummaryID
@end

@implementation _ETGProjectSummary

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProjectSummary" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProjectSummary";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProjectSummary" inManagedObjectContext:moc_];
}

- (ETGProjectSummaryID*)objectID {
	return (ETGProjectSummaryID*)[super objectID];
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
	

@dynamic etgAfeTable_Projects;

	
- (NSMutableSet*)etgAfeTable_ProjectsSet {
	[self willAccessValueForKey:@"etgAfeTable_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgAfeTable_Projects"];
  
	[self didAccessValueForKey:@"etgAfeTable_Projects"];
	return result;
}
	

@dynamic etgAfe_Projects;

	
- (NSMutableSet*)etgAfe_ProjectsSet {
	[self willAccessValueForKey:@"etgAfe_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgAfe_Projects"];
  
	[self didAccessValueForKey:@"etgAfe_Projects"];
	return result;
}
	

@dynamic etgBudgetCoreInfo_Projects;

	

@dynamic etgBudgetPerformance_Projects;

	
- (NSMutableSet*)etgBudgetPerformance_ProjectsSet {
	[self willAccessValueForKey:@"etgBudgetPerformance_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgBudgetPerformance_Projects"];
  
	[self didAccessValueForKey:@"etgBudgetPerformance_Projects"];
	return result;
}
	

@dynamic etgEccr_cps;

	

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
	

@dynamic etgHse_Projects;

	

@dynamic etgKeyMilestone_ProjectPhase;

	

@dynamic etgManpowerTable_Projects;

	
- (NSMutableSet*)etgManpowerTable_ProjectsSet {
	[self willAccessValueForKey:@"etgManpowerTable_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgManpowerTable_Projects"];
  
	[self didAccessValueForKey:@"etgManpowerTable_Projects"];
	return result;
}
	

@dynamic etgMlProjects;

	
- (NSMutableSet*)etgMlProjectsSet {
	[self willAccessValueForKey:@"etgMlProjects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgMlProjects"];
  
	[self didAccessValueForKey:@"etgMlProjects"];
	return result;
}
	

@dynamic etgOpportunityImpact_Projects;

	
- (NSMutableSet*)etgOpportunityImpact_ProjectsSet {
	[self willAccessValueForKey:@"etgOpportunityImpact_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgOpportunityImpact_Projects"];
  
	[self didAccessValueForKey:@"etgOpportunityImpact_Projects"];
	return result;
}
	

@dynamic etgPpms_Projects;

	
- (NSMutableSet*)etgPpms_ProjectsSet {
	[self willAccessValueForKey:@"etgPpms_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgPpms_Projects"];
  
	[self didAccessValueForKey:@"etgPpms_Projects"];
	return result;
}
	

@dynamic etgProductionRtbd_Projects;

	
- (NSMutableSet*)etgProductionRtbd_ProjectsSet {
	[self willAccessValueForKey:@"etgProductionRtbd_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgProductionRtbd_Projects"];
  
	[self didAccessValueForKey:@"etgProductionRtbd_Projects"];
	return result;
}
	

@dynamic etgScheduleProgress_Projects;

	
- (NSMutableSet*)etgScheduleProgress_ProjectsSet {
	[self willAccessValueForKey:@"etgScheduleProgress_Projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgScheduleProgress_Projects"];
  
	[self didAccessValueForKey:@"etgScheduleProgress_Projects"];
	return result;
}
	

@dynamic project;

	

@dynamic reportingMonth;

	






@end
