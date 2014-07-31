// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCpbCostPcsb.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGCpbCostPcsbAttributes {
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *latestCpb;
	__unsafe_unretained NSString *originalCpb;
	__unsafe_unretained NSString *performanceName;
	__unsafe_unretained NSString *variance;
	__unsafe_unretained NSString *yep_e;
	__unsafe_unretained NSString *ytdActual;
} ETGCpbCostPcsbAttributes;

extern const struct ETGCpbCostPcsbRelationships {
	__unsafe_unretained NSString *costPcsb;
} ETGCpbCostPcsbRelationships;

extern const struct ETGCpbCostPcsbFetchedProperties {
} ETGCpbCostPcsbFetchedProperties;

@class ;









@interface ETGCpbCostPcsbID : NSManagedObjectID {}
@end

@interface _ETGCpbCostPcsb : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGCpbCostPcsbID*)objectID;





@property (nonatomic, strong) NSString* indicator;



//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* latestCpb;



@property float latestCpbValue;
- (float)latestCpbValue;
- (void)setLatestCpbValue:(float)value_;

//- (BOOL)validateLatestCpb:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* originalCpb;



@property float originalCpbValue;
- (float)originalCpbValue;
- (void)setOriginalCpbValue:(float)value_;

//- (BOOL)validateOriginalCpb:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* performanceName;



//- (BOOL)validatePerformanceName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* variance;



@property float varianceValue;
- (float)varianceValue;
- (void)setVarianceValue:(float)value_;

//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* yep_e;



@property float yep_eValue;
- (float)yep_eValue;
- (void)setYep_eValue:(float)value_;

//- (BOOL)validateYep_e:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* ytdActual;



@property float ytdActualValue;
- (float)ytdActualValue;
- (void)setYtdActualValue:(float)value_;

//- (BOOL)validateYtdActual:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong)  *costPcsb;

//- (BOOL)validateCostPcsb:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGCpbCostPcsb (CoreDataGeneratedAccessors)

@end

@interface _ETGCpbCostPcsb (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSNumber*)primitiveLatestCpb;
- (void)setPrimitiveLatestCpb:(NSNumber*)value;

- (float)primitiveLatestCpbValue;
- (void)setPrimitiveLatestCpbValue:(float)value_;




- (NSNumber*)primitiveOriginalCpb;
- (void)setPrimitiveOriginalCpb:(NSNumber*)value;

- (float)primitiveOriginalCpbValue;
- (void)setPrimitiveOriginalCpbValue:(float)value_;




- (NSString*)primitivePerformanceName;
- (void)setPrimitivePerformanceName:(NSString*)value;




- (NSNumber*)primitiveVariance;
- (void)setPrimitiveVariance:(NSNumber*)value;

- (float)primitiveVarianceValue;
- (void)setPrimitiveVarianceValue:(float)value_;




- (NSNumber*)primitiveYep_e;
- (void)setPrimitiveYep_e:(NSNumber*)value;

- (float)primitiveYep_eValue;
- (void)setPrimitiveYep_eValue:(float)value_;




- (NSNumber*)primitiveYtdActual;
- (void)setPrimitiveYtdActual:(NSNumber*)value;

- (float)primitiveYtdActualValue;
- (void)setPrimitiveYtdActualValue:(float)value_;





- (*)primitiveCostPcsb;
- (void)setPrimitiveCostPcsb:(*)value;


@end
