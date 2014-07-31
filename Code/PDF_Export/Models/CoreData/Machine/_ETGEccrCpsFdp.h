// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsFdp.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpsFdpAttributes {
} ETGEccrCpsFdpAttributes;

extern const struct ETGEccrCpsFdpRelationships {
	__unsafe_unretained NSString *capex;
	__unsafe_unretained NSString *cps;
	__unsafe_unretained NSString *justifications;
	__unsafe_unretained NSString *opex;
	__unsafe_unretained NSString *statusCurrencies;
} ETGEccrCpsFdpRelationships;

extern const struct ETGEccrCpsFdpFetchedProperties {
} ETGEccrCpsFdpFetchedProperties;

@class ETGEccrCpsFdpDetail;
@class ETGEccrCps;
@class ETGEccrCpsJustification;
@class ETGEccrCpsFdpDetail;
@class ETGEccrCpsStatusCurrency;


@interface ETGEccrCpsFdpID : NSManagedObjectID {}
@end

@interface _ETGEccrCpsFdp : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpsFdpID*)objectID;





@property (nonatomic, strong) NSSet* capex;

- (NSMutableSet*)capexSet;




@property (nonatomic, strong) NSSet* cps;

- (NSMutableSet*)cpsSet;




@property (nonatomic, strong) NSSet* justifications;

- (NSMutableSet*)justificationsSet;




@property (nonatomic, strong) NSSet* opex;

- (NSMutableSet*)opexSet;




@property (nonatomic, strong) NSSet* statusCurrencies;

- (NSMutableSet*)statusCurrenciesSet;





@end

@interface _ETGEccrCpsFdp (CoreDataGeneratedAccessors)

- (void)addCapex:(NSSet*)value_;
- (void)removeCapex:(NSSet*)value_;
- (void)addCapexObject:(ETGEccrCpsFdpDetail*)value_;
- (void)removeCapexObject:(ETGEccrCpsFdpDetail*)value_;

- (void)addCps:(NSSet*)value_;
- (void)removeCps:(NSSet*)value_;
- (void)addCpsObject:(ETGEccrCps*)value_;
- (void)removeCpsObject:(ETGEccrCps*)value_;

- (void)addJustifications:(NSSet*)value_;
- (void)removeJustifications:(NSSet*)value_;
- (void)addJustificationsObject:(ETGEccrCpsJustification*)value_;
- (void)removeJustificationsObject:(ETGEccrCpsJustification*)value_;

- (void)addOpex:(NSSet*)value_;
- (void)removeOpex:(NSSet*)value_;
- (void)addOpexObject:(ETGEccrCpsFdpDetail*)value_;
- (void)removeOpexObject:(ETGEccrCpsFdpDetail*)value_;

- (void)addStatusCurrencies:(NSSet*)value_;
- (void)removeStatusCurrencies:(NSSet*)value_;
- (void)addStatusCurrenciesObject:(ETGEccrCpsStatusCurrency*)value_;
- (void)removeStatusCurrenciesObject:(ETGEccrCpsStatusCurrency*)value_;

@end

@interface _ETGEccrCpsFdp (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveCapex;
- (void)setPrimitiveCapex:(NSMutableSet*)value;



- (NSMutableSet*)primitiveCps;
- (void)setPrimitiveCps:(NSMutableSet*)value;



- (NSMutableSet*)primitiveJustifications;
- (void)setPrimitiveJustifications:(NSMutableSet*)value;



- (NSMutableSet*)primitiveOpex;
- (void)setPrimitiveOpex:(NSMutableSet*)value;



- (NSMutableSet*)primitiveStatusCurrencies;
- (void)setPrimitiveStatusCurrencies:(NSMutableSet*)value;


@end
