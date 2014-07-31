// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectBackground.m instead.

#import "_ETGProjectBackground.h"

const struct ETGProjectBackgroundAttributes ETGProjectBackgroundAttributes = {
	.clusterName = @"clusterName",
	.country = @"country",
	.currencyName = @"currencyName",
	.endDate = @"endDate",
	.equity = @"equity",
	.fdpAmt = @"fdpAmt",
	.fdpDate = @"fdpDate",
	.fdpStatus = @"fdpStatus",
	.firAmt = @"firAmt",
	.firDate = @"firDate",
	.firStatus = @"firStatus",
	.objective = @"objective",
	.operatorshipName = @"operatorshipName",
	.projectCostCategoryName = @"projectCostCategoryName",
	.projectEndDate = @"projectEndDate",
	.projectId = @"projectId",
	.projectImage = @"projectImage",
	.projectName = @"projectName",
	.projectNatureName = @"projectNatureName",
	.projectStartDate = @"projectStartDate",
	.projectStatusName = @"projectStatusName",
	.projectTypeName = @"projectTypeName",
	.region = @"region",
	.startDate = @"startDate",
};

const struct ETGProjectBackgroundRelationships ETGProjectBackgroundRelationships = {
	.project = @"project",
};

const struct ETGProjectBackgroundFetchedProperties ETGProjectBackgroundFetchedProperties = {
};

@implementation ETGProjectBackgroundID
@end

@implementation _ETGProjectBackground

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProjectBackground" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProjectBackground";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProjectBackground" inManagedObjectContext:moc_];
}

- (ETGProjectBackgroundID*)objectID {
	return (ETGProjectBackgroundID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic clusterName;






@dynamic country;






@dynamic currencyName;






@dynamic endDate;






@dynamic equity;






@dynamic fdpAmt;






@dynamic fdpDate;






@dynamic fdpStatus;






@dynamic firAmt;






@dynamic firDate;






@dynamic firStatus;






@dynamic objective;






@dynamic operatorshipName;






@dynamic projectCostCategoryName;






@dynamic projectEndDate;






@dynamic projectId;






@dynamic projectImage;






@dynamic projectName;






@dynamic projectNatureName;






@dynamic projectStartDate;






@dynamic projectStatusName;






@dynamic projectTypeName;






@dynamic region;






@dynamic startDate;






@dynamic project;

	






@end
