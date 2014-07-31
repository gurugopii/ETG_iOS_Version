// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyHighlight.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGKeyHighlightAttributes {
	__unsafe_unretained NSString *overallPpa;
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *reportMonth;
} ETGKeyHighlightAttributes;

extern const struct ETGKeyHighlightRelationships {
	__unsafe_unretained NSString *issuesAndConcerns;
	__unsafe_unretained NSString *keyhighlightsProgress;
	__unsafe_unretained NSString *monthlyKeyHighlights;
	__unsafe_unretained NSString *plannedActivitiesforNextMonth;
	__unsafe_unretained NSString *ppa;
	__unsafe_unretained NSString *project;
	__unsafe_unretained NSString *reportingMonth;
} ETGKeyHighlightRelationships;

extern const struct ETGKeyHighlightFetchedProperties {
} ETGKeyHighlightFetchedProperties;

@class ETGIssuesKeyHighlight;
@class ETGKeyHighlightProgressOverall;
@class ETGMonthlyKeyHighlight;
@class ETGPlannedKeyHighlight;
@class ETGPpaKeyHighlight;
@class ETGProject;
@class ETGReportingMonth;





@interface ETGKeyHighlightID : NSManagedObjectID {}
@end

@interface _ETGKeyHighlight : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGKeyHighlightID*)objectID;




@property (nonatomic, strong) NSString* overallPpa;


//- (BOOL)validateOverallPpa:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* reportMonth;


//- (BOOL)validateReportMonth:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* issuesAndConcerns;

- (NSMutableSet*)issuesAndConcernsSet;




@property (nonatomic, strong) NSSet* keyhighlightsProgress;

- (NSMutableSet*)keyhighlightsProgressSet;




@property (nonatomic, strong) NSSet* monthlyKeyHighlights;

- (NSMutableSet*)monthlyKeyHighlightsSet;




@property (nonatomic, strong) NSSet* plannedActivitiesforNextMonth;

- (NSMutableSet*)plannedActivitiesforNextMonthSet;




@property (nonatomic, strong) NSSet* ppa;

- (NSMutableSet*)ppaSet;




@property (nonatomic, strong) ETGProject* project;

//- (BOOL)validateProject:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGKeyHighlight (CoreDataGeneratedAccessors)

- (void)addIssuesAndConcerns:(NSSet*)value_;
- (void)removeIssuesAndConcerns:(NSSet*)value_;
- (void)addIssuesAndConcernsObject:(ETGIssuesKeyHighlight*)value_;
- (void)removeIssuesAndConcernsObject:(ETGIssuesKeyHighlight*)value_;

- (void)addKeyhighlightsProgress:(NSSet*)value_;
- (void)removeKeyhighlightsProgress:(NSSet*)value_;
- (void)addKeyhighlightsProgressObject:(ETGKeyHighlightProgressOverall*)value_;
- (void)removeKeyhighlightsProgressObject:(ETGKeyHighlightProgressOverall*)value_;

- (void)addMonthlyKeyHighlights:(NSSet*)value_;
- (void)removeMonthlyKeyHighlights:(NSSet*)value_;
- (void)addMonthlyKeyHighlightsObject:(ETGMonthlyKeyHighlight*)value_;
- (void)removeMonthlyKeyHighlightsObject:(ETGMonthlyKeyHighlight*)value_;

- (void)addPlannedActivitiesforNextMonth:(NSSet*)value_;
- (void)removePlannedActivitiesforNextMonth:(NSSet*)value_;
- (void)addPlannedActivitiesforNextMonthObject:(ETGPlannedKeyHighlight*)value_;
- (void)removePlannedActivitiesforNextMonthObject:(ETGPlannedKeyHighlight*)value_;

- (void)addPpa:(NSSet*)value_;
- (void)removePpa:(NSSet*)value_;
- (void)addPpaObject:(ETGPpaKeyHighlight*)value_;
- (void)removePpaObject:(ETGPpaKeyHighlight*)value_;

@end

@interface _ETGKeyHighlight (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveOverallPpa;
- (void)setPrimitiveOverallPpa:(NSString*)value;




- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSDate*)primitiveReportMonth;
- (void)setPrimitiveReportMonth:(NSDate*)value;





- (NSMutableSet*)primitiveIssuesAndConcerns;
- (void)setPrimitiveIssuesAndConcerns:(NSMutableSet*)value;



- (NSMutableSet*)primitiveKeyhighlightsProgress;
- (void)setPrimitiveKeyhighlightsProgress:(NSMutableSet*)value;



- (NSMutableSet*)primitiveMonthlyKeyHighlights;
- (void)setPrimitiveMonthlyKeyHighlights:(NSMutableSet*)value;



- (NSMutableSet*)primitivePlannedActivitiesforNextMonth;
- (void)setPrimitivePlannedActivitiesforNextMonth:(NSMutableSet*)value;



- (NSMutableSet*)primitivePpa;
- (void)setPrimitivePpa:(NSMutableSet*)value;



- (ETGProject*)primitiveProject;
- (void)setPrimitiveProject:(ETGProject*)value;



- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;


@end
