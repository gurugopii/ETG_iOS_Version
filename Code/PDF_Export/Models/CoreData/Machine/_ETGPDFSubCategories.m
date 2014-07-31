// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPDFSubCategories.m instead.

#import "_ETGPDFSubCategories.h"

const struct ETGPDFSubCategoriesAttributes ETGPDFSubCategoriesAttributes = {
	.subCategoryId = @"subCategoryId",
	.subCategoryName = @"subCategoryName",
};

const struct ETGPDFSubCategoriesRelationships ETGPDFSubCategoriesRelationships = {
	.category = @"category",
};

const struct ETGPDFSubCategoriesFetchedProperties ETGPDFSubCategoriesFetchedProperties = {
};

@implementation ETGPDFSubCategoriesID
@end

@implementation _ETGPDFSubCategories

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPDFSubCategories" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPDFSubCategories";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPDFSubCategories" inManagedObjectContext:moc_];
}

- (ETGPDFSubCategoriesID*)objectID {
	return (ETGPDFSubCategoriesID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic subCategoryId;






@dynamic subCategoryName;






@dynamic category;

	
- (NSMutableSet*)categorySet {
	[self willAccessValueForKey:@"category"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"category"];
  
	[self didAccessValueForKey:@"category"];
	return result;
}
	






@end
