// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPDFCategories.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPDFCategoriesAttributes {
	__unsafe_unretained NSString *categoryId;
	__unsafe_unretained NSString *categoryName;
} ETGPDFCategoriesAttributes;

extern const struct ETGPDFCategoriesRelationships {
	__unsafe_unretained NSString *subCategory;
} ETGPDFCategoriesRelationships;

extern const struct ETGPDFCategoriesFetchedProperties {
} ETGPDFCategoriesFetchedProperties;

@class ETGPDFSubCategories;




@interface ETGPDFCategoriesID : NSManagedObjectID {}
@end

@interface _ETGPDFCategories : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPDFCategoriesID*)objectID;




@property (nonatomic, strong) NSString* categoryId;


//- (BOOL)validateCategoryId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* categoryName;


//- (BOOL)validateCategoryName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* subCategory;

- (NSMutableSet*)subCategorySet;





@end

@interface _ETGPDFCategories (CoreDataGeneratedAccessors)

- (void)addSubCategory:(NSSet*)value_;
- (void)removeSubCategory:(NSSet*)value_;
- (void)addSubCategoryObject:(ETGPDFSubCategories*)value_;
- (void)removeSubCategoryObject:(ETGPDFSubCategories*)value_;

@end

@interface _ETGPDFCategories (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCategoryId;
- (void)setPrimitiveCategoryId:(NSString*)value;




- (NSString*)primitiveCategoryName;
- (void)setPrimitiveCategoryName:(NSString*)value;





- (NSMutableSet*)primitiveSubCategory;
- (void)setPrimitiveSubCategory:(NSMutableSet*)value;


@end
