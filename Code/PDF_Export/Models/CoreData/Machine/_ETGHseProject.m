// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGHseProject.m instead.

#import "_ETGHseProject.h"

const struct ETGHseProjectAttributes ETGHseProjectAttributes = {
	.totalManHour = @"totalManHour",
};

const struct ETGHseProjectRelationships ETGHseProjectRelationships = {
	.projectSummary = @"projectSummary",
};

const struct ETGHseProjectFetchedProperties ETGHseProjectFetchedProperties = {
};

@implementation ETGHseProjectID
@end

@implementation _ETGHseProject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGHseProject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGHseProject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGHseProject" inManagedObjectContext:moc_];
}

- (ETGHseProjectID*)objectID {
	return (ETGHseProjectID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"totalManHourValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"totalManHour"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic totalManHour;



- (int32_t)totalManHourValue {
	NSNumber *result = [self totalManHour];
	return [result intValue];
}

- (void)setTotalManHourValue:(int32_t)value_ {
	[self setTotalManHour:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveTotalManHourValue {
	NSNumber *result = [self primitiveTotalManHour];
	return [result intValue];
}

- (void)setPrimitiveTotalManHourValue:(int32_t)value_ {
	[self setPrimitiveTotalManHour:[NSNumber numberWithInt:value_]];
}





@dynamic projectSummary;

	






@end
