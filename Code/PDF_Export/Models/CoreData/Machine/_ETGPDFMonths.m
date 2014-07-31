// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPDFMonths.m instead.

#import "_ETGPDFMonths.h"

const struct ETGPDFMonthsAttributes ETGPDFMonthsAttributes = {
	.month = @"month",
	.monthId = @"monthId",
};

const struct ETGPDFMonthsRelationships ETGPDFMonthsRelationships = {
};

const struct ETGPDFMonthsFetchedProperties ETGPDFMonthsFetchedProperties = {
};

@implementation ETGPDFMonthsID
@end

@implementation _ETGPDFMonths

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPDFMonths" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPDFMonths";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPDFMonths" inManagedObjectContext:moc_];
}

- (ETGPDFMonthsID*)objectID {
	return (ETGPDFMonthsID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic month;






@dynamic monthId;











@end
