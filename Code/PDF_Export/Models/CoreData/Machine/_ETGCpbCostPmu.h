// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGCpbCostPmu.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGCpbCostPmuAttributes {
	__unsafe_unretained NSString *abrApproved;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *latestWpb;
	__unsafe_unretained NSString *originalWpb;
	__unsafe_unretained NSString *section;
	__unsafe_unretained NSString *variance;
	__unsafe_unretained NSString *yepG;
	__unsafe_unretained NSString *yercoApproved;
} ETGCpbCostPmuAttributes;

extern const struct ETGCpbCostPmuRelationships {
	__unsafe_unretained NSString *costPmu;
} ETGCpbCostPmuRelationships;

extern const struct ETGCpbCostPmuFetchedProperties {
} ETGCpbCostPmuFetchedProperties;

@class ;










@interface ETGCpbCostPmuID : NSManagedObjectID {}
@end

@interface _ETGCpbCostPmu : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGCpbCostPmuID*)objectID;




@property (nonatomic, strong) NSString* abrApproved;


//- (BOOL)validateAbrApproved:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* latestWpb;


//- (BOOL)validateLatestWpb:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* originalWpb;


//- (BOOL)validateOriginalWpb:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* section;


//- (BOOL)validateSection:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* variance;


//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* yepG;


//- (BOOL)validateYepG:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* yercoApproved;


//- (BOOL)validateYercoApproved:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* costPmu;

- (NSMutableSet*)costPmuSet;





@end

@interface _ETGCpbCostPmu (CoreDataGeneratedAccessors)

- (void)addCostPmu:(NSSet*)value_;
- (void)removeCostPmu:(NSSet*)value_;
- (void)addCostPmuObject:(*)value_;
- (void)removeCostPmuObject:(*)value_;

@end

@interface _ETGCpbCostPmu (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAbrApproved;
- (void)setPrimitiveAbrApproved:(NSString*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSString*)primitiveLatestWpb;
- (void)setPrimitiveLatestWpb:(NSString*)value;




- (NSString*)primitiveOriginalWpb;
- (void)setPrimitiveOriginalWpb:(NSString*)value;




- (NSString*)primitiveSection;
- (void)setPrimitiveSection:(NSString*)value;




- (NSString*)primitiveVariance;
- (void)setPrimitiveVariance:(NSString*)value;




- (NSString*)primitiveYepG;
- (void)setPrimitiveYepG:(NSString*)value;




- (NSString*)primitiveYercoApproved;
- (void)setPrimitiveYercoApproved:(NSString*)value;





- (NSMutableSet*)primitiveCostPmu;
- (void)setPrimitiveCostPmu:(NSMutableSet*)value;


@end
