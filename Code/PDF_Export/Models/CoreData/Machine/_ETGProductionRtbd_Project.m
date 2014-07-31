// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProductionRtbd_Project.m instead.

#import "_ETGProductionRtbd_Project.h"

const struct ETGProductionRtbd_ProjectAttributes ETGProductionRtbd_ProjectAttributes = {
	.category = @"category",
	.cpb = @"cpb",
	.indicator = @"indicator",
	.type = @"type",
	.yep = @"yep",
};

const struct ETGProductionRtbd_ProjectRelationships ETGProductionRtbd_ProjectRelationships = {
	.projectSummary = @"projectSummary",
};

const struct ETGProductionRtbd_ProjectFetchedProperties ETGProductionRtbd_ProjectFetchedProperties = {
};

@implementation ETGProductionRtbd_ProjectID
@end

@implementation _ETGProductionRtbd_Project

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProductionRtbd_Project" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProductionRtbd_Project";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProductionRtbd_Project" inManagedObjectContext:moc_];
}

- (ETGProductionRtbd_ProjectID*)objectID {
	return (ETGProductionRtbd_ProjectID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic category;






@dynamic cpb;






@dynamic indicator;






@dynamic type;






@dynamic yep;






@dynamic projectSummary;

	






@end
