// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGUacPermission.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGUacPermissionAttributes {
	__unsafe_unretained NSString *content;
} ETGUacPermissionAttributes;

extern const struct ETGUacPermissionRelationships {
} ETGUacPermissionRelationships;

extern const struct ETGUacPermissionFetchedProperties {
} ETGUacPermissionFetchedProperties;




@interface ETGUacPermissionID : NSManagedObjectID {}
@end

@interface _ETGUacPermission : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGUacPermissionID*)objectID;




@property (nonatomic, strong) NSData* content;


//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;






@end

@interface _ETGUacPermission (CoreDataGeneratedAccessors)

@end

@interface _ETGUacPermission (CoreDataGeneratedPrimitiveAccessors)


- (NSData*)primitiveContent;
- (void)setPrimitiveContent:(NSData*)value;




@end
