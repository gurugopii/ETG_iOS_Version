// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGApc.m instead.

#import "_ETGApc.h"

const struct ETGApcAttributes ETGApcAttributes = {
	.afc = @"afc",
	.apc = @"apc",
	.category = @"category",
	.categoryRange = @"categoryRange",
	.indicator = @"indicator",
	.itd = @"itd",
	.phase = @"phase",
	.remark = @"remark",
	.variance = @"variance",
};

const struct ETGApcRelationships ETGApcRelationships = {
	.portfolio = @"portfolio",
	.scorecard = @"scorecard",
};

const struct ETGApcFetchedProperties ETGApcFetchedProperties = {
};

@implementation ETGApcID
@end

@implementation _ETGApc

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGApc" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGApc";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGApc" inManagedObjectContext:moc_];
}

- (ETGApcID*)objectID {
	return (ETGApcID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic afc;






@dynamic apc;






@dynamic category;






@dynamic categoryRange;






@dynamic indicator;






@dynamic itd;






@dynamic phase;






@dynamic remark;






@dynamic variance;






@dynamic portfolio;

	

@dynamic scorecard;

	






@end
