// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGAfe.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGAfeAttributes {
	__unsafe_unretained NSString *afe;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *status;
} ETGAfeAttributes;

extern const struct ETGAfeRelationships {
	__unsafe_unretained NSString *projectSummary;
} ETGAfeRelationships;

extern const struct ETGAfeFetchedProperties {
} ETGAfeFetchedProperties;

@class ETGProjectSummary;





@interface ETGAfeID : NSManagedObjectID {}
@end

@interface _ETGAfe : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGAfeID*)objectID;




@property (nonatomic, strong) NSDecimalNumber* afe;


//- (BOOL)validateAfe:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* status;


//- (BOOL)validateStatus:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGAfe (CoreDataGeneratedAccessors)

@end

@interface _ETGAfe (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveAfe;
- (void)setPrimitiveAfe:(NSDecimalNumber*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSString*)primitiveStatus;
- (void)setPrimitiveStatus:(NSString*)value;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;


@end
