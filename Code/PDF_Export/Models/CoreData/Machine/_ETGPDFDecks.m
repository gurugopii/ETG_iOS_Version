// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPDFDecks.m instead.

#import "_ETGPDFDecks.h"

const struct ETGPDFDecksAttributes ETGPDFDecksAttributes = {
	.category = @"category",
	.dateAddedToServer = @"dateAddedToServer",
	.fileId = @"fileId",
	.fileName = @"fileName",
	.identification = @"identification",
	.isOffline = @"isOffline",
	.reportingMonth = @"reportingMonth",
	.subCategory = @"subCategory",
	.tags = @"tags",
};

const struct ETGPDFDecksRelationships ETGPDFDecksRelationships = {
};

const struct ETGPDFDecksFetchedProperties ETGPDFDecksFetchedProperties = {
};

@implementation ETGPDFDecksID
@end

@implementation _ETGPDFDecks

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPDFDecks" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPDFDecks";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPDFDecks" inManagedObjectContext:moc_];
}

- (ETGPDFDecksID*)objectID {
	return (ETGPDFDecksID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isOfflineValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isOffline"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic category;






@dynamic dateAddedToServer;






@dynamic fileId;






@dynamic fileName;






@dynamic identification;






@dynamic isOffline;



- (BOOL)isOfflineValue {
	NSNumber *result = [self isOffline];
	return [result boolValue];
}

- (void)setIsOfflineValue:(BOOL)value_ {
	[self setIsOffline:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsOfflineValue {
	NSNumber *result = [self primitiveIsOffline];
	return [result boolValue];
}

- (void)setPrimitiveIsOfflineValue:(BOOL)value_ {
	[self setPrimitiveIsOffline:[NSNumber numberWithBool:value_]];
}





@dynamic reportingMonth;






@dynamic subCategory;






@dynamic tags;











@end
