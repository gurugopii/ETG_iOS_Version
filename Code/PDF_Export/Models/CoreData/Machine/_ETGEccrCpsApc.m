// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsApc.m instead.

#import "_ETGEccrCpsApc.h"

const struct ETGEccrCpsApcAttributes ETGEccrCpsApcAttributes = {
};

const struct ETGEccrCpsApcRelationships ETGEccrCpsApcRelationships = {
	.capex = @"capex",
	.cps = @"cps",
	.justifications = @"justifications",
	.opex = @"opex",
	.statusCurrencies = @"statusCurrencies",
};

const struct ETGEccrCpsApcFetchedProperties ETGEccrCpsApcFetchedProperties = {
};

@implementation ETGEccrCpsApcID
@end

@implementation _ETGEccrCpsApc

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpsApc" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpsApc";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpsApc" inManagedObjectContext:moc_];
}

- (ETGEccrCpsApcID*)objectID {
	return (ETGEccrCpsApcID*)[super objectID];
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

	

@dynamic justifications;

	
- (NSMutableSet*)justificationsSet {
	[self willAccessValueForKey:@"justifications"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"justifications"];
  
	[self didAccessValueForKey:@"justifications"];
	return result;
}
	

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
