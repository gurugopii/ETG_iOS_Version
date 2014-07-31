// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCostAllocation.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGCostAllocationAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGCostAllocationAttributes;

extern const struct ETGCostAllocationRelationships {
	__unsafe_unretained NSString *budgetPerformances;
	__unsafe_unretained NSString *cpbs;
	__unsafe_unretained NSString *projects;
} ETGCostAllocationRelationships;

extern const struct ETGCostAllocationFetchedProperties {
} ETGCostAllocationFetchedProperties;

@class ETGBudgetPerformance;
@class ETGCpb;
@class ETGProject;




@interface ETGCostAllocationID : NSManagedObjectID {}
@end

@interface _ETGCostAllocation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGCostAllocationID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* budgetPerformances;

- (NSMutableSet*)budgetPerformancesSet;




@property (nonatomic, strong) NSSet* cpbs;

- (NSMutableSet*)cpbsSet;




@property (nonatomic, strong) NSSet* projects;

- (NSMutableSet*)projectsSet;





@end

@interface _ETGCostAllocation (CoreDataGeneratedAccessors)

- (void)addBudgetPerformances:(NSSet*)value_;
- (void)removeBudgetPerformances:(NSSet*)value_;
- (void)addBudgetPerformancesObject:(ETGBudgetPerformance*)value_;
- (void)removeBudgetPerformancesObject:(ETGBudgetPerformance*)value_;

- (void)addCpbs:(NSSet*)value_;
- (void)removeCpbs:(NSSet*)value_;
- (void)addCpbsObject:(ETGCpb*)value_;
- (void)removeCpbsObject:(ETGCpb*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(ETGProject*)value_;
- (void)removeProjectsObject:(ETGProject*)value_;

@end

@interface _ETGCostAllocation (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveBudgetPerformances;
- (void)setPrimitiveBudgetPerformances:(NSMutableSet*)value;



- (NSMutableSet*)primitiveCpbs;
- (void)setPrimitiveCpbs:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;


@end
