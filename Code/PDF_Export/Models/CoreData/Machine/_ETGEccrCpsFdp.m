// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsFdp.m instead.

#import "_ETGEccrCpsFdp.h"

const struct ETGEccrCpsFdpAttributes ETGEccrCpsFdpAttributes = {
};

const struct ETGEccrCpsFdpRelationships ETGEccrCpsFdpRelationships = {
	.capex = @"capex",
	.cps = @"cps",
	.justifications = @"justifications",
	.opex = @"opex",
	.statusCurrencies = @"statusCurrencies",
};

const struct ETGEccrCpsFdpFetchedProperties ETGEccrCpsFdpFetchedProperties = {
};

@implementation ETGEccrCpsFdpID
@end

@implementation _ETGEccrCpsFdp

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpsFdp" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpsFdp";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpsFdp" inManagedObjectContext:moc_];
}

- (ETGEccrCpsFdpID*)objectID {
	return (ETGEccrCpsFdpID*)[super objectID];
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

	
- (NSMutableSet*)cpsSet {
	[self willAccessValueForKey:@"cps"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"cps"];
  
	[self didAccessValueForKey:@"cps"];
	return result;
}
	

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
