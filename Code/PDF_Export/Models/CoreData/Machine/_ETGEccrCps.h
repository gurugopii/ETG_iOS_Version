// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrCps.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrCpsAttributes {
} ETGEccrCpsAttributes;

extern const struct ETGEccrCpsRelationships {
	__unsafe_unretained NSString *afe;
	__unsafe_unretained NSString *apc;
	__unsafe_unretained NSString *cpb;
	__unsafe_unretained NSString *fdp;
	__unsafe_unretained NSString *projectSummary;
	__unsafe_unretained NSString *wpb;
} ETGEccrCpsRelationships;

extern const struct ETGEccrCpsFetchedProperties {
} ETGEccrCpsFetchedProperties;

@class ETGEccrCpsAfe;
@class ETGEccrCpsApc;
@class ETGEccrCpsCpb;
@class ETGEccrCpsFdp;
@class ETGProjectSummary;
@class ETGEccrCpsWpb;


@interface ETGEccrCpsID : NSManagedObjectID {}
@end

@interface _ETGEccrCps : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrCpsID*)objectID;





@property (nonatomic, strong) ETGEccrCpsAfe* afe;

//- (BOOL)validateAfe:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsApc* apc;

//- (BOOL)validateApc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsCpb* cpb;

//- (BOOL)validateCpb:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsFdp* fdp;

//- (BOOL)validateFdp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGEccrCpsWpb* wpb;

//- (BOOL)validateWpb:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGEccrCps (CoreDataGeneratedAccessors)

@end

@interface _ETGEccrCps (CoreDataGeneratedPrimitiveAccessors)



- (ETGEccrCpsAfe*)primitiveAfe;
- (void)setPrimitiveAfe:(ETGEccrCpsAfe*)value;



- (ETGEccrCpsApc*)primitiveApc;
- (void)setPrimitiveApc:(ETGEccrCpsApc*)value;



- (ETGEccrCpsCpb*)primitiveCpb;
- (void)setPrimitiveCpb:(ETGEccrCpsCpb*)value;



- (ETGEccrCpsFdp*)primitiveFdp;
- (void)setPrimitiveFdp:(ETGEccrCpsFdp*)value;



- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;



- (ETGEccrCpsWpb*)primitiveWpb;
- (void)setPrimitiveWpb:(ETGEccrCpsWpb*)value;


@end
