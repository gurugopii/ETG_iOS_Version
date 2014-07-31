// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGWpb.m instead.

#import "_ETGWpb.h"

const struct ETGWpbAttributes ETGWpbAttributes = {
	.abrApproved = @"abrApproved",
	.abrSubmitted = @"abrSubmitted",
	.indicator = @"indicator",
	.reportingDate = @"reportingDate",
};

const struct ETGWpbRelationships ETGWpbRelationships = {
	.portfolio = @"portfolio",
};

const struct ETGWpbFetchedProperties ETGWpbFetchedProperties = {
};

@implementation ETGWpbID
@end

@implementation _ETGWpb

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGWpb" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGWpb";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGWpb" inManagedObjectContext:moc_];
}

- (ETGWpbID*)objectID {
	return (ETGWpbID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic abrApproved;






@dynamic abrSubmitted;






@dynamic indicator;






@dynamic reportingDate;






@dynamic portfolio;

	






@end
