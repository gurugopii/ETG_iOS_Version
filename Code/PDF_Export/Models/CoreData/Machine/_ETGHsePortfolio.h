// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGHsePortfolio.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGHsePortfolioAttributes {
	__unsafe_unretained NSString *fatality;
	__unsafe_unretained NSString *fireincident;
	__unsafe_unretained NSString *losttimeinjuries;
	__unsafe_unretained NSString *totalrecordable;
} ETGHsePortfolioAttributes;

extern const struct ETGHsePortfolioRelationships {
	__unsafe_unretained NSString *portfolio;
} ETGHsePortfolioRelationships;

extern const struct ETGHsePortfolioFetchedProperties {
} ETGHsePortfolioFetchedProperties;

@class ETGPortfolio;






@interface ETGHsePortfolioID : NSManagedObjectID {}
@end

@interface _ETGHsePortfolio : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGHsePortfolioID*)objectID;




@property (nonatomic, strong) NSNumber* fatality;


@property int32_t fatalityValue;
- (int32_t)fatalityValue;
- (void)setFatalityValue:(int32_t)value_;

//- (BOOL)validateFatality:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* fireincident;


@property int32_t fireincidentValue;
- (int32_t)fireincidentValue;
- (void)setFireincidentValue:(int32_t)value_;

//- (BOOL)validateFireincident:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* losttimeinjuries;


@property int32_t losttimeinjuriesValue;
- (int32_t)losttimeinjuriesValue;
- (void)setLosttimeinjuriesValue:(int32_t)value_;

//- (BOOL)validateLosttimeinjuries:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* totalrecordable;


@property int32_t totalrecordableValue;
- (int32_t)totalrecordableValue;
- (void)setTotalrecordableValue:(int32_t)value_;

//- (BOOL)validateTotalrecordable:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGPortfolio* portfolio;

//- (BOOL)validatePortfolio:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGHsePortfolio (CoreDataGeneratedAccessors)

@end

@interface _ETGHsePortfolio (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveFatality;
- (void)setPrimitiveFatality:(NSNumber*)value;

- (int32_t)primitiveFatalityValue;
- (void)setPrimitiveFatalityValue:(int32_t)value_;




- (NSNumber*)primitiveFireincident;
- (void)setPrimitiveFireincident:(NSNumber*)value;

- (int32_t)primitiveFireincidentValue;
- (void)setPrimitiveFireincidentValue:(int32_t)value_;




- (NSNumber*)primitiveLosttimeinjuries;
- (void)setPrimitiveLosttimeinjuries:(NSNumber*)value;

- (int32_t)primitiveLosttimeinjuriesValue;
- (void)setPrimitiveLosttimeinjuriesValue:(int32_t)value_;




- (NSNumber*)primitiveTotalrecordable;
- (void)setPrimitiveTotalrecordable:(NSNumber*)value;

- (int32_t)primitiveTotalrecordableValue;
- (void)setPrimitiveTotalrecordableValue:(int32_t)value_;





- (ETGPortfolio*)primitivePortfolio;
- (void)setPrimitivePortfolio:(ETGPortfolio*)value;


@end
