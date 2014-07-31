// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGUacPermission.m instead.

#import "_ETGUacPermission.h"

const struct ETGUacPermissionAttributes ETGUacPermissionAttributes = {
	.content = @"content",
};

const struct ETGUacPermissionRelationships ETGUacPermissionRelationships = {
};

const struct ETGUacPermissionFetchedProperties ETGUacPermissionFetchedProperties = {
};

@implementation ETGUacPermissionID
@end

@implementation _ETGUacPermission

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGUacPermission" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGUacPermission";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGUacPermission" inManagedObjectContext:moc_];
}

- (ETGUacPermissionID*)objectID {
	return (ETGUacPermissionID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic content;











@end
