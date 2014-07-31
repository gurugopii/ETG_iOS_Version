// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProject.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGProjectAttributes {
	__unsafe_unretained NSString *endDate;
	__unsafe_unretained NSString *isUsedByMap;
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *startDate;
} ETGProjectAttributes;

extern const struct ETGProjectRelationships {
	__unsafe_unretained NSString *budgetHolders;
	__unsafe_unretained NSString *cluster;
	__unsafe_unretained NSString *complexities;
	__unsafe_unretained NSString *costCategory;
	__unsafe_unretained NSString *keyHighlights;
	__unsafe_unretained NSString *maps;
	__unsafe_unretained NSString *natures;
	__unsafe_unretained NSString *operatorship;
	__unsafe_unretained NSString *phase;
	__unsafe_unretained NSString *portfolios;
	__unsafe_unretained NSString *projectBackground;
	__unsafe_unretained NSString *projectStatus;
	__unsafe_unretained NSString *projects;
	__unsafe_unretained NSString *projectsForMap;
	__unsafe_unretained NSString *region;
	__unsafe_unretained NSString *reportingMonths;
	__unsafe_unretained NSString *scorecards;
	__unsafe_unretained NSString *types;
} ETGProjectRelationships;

extern const struct ETGProjectFetchedProperties {
} ETGProjectFetchedProperties;

@class ETGCostAllocation;
@class ETGCluster;
@class ETGProjetComplexities;
@class ETGCostCategory;
@class ETGKeyHighlight;
@class ETGMap;
@class ETGProjectNatures;
@class ETGOperatorship;
@class ETGPhase;
@class ETGPortfolio;
@class ETGProjectBackground;
@class ETGProjectStatus;
@class ETGProjectSummary;
@class ETGProjectSummaryForMap;
@class ETGRegion;
@class ETGReportingMonth;
@class ETGScorecard;
@class ETGProjectTypes;







@interface ETGProjectID : NSManagedObjectID {}
@end

@interface _ETGProject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGProjectID*)objectID;




@property (nonatomic, strong) NSNumber* endDate;


@property int32_t endDateValue;
- (int32_t)endDateValue;
- (void)setEndDateValue:(int32_t)value_;

//- (BOOL)validateEndDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* isUsedByMap;


@property BOOL isUsedByMapValue;
- (BOOL)isUsedByMapValue;
- (void)setIsUsedByMapValue:(BOOL)value_;

//- (BOOL)validateIsUsedByMap:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* startDate;


@property int32_t startDateValue;
- (int32_t)startDateValue;
- (void)setStartDateValue:(int32_t)value_;

//- (BOOL)validateStartDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* budgetHolders;

- (NSMutableSet*)budgetHoldersSet;




@property (nonatomic, strong) ETGCluster* cluster;

//- (BOOL)validateCluster:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGProjetComplexities* complexities;

//- (BOOL)validateComplexities:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGCostCategory* costCategory;

//- (BOOL)validateCostCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* keyHighlights;

- (NSMutableSet*)keyHighlightsSet;




@property (nonatomic, strong) NSSet* maps;

- (NSMutableSet*)mapsSet;




@property (nonatomic, strong) ETGProjectNatures* natures;

//- (BOOL)validateNatures:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGOperatorship* operatorship;

//- (BOOL)validateOperatorship:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGPhase* phase;

//- (BOOL)validatePhase:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* portfolios;

- (NSMutableSet*)portfoliosSet;




@property (nonatomic, strong) ETGProjectBackground* projectBackground;

//- (BOOL)validateProjectBackground:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGProjectStatus* projectStatus;

//- (BOOL)validateProjectStatus:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* projects;

- (NSMutableSet*)projectsSet;




@property (nonatomic, strong) ETGProjectSummaryForMap* projectsForMap;

//- (BOOL)validateProjectsForMap:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGRegion* region;

//- (BOOL)validateRegion:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* reportingMonths;

- (NSMutableSet*)reportingMonthsSet;




@property (nonatomic, strong) NSSet* scorecards;

- (NSMutableSet*)scorecardsSet;




@property (nonatomic, strong) ETGProjectTypes* types;

//- (BOOL)validateTypes:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGProject (CoreDataGeneratedAccessors)

- (void)addBudgetHolders:(NSSet*)value_;
- (void)removeBudgetHolders:(NSSet*)value_;
- (void)addBudgetHoldersObject:(ETGCostAllocation*)value_;
- (void)removeBudgetHoldersObject:(ETGCostAllocation*)value_;

- (void)addKeyHighlights:(NSSet*)value_;
- (void)removeKeyHighlights:(NSSet*)value_;
- (void)addKeyHighlightsObject:(ETGKeyHighlight*)value_;
- (void)removeKeyHighlightsObject:(ETGKeyHighlight*)value_;

- (void)addMaps:(NSSet*)value_;
- (void)removeMaps:(NSSet*)value_;
- (void)addMapsObject:(ETGMap*)value_;
- (void)removeMapsObject:(ETGMap*)value_;

- (void)addPortfolios:(NSSet*)value_;
- (void)removePortfolios:(NSSet*)value_;
- (void)addPortfoliosObject:(ETGPortfolio*)value_;
- (void)removePortfoliosObject:(ETGPortfolio*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(ETGProjectSummary*)value_;
- (void)removeProjectsObject:(ETGProjectSummary*)value_;

- (void)addReportingMonths:(NSSet*)value_;
- (void)removeReportingMonths:(NSSet*)value_;
- (void)addReportingMonthsObject:(ETGReportingMonth*)value_;
- (void)removeReportingMonthsObject:(ETGReportingMonth*)value_;

- (void)addScorecards:(NSSet*)value_;
- (void)removeScorecards:(NSSet*)value_;
- (void)addScorecardsObject:(ETGScorecard*)value_;
- (void)removeScorecardsObject:(ETGScorecard*)value_;

@end

@interface _ETGProject (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveEndDate;
- (void)setPrimitiveEndDate:(NSNumber*)value;

- (int32_t)primitiveEndDateValue;
- (void)setPrimitiveEndDateValue:(int32_t)value_;




- (NSNumber*)primitiveIsUsedByMap;
- (void)setPrimitiveIsUsedByMap:(NSNumber*)value;

- (BOOL)primitiveIsUsedByMapValue;
- (void)setPrimitiveIsUsedByMapValue:(BOOL)value_;




- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveStartDate;
- (void)setPrimitiveStartDate:(NSNumber*)value;

- (int32_t)primitiveStartDateValue;
- (void)setPrimitiveStartDateValue:(int32_t)value_;





- (NSMutableSet*)primitiveBudgetHolders;
- (void)setPrimitiveBudgetHolders:(NSMutableSet*)value;



- (ETGCluster*)primitiveCluster;
- (void)setPrimitiveCluster:(ETGCluster*)value;



- (ETGProjetComplexities*)primitiveComplexities;
- (void)setPrimitiveComplexities:(ETGProjetComplexities*)value;



- (ETGCostCategory*)primitiveCostCategory;
- (void)setPrimitiveCostCategory:(ETGCostCategory*)value;



- (NSMutableSet*)primitiveKeyHighlights;
- (void)setPrimitiveKeyHighlights:(NSMutableSet*)value;



- (NSMutableSet*)primitiveMaps;
- (void)setPrimitiveMaps:(NSMutableSet*)value;



- (ETGProjectNatures*)primitiveNatures;
- (void)setPrimitiveNatures:(ETGProjectNatures*)value;



- (ETGOperatorship*)primitiveOperatorship;
- (void)setPrimitiveOperatorship:(ETGOperatorship*)value;



- (ETGPhase*)primitivePhase;
- (void)setPrimitivePhase:(ETGPhase*)value;



- (NSMutableSet*)primitivePortfolios;
- (void)setPrimitivePortfolios:(NSMutableSet*)value;



- (ETGProjectBackground*)primitiveProjectBackground;
- (void)setPrimitiveProjectBackground:(ETGProjectBackground*)value;



- (ETGProjectStatus*)primitiveProjectStatus;
- (void)setPrimitiveProjectStatus:(ETGProjectStatus*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;



- (ETGProjectSummaryForMap*)primitiveProjectsForMap;
- (void)setPrimitiveProjectsForMap:(ETGProjectSummaryForMap*)value;



- (ETGRegion*)primitiveRegion;
- (void)setPrimitiveRegion:(ETGRegion*)value;



- (NSMutableSet*)primitiveReportingMonths;
- (void)setPrimitiveReportingMonths:(NSMutableSet*)value;



- (NSMutableSet*)primitiveScorecards;
- (void)setPrimitiveScorecards:(NSMutableSet*)value;



- (ETGProjectTypes*)primitiveTypes;
- (void)setPrimitiveTypes:(ETGProjectTypes*)value;


@end
