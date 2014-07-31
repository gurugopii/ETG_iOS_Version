// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPDFCategories.m instead.

#import "_ETGPDFCategories.h"

const struct ETGPDFCategoriesAttributes ETGPDFCategoriesAttributes = {
	.categoryId = @"categoryId",
	.categoryName = @"categoryName",
};

const struct ETGPDFCategoriesRelationships ETGPDFCategoriesRelationships = {
	.subCategory = @"subCategory",
};

const struct ETGPDFCategoriesFetchedProperties ETGPDFCategoriesFetchedProperties = {
};

@implementation ETGPDFCategoriesID
@end

@implementation _ETGPDFCategories

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGPDFCategories" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGPDFCategories";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGPDFCategories" inManagedObjectContext:moc_];
}

- (ETGPDFCategoriesID*)objectID {
	return (ETGPDFCategoriesID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic categoryId;






@dynamic categoryName;






@dynamic subCategory;

	
- (NSMutableSet*)subCategorySet {
	[self willAccessValueForKey:@"subCategory"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"subCategory"];
  
	[self didAccessValueForKey:@"subCategory"];
	return result;
}
	






@end
