// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsAfe.m instead.

#import "_ETGEccrCpsAfe.h"

const struct ETGEccrCpsAfeAttributes ETGEccrCpsAfeAttributes = {
};

const struct ETGEccrCpsAfeRelationships ETGEccrCpsAfeRelationships = {
	.capex = @"capex",
	.cps = @"cps",
	.opex = @"opex",
	.statusCurrencies = @"statusCurrencies",
};

const struct ETGEccrCpsAfeFetchedProperties ETGEccrCpsAfeFetchedProperties = {
};

@implementation ETGEccrCpsAfeID
@end

@implementation _ETGEccrCpsAfe

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpsAfe" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpsAfe";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpsAfe" inManagedObjectContext:moc_];
}

- (ETGEccrCpsAfeID*)objectID {
	return (ETGEccrCpsAfeID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic capex;

	
- (NSMutableSet*)capexSet {
	[self willAccessValueForKey:@"capex"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"capex"];
  
	[self didAccessValueForKey:@"capex"];
	return result;
}
	

@dynamic cps;

	

@dynamic opex;

	
- (NSMutableSet*)opexSet {
	[self willAccessValueForKey:@"opex"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"opex"];
  
	[self didAccessValueForKey:@"opex"];
	return result;
}
	

@dynamic statusCurrencies;

	
- (NSMutableSet*)statusCurrenciesSet {
	[self willAccessValueForKey:@"statusCurrencies"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"statusCurrencies"];
  
	[self didAccessValueForKey:@"statusCurrencies"];
	return result;
}
	






@end
