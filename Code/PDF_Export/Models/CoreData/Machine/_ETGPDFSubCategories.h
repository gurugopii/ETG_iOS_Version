// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPDFSubCategories.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPDFSubCategoriesAttributes {
	__unsafe_unretained NSString *subCategoryId;
	__unsafe_unretained NSString *subCategoryName;
} ETGPDFSubCategoriesAttributes;

extern const struct ETGPDFSubCategoriesRelationships {
	__unsafe_unretained NSString *category;
} ETGPDFSubCategoriesRelationships;

extern const struct ETGPDFSubCategoriesFetchedProperties {
} ETGPDFSubCategoriesFetchedProperties;

@class ETGPDFCategories;




@interface ETGPDFSubCategoriesID : NSManagedObjectID {}
@end

@interface _ETGPDFSubCategories : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPDFSubCategoriesID*)objectID;




@property (nonatomic, strong) NSString* subCategoryId;


//- (BOOL)validateSubCategoryId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* subCategoryName;


//- (BOOL)validateSubCategoryName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* category;

- (NSMutableSet*)categorySet;





@end

@interface _ETGPDFSubCategories (CoreDataGeneratedAccessors)

- (void)addCategory:(NSSet*)value_;
- (void)removeCategory:(NSSet*)value_;
- (void)addCategoryObject:(ETGPDFCategories*)value_;
- (void)removeCategoryObject:(ETGPDFCategories*)value_;

@end

@interface _ETGPDFSubCategories (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveSubCategoryId;
- (void)setPrimitiveSubCategoryId:(NSString*)value;




- (NSString*)primitiveSubCategoryName;
- (void)setPrimitiveSubCategoryName:(NSString*)value;





- (NSMutableSet*)primitiveCategory;
- (void)setPrimitiveCategory:(NSMutableSet*)value;


@end
