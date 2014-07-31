// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPPMS.m instead.

#import "_ETGPPMS.h"

const struct ETGPPMSAttributes ETGPPMSAttributes = {
	.indicator = @"indicator",
	.percentage = @"percentage",
	.status = @"status",
};

const struct ETGPPMSRelationships ETGPPMSRelationships = {
	.projectSummary = @"projectSummary",
};

const struct ETGPPMSFetchedProperties ETGPPMSFetchedProperties = {
};

@implementation ETGPPMSID
@end

@implementation _ETGPPMS

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPPMS" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPPMS";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPPMS" inManagedObjectContext:moc_];
}

- (ETGPPMSID*)objectID {
	return (ETGPPMSID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic indicator;






@dynamic percentage;






@dynamic status;






@dynamic projectSummary;

	






@end
