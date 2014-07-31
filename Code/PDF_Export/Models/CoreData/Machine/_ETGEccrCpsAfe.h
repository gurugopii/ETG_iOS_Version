// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsAfe.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpsAfeAttributes {
} ETGEccrCpsAfeAttributes;

extern const struct ETGEccrCpsAfeRelationships {
	__unsafe_unretained NSString *capex;
	__unsafe_unretained NSString *cps;
	__unsafe_unretained NSString *opex;
	__unsafe_unretained NSString *statusCurrencies;
} ETGEccrCpsAfeRelationships;

extern const struct ETGEccrCpsAfeFetchedProperties {
} ETGEccrCpsAfeFetchedProperties;

@class ETGEccrCpsAfeDetail;
@class ETGEccrCps;
@class ETGEccrCpsAfeDetail;
@class ETGEccrCpsStatusCurrency;


@interface ETGEccrCpsAfeID : NSManagedObjectID {}
@end

@interface _ETGEccrCpsAfe : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpsAfeID*)objectID;





@property (nonatomic, strong) NSSet* capex;

- (NSMutableSet*)capexSet;




@property (nonatomic, strong) ETGEccrCps* cps;

//- (BOOL)validateCps:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* opex;

- (NSMutableSet*)opexSet;




@property (nonatomic, strong) NSSet* statusCurrencies;

- (NSMutableSet*)statusCurrenciesSet;





@end

@interface _ETGEccrCpsAfe (CoreDataGeneratedAccessors)

- (void)addCapex:(NSSet*)value_;
- (void)removeCapex:(NSSet*)value_;
- (void)addCapexObject:(ETGEccrCpsAfeDetail*)value_;
- (void)removeCapexObject:(ETGEccrCpsAfeDetail*)value_;

- (void)addOpex:(NSSet*)value_;
- (void)removeOpex:(NSSet*)value_;
- (void)addOpexObject:(ETGEccrCpsAfeDetail*)value_;
- (void)removeOpexObject:(ETGEccrCpsAfeDetail*)value_;

- (void)addStatusCurrencies:(NSSet*)value_;
- (void)removeStatusCurrencies:(NSSet*)value_;
- (void)addStatusCurrenciesObject:(ETGEccrCpsStatusCurrency*)value_;
- (void)removeStatusCurrenciesObject:(ETGEccrCpsStatusCurrency*)value_;

@end

@interface _ETGEccrCpsAfe (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveCapex;
- (void)setPrimitiveCapex:(NSMutableSet*)value;



- (ETGEccrCps*)primitiveCps;
- (void)setPrimitiveCps:(ETGEccrCps*)value;



- (NSMutableSet*)primitiveOpex;
- (void)setPrimitiveOpex:(NSMutableSet*)value;



- (NSMutableSet*)primitiveStatusCurrencies;
- (void)setPrimitiveStatusCurrencies:(NSMutableSet*)value;


@end
