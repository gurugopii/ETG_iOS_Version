// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllDisciplines.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPllDisciplinesAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGPllDisciplinesAttributes;

extern const struct ETGPllDisciplinesRelationships {
	__unsafe_unretained NSString *area;
} ETGPllDisciplinesRelationships;

extern const struct ETGPllDisciplinesFetchedProperties {
} ETGPllDisciplinesFetchedProperties;

@class ETGPllAreasDisciplines;




@interface ETGPllDisciplinesID : NSManagedObjectID {}
@end

@interface _ETGPllDisciplines : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPllDisciplinesID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGPllAreasDisciplines* area;

//- (BOOL)validateArea:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGPllDisciplines (CoreDataGeneratedAccessors)

@end

@interface _ETGPllDisciplines (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (ETGPllAreasDisciplines*)primitiveArea;
- (void)setPrimitiveArea:(ETGPllAreasDisciplines*)value;


@end
