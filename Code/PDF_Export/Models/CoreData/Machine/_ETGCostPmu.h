// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCostPmu.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGCostPmuAttributes {
} ETGCostPmuAttributes;

extern const struct ETGCostPmuRelationships {
	__unsafe_unretained NSString *apc;
	__unsafe_unretained NSString *cpbs;
	__unsafe_unretained NSString *scorecards;
} ETGCostPmuRelationships;

extern const struct ETGCostPmuFetchedProperties {
} ETGCostPmuFetchedProperties;

@class ETGApcCostPmu;
@class ;
@class ;


@interface ETGCostPmuID : NSManagedObjectID {}
@end

@interface _ETGCostPmu : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGCostPmuID*)objectID;





@property (nonatomic, strong) ETGApcCostPmu *apc;

//- (BOOL)validateApc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *cpbs;

- (NSMutableSet*)cpbsSet;




@property (nonatomic, strong)  *scorecards;

//- (BOOL)validateScorecards:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGCostPmu (CoreDataGeneratedAccessors)

- (void)addCpbs:(NSSet*)value_;
- (void)removeCpbs:(NSSet*)value_;
- (void)addCpbsObject:(*)value_;
- (void)removeCpbsObject:(*)value_;

@end

@interface _ETGCostPmu (CoreDataGeneratedPrimitiveAccessors)



- (ETGApcCostPmu*)primitiveApc;
- (void)setPrimitiveApc:(ETGApcCostPmu*)value;



- (NSMutableSet*)primitiveCpbs;
- (void)setPrimitiveCpbs:(NSMutableSet*)value;



- (*)primitiveScorecards;
- (void)setPrimitiveScorecards:(*)value;


@end
