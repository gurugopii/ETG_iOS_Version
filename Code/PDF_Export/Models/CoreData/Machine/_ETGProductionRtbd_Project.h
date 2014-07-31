// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProductionRtbd_Project.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGProductionRtbd_ProjectAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *cpb;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *type;
	__unsafe_unretained NSString *yep;
} ETGProductionRtbd_ProjectAttributes;

extern const struct ETGProductionRtbd_ProjectRelationships {
	__unsafe_unretained NSString *projectSummary;
} ETGProductionRtbd_ProjectRelationships;

extern const struct ETGProductionRtbd_ProjectFetchedProperties {
} ETGProductionRtbd_ProjectFetchedProperties;

@class ETGProjectSummary;







@interface ETGProductionRtbd_ProjectID : NSManagedObjectID {}
@end

@interface _ETGProductionRtbd_Project : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGProductionRtbd_ProjectID*)objectID;




@property (nonatomic, strong) NSString* category;


//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* cpb;


//- (BOOL)validateCpb:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* type;


//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* yep;


//- (BOOL)validateYep:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGProductionRtbd_Project (CoreDataGeneratedAccessors)

@end

@interface _ETGProductionRtbd_Project (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;




- (NSDecimalNumber*)primitiveCpb;
- (void)setPrimitiveCpb:(NSDecimalNumber*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;




- (NSDecimalNumber*)primitiveYep;
- (void)setPrimitiveYep:(NSDecimalNumber*)value;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;


@end
