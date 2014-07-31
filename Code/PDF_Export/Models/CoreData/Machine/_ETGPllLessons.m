// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllLessons.m instead.

#import "_ETGPllLessons.h"

const struct ETGPllLessonsAttributes ETGPllLessonsAttributes = {
	.activity = @"activity",
	.approvalStatus = @"approvalStatus",
	.areaName = @"areaName",
	.baselineDesc = @"baselineDesc",
	.causeDesc = @"causeDesc",
	.createDttm = @"createDttm",
	.createUserId = @"createUserId",
	.currencyName = @"currencyName",
	.disciplineName = @"disciplineName",
	.impactDesc = @"impactDesc",
	.lessonDesc = @"lessonDesc",
	.potentialValue = @"potentialValue",
	.potentialValueBasis = @"potentialValueBasis",
	.potentialValueConverted = @"potentialValueConverted",
	.projectLessonDetailKey = @"projectLessonDetailKey",
	.projectLessonImpactNm = @"projectLessonImpactNm",
	.projectLessonRatingNm = @"projectLessonRatingNm",
	.projectName = @"projectName",
	.recommendationDesc = @"recommendationDesc",
	.replicateInd = @"replicateInd",
	.reviewItemName = @"reviewItemName",
	.riskCategoryName = @"riskCategoryName",
	.totalLikeNo = @"totalLikeNo",
	.updateDttm = @"updateDttm",
	.updateUserId = @"updateUserId",
	.usdRate = @"usdRate",
};

const struct ETGPllLessonsRelationships ETGPllLessonsRelationships = {
};

const struct ETGPllLessonsFetchedProperties ETGPllLessonsFetchedProperties = {
};

@implementation ETGPllLessonsID
@end

@implementation _ETGPllLessons

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPllLessons" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPllLessons";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPllLessons" inManagedObjectContext:moc_];
}

- (ETGPllLessonsID*)objectID {
	return (ETGPllLessonsID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"potentialValueValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"potentialValue"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"potentialValueConvertedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"potentialValueConverted"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"projectLessonDetailKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectLessonDetailKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"totalLikeNoValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"totalLikeNo"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic activity;






@dynamic approvalStatus;






@dynamic areaName;






@dynamic baselineDesc;






@dynamic causeDesc;






@dynamic createDttm;






@dynamic createUserId;






@dynamic currencyName;






@dynamic disciplineName;






@dynamic impactDesc;






@dynamic lessonDesc;






@dynamic potentialValue;



- (int32_t)potentialValueValue {
	NSNumber *result = [self potentialValue];
	return [result intValue];
}

- (void)setPotentialValueValue:(int32_t)value_ {
	[self setPotentialValue:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePotentialValueValue {
	NSNumber *result = [self primitivePotentialValue];
	return [result intValue];
}

- (void)setPrimitivePotentialValueValue:(int32_t)value_ {
	[self setPrimitivePotentialValue:[NSNumber numberWithInt:value_]];
}





@dynamic potentialValueBasis;






@dynamic potentialValueConverted;



- (double)potentialValueConvertedValue {
	NSNumber *result = [self potentialValueConverted];
	return [result doubleValue];
}

- (void)setPotentialValueConvertedValue:(double)value_ {
	[self setPotentialValueConverted:[NSNumber numberWithDouble:value_]];
}

- (double)primitivePotentialValueConvertedValue {
	NSNumber *result = [self primitivePotentialValueConverted];
	return [result doubleValue];
}

- (void)setPrimitivePotentialValueConvertedValue:(double)value_ {
	[self setPrimitivePotentialValueConverted:[NSNumber numberWithDouble:value_]];
}





@dynamic projectLessonDetailKey;



- (int32_t)projectLessonDetailKeyValue {
	NSNumber *result = [self projectLessonDetailKey];
	return [result intValue];
}

- (void)setProjectLessonDetailKeyValue:(int32_t)value_ {
	[self setProjectLessonDetailKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveProjectLessonDetailKeyValue {
	NSNumber *result = [self primitiveProjectLessonDetailKey];
	return [result intValue];
}

- (void)setPrimitiveProjectLessonDetailKeyValue:(int32_t)value_ {
	[self setPrimitiveProjectLessonDetailKey:[NSNumber numberWithInt:value_]];
}





@dynamic projectLessonImpactNm;






@dynamic projectLessonRatingNm;






@dynamic projectName;






@dynamic recommendationDesc;






@dynamic replicateInd;






@dynamic reviewItemName;






@dynamic riskCategoryName;






@dynamic totalLikeNo;



- (int32_t)totalLikeNoValue {
	NSNumber *result = [self totalLikeNo];
	return [result intValue];
}

- (void)setTotalLikeNoValue:(int32_t)value_ {
	[self setTotalLikeNo:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveTotalLikeNoValue {
	NSNumber *result = [self primitiveTotalLikeNo];
	return [result intValue];
}

- (void)setPrimitiveTotalLikeNoValue:(int32_t)value_ {
	[self setPrimitiveTotalLikeNo:[NSNumber numberWithInt:value_]];
}





@dynamic updateDttm;






@dynamic updateUserId;






@dynamic usdRate;











@end
