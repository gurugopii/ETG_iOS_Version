// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllReviews.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPllReviewsAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGPllReviewsAttributes;

extern const struct ETGPllReviewsRelationships {
} ETGPllReviewsRelationships;

extern const struct ETGPllReviewsFetchedProperties {
} ETGPllReviewsFetchedProperties;





@interface ETGPllReviewsID : NSManagedObjectID {}
@end

@interface _ETGPllReviews : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPllReviewsID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;






@end

@interface _ETGPllReviews (CoreDataGeneratedAccessors)

@end

@interface _ETGPllReviews (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




@end
