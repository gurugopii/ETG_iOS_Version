// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMap.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMapAttributes {
	__unsafe_unretained NSString *reportMonth;
} ETGMapAttributes;

extern const struct ETGMapRelationships {
	__unsafe_unretained NSString *etgMapsPems;
	__unsafe_unretained NSString *etgMapsPgd;
	__unsafe_unretained NSString *project;
	__unsafe_unretained NSString *reportingMonth;
} ETGMapRelationships;

extern const struct ETGMapFetchedProperties {
} ETGMapFetchedProperties;

@class ETGMapsPEM;
@class ETGMapsPGD;
@class ETGProject;
@class ETGReportingMonth;



@interface ETGMapID : NSManagedObjectID {}
@end

@interface _ETGMap : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMapID*)objectID;




@property (nonatomic, strong) NSString* reportMonth;


//- (BOOL)validateReportMonth:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* etgMapsPems;

- (NSMutableSet*)etgMapsPemsSet;




@property (nonatomic, strong) NSSet* etgMapsPgd;

- (NSMutableSet*)etgMapsPgdSet;




@property (nonatomic, strong) ETGProject* project;

//- (BOOL)validateProject:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGMap (CoreDataGeneratedAccessors)

- (void)addEtgMapsPems:(NSSet*)value_;
- (void)removeEtgMapsPems:(NSSet*)value_;
- (void)addEtgMapsPemsObject:(ETGMapsPEM*)value_;
- (void)removeEtgMapsPemsObject:(ETGMapsPEM*)value_;

- (void)addEtgMapsPgd:(NSSet*)value_;
- (void)removeEtgMapsPgd:(NSSet*)value_;
- (void)addEtgMapsPgdObject:(ETGMapsPGD*)value_;
- (void)removeEtgMapsPgdObject:(ETGMapsPGD*)value_;

@end

@interface _ETGMap (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveReportMonth;
- (void)setPrimitiveReportMonth:(NSString*)value;





- (NSMutableSet*)primitiveEtgMapsPems;
- (void)setPrimitiveEtgMapsPems:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgMapsPgd;
- (void)setPrimitiveEtgMapsPgd:(NSMutableSet*)value;



- (ETGProject*)primitiveProject;
- (void)setPrimitiveProject:(ETGProject*)value;



- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;


@end
