// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMpAhc.m instead.

#import "_ETGMpAhc.h"

const struct ETGMpAhcAttributes ETGMpAhcAttributes = {
	.departmentKey = @"departmentKey",
	.departmentName = @"departmentName",
	.divisionKey = @"divisionKey",
	.divisionName = @"divisionName",
	.filledHeadcount = @"filledHeadcount",
	.sectionKey = @"sectionKey",
	.sectionName = @"sectionName",
	.vacantHeadcount = @"vacantHeadcount",
	.year = @"year",
};

const struct ETGMpAhcRelationships ETGMpAhcRelationships = {
	.reportingMonth = @"reportingMonth",
};

const struct ETGMpAhcFetchedProperties ETGMpAhcFetchedProperties = {
};

@implementation ETGMpAhcID
@end

@implementation _ETGMpAhc

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMpAhc" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMpAhc";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMpAhc" inManagedObjectContext:moc_];
}

- (ETGMpAhcID*)objectID {
	return (ETGMpAhcID*)[super objectID];
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
