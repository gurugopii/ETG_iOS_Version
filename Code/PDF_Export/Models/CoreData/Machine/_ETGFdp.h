// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGFdp.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGFdpAttributes {
	__unsafe_unretained NSString *afc;
	__unsafe_unretained NSString *fia;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *tpFipFdp;
	__unsafe_unretained NSString *variance;
	__unsafe_unretained NSString *vowd;
} ETGFdpAttributes;

extern const struct ETGFdpRelationships {
	__unsafe_unretained NSString *scorecard;
} ETGFdpRelationships;

extern const struct ETGFdpFetchedProperties {
} ETGFdpFetchedProperties;

@class ETGScorecard;








@interface ETGFdpID : NSManagedObjectID {}
@end

@interface _ETGFdp : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGFdpID*)objectID;




@property (nonatomic, strong) NSString* afc;


//- (BOOL)validateAfc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* fia;


//- (BOOL)validateFia:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* tpFipFdp;


//- (BOOL)validateTpFipFdp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* variance;


//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* vowd;


//- (BOOL)validateVowd:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGFdp (CoreDataGeneratedAccessors)

@end

@interface _ETGFdp (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAfc;
- (void)setPrimitiveAfc:(NSString*)value;




- (NSString*)primitiveFia;
- (void)setPrimitiveFia:(NSString*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSString*)primitiveTpFipFdp;
- (void)setPrimitiveTpFipFdp:(NSString*)value;




- (NSString*)primitiveVariance;
- (void)setPrimitiveVariance:(NSString*)value;




- (NSString*)primitiveVowd;
- (void)setPrimitiveVowd:(NSString*)value;





- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
