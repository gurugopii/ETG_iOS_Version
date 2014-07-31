// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGRiskOpportunity.m instead.

#import "_ETGRiskOpportunity.h"

const struct ETGRiskOpportunityAttributes ETGRiskOpportunityAttributes = {
	.activity = @"activity",
	.cluster = @"cluster",
	.cost = @"cost",
	.descriptions = @"descriptions",
	.identifiedDate = @"identifiedDate",
	.mitigation = @"mitigation",
	.negativeImpact = @"negativeImpact",
	.probability = @"probability",
	.production = @"production",
	.productionGas = @"productionGas",
	.productionOil = @"productionOil",
	.schedule = @"schedule",
	.status = @"status",
	.type = @"type",
};

const struct ETGRiskOpportunityRelationships ETGRiskOpportunityRelationships = {
	.projectSummary = @"projectSummary",
};

const struct ETGRiskOpportunityFetchedProperties ETGRiskOpportunityFetchedProperties = {
};

@implementation ETGRiskOpportunityID
@end

@implementation _ETGRiskOpportunity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGRiskOpportunity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGRiskOpportunity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGRiskOpportunity" inManagedObjectContext:moc_];
}

- (ETGRiskOpportunityID*)objectID {
	return (ETGRiskOpportunityID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"scheduleValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"schedule"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic activity;






@dynamic cluster;






@dynamic cost;






@dynamic descriptions;






@dynamic identifiedDate;






@dynamic mitigation;






@dynamic negativeImpact;






@dynamic probability;






@dynamic production;






@dynamic productionGas;






@dynamic productionOil;






@dynamic schedule;



- (int32_t)scheduleValue {
	NSNumber *result = [self schedule];
	return [result intValue];
}

- (void)setScheduleValue:(int32_t)value_ {
	[self setSchedule:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveScheduleValue {
	NSNumber *result = [self primitiveSchedule];
	return [result intValue];
}

- (void)setPrimitiveScheduleValue:(int32_t)value_ {
	[self setPrimitiveSchedule:[NSNumber numberWithInt:value_]];
}





@dynamic status;






@dynamic type;






@dynamic projectSummary;

	






@end
