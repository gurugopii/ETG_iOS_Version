// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsStatusCurrency.m instead.

#import "_ETGEccrCpsStatusCurrency.h"

const struct ETGEccrCpsStatusCurrencyAttributes ETGEccrCpsStatusCurrencyAttributes = {
	.cpsCurrency = @"cpsCurrency",
	.cpsStatus = @"cpsStatus",
};

const struct ETGEccrCpsStatusCurrencyRelationships ETGEccrCpsStatusCurrencyRelationships = {
	.afe = @"afe",
	.apc = @"apc",
	.cpb = @"cpb",
	.fdp = @"fdp",
	.wpb = @"wpb",
};

const struct ETGEccrCpsStatusCurrencyFetchedProperties ETGEccrCpsStatusCurrencyFetchedProperties = {
};

@implementation ETGEccrCpsStatusCurrencyID
@end

@implementation _ETGEccrCpsStatusCurrency

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGEccrCpsStatusCurrency" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGEccrCpsStatusCurrency";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGEccrCpsStatusCurrency" inManagedObjectContext:moc_];
}

- (ETGEccrCpsStatusCurrencyID*)objectID {
	return (ETGEccrCpsStatusCurrencyID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic cpsCurrency;






@dynamic cpsStatus;






@dynamic afe;

	

@dynamic apc;

	

@dynamic cpb;

	

@dynamic fdp;

	

@dynamic wpb;

	






@end
