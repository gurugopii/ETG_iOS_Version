// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMLProject.m instead.

#import "_ETGMLProject.h"

const struct ETGMLProjectAttributes ETGMLProjectAttributes = {
	.calendarMonthOfYear = @"calendarMonthOfYear",
	.calendarYear = @"calendarYear",
	.calendarYearEnglishMonth = @"calendarYearEnglishMonth",
	.fTELoading = @"fTELoading",
	.projectStaffingStatusName = @"projectStaffingStatusName",
	.reportingTimeKey = @"reportingTimeKey",
};

const struct ETGMLProjectRelationships ETGMLProjectRelationships = {
	.projectSummary = @"projectSummary",
};

const struct ETGMLProjectFetchedProperties ETGMLProjectFetchedProperties = {
};

@implementation ETGMLProjectID
@end

@implementation _ETGMLProject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMLProject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMLProject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMLProject" inManagedObjectContext:moc_];
}

- (ETGMLProjectID*)objectID {
	return (ETGMLProjectID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"calendarMonthOfYearValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"calendarMonthOfYear"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"calendarYearValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"calendarYear"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"reportingTimeKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"reportingTimeKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic calendarMonthOfYear;



- (int32_t)calendarMonthOfYearValue {
	NSNumber *result = [self calendarMonthOfYear];
	return [result intValue];
}

- (void)setCalendarMonthOfYearValue:(int32_t)value_ {
	[self setCalendarMonthOfYear:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCalendarMonthOfYearValue {
	NSNumber *result = [self primitiveCalendarMonthOfYear];
	return [result intValue];
}

- (void)setPrimitiveCalendarMonthOfYearValue:(int32_t)value_ {
	[self setPrimitiveCalendarMonthOfYear:[NSNumber numberWithInt:value_]];
}





@dynamic calendarYear;



- (int32_t)calendarYearValue {
	NSNumber *result = [self calendarYear];
	return [result intValue];
}

- (void)setCalendarYearValue:(int32_t)value_ {
	[self setCalendarYear:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCalendarYearValue {
	NSNumber *result = [self primitiveCalendarYear];
	return [result intValue];
}

- (void)setPrimitiveCalendarYearValue:(int32_t)value_ {
	[self setPrimitiveCalendarYear:[NSNumber numberWithInt:value_]];
}





@dynamic calendarYearEnglishMonth;






@dynamic fTELoading;






@dynamic projectStaffingStatusName;






@dynamic reportingTimeKey;



- (int32_t)reportingTimeKeyValue {
	NSNumber *result = [self reportingTimeKey];
	return [result intValue];
}

- (void)setReportingTimeKeyValue:(int32_t)value_ {
	[self setReportingTimeKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveReportingTimeKeyValue {
	NSNumber *result = [self primitiveReportingTimeKey];
	return [result intValue];
}

- (void)setPrimitiveReportingTimeKeyValue:(int32_t)value_ {
	[self setPrimitiveReportingTimeKey:[NSNumber numberWithInt:value_]];
}





@dynamic projectSummary;

	






@end
