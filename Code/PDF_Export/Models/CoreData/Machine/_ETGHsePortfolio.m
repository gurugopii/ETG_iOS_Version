// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGHsePortfolio.m instead.

#import "_ETGHsePortfolio.h"

const struct ETGHsePortfolioAttributes ETGHsePortfolioAttributes = {
	.fatality = @"fatality",
	.fireincident = @"fireincident",
	.losttimeinjuries = @"losttimeinjuries",
	.totalrecordable = @"totalrecordable",
};

const struct ETGHsePortfolioRelationships ETGHsePortfolioRelationships = {
	.portfolio = @"portfolio",
};

const struct ETGHsePortfolioFetchedProperties ETGHsePortfolioFetchedProperties = {
};

@implementation ETGHsePortfolioID
@end

@implementation _ETGHsePortfolio

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGHsePortfolio" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGHsePortfolio";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGHsePortfolio" inManagedObjectContext:moc_];
}

- (ETGHsePortfolioID*)objectID {
	return (ETGHsePortfolioID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"fatalityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fatality"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"fireincidentValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fireincident"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"losttimeinjuriesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"losttimeinjuries"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"totalrecordableValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"totalrecordable"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic fatality;



- (int32_t)fatalityValue {
	NSNumber *result = [self fatality];
	return [result intValue];
}

- (void)setFatalityValue:(int32_t)value_ {
	[self setFatality:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFatalityValue {
	NSNumber *result = [self primitiveFatality];
	return [result intValue];
}

- (void)setPrimitiveFatalityValue:(int32_t)value_ {
	[self setPrimitiveFatality:[NSNumber numberWithInt:value_]];
}





@dynamic fireincident;



- (int32_t)fireincidentValue {
	NSNumber *result = [self fireincident];
	return [result intValue];
}

- (void)setFireincidentValue:(int32_t)value_ {
	[self setFireincident:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFireincidentValue {
	NSNumber *result = [self primitiveFireincident];
	return [result intValue];
}

- (void)setPrimitiveFireincidentValue:(int32_t)value_ {
	[self setPrimitiveFireincident:[NSNumber numberWithInt:value_]];
}





@dynamic losttimeinjuries;



- (int32_t)losttimeinjuriesValue {
	NSNumber *result = [self losttimeinjuries];
	return [result intValue];
}

- (void)setLosttimeinjuriesValue:(int32_t)value_ {
	[self setLosttimeinjuries:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveLosttimeinjuriesValue {
	NSNumber *result = [self primitiveLosttimeinjuries];
	return [result intValue];
}

- (void)setPrimitiveLosttimeinjuriesValue:(int32_t)value_ {
	[self setPrimitiveLosttimeinjuries:[NSNumber numberWithInt:value_]];
}





@dynamic totalrecordable;



- (int32_t)totalrecordableValue {
	NSNumber *result = [self totalrecordable];
	return [result intValue];
}

- (void)setTotalrecordableValue:(int32_t)value_ {
	[self setTotalrecordable:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveTotalrecordableValue {
	NSNumber *result = [self primitiveTotalrecordable];
	return [result intValue];
}

- (void)setPrimitiveTotalrecordableValue:(int32_t)value_ {
	[self setPrimitiveTotalrecordable:[NSNumber numberWithInt:value_]];
}





@dynamic portfolio;

	






@end
