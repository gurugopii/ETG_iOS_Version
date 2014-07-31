// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsCpb.m instead.

#import "_ETGEccrCpsCpb.h"

const struct ETGEccrCpsCpbAttributes ETGEccrCpsCpbAttributes = {
};

const struct ETGEccrCpsCpbRelationships ETGEccrCpsCpbRelationships = {
	.capex = @"capex",
	.cps = @"cps",
	.justifications = @"justifications",
	.opex = @"opex",
	.statusCurrencies = @"statusCurrencies",
};

const struct ETGEccrCpsCpbFetchedProperties ETGEccrCpsCpbFetchedProperties = {
};

@implementation ETGEccrCpsCpbID
@end

@implementation _ETGEccrCpsCpb

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpsCpb" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpsCpb";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpsCpb" inManagedObjectContext:moc_];
}

- (ETGEccrCpsCpbID*)objectID {
	return (ETGEccrCpsCpbID*)[super objectID];
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
