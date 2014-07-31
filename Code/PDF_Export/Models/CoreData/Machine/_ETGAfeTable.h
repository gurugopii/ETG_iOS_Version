// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGAfeTable.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGAfeTableAttributes {
	__unsafe_unretained NSString *afc;
	__unsafe_unretained NSString *afeDescription;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *itd;
	__unsafe_unretained NSString *latestApprovedAfe;
	__unsafe_unretained NSString *variance;
} ETGAfeTableAttributes;

extern const struct ETGAfeTableRelationships {
	__unsafe_unretained NSString *projectSummary;
	__unsafe_unretained NSString *scorecard;
} ETGAfeTableRelationships;

extern const struct ETGAfeTableFetchedProperties {
} ETGAfeTableFetchedProperties;

@class ETGProjectSummary;
@class ETGScorecard;








@interface ETGAfeTableID : NSManagedObjectID {}
@end

@interface _ETGAfeTable : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGAfeTableID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* afc;


//- (BOOL)validateAfc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* afeDescription;


//- (BOOL)validateAfeDescription:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* itd;


//- (BOOL)validateItd:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* latestApprovedAfe;


//- (BOOL)validateLatestApprovedAfe:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* variance;


//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGAfeTable (CoreDataGeneratedAccessors)

@end

@interface _ETGAfeTable (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveAfc;
- (void)setPrimitiveAfc:(NSDecimalNumber*)value;




- (NSString*)primitiveAfeDescription;
- (void)setPrimitiveAfeDescription:(NSString*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDecimalNumber*)primitiveItd;
- (void)setPrimitiveItd:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveLatestApprovedAfe;
- (void)setPrimitiveLatestApprovedAfe:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveVariance;
- (void)setPrimitiveVariance:(NSDecimalNumber*)value;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;



- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
