// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGTimestamp.m instead.

#import "_ETGTimestamp.h"

const struct ETGTimestampAttributes ETGTimestampAttributes = {
	.moduleName = @"moduleName",
	.timeStamp = @"timeStamp",
};

const struct ETGTimestampRelationships ETGTimestampRelationships = {
	.reportingMonth = @"reportingMonth",
};

const struct ETGTimestampFetchedProperties ETGTimestampFetchedProperties = {
};

@implementation ETGTimestampID
@end

@implementation _ETGTimestamp

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGTimestamp" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGTimestamp";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGTimestamp" inManagedObjectContext:moc_];
}

- (ETGTimestampID*)objectID {
	return (ETGTimestampID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic moduleName;






@dynamic timeStamp;






@dynamic reportingMonth;

	






@end
