// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGFirstHydrocarbon.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGFirstHydrocarbonAttributes {
	__unsafe_unretained NSString *actualDt;
	__unsafe_unretained NSString *field;
	__unsafe_unretained NSString *fieldKey;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *plannedDt;
} ETGFirstHydrocarbonAttributes;

extern const struct ETGFirstHydrocarbonRelationships {
	__unsafe_unretained NSString *projectSummary;
	__unsafe_unretained NSString *projectSummaryForMap;
	__unsafe_unretained NSString *scorecard;
} ETGFirstHydrocarbonRelationships;

extern const struct ETGFirstHydrocarbonFetchedProperties {
} ETGFirstHydrocarbonFetchedProperties;

@class ETGProjectSummary;
@class ETGProjectSummaryForMap;
@class ETGScorecard;







@interface ETGFirstHydrocarbonID : NSManagedObjectID {}
@end

@interface _ETGFirstHydrocarbon : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGFirstHydrocarbonID*)objectID;




@property (nonatomic, strong) NSDate* actualDt;


//- (BOOL)validateActualDt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* field;


//- (BOOL)validateField:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* fieldKey;


@property int32_t fieldKeyValue;
- (int32_t)fieldKeyValue;
- (void)setFieldKeyValue:(int32_t)value_;

//- (BOOL)validateFieldKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* plannedDt;


//- (BOOL)validatePlannedDt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGProjectSummaryForMap* projectSummaryForMap;

//- (BOOL)validateProjectSummaryForMap:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGFirstHydrocarbon (CoreDataGeneratedAccessors)

@end

@interface _ETGFirstHydrocarbon (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveActualDt;
- (void)setPrimitiveActualDt:(NSDate*)value;




- (NSString*)primitiveField;
- (void)setPrimitiveField:(NSString*)value;




- (NSNumber*)primitiveFieldKey;
- (void)setPrimitiveFieldKey:(NSNumber*)value;

- (int32_t)primitiveFieldKeyValue;
- (void)setPrimitiveFieldKeyValue:(int32_t)value_;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDate*)primitivePlannedDt;
- (void)setPrimitivePlannedDt:(NSDate*)value;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;



- (ETGProjectSummaryForMap*)primitiveProjectSummaryForMap;
- (void)setPrimitiveProjectSummaryForMap:(ETGProjectSummaryForMap*)value;



- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
