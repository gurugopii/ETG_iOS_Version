// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGWelcomeImage.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGWelcomeImageAttributes {
	__unsafe_unretained NSString *data;
	__unsafe_unretained NSString *key;
} ETGWelcomeImageAttributes;

extern const struct ETGWelcomeImageRelationships {
} ETGWelcomeImageRelationships;

extern const struct ETGWelcomeImageFetchedProperties {
} ETGWelcomeImageFetchedProperties;





@interface ETGWelcomeImageID : NSManagedObjectID {}
@end

@interface _ETGWelcomeImage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGWelcomeImageID*)objectID;




@property (nonatomic, strong) NSData* data;


//- (BOOL)validateData:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;






@end

@interface _ETGWelcomeImage (CoreDataGeneratedAccessors)

@end

@interface _ETGWelcomeImage (CoreDataGeneratedPrimitiveAccessors)


- (NSData*)primitiveData;
- (void)setPrimitiveData:(NSData*)value;




- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




@end
