// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMpPnechcr.m instead.

#import "_ETGMpPnechcr.h"

const struct ETGMpPnechcrAttributes ETGMpPnechcrAttributes = {
	.departmentKey = @"departmentKey",
	.departmentName = @"departmentName",
	.divisionKey = @"divisionKey",
	.divisionName = @"divisionName",
	.filledHeadcount = @"filledHeadcount",
	.pneClusterKey = @"pneClusterKey",
	.pneClusterName = @"pneClusterName",
	.projectJobTitleKey = @"projectJobTitleKey",
	.regionKey = @"regionKey",
	.regionName = @"regionName",
	.sectionKey = @"sectionKey",
	.sectionName = @"sectionName",
	.vacantHeadcount = @"vacantHeadcount",
	.year = @"year",
};

const struct ETGMpPnechcrRelationships ETGMpPnechcrRelationships = {
	.reportingMonth = @"reportingMonth",
};

const struct ETGMpPnechcrFetchedProperties ETGMpPnechcrFetchedProperties = {
};

@implementation ETGMpPnechcrID
@end

@implementation _ETGMpPnechcr

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMpPnechcr" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMpPnechcr";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMpPnechcr" inManagedObjectContext:moc_];
}

- (ETGMpPnechcrID*)objectID {
	return (ETGMpPnechcrID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"departmentKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"departmentKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"divisionKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"divisionKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"filledHeadcountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"filledHeadcount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"pneClusterKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pneClusterKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"projectJobTitleKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectJobTitleKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"regionKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"regionKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"sectionKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sectionKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"vacantHeadcountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"vacantHeadcount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"yearValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"year"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic departmentKey;



- (int32_t)departmentKeyValue {
	NSNumber *result = [self departmentKey];
	return [result intValue];
}

- (void)setDepartmentKeyValue:(int32_t)value_ {
	[self setDepartmentKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveDepartmentKeyValue {
	NSNumber *result = [self primitiveDepartmentKey];
	return [result intValue];
}

- (void)setPrimitiveDepartmentKeyValue:(int32_t)value_ {
	[self setPrimitiveDepartmentKey:[NSNumber numberWithInt:value_]];
}





@dynamic departmentName;






@dynamic divisionKey;



- (int32_t)divisionKeyValue {
	NSNumber *result = [self divisionKey];
	return [result intValue];
}

- (void)setDivisionKeyValue:(int32_t)value_ {
	[self setDivisionKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveDivisionKeyValue {
	NSNumber *result = [self primitiveDivisionKey];
	return [result intValue];
}

- (void)setPrimitiveDivisionKeyValue:(int32_t)value_ {
	[self setPrimitiveDivisionKey:[NSNumber numberWithInt:value_]];
}





@dynamic divisionName;






@dynamic filledHeadcount;



- (int32_t)filledHeadcountValue {
	NSNumber *result = [self filledHeadcount];
	return [result intValue];
}

- (void)setFilledHeadcountValue:(int32_t)value_ {
	[self setFilledHeadcount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFilledHeadcountValue {
	NSNumber *result = [self primitiveFilledHeadcount];
	return [result intValue];
}

- (void)setPrimitiveFilledHeadcountValue:(int32_t)value_ {
	[self setPrimitiveFilledHeadcount:[NSNumber numberWithInt:value_]];
}





@dynamic pneClusterKey;



- (int32_t)pneClusterKeyValue {
	NSNumber *result = [self pneClusterKey];
	return [result intValue];
}

- (void)setPneClusterKeyValue:(int32_t)value_ {
	[self setPneClusterKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePneClusterKeyValue {
	NSNumber *result = [self primitivePneClusterKey];
	return [result intValue];
}

- (void)setPrimitivePneClusterKeyValue:(int32_t)value_ {
	[self setPrimitivePneClusterKey:[NSNumber numberWithInt:value_]];
}





@dynamic pneClusterName;






@dynamic projectJobTitleKey;



- (int32_t)projectJobTitleKeyValue {
	NSNumber *result = [self projectJobTitleKey];
	return [result intValue];
}

- (void)setProjectJobTitleKeyValue:(int32_t)value_ {
	[self setProjectJobTitleKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveProjectJobTitleKeyValue {
	NSNumber *result = [self primitiveProjectJobTitleKey];
	return [result intValue];
}

- (void)setPrimitiveProjectJobTitleKeyValue:(int32_t)value_ {
	[self setPrimitiveProjectJobTitleKey:[NSNumber numberWithInt:value_]];
}





@dynamic regionKey;



- (int32_t)regionKeyValue {
	NSNumber *result = [self regionKey];
	return [result intValue];
}

- (void)setRegionKeyValue:(int32_t)value_ {
	[self setRegionKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveRegionKeyValue {
	NSNumber *result = [self primitiveRegionKey];
	return [result intValue];
}

- (void)setPrimitiveRegionKeyValue:(int32_t)value_ {
	[self setPrimitiveRegionKey:[NSNumber numberWithInt:value_]];
}





@dynamic regionName;






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





@dynamic sectionName;






@dynamic vacantHeadcount;



- (int32_t)vacantHeadcountValue {
	NSNumber *result = [self vacantHeadcount];
	return [result intValue];
}

- (void)setVacantHeadcountValue:(int32_t)value_ {
	[self setVacantHeadcount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveVacantHeadcountValue {
	NSNumber *result = [self primitiveVacantHeadcount];
	return [result intValue];
}

- (void)setPrimitiveVacantHeadcountValue:(int32_t)value_ {
	[self setPrimitiveVacantHeadcount:[NSNumber numberWithInt:value_]];
}





@dynamic year;



- (int32_t)yearValue {
	NSNumber *result = [self year];
	return [result intValue];
}

- (void)setYearValue:(int32_t)value_ {
	[self setYear:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveYearValue {
	NSNumber *result = [self primitiveYear];
	return [result intValue];
}

- (void)setPrimitiveYearValue:(int32_t)value_ {
	[self setPrimitiveYear:[NSNumber numberWithInt:value_]];
}





@dynamic reportingMonth;

	






@end
