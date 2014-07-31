// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCpsStatusCurrency.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpsStatusCurrencyAttributes {
	__unsafe_unretained NSString *cpsCurrency;
	__unsafe_unretained NSString *cpsStatus;
} ETGEccrCpsStatusCurrencyAttributes;

extern const struct ETGEccrCpsStatusCurrencyRelationships {
	__unsafe_unretained NSString *afe;
	__unsafe_unretained NSString *apc;
	__unsafe_unretained NSString *cpb;
	__unsafe_unretained NSString *fdp;
	__unsafe_unretained NSString *wpb;
} ETGEccrCpsStatusCurrencyRelationships;

extern const struct ETGEccrCpsStatusCurrencyFetchedProperties {
} ETGEccrCpsStatusCurrencyFetchedProperties;

@class ETGEccrCpsAfe;
@class ETGEccrCpsApc;
@class ETGEccrCpsCpb;
@class ETGEccrCpsFdp;
@class ETGEccrCpsWpb;




@interface ETGEccrCpsStatusCurrencyID : NSManagedObjectID {}
@end

@interface _ETGEccrCpsStatusCurrency : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpsStatusCurrencyID*)objectID;




@property (nonatomic, strong) NSString* cpsCurrency;


//- (BOOL)validateCpsCurrency:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* cpsStatus;


//- (BOOL)validateCpsStatus:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGEccrCpsAfe* afe;

//- (BOOL)validateAfe:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsApc* apc;

//- (BOOL)validateApc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsCpb* cpb;

//- (BOOL)validateCpb:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsFdp* fdp;

//- (BOOL)validateFdp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsWpb* wpb;

//- (BOOL)validateWpb:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGEccrCpsStatusCurrency (CoreDataGeneratedAccessors)

@end

@interface _ETGEccrCpsStatusCurrency (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCpsCurrency;
- (void)setPrimitiveCpsCurrency:(NSString*)value;




- (NSString*)primitiveCpsStatus;
- (void)setPrimitiveCpsStatus:(NSString*)value;





- (ETGEccrCpsAfe*)primitiveAfe;
- (void)setPrimitiveAfe:(ETGEccrCpsAfe*)value;



- (ETGEccrCpsApc*)primitiveApc;
- (void)setPrimitiveApc:(ETGEccrCpsApc*)value;



- (ETGEccrCpsCpb*)primitiveCpb;
- (void)setPrimitiveCpb:(ETGEccrCpsCpb*)value;



- (ETGEccrCpsFdp*)primitiveFdp;
- (void)setPrimitiveFdp:(ETGEccrCpsFdp*)value;



- (ETGEccrCpsWpb*)primitiveWpb;
- (void)setPrimitiveWpb:(ETGEccrCpsWpb*)value;


@end
