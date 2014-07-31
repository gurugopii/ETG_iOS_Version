// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsCpb.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpsCpbAttributes {
} ETGEccrCpsCpbAttributes;

extern const struct ETGEccrCpsCpbRelationships {
	__unsafe_unretained NSString *capex;
	__unsafe_unretained NSString *cps;
	__unsafe_unretained NSString *justifications;
	__unsafe_unretained NSString *opex;
	__unsafe_unretained NSString *statusCurrencies;
} ETGEccrCpsCpbRelationships;

extern const struct ETGEccrCpsCpbFetchedProperties {
} ETGEccrCpsCpbFetchedProperties;

@class ETGEccrCpsCpbDetail;
@class ETGEccrCps;
@class ETGEccrCpsJustification;
@class ETGEccrCpsCpbDetail;
@class ETGEccrCpsStatusCurrency;


@interface ETGEccrCpsCpbID : NSManagedObjectID {}
@end

@interface _ETGEccrCpsCpb : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpsCpbID*)objectID;





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

@interface _ETGEccrCpsCpb (CoreDataGeneratedAccessors)

- (void)addCapex:(NSSet*)value_;
- (void)removeCapex:(NSSet*)value_;
- (void)addCapexObject:(ETGEccrCpsCpbDetail*)value_;
- (void)removeCapexObject:(ETGEccrCpsCpbDetail*)value_;

- (void)addJustifications:(NSSet*)value_;
- (void)removeJustifications:(NSSet*)value_;
- (void)addJustificationsObject:(ETGEccrCpsJustification*)value_;
- (void)removeJustificationsObject:(ETGEccrCpsJustification*)value_;

- (void)addOpex:(NSSet*)value_;
- (void)removeOpex:(NSSet*)value_;
- (void)addOpexObject:(ETGEccrCpsCpbDetail*)value_;
- (void)removeOpexObject:(ETGEccrCpsCpbDetail*)value_;

- (void)addStatusCurrencies:(NSSet*)value_;
- (void)removeStatusCurrencies:(NSSet*)value_;
- (void)addStatusCurrenciesObject:(ETGEccrCpsStatusCurrency*)value_;
- (void)removeStatusCurrenciesObject:(ETGEccrCpsStatusCurrency*)value_;

@end

@interface _ETGEccrCpsCpb (CoreDataGeneratedPrimitiveAccessors)



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
