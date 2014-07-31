// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGApcCostPmu.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGApcCostPmuAttributes {
	__unsafe_unretained NSString *afc;
	__unsafe_unretained NSString *fia;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *performanceName;
	__unsafe_unretained NSString *tpFipFdp;
	__unsafe_unretained NSString *variance;
	__unsafe_unretained NSString *vowd;
} ETGApcCostPmuAttributes;

extern const struct ETGApcCostPmuRelationships {
	__unsafe_unretained NSString *costPmu;
} ETGApcCostPmuRelationships;

extern const struct ETGApcCostPmuFetchedProperties {
} ETGApcCostPmuFetchedProperties;

@class ;









@interface ETGApcCostPmuID : NSManagedObjectID {}
@end

@interface _ETGApcCostPmu : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGApcCostPmuID*)objectID;





@property (nonatomic, strong) NSString* afc;



//- (BOOL)validateAfc:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* fia;



//- (BOOL)validateFia:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* indicator;



//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* performanceName;



//- (BOOL)validatePerformanceName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* tpFipFdp;



//- (BOOL)validateTpFipFdp:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* variance;



//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* vowd;



//- (BOOL)validateVowd:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong)  *costPmu;

//- (BOOL)validateCostPmu:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGApcCostPmu (CoreDataGeneratedAccessors)

@end

@interface _ETGApcCostPmu (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAfc;
- (void)setPrimitiveAfc:(NSString*)value;




- (NSString*)primitiveFia;
- (void)setPrimitiveFia:(NSString*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSString*)primitivePerformanceName;
- (void)setPrimitivePerformanceName:(NSString*)value;




- (NSString*)primitiveTpFipFdp;
- (void)setPrimitiveTpFipFdp:(NSString*)value;




- (NSString*)primitiveVariance;
- (void)setPrimitiveVariance:(NSString*)value;




- (NSString*)primitiveVowd;
- (void)setPrimitiveVowd:(NSString*)value;





- (*)primitiveCostPmu;
- (void)setPrimitiveCostPmu:(*)value;


@end
