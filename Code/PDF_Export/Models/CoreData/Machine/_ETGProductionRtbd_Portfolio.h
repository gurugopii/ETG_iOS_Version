// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProductionRtbd_Portfolio.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGProductionRtbd_PortfolioAttributes {
	__unsafe_unretained NSString *condyIndicator;
	__unsafe_unretained NSString *condyOutlook;
	__unsafe_unretained NSString *condyPlan;
	__unsafe_unretained NSString *gasIndicator;
	__unsafe_unretained NSString *gasOutlook;
	__unsafe_unretained NSString *gasPlan;
	__unsafe_unretained NSString *oilIndicator;
	__unsafe_unretained NSString *oilOutlook;
	__unsafe_unretained NSString *oilPlan;
	__unsafe_unretained NSString *rtbdIndicator;
	__unsafe_unretained NSString *rtbdOutlook;
	__unsafe_unretained NSString *rtbdPlan;
} ETGProductionRtbd_PortfolioAttributes;

extern const struct ETGProductionRtbd_PortfolioRelationships {
	__unsafe_unretained NSString *portfolio;
} ETGProductionRtbd_PortfolioRelationships;

extern const struct ETGProductionRtbd_PortfolioFetchedProperties {
} ETGProductionRtbd_PortfolioFetchedProperties;

@class ETGPortfolio;














@interface ETGProductionRtbd_PortfolioID : NSManagedObjectID {}
@end

@interface _ETGProductionRtbd_Portfolio : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGProductionRtbd_PortfolioID*)objectID;




@property (nonatomic, strong) NSString* condyIndicator;


//- (BOOL)validateCondyIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* condyOutlook;


//- (BOOL)validateCondyOutlook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* condyPlan;


//- (BOOL)validateCondyPlan:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* gasIndicator;


//- (BOOL)validateGasIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* gasOutlook;


//- (BOOL)validateGasOutlook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* gasPlan;


//- (BOOL)validateGasPlan:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* oilIndicator;


//- (BOOL)validateOilIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* oilOutlook;


//- (BOOL)validateOilOutlook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* oilPlan;


//- (BOOL)validateOilPlan:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* rtbdIndicator;


//- (BOOL)validateRtbdIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* rtbdOutlook;


//- (BOOL)validateRtbdOutlook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* rtbdPlan;


//- (BOOL)validateRtbdPlan:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGPortfolio* portfolio;

//- (BOOL)validatePortfolio:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGProductionRtbd_Portfolio (CoreDataGeneratedAccessors)

@end

@interface _ETGProductionRtbd_Portfolio (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCondyIndicator;
- (void)setPrimitiveCondyIndicator:(NSString*)value;




- (NSDecimalNumber*)primitiveCondyOutlook;
- (void)setPrimitiveCondyOutlook:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveCondyPlan;
- (void)setPrimitiveCondyPlan:(NSDecimalNumber*)value;




- (NSString*)primitiveGasIndicator;
- (void)setPrimitiveGasIndicator:(NSString*)value;




- (NSDecimalNumber*)primitiveGasOutlook;
- (void)setPrimitiveGasOutlook:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveGasPlan;
- (void)setPrimitiveGasPlan:(NSDecimalNumber*)value;




- (NSString*)primitiveOilIndicator;
- (void)setPrimitiveOilIndicator:(NSString*)value;




- (NSDecimalNumber*)primitiveOilOutlook;
- (void)setPrimitiveOilOutlook:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveOilPlan;
- (void)setPrimitiveOilPlan:(NSDecimalNumber*)value;




- (NSString*)primitiveRtbdIndicator;
- (void)setPrimitiveRtbdIndicator:(NSString*)value;




- (NSDecimalNumber*)primitiveRtbdOutlook;
- (void)setPrimitiveRtbdOutlook:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveRtbdPlan;
- (void)setPrimitiveRtbdPlan:(NSDecimalNumber*)value;





- (ETGPortfolio*)primitivePortfolio;
- (void)setPrimitivePortfolio:(ETGPortfolio*)value;


@end
