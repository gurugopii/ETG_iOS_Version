// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGAfeCostPcsb.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGAfeCostPcsbAttributes {
	__unsafe_unretained NSString *afeAfc;
	__unsafe_unretained NSString *afeIndicator;
	__unsafe_unretained NSString *afeSection;
	__unsafe_unretained NSString *afeVariance;
	__unsafe_unretained NSString *afeVowd;
	__unsafe_unretained NSString *latestAfe;
} ETGAfeCostPcsbAttributes;

extern const struct ETGAfeCostPcsbRelationships {
	__unsafe_unretained NSString *costPcsb;
} ETGAfeCostPcsbRelationships;

extern const struct ETGAfeCostPcsbFetchedProperties {
} ETGAfeCostPcsbFetchedProperties;

@class ;








@interface ETGAfeCostPcsbID : NSManagedObjectID {}
@end

@interface _ETGAfeCostPcsb : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGAfeCostPcsbID*)objectID;





@property (nonatomic, strong) NSNumber* afeAfc;



@property float afeAfcValue;
- (float)afeAfcValue;
- (void)setAfeAfcValue:(float)value_;

//- (BOOL)validateAfeAfc:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* afeIndicator;



//- (BOOL)validateAfeIndicator:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* afeSection;



//- (BOOL)validateAfeSection:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* afeVariance;



@property float afeVarianceValue;
- (float)afeVarianceValue;
- (void)setAfeVarianceValue:(float)value_;

//- (BOOL)validateAfeVariance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* afeVowd;



@property float afeVowdValue;
- (float)afeVowdValue;
- (void)setAfeVowdValue:(float)value_;

//- (BOOL)validateAfeVowd:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* latestAfe;



@property float latestAfeValue;
- (float)latestAfeValue;
- (void)setLatestAfeValue:(float)value_;

//- (BOOL)validateLatestAfe:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong)  *costPcsb;

//- (BOOL)validateCostPcsb:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGAfeCostPcsb (CoreDataGeneratedAccessors)

@end

@interface _ETGAfeCostPcsb (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAfeAfc;
- (void)setPrimitiveAfeAfc:(NSNumber*)value;

- (float)primitiveAfeAfcValue;
- (void)setPrimitiveAfeAfcValue:(float)value_;




- (NSString*)primitiveAfeIndicator;
- (void)setPrimitiveAfeIndicator:(NSString*)value;




- (NSString*)primitiveAfeSection;
- (void)setPrimitiveAfeSection:(NSString*)value;




- (NSNumber*)primitiveAfeVariance;
- (void)setPrimitiveAfeVariance:(NSNumber*)value;

- (float)primitiveAfeVarianceValue;
- (void)setPrimitiveAfeVarianceValue:(float)value_;




- (NSNumber*)primitiveAfeVowd;
- (void)setPrimitiveAfeVowd:(NSNumber*)value;

- (float)primitiveAfeVowdValue;
- (void)setPrimitiveAfeVowdValue:(float)value_;




- (NSNumber*)primitiveLatestAfe;
- (void)setPrimitiveLatestAfe:(NSNumber*)value;

- (float)primitiveLatestAfeValue;
- (void)setPrimitiveLatestAfeValue:(float)value_;





- (*)primitiveCostPcsb;
- (void)setPrimitiveCostPcsb:(*)value;


@end
