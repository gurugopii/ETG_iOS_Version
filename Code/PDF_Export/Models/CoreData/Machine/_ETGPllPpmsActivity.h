// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllPpmsActivity.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPllPpmsActivityAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGPllPpmsActivityAttributes;

extern const struct ETGPllPpmsActivityRelationships {
} ETGPllPpmsActivityRelationships;

extern const struct ETGPllPpmsActivityFetchedProperties {
} ETGPllPpmsActivityFetchedProperties;





@interface ETGPllPpmsActivityID : NSManagedObjectID {}
@end

@interface _ETGPllPpmsActivity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPllPpmsActivityID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;






@end

@interface _ETGPllPpmsActivity (CoreDataGeneratedAccessors)

@end

@interface _ETGPllPpmsActivity (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




@end
