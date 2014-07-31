// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsApc.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpsApcAttributes {
} ETGEccrCpsApcAttributes;

extern const struct ETGEccrCpsApcRelationships {
	__unsafe_unretained NSString *capex;
	__unsafe_unretained NSString *cps;
	__unsafe_unretained NSString *justifications;
	__unsafe_unretained NSString *opex;
	__unsafe_unretained NSString *statusCurrencies;
} ETGEccrCpsApcRelationships;

extern const struct ETGEccrCpsApcFetchedProperties {
} ETGEccrCpsApcFetchedProperties;

@class ETGEccrCpsApcDetail;
@class ETGEccrCps;
@class ETGEccrCpsJustification;
@class ETGEccrCpsApcDetail;
@class ETGEccrCpsStatusCurrency;


@interface ETGEccrCpsApcID : NSManagedObjectID {}
@end

@interface _ETGEccrCpsApc : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpsApcID*)objectID;





@property (nonatomic, strong) NSSet* capex;

- (NSMutableSet*)capexSet;




@property (nonatomic, strong) ETGEccrCps* cps;

//- (BOOL)validateCps:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* justifications;

- (NSMutableSet*)justificationsSet;




@property (nonatomic, strong) NSSet* opex;

- (NSMutableSet*)opexSet;




@property (nonatomic, strong) NSSet* statusCurrencies;

- (NSMutableSet*)statusCurrenciesSet;





@end

@interface _ETGEccrCpsApc (CoreDataGeneratedAccessors)

- (void)addCapex:(NSSet*)value_;
- (void)removeCapex:(NSSet*)value_;
- (void)addCapexObject:(ETGEccrCpsApcDetail*)value_;
- (void)removeCapexObject:(ETGEccrCpsApcDetail*)value_;

- (void)addJustifications:(NSSet*)value_;
- (void)removeJustifications:(NSSet*)value_;
- (void)addJustificationsObject:(ETGEccrCpsJustification*)value_;
- (void)removeJustificationsObject:(ETGEccrCpsJustification*)value_;

- (void)addOpex:(NSSet*)value_;
- (void)removeOpex:(NSSet*)value_;
- (void)addOpexObject:(ETGEccrCpsApcDetail*)value_;
- (void)removeOpexObject:(ETGEccrCpsApcDetail*)value_;

- (void)addStatusCurrencies:(NSSet*)value_;
- (void)removeStatusCurrencies:(NSSet*)value_;
- (void)addStatusCurrenciesObject:(ETGEccrCpsStatusCurrency*)value_;
- (void)removeStatusCurrenciesObject:(ETGEccrCpsStatusCurrency*)value_;

@end

@interface _ETGEccrCpsApc (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveCapex;
- (void)setPrimitiveCapex:(NSMutableSet*)value;



- (ETGEccrCps*)primitiveCps;
- (void)setPrimitiveCps:(ETGEccrCps*)value;



- (NSMutableSet*)primitiveJustifications;
- (void)setPrimitiveJustifications:(NSMutableSet*)value;



- (NSMutableSet*)primitiveOpex;
- (void)setPrimitiveOpex:(NSMutableSet*)value;



- (NSMutableSet*)primitiveStatusCurrencies;
- (void)setPrimitiveStatusCurrencies:(NSMutableSet*)value;


@end
