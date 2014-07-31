// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMLPortfolio.m instead.

#import "_ETGMLPortfolio.h"

const struct ETGMLPortfolioAttributes ETGMLPortfolioAttributes = {
	.calendarMonthOfYear = @"calendarMonthOfYear",
	.calendarYear = @"calendarYear",
	.calendarYearEnglishMonth = @"calendarYearEnglishMonth",
	.fTELoading = @"fTELoading",
	.projectStaffingStatusName = @"projectStaffingStatusName",
	.reportingtimekey = @"reportingtimekey",
};

const struct ETGMLPortfolioRelationships ETGMLPortfolioRelationships = {
	.portfolio = @"portfolio",
};

const struct ETGMLPortfolioFetchedProperties ETGMLPortfolioFetchedProperties = {
};

@implementation ETGMLPortfolioID
@end

@implementation _ETGMLPortfolio

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMLPortfolio" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMLPortfolio";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMLPortfolio" inManagedObjectContext:moc_];
}

- (ETGMLPortfolioID*)objectID {
	return (ETGMLPortfolioID*)[super objectID];
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
	if ([key isEqualToString:@"reportingtimekeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"reportingtimekey"];
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






@dynamic reportingtimekey;



- (int32_t)reportingtimekeyValue {
	NSNumber *result = [self reportingtimekey];
	return [result intValue];
}

- (void)setReportingtimekeyValue:(int32_t)value_ {
	[self setReportingtimekey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveReportingtimekeyValue {
	NSNumber *result = [self primitiveReportingtimekey];
	return [result intValue];
}

- (void)setPrimitiveReportingtimekeyValue:(int32_t)value_ {
	[self setPrimitiveReportingtimekey:[NSNumber numberWithInt:value_]];
}





@dynamic portfolio;

	






@end
