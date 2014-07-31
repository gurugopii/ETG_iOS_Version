// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMap.m instead.

#import "_ETGMap.h"

const struct ETGMapAttributes ETGMapAttributes = {
	.reportMonth = @"reportMonth",
};

const struct ETGMapRelationships ETGMapRelationships = {
	.etgMapsPems = @"etgMapsPems",
	.etgMapsPgd = @"etgMapsPgd",
	.project = @"project",
	.reportingMonth = @"reportingMonth",
};

const struct ETGMapFetchedProperties ETGMapFetchedProperties = {
};

@implementation ETGMapID
@end

@implementation _ETGMap

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGMap" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGMap";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGMap" inManagedObjectContext:moc_];
}

- (ETGMapID*)objectID {
	return (ETGMapID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic reportMonth;






@dynamic etgMapsPems;

	
- (NSMutableSet*)etgMapsPemsSet {
	[self willAccessValueForKey:@"etgMapsPems"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgMapsPems"];
  
	[self didAccessValueForKey:@"etgMapsPems"];
	return result;
}
	

@dynamic etgMapsPgd;

	
- (NSMutableSet*)etgMapsPgdSet {
	[self willAccessValueForKey:@"etgMapsPgd"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"etgMapsPgd"];
  
	[self didAccessValueForKey:@"etgMapsPgd"];
	return result;
}
	

@dynamic project;

	

@dynamic reportingMonth;

	






@end
