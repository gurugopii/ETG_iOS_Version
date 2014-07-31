// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGBudgetCoreInfo.m instead.

#import "_ETGBudgetCoreInfo.h"

const struct ETGBudgetCoreInfoAttributes ETGBudgetCoreInfoAttributes = {
	.cumVowd = @"cumVowd",
	.fdp = @"fdp",
	.ytdActual = @"ytdActual",
};

const struct ETGBudgetCoreInfoRelationships ETGBudgetCoreInfoRelationships = {
	.projectSummary = @"projectSummary",
};

const struct ETGBudgetCoreInfoFetchedProperties ETGBudgetCoreInfoFetchedProperties = {
};

@implementation ETGBudgetCoreInfoID
@end

@implementation _ETGBudgetCoreInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGBudgetCoreInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGBudgetCoreInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGBudgetCoreInfo" inManagedObjectContext:moc_];
}

- (ETGBudgetCoreInfoID*)objectID {
	return (ETGBudgetCoreInfoID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic cumVowd;






@dynamic fdp;






@dynamic ytdActual;






@dynamic projectSummary;

	






@end
