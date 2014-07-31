// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCluster.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGClusterAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGClusterAttributes;

extern const struct ETGClusterRelationships {
	__unsafe_unretained NSString *projects;
	__unsafe_unretained NSString *region;
} ETGClusterRelationships;

extern const struct ETGClusterFetchedProperties {
} ETGClusterFetchedProperties;

@class ETGProject;
@class ETGRegion;




@interface ETGClusterID : NSManagedObjectID {}
@end

@interface _ETGCluster : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGClusterID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* projects;

- (NSMutableSet*)projectsSet;




@property (nonatomic, strong) NSSet* region;

- (NSMutableSet*)regionSet;





@end

@interface _ETGCluster (CoreDataGeneratedAccessors)

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(ETGProject*)value_;
- (void)removeProjectsObject:(ETGProject*)value_;

- (void)addRegion:(NSSet*)value_;
- (void)removeRegion:(NSSet*)value_;
- (void)addRegionObject:(ETGRegion*)value_;
- (void)removeRegionObject:(ETGRegion*)value_;

@end

@interface _ETGCluster (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveRegion;
- (void)setPrimitiveRegion:(NSMutableSet*)value;


@end
