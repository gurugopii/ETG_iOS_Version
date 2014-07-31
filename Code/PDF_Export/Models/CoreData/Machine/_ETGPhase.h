// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPhase.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPhaseAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGPhaseAttributes;

extern const struct ETGPhaseRelationships {
	__unsafe_unretained NSString *project;
} ETGPhaseRelationships;

extern const struct ETGPhaseFetchedProperties {
} ETGPhaseFetchedProperties;

@class ETGProject;




@interface ETGPhaseID : NSManagedObjectID {}
@end

@interface _ETGPhase : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPhaseID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* project;

- (NSMutableSet*)projectSet;





@end

@interface _ETGPhase (CoreDataGeneratedAccessors)

- (void)addProject:(NSSet*)value_;
- (void)removeProject:(NSSet*)value_;
- (void)addProjectObject:(ETGProject*)value_;
- (void)removeProjectObject:(ETGProject*)value_;

@end

@interface _ETGPhase (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveProject;
- (void)setPrimitiveProject:(NSMutableSet*)value;


@end
