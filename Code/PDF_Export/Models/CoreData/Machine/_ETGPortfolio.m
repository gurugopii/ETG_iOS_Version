// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPortfolio.m instead.

#import "_ETGPortfolio.h"

const struct ETGPortfolioAttributes ETGPortfolioAttributes = {
	.projectKey = @"projectKey",
	.reportMonth = @"reportMonth",
};

const struct ETGPortfolioRelationships ETGPortfolioRelationships = {
	.etgApcPortfolios = @"etgApcPortfolios",
	.etgCpbPortfolios = @"etgCpbPortfolios",
	.etgHsePortfolios = @"etgHsePortfolios",
	.etgHydrocarbonPortfolios = @"etgHydrocarbonPortfolios",
	.etgMLPortfolios = @"etgMLPortfolios",
	.etgProductionRtbdPortfolios = @"etgProductionRtbdPortfolios",
	.etgWpbPortfolios = @"etgWpbPortfolios",
	.project = @"project",
	.reportingMonth = @"reportingMonth",
};

const struct ETGPortfolioFetchedProperties ETGPortfolioFetchedProperties = {
};

@implementation ETGPortfolioID
@end

@implementation _ETGPortfolio

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPortfolio" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPortfolio";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPortfolio" inManagedObjectContext:moc_];
}

- (ETGPortfolioID*)objectID {
	return (ETGPortfolioID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"projectKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic projectKey;



- (int32_t)projectKeyValue {
	NSNumber *result = [self projectKey];
	return [result intValue];
}

- (void)setProjectKeyValue:(int32_t)value_ {
	[self setProjectKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveProjectKeyValue {
	NSNumber *result = [self primitiveProjectKey];
	return [result intValue];
}

- (void)setPrimitiveProjectKeyValue:(int32_t)value_ {
	[self setPrimitiveProjectKey:[NSNumber numberWithInt:value_]];
}





@dynamic reportMonth;






@dynamic etgApcPortfolios;

	
- (NSMutableSet*)etgApcPortfoliosSet {
	[self willAccessValueForKey:@"etgApcPortfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgApcPortfolios"];
  
	[self didAccessValueForKey:@"etgApcPortfolios"];
	return result;
}
	

@dynamic etgCpbPortfolios;

	
- (NSMutableSet*)etgCpbPortfoliosSet {
	[self willAccessValueForKey:@"etgCpbPortfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgCpbPortfolios"];
  
	[self didAccessValueForKey:@"etgCpbPortfolios"];
	return result;
}
	

@dynamic etgHsePortfolios;

	
- (NSMutableSet*)etgHsePortfoliosSet {
	[self willAccessValueForKey:@"etgHsePortfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgHsePortfolios"];
  
	[self didAccessValueForKey:@"etgHsePortfolios"];
	return result;
}
	

@dynamic etgHydrocarbonPortfolios;

	
- (NSMutableSet*)etgHydrocarbonPortfoliosSet {
	[self willAccessValueForKey:@"etgHydrocarbonPortfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgHydrocarbonPortfolios"];
  
	[self didAccessValueForKey:@"etgHydrocarbonPortfolios"];
	return result;
}
	

@dynamic etgMLPortfolios;

	
- (NSMutableSet*)etgMLPortfoliosSet {
	[self willAccessValueForKey:@"etgMLPortfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgMLPortfolios"];
  
	[self didAccessValueForKey:@"etgMLPortfolios"];
	return result;
}
	

@dynamic etgProductionRtbdPortfolios;

	
- (NSMutableSet*)etgProductionRtbdPortfoliosSet {
	[self willAccessValueForKey:@"etgProductionRtbdPortfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgProductionRtbdPortfolios"];
  
	[self didAccessValueForKey:@"etgProductionRtbdPortfolios"];
	return result;
}
	

@dynamic etgWpbPortfolios;

	
- (NSMutableSet*)etgWpbPortfoliosSet {
	[self willAccessValueForKey:@"etgWpbPortfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgWpbPortfolios"];
  
	[self didAccessValueForKey:@"etgWpbPortfolios"];
	return result;
}
	

@dynamic project;

	

@dynamic reportingMonth;

	






@end
