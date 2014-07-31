// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGWPBCostPMU.m instead.

#import "_ETGWPBCostPMU.h"

const struct ETGWPBCostPMUAttributes ETGWPBCostPMUAttributes = {
	.abrApproved = @"abrApproved",
	.indicator = @"indicator",
	.latestWpb = @"latestWpb",
	.originalWpb = @"originalWpb",
	.section = @"section",
	.sectionKey = @"sectionKey",
	.variance = @"variance",
	.yepG = @"yepG",
	.yercoApproved = @"yercoApproved",
};

const struct ETGWPBCostPMURelationships ETGWPBCostPMURelationships = {
	.scorecard = @"scorecard",
};

const struct ETGWPBCostPMUFetchedProperties ETGWPBCostPMUFetchedProperties = {
};

@implementation ETGWPBCostPMUID
@end

@implementation _ETGWPBCostPMU

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGWPBCostPMU" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGWPBCostPMU";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGWPBCostPMU" inManagedObjectContext:moc_];
}

- (ETGWPBCostPMUID*)objectID {
	return (ETGWPBCostPMUID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"sectionKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sectionKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic abrApproved;






@dynamic indicator;






@dynamic latestWpb;






@dynamic originalWpb;






@dynamic section;






@dynamic sectionKey;



- (int32_t)sectionKeyValue {
	NSNumber *result = [self sectionKey];
	return [result intValue];
}

- (void)setSectionKeyValue:(int32_t)value_ {
	[self setSectionKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveSectionKeyValue {
	NSNumber *result = [self primitiveSectionKey];
	return [result intValue];
}

- (void)setPrimitiveSectionKeyValue:(int32_t)value_ {
	[self setPrimitiveSectionKey:[NSNumber numberWithInt:value_]];
}





@dynamic variance;






@dynamic yepG;






@dynamic yercoApproved;






@dynamic scorecard;

	






@end
