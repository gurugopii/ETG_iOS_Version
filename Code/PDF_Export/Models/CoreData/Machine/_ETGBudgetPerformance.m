// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGBudgetPerformance.m instead.

#import "_ETGBudgetPerformance.h"

const struct ETGBudgetPerformanceAttributes ETGBudgetPerformanceAttributes = {
	.forecastDescription = @"forecastDescription",
	.forecastValue = @"forecastValue",
	.forecastVariance = @"forecastVariance",
	.indicator = @"indicator",
	.planDescription = @"planDescription",
	.planValue = @"planValue",
};

const struct ETGBudgetPerformanceRelationships ETGBudgetPerformanceRelationships = {
	.budgetHolder = @"budgetHolder",
	.projectSummary = @"projectSummary",
};

const struct ETGBudgetPerformanceFetchedProperties ETGBudgetPerformanceFetchedProperties = {
};

@implementation ETGBudgetPerformanceID
@end

@implementation _ETGBudgetPerformance

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGBudgetPerformance" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGBudgetPerformance";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGBudgetPerformance" inManagedObjectContext:moc_];
}

- (ETGBudgetPerformanceID*)objectID {
	return (ETGBudgetPerformanceID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic forecastDescription;






@dynamic forecastValue;






@dynamic forecastVariance;






@dynamic indicator;






@dynamic planDescription;






@dynamic planValue;






@dynamic budgetHolder;

	

@dynamic projectSummary;

	






@end
