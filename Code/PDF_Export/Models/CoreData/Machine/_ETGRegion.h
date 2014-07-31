// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGRegion.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGRegionAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGRegionAttributes;

extern const struct ETGRegionRelationships {
	__unsafe_unretained NSString *clusters;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *projects;
} ETGRegionRelationships;

extern const struct ETGRegionFetchedProperties {
} ETGRegionFetchedProperties;

@class ETGCluster;
@class ETGCountries;
@class ETGProject;




@interface ETGRegionID : NSManagedObjectID {}
@end

@interface _ETGRegion : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGRegionID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* clusters;

- (NSMutableSet*)clustersSet;




@property (nonatomic, strong) ETGCountries* country;

//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* projects;

- (NSMutableSet*)projectsSet;





@end

@interface _ETGRegion (CoreDataGeneratedAccessors)

- (void)addClusters:(NSSet*)value_;
- (void)removeClusters:(NSSet*)value_;
- (void)addClustersObject:(ETGCluster*)value_;
- (void)removeClustersObject:(ETGCluster*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(ETGProject*)value_;
- (void)removeProjectsObject:(ETGProject*)value_;

@end

@interface _ETGRegion (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveClusters;
- (void)setPrimitiveClusters:(NSMutableSet*)value;



- (ETGCountries*)primitiveCountry;
- (void)setPrimitiveCountry:(ETGCountries*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;


@end
