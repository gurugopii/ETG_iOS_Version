// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPllAreasDisciplines.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPllAreasDisciplinesAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGPllAreasDisciplinesAttributes;

extern const struct ETGPllAreasDisciplinesRelationships {
	__unsafe_unretained NSString *disciplines;
} ETGPllAreasDisciplinesRelationships;

extern const struct ETGPllAreasDisciplinesFetchedProperties {
} ETGPllAreasDisciplinesFetchedProperties;

@class ETGPllDisciplines;




@interface ETGPllAreasDisciplinesID : NSManagedObjectID {}
@end

@interface _ETGPllAreasDisciplines : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPllAreasDisciplinesID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* disciplines;

- (NSMutableSet*)disciplinesSet;





@end

@interface _ETGPllAreasDisciplines (CoreDataGeneratedAccessors)

- (void)addDisciplines:(NSSet*)value_;
- (void)removeDisciplines:(NSSet*)value_;
- (void)addDisciplinesObject:(ETGPllDisciplines*)value_;
- (void)removeDisciplinesObject:(ETGPllDisciplines*)value_;

@end

@interface _ETGPllAreasDisciplines (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveDisciplines;
- (void)setPrimitiveDisciplines:(NSMutableSet*)value;


@end
