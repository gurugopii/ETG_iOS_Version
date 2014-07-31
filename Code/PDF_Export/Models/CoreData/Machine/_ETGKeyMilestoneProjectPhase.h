// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyMilestoneProjectPhase.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGKeyMilestoneProjectPhaseAttributes {
	__unsafe_unretained NSString *projectPhase;
	__unsafe_unretained NSString *projectPhaseKey;
} ETGKeyMilestoneProjectPhaseAttributes;

extern const struct ETGKeyMilestoneProjectPhaseRelationships {
	__unsafe_unretained NSString *projectSummary;
	__unsafe_unretained NSString *projectSummaryForMap;
	__unsafe_unretained NSString *scorecard;
} ETGKeyMilestoneProjectPhaseRelationships;

extern const struct ETGKeyMilestoneProjectPhaseFetchedProperties {
} ETGKeyMilestoneProjectPhaseFetchedProperties;

@class ETGProjectSummary;
@class ETGProjectSummaryForMap;
@class ETGScorecard;




@interface ETGKeyMilestoneProjectPhaseID : NSManagedObjectID {}
@end

@interface _ETGKeyMilestoneProjectPhase : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGKeyMilestoneProjectPhaseID*)objectID;




@property (nonatomic, strong) NSString* projectPhase;


//- (BOOL)validateProjectPhase:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectPhaseKey;


@property int32_t projectPhaseKeyValue;
- (int32_t)projectPhaseKeyValue;
- (void)setProjectPhaseKeyValue:(int32_t)value_;

//- (BOOL)validateProjectPhaseKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* projectSummary;

- (NSMutableSet*)projectSummarySet;




@property (nonatomic, strong) NSSet* projectSummaryForMap;

- (NSMutableSet*)projectSummaryForMapSet;




@property (nonatomic, strong) NSSet* scorecard;

- (NSMutableSet*)scorecardSet;





@end

@interface _ETGKeyMilestoneProjectPhase (CoreDataGeneratedAccessors)

- (void)addProjectSummary:(NSSet*)value_;
- (void)removeProjectSummary:(NSSet*)value_;
- (void)addProjectSummaryObject:(ETGProjectSummary*)value_;
- (void)removeProjectSummaryObject:(ETGProjectSummary*)value_;

- (void)addProjectSummaryForMap:(NSSet*)value_;
- (void)removeProjectSummaryForMap:(NSSet*)value_;
- (void)addProjectSummaryForMapObject:(ETGProjectSummaryForMap*)value_;
- (void)removeProjectSummaryForMapObject:(ETGProjectSummaryForMap*)value_;

- (void)addScorecard:(NSSet*)value_;
- (void)removeScorecard:(NSSet*)value_;
- (void)addScorecardObject:(ETGScorecard*)value_;
- (void)removeScorecardObject:(ETGScorecard*)value_;

@end

@interface _ETGKeyMilestoneProjectPhase (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveProjectPhase;
- (void)setPrimitiveProjectPhase:(NSString*)value;




- (NSNumber*)primitiveProjectPhaseKey;
- (void)setPrimitiveProjectPhaseKey:(NSNumber*)value;

- (int32_t)primitiveProjectPhaseKeyValue;
- (void)setPrimitiveProjectPhaseKeyValue:(int32_t)value_;





- (NSMutableSet*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjectSummaryForMap;
- (void)setPrimitiveProjectSummaryForMap:(NSMutableSet*)value;



- (NSMutableSet*)primitiveScorecard;
- (void)setPrimitiveScorecard:(NSMutableSet*)value;


@end
