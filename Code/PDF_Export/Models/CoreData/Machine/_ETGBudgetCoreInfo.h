// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGBudgetCoreInfo.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGBudgetCoreInfoAttributes {
	__unsafe_unretained NSString *cumVowd;
	__unsafe_unretained NSString *fdp;
	__unsafe_unretained NSString *ytdActual;
} ETGBudgetCoreInfoAttributes;

extern const struct ETGBudgetCoreInfoRelationships {
	__unsafe_unretained NSString *projectSummary;
} ETGBudgetCoreInfoRelationships;

extern const struct ETGBudgetCoreInfoFetchedProperties {
} ETGBudgetCoreInfoFetchedProperties;

@class ETGProjectSummary;





@interface ETGBudgetCoreInfoID : NSManagedObjectID {}
@end

@interface _ETGBudgetCoreInfo : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGBudgetCoreInfoID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* cumVowd;


//- (BOOL)validateCumVowd:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* fdp;


//- (BOOL)validateFdp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* ytdActual;


//- (BOOL)validateYtdActual:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGBudgetCoreInfo (CoreDataGeneratedAccessors)

@end

@interface _ETGBudgetCoreInfo (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveCumVowd;
- (void)setPrimitiveCumVowd:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveFdp;
- (void)setPrimitiveFdp:(NSDecimalNumber*)value;




- (NSDecimalNumber*)primitiveYtdActual;
- (void)setPrimitiveYtdActual:(NSDecimalNumber*)value;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;


@end
