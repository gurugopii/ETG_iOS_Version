// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCostPcsb.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGCostPcsbAttributes {
} ETGCostPcsbAttributes;

extern const struct ETGCostPcsbRelationships {
	__unsafe_unretained NSString *afes;
	__unsafe_unretained NSString *apc;
	__unsafe_unretained NSString *cpb;
	__unsafe_unretained NSString *scorecards;
} ETGCostPcsbRelationships;

extern const struct ETGCostPcsbFetchedProperties {
} ETGCostPcsbFetchedProperties;

@class ETGAfeCostPcsb;
@class ETGApcCostPcsb;
@class ETGCpbCostPcsb;
@class ;


@interface ETGCostPcsbID : NSManagedObjectID {}
@end

@interface _ETGCostPcsb : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGCostPcsbID*)objectID;





@property (nonatomic, strong) NSSet *afes;

- (NSMutableSet*)afesSet;




@property (nonatomic, strong) ETGApcCostPcsb *apc;

//- (BOOL)validateApc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGCpbCostPcsb *cpb;

//- (BOOL)validateCpb:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong)  *scorecards;

//- (BOOL)validateScorecards:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGCostPcsb (CoreDataGeneratedAccessors)

- (void)addAfes:(NSSet*)value_;
- (void)removeAfes:(NSSet*)value_;
- (void)addAfesObject:(ETGAfeCostPcsb*)value_;
- (void)removeAfesObject:(ETGAfeCostPcsb*)value_;

@end

@interface _ETGCostPcsb (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveAfes;
- (void)setPrimitiveAfes:(NSMutableSet*)value;



- (ETGApcCostPcsb*)primitiveApc;
- (void)setPrimitiveApc:(ETGApcCostPcsb*)value;



- (ETGCpbCostPcsb*)primitiveCpb;
- (void)setPrimitiveCpb:(ETGCpbCostPcsb*)value;



- (*)primitiveScorecards;
- (void)setPrimitiveScorecards:(*)value;


@end
