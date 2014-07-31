// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGBaselineType.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGBaselineTypeAttributes {
	__unsafe_unretained NSString *createdTime;
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *reportMonth;
} ETGBaselineTypeAttributes;

extern const struct ETGBaselineTypeRelationships {
	__unsafe_unretained NSString *projectSummary;
	__unsafe_unretained NSString *projectSummaryForMap;
	__unsafe_unretained NSString *revisions;
	__unsafe_unretained NSString *scorecard;
} ETGBaselineTypeRelationships;

extern const struct ETGBaselineTypeFetchedProperties {
} ETGBaselineTypeFetchedProperties;

@class ETGProjectSummary;
@class ETGProjectSummaryForMap;
@class ETGRevision;
@class ETGScorecard;







@interface ETGBaselineTypeID : NSManagedObjectID {}
@end

@interface _ETGBaselineType : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGBaselineTypeID*)objectID;




@property (nonatomic, strong) NSDate* createdTime;


//- (BOOL)validateCreatedTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* reportMonth;


//- (BOOL)validateReportMonth:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGProjectSummaryForMap* projectSummaryForMap;

//- (BOOL)validateProjectSummaryForMap:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* revisions;

- (NSMutableSet*)revisionsSet;




@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGBaselineType (CoreDataGeneratedAccessors)

- (void)addRevisions:(NSSet*)value_;
- (void)removeRevisions:(NSSet*)value_;
- (void)addRevisionsObject:(ETGRevision*)value_;
- (void)removeRevisionsObject:(ETGRevision*)value_;

@end

@interface _ETGBaselineType (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreatedTime;
- (void)setPrimitiveCreatedTime:(NSDate*)value;




- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSDate*)primitiveReportMonth;
- (void)setPrimitiveReportMonth:(NSDate*)value;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;



- (ETGProjectSummaryForMap*)primitiveProjectSummaryForMap;
- (void)setPrimitiveProjectSummaryForMap:(ETGProjectSummaryForMap*)value;



- (NSMutableSet*)primitiveRevisions;
- (void)setPrimitiveRevisions:(NSMutableSet*)value;



- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
