// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGRiskOpportunity.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGRiskOpportunityAttributes {
	__unsafe_unretained NSString *activity;
	__unsafe_unretained NSString *cluster;
	__unsafe_unretained NSString *cost;
	__unsafe_unretained NSString *descriptions;
	__unsafe_unretained NSString *identifiedDate;
	__unsafe_unretained NSString *mitigation;
	__unsafe_unretained NSString *negativeImpact;
	__unsafe_unretained NSString *probability;
	__unsafe_unretained NSString *production;
	__unsafe_unretained NSString *productionGas;
	__unsafe_unretained NSString *productionOil;
	__unsafe_unretained NSString *schedule;
	__unsafe_unretained NSString *status;
	__unsafe_unretained NSString *type;
} ETGRiskOpportunityAttributes;

extern const struct ETGRiskOpportunityRelationships {
	__unsafe_unretained NSString *projectSummary;
} ETGRiskOpportunityRelationships;

extern const struct ETGRiskOpportunityFetchedProperties {
} ETGRiskOpportunityFetchedProperties;

@class ETGProjectSummary;
















@interface ETGRiskOpportunityID : NSManagedObjectID {}
@end

@interface _ETGRiskOpportunity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGRiskOpportunityID*)objectID;




@property (nonatomic, strong) NSString* activity;


//- (BOOL)validateActivity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* cluster;


//- (BOOL)validateCluster:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* cost;


//- (BOOL)validateCost:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* descriptions;


//- (BOOL)validateDescriptions:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* identifiedDate;


//- (BOOL)validateIdentifiedDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* mitigation;


//- (BOOL)validateMitigation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* negativeImpact;


//- (BOOL)validateNegativeImpact:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* probability;


//- (BOOL)validateProbability:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* production;


//- (BOOL)validateProduction:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* productionGas;


//- (BOOL)validateProductionGas:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* productionOil;


//- (BOOL)validateProductionOil:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* schedule;


@property int32_t scheduleValue;
- (int32_t)scheduleValue;
- (void)setScheduleValue:(int32_t)value_;

//- (BOOL)validateSchedule:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* status;


//- (BOOL)validateStatus:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* type;


//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGRiskOpportunity (CoreDataGeneratedAccessors)

@end

@interface _ETGRiskOpportunity (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveActivity;
- (void)setPrimitiveActivity:(NSString*)value;




- (NSString*)primitiveCluster;
- (void)setPrimitiveCluster:(NSString*)value;




- (NSDecimalNumber*)primitiveCost;
- (void)setPrimitiveCost:(NSDecimalNumber*)value;




- (NSString*)primitiveDescriptions;
- (void)setPrimitiveDescriptions:(NSString*)value;




- (NSDate*)primitiveIdentifiedDate;
- (void)setPrimitiveIdentifiedDate:(NSDate*)value;




- (NSString*)primitiveMitigation;
- (void)setPrimitiveMitigation:(NSString*)value;




- (NSString*)primitiveNegativeImpact;
- (void)setPrimitiveNegativeImpact:(NSString*)value;




- (NSString*)primitiveProbability;
- (void)setPrimitiveProbability:(NSString*)value;




- (NSDecimalNumber*)primitiveProduction;
- (void)setPrimitiveProduction:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveProductionGas;
- (void)setPrimitiveProductionGas:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveProductionOil;
- (void)setPrimitiveProductionOil:(NSDecimalNumber*)value;




- (NSNumber*)primitiveSchedule;
- (void)setPrimitiveSchedule:(NSNumber*)value;

- (int32_t)primitiveScheduleValue;
- (void)setPrimitiveScheduleValue:(int32_t)value_;




- (NSString*)primitiveStatus;
- (void)setPrimitiveStatus:(NSString*)value;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;


@end
