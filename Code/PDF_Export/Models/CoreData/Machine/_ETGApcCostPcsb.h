// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGApcCostPcsb.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGApcCostPcsbAttributes {
	__unsafe_unretained NSString *afc;
	__unsafe_unretained NSString *apcIndicator;
	__unsafe_unretained NSString *apcVariance;
	__unsafe_unretained NSString *latestApc;
	__unsafe_unretained NSString *vowd;
} ETGApcCostPcsbAttributes;

extern const struct ETGApcCostPcsbRelationships {
	__unsafe_unretained NSString *costPcsb;
} ETGApcCostPcsbRelationships;

extern const struct ETGApcCostPcsbFetchedProperties {
} ETGApcCostPcsbFetchedProperties;

@class ;







@interface ETGApcCostPcsbID : NSManagedObjectID {}
@end

@interface _ETGApcCostPcsb : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGApcCostPcsbID*)objectID;





@property (nonatomic, strong) NSNumber* afc;



@property float afcValue;
- (float)afcValue;
- (void)setAfcValue:(float)value_;

//- (BOOL)validateAfc:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* apcIndicator;



//- (BOOL)validateApcIndicator:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* apcVariance;



@property float apcVarianceValue;
- (float)apcVarianceValue;
- (void)setApcVarianceValue:(float)value_;

//- (BOOL)validateApcVariance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* latestApc;



@property float latestApcValue;
- (float)latestApcValue;
- (void)setLatestApcValue:(float)value_;

//- (BOOL)validateLatestApc:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* vowd;



@property float vowdValue;
- (float)vowdValue;
- (void)setVowdValue:(float)value_;

//- (BOOL)validateVowd:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong)  *costPcsb;

//- (BOOL)validateCostPcsb:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGApcCostPcsb (CoreDataGeneratedAccessors)

@end

@interface _ETGApcCostPcsb (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAfc;
- (void)setPrimitiveAfc:(NSNumber*)value;

- (float)primitiveAfcValue;
- (void)setPrimitiveAfcValue:(float)value_;




- (NSString*)primitiveApcIndicator;
- (void)setPrimitiveApcIndicator:(NSString*)value;




- (NSNumber*)primitiveApcVariance;
- (void)setPrimitiveApcVariance:(NSNumber*)value;

- (float)primitiveApcVarianceValue;
- (void)setPrimitiveApcVarianceValue:(float)value_;




- (NSNumber*)primitiveLatestApc;
- (void)setPrimitiveLatestApc:(NSNumber*)value;

- (float)primitiveLatestApcValue;
- (void)setPrimitiveLatestApcValue:(float)value_;




- (NSNumber*)primitiveVowd;
- (void)setPrimitiveVowd:(NSNumber*)value;

- (float)primitiveVowdValue;
- (void)setPrimitiveVowdValue:(float)value_;





- (*)primitiveCostPcsb;
- (void)setPrimitiveCostPcsb:(*)value;


@end
