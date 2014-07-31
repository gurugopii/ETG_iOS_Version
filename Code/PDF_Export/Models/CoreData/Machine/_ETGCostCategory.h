// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCostCategory.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGCostCategoryAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGCostCategoryAttributes;

extern const struct ETGCostCategoryRelationships {
	__unsafe_unretained NSString *projects;
} ETGCostCategoryRelationships;

extern const struct ETGCostCategoryFetchedProperties {
} ETGCostCategoryFetchedProperties;

@class ETGProject;




@interface ETGCostCategoryID : NSManagedObjectID {}
@end

@interface _ETGCostCategory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGCostCategoryID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* projects;

- (NSMutableSet*)projectsSet;





@end

@interface _ETGCostCategory (CoreDataGeneratedAccessors)

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(ETGProject*)value_;
- (void)removeProjectsObject:(ETGProject*)value_;

@end

@interface _ETGCostCategory (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;


@end
