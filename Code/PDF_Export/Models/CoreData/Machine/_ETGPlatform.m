// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPlatform.m instead.

#import "_ETGPlatform.h"

const struct ETGPlatformAttributes ETGPlatformAttributes = {
	.actualDt = @"actualDt",
	.indicator = @"indicator",
	.plannedDt = @"plannedDt",
	.platform = @"platform",
};

const struct ETGPlatformRelationships ETGPlatformRelationships = {
	.scorecard = @"scorecard",
};

const struct ETGPlatformFetchedProperties ETGPlatformFetchedProperties = {
};

@implementation ETGPlatformID
@end

@implementation _ETGPlatform

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPlatform" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPlatform";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPlatform" inManagedObjectContext:moc_];
}

- (ETGPlatformID*)objectID {
	return (ETGPlatformID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic actualDt;






@dynamic indicator;






@dynamic plannedDt;






@dynamic platform;






@dynamic scorecard;

	






@end
