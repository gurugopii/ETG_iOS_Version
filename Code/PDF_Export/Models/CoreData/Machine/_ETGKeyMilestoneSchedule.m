// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyMilestoneSchedule.m instead.

#import "_ETGKeyMilestoneSchedule.h"

const struct ETGKeyMilestoneScheduleAttributes ETGKeyMilestoneScheduleAttributes = {
	.actualDate = @"actualDate",
	.baselineNum = @"baselineNum",
	.indicator = @"indicator",
	.markerValue = @"markerValue",
	.milestone = @"milestone",
	.milestoneDesc = @"milestoneDesc",
	.milestoneKey = @"milestoneKey",
	.milestoneStatus = @"milestoneStatus",
	.outlookNum = @"outlookNum",
	.plannedDate = @"plannedDate",
	.projectEndDate = @"projectEndDate",
	.projectStartDate = @"projectStartDate",
	.reportingPeriod = @"reportingPeriod",
	.rowNum = @"rowNum",
};

const struct ETGKeyMilestoneScheduleRelationships ETGKeyMilestoneScheduleRelationships = {
	.scheduleScorecard = @"scheduleScorecard",
};

const struct ETGKeyMilestoneScheduleFetchedProperties ETGKeyMilestoneScheduleFetchedProperties = {
};

@implementation ETGKeyMilestoneScheduleID
@end

@implementation _ETGKeyMilestoneSchedule

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGKeyMilestoneSchedule" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGKeyMilestoneSchedule";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGKeyMilestoneSchedule" inManagedObjectContext:moc_];
}

- (ETGKeyMilestoneScheduleID*)objectID {
	return (ETGKeyMilestoneScheduleID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"baselineNumValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"baselineNum"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"markerValueValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"markerValue"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"milestoneKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"milestoneKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"milestoneStatusValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"milestoneStatus"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"outlookNumValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"outlookNum"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"rowNumValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rowNum"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic actualDate;






@dynamic baselineNum;



- (int32_t)baselineNumValue {
	NSNumber *result = [self baselineNum];
	return [result intValue];
}

- (void)setBaselineNumValue:(int32_t)value_ {
	[self setBaselineNum:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveBaselineNumValue {
	NSNumber *result = [self primitiveBaselineNum];
	return [result intValue];
}

- (void)setPrimitiveBaselineNumValue:(int32_t)value_ {
	[self setPrimitiveBaselineNum:[NSNumber numberWithInt:value_]];
}





@dynamic indicator;






@dynamic markerValue;



- (int32_t)markerValueValue {
	NSNumber *result = [self markerValue];
	return [result intValue];
}

- (void)setMarkerValueValue:(int32_t)value_ {
	[self setMarkerValue:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMarkerValueValue {
	NSNumber *result = [self primitiveMarkerValue];
	return [result intValue];
}

- (void)setPrimitiveMarkerValueValue:(int32_t)value_ {
	[self setPrimitiveMarkerValue:[NSNumber numberWithInt:value_]];
}





@dynamic milestone;






@dynamic milestoneDesc;






@dynamic milestoneKey;



- (int32_t)milestoneKeyValue {
	NSNumber *result = [self milestoneKey];
	return [result intValue];
}

- (void)setMilestoneKeyValue:(int32_t)value_ {
	[self setMilestoneKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMilestoneKeyValue {
	NSNumber *result = [self primitiveMilestoneKey];
	return [result intValue];
}

- (void)setPrimitiveMilestoneKeyValue:(int32_t)value_ {
	[self setPrimitiveMilestoneKey:[NSNumber numberWithInt:value_]];
}





@dynamic milestoneStatus;



- (int32_t)milestoneStatusValue {
	NSNumber *result = [self milestoneStatus];
	return [result intValue];
}

- (void)setMilestoneStatusValue:(int32_t)value_ {
	[self setMilestoneStatus:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMilestoneStatusValue {
	NSNumber *result = [self primitiveMilestoneStatus];
	return [result intValue];
}

- (void)setPrimitiveMilestoneStatusValue:(int32_t)value_ {
	[self setPrimitiveMilestoneStatus:[NSNumber numberWithInt:value_]];
}





@dynamic outlookNum;



- (int32_t)outlookNumValue {
	NSNumber *result = [self outlookNum];
	return [result intValue];
}

- (void)setOutlookNumValue:(int32_t)value_ {
	[self setOutlookNum:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveOutlookNumValue {
	NSNumber *result = [self primitiveOutlookNum];
	return [result intValue];
}

- (void)setPrimitiveOutlookNumValue:(int32_t)value_ {
	[self setPrimitiveOutlookNum:[NSNumber numberWithInt:value_]];
}





@dynamic plannedDate;






@dynamic projectEndDate;






@dynamic projectStartDate;






@dynamic reportingPeriod;






@dynamic rowNum;



- (int32_t)rowNumValue {
	NSNumber *result = [self rowNum];
	return [result intValue];
}

- (void)setRowNumValue:(int32_t)value_ {
	[self setRowNum:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveRowNumValue {
	NSNumber *result = [self primitiveRowNum];
	return [result intValue];
}

- (void)setPrimitiveRowNumValue:(int32_t)value_ {
	[self setPrimitiveRowNum:[NSNumber numberWithInt:value_]];
}





@dynamic scheduleScorecard;

	






@end
