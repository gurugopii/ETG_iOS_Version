// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsWpb.m instead.

#import "_ETGEccrCpsWpb.h"

const struct ETGEccrCpsWpbAttributes ETGEccrCpsWpbAttributes = {
};

const struct ETGEccrCpsWpbRelationships ETGEccrCpsWpbRelationships = {
	.capex = @"capex",
	.cps = @"cps",
	.justifications = @"justifications",
	.opex = @"opex",
	.statusCurrencies = @"statusCurrencies",
};

const struct ETGEccrCpsWpbFetchedProperties ETGEccrCpsWpbFetchedProperties = {
};

@implementation ETGEccrCpsWpbID
@end

@implementation _ETGEccrCpsWpb

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpsWpb" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpsWpb";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpsWpb" inManagedObjectContext:moc_];
}

- (ETGEccrCpsWpbID*)objectID {
	return (ETGEccrCpsWpbID*)[super objectID];
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
