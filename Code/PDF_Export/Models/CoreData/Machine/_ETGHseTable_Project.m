// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGHseTable_Project.m instead.

#import "_ETGHseTable_Project.h"

const struct ETGHseTable_ProjectAttributes ETGHseTable_ProjectAttributes = {
	.hseDescription = @"hseDescription",
	.hseId = @"hseId",
	.indicator = @"indicator",
	.kpi = @"kpi",
	.ytdCase = @"ytdCase",
	.ytdFrequency = @"ytdFrequency",
};

const struct ETGHseTable_ProjectRelationships ETGHseTable_ProjectRelationships = {
	.projectSummary = @"projectSummary",
	.scorecard = @"scorecard",
};

const struct ETGHseTable_ProjectFetchedProperties ETGHseTable_ProjectFetchedProperties = {
};

@implementation ETGHseTable_ProjectID
@end

@implementation _ETGHseTable_Project

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGHseTable_Project" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGHseTable_Project";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGHseTable_Project" inManagedObjectContext:moc_];
}

- (ETGHseTable_ProjectID*)objectID {
	return (ETGHseTable_ProjectID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"kpiValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"kpi"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"ytdCaseValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ytdCase"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic hseDescription;






@dynamic hseId;






@dynamic indicator;






@dynamic kpi;



- (int32_t)kpiValue {
	NSNumber *result = [self kpi];
	return [result intValue];
}

- (void)setKpiValue:(int32_t)value_ {
	[self setKpi:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveKpiValue {
	NSNumber *result = [self primitiveKpi];
	return [result intValue];
}

- (void)setPrimitiveKpiValue:(int32_t)value_ {
	[self setPrimitiveKpi:[NSNumber numberWithInt:value_]];
}





@dynamic ytdCase;



- (int32_t)ytdCaseValue {
	NSNumber *result = [self ytdCase];
	return [result intValue];
}

- (void)setYtdCaseValue:(int32_t)value_ {
	[self setYtdCase:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveYtdCaseValue {
	NSNumber *result = [self primitiveYtdCase];
	return [result intValue];
}

- (void)setPrimitiveYtdCaseValue:(int32_t)value_ {
	[self setPrimitiveYtdCase:[NSNumber numberWithInt:value_]];
}





@dynamic ytdFrequency;






@dynamic projectSummary;

	

@dynamic scorecard;

	






@end
