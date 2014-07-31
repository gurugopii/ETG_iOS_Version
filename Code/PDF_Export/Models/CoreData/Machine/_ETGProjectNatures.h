// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectNatures.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGProjectNaturesAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGProjectNaturesAttributes;

extern const struct ETGProjectNaturesRelationships {
	__unsafe_unretained NSString *project;
} ETGProjectNaturesRelationships;

extern const struct ETGProjectNaturesFetchedProperties {
} ETGProjectNaturesFetchedProperties;

@class ETGProject;




@interface ETGProjectNaturesID : NSManagedObjectID {}
@end

@interface _ETGProjectNatures : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGProjectNaturesID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProject* project;

//- (BOOL)validateProject:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGProjectNatures (CoreDataGeneratedAccessors)

@end

@interface _ETGProjectNatures (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (ETGProject*)primitiveProject;
- (void)setPrimitiveProject:(ETGProject*)value;


@end
