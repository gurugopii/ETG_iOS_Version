// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGHydrocarbon.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGHydrocarbonAttributes {
	__unsafe_unretained NSString *actualforecast;
	__unsafe_unretained NSString *group;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *plan;
} ETGHydrocarbonAttributes;

extern const struct ETGHydrocarbonRelationships {
	__unsafe_unretained NSString *portfolio;
} ETGHydrocarbonRelationships;

extern const struct ETGHydrocarbonFetchedProperties {
} ETGHydrocarbonFetchedProperties;

@class ETGPortfolio;






@interface ETGHydrocarbonID : NSManagedObjectID {}
@end

@interface _ETGHydrocarbon : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGHydrocarbonID*)objectID;




@property (nonatomic, strong) NSDate* actualforecast;


//- (BOOL)validateActualforecast:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* group;


//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* plan;


//- (BOOL)validatePlan:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGPortfolio* portfolio;

//- (BOOL)validatePortfolio:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGHydrocarbon (CoreDataGeneratedAccessors)

@end

@interface _ETGHydrocarbon (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveActualforecast;
- (void)setPrimitiveActualforecast:(NSDate*)value;




- (NSString*)primitiveGroup;
- (void)setPrimitiveGroup:(NSString*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDate*)primitivePlan;
- (void)setPrimitivePlan:(NSDate*)value;





- (ETGPortfolio*)primitivePortfolio;
- (void)setPrimitivePortfolio:(ETGPortfolio*)value;


@end
