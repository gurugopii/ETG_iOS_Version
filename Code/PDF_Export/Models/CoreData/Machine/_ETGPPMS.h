// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPPMS.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPPMSAttributes {
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *percentage;
	__unsafe_unretained NSString *status;
} ETGPPMSAttributes;

extern const struct ETGPPMSRelationships {
	__unsafe_unretained NSString *projectSummary;
} ETGPPMSRelationships;

extern const struct ETGPPMSFetchedProperties {
} ETGPPMSFetchedProperties;

@class ETGProjectSummary;





@interface ETGPPMSID : NSManagedObjectID {}
@end

@interface _ETGPPMS : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPPMSID*)objectID;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* percentage;


//- (BOOL)validatePercentage:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* status;


//- (BOOL)validateStatus:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGPPMS (CoreDataGeneratedAccessors)

@end

@interface _ETGPPMS (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSDecimalNumber*)primitivePercentage;
- (void)setPrimitivePercentage:(NSDecimalNumber*)value;




- (NSString*)primitiveStatus;
- (void)setPrimitiveStatus:(NSString*)value;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;


@end
