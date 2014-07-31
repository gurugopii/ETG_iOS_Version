// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGWPBCostPMU.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGWPBCostPMUAttributes {
	__unsafe_unretained NSString *abrApproved;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *latestWpb;
	__unsafe_unretained NSString *originalWpb;
	__unsafe_unretained NSString *section;
	__unsafe_unretained NSString *sectionKey;
	__unsafe_unretained NSString *variance;
	__unsafe_unretained NSString *yepG;
	__unsafe_unretained NSString *yercoApproved;
} ETGWPBCostPMUAttributes;

extern const struct ETGWPBCostPMURelationships {
	__unsafe_unretained NSString *scorecard;
} ETGWPBCostPMURelationships;

extern const struct ETGWPBCostPMUFetchedProperties {
} ETGWPBCostPMUFetchedProperties;

@class ETGScorecard;











@interface ETGWPBCostPMUID : NSManagedObjectID {}
@end

@interface _ETGWPBCostPMU : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGWPBCostPMUID*)objectID;




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




@property (nonatomic, strong) NSNumber* sectionKey;


@property int32_t sectionKeyValue;
- (int32_t)sectionKeyValue;
- (void)setSectionKeyValue:(int32_t)value_;

//- (BOOL)validateSectionKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* variance;


//- (BOOL)validateVariance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* yepG;


//- (BOOL)validateYepG:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* yercoApproved;


//- (BOOL)validateYercoApproved:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGWPBCostPMU (CoreDataGeneratedAccessors)

@end

@interface _ETGWPBCostPMU (CoreDataGeneratedPrimitiveAccessors)


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




- (NSNumber*)primitiveSectionKey;
- (void)setPrimitiveSectionKey:(NSNumber*)value;

- (int32_t)primitiveSectionKeyValue;
- (void)setPrimitiveSectionKeyValue:(int32_t)value_;




- (NSString*)primitiveVariance;
- (void)setPrimitiveVariance:(NSString*)value;




- (NSString*)primitiveYepG;
- (void)setPrimitiveYepG:(NSString*)value;




- (NSString*)primitiveYercoApproved;
- (void)setPrimitiveYercoApproved:(NSString*)value;





- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
