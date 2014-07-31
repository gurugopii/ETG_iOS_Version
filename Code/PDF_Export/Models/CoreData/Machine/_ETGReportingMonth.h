// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGReportingMonth.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGReportingMonthAttributes {
	__unsafe_unretained NSString *key;
	__unsafe_unretained NSString *name;
} ETGReportingMonthAttributes;

extern const struct ETGReportingMonthRelationships {
	__unsafe_unretained NSString *abrs;
	__unsafe_unretained NSString *ahcs;
	__unsafe_unretained NSString *cpbs;
	__unsafe_unretained NSString *keyHighlights;
	__unsafe_unretained NSString *maps;
	__unsafe_unretained NSString *plrs;
	__unsafe_unretained NSString *pnechcrs;
	__unsafe_unretained NSString *portfolios;
	__unsafe_unretained NSString *projectSummarys;
	__unsafe_unretained NSString *projectSummarysForMap;
	__unsafe_unretained NSString *projects;
	__unsafe_unretained NSString *scorecards;
	__unsafe_unretained NSString *timeStamps;
} ETGReportingMonthRelationships;

extern const struct ETGReportingMonthFetchedProperties {
} ETGReportingMonthFetchedProperties;

@class ETGEccrAbr;
@class ETGMpAhc;
@class ETGEccrCpb;
@class ETGKeyHighlight;
@class ETGMap;
@class ETGMpPlr;
@class ETGMpPnechcr;
@class ETGPortfolio;
@class ETGProjectSummary;
@class ETGProjectSummaryForMap;
@class ETGProject;
@class ETGScorecard;
@class ETGTimestamp;




@interface ETGReportingMonthID : NSManagedObjectID {}
@end

@interface _ETGReportingMonth : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGReportingMonthID*)objectID;




@property (nonatomic, strong) NSNumber* key;


@property int32_t keyValue;
- (int32_t)keyValue;
- (void)setKeyValue:(int32_t)value_;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* abrs;

- (NSMutableSet*)abrsSet;




@property (nonatomic, strong) NSSet* ahcs;

- (NSMutableSet*)ahcsSet;




@property (nonatomic, strong) NSSet* cpbs;

- (NSMutableSet*)cpbsSet;




@property (nonatomic, strong) NSSet* keyHighlights;

- (NSMutableSet*)keyHighlightsSet;




@property (nonatomic, strong) NSSet* maps;

- (NSMutableSet*)mapsSet;




@property (nonatomic, strong) NSSet* plrs;

- (NSMutableSet*)plrsSet;




@property (nonatomic, strong) NSSet* pnechcrs;

- (NSMutableSet*)pnechcrsSet;




@property (nonatomic, strong) NSSet* portfolios;

- (NSMutableSet*)portfoliosSet;




@property (nonatomic, strong) NSSet* projectSummarys;

- (NSMutableSet*)projectSummarysSet;




@property (nonatomic, strong) ETGProjectSummaryForMap* projectSummarysForMap;

//- (BOOL)validateProjectSummarysForMap:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* projects;

- (NSMutableSet*)projectsSet;




@property (nonatomic, strong) NSSet* scorecards;

- (NSMutableSet*)scorecardsSet;




@property (nonatomic, strong) NSSet* timeStamps;

- (NSMutableSet*)timeStampsSet;





@end

@interface _ETGReportingMonth (CoreDataGeneratedAccessors)

- (void)addAbrs:(NSSet*)value_;
- (void)removeAbrs:(NSSet*)value_;
- (void)addAbrsObject:(ETGEccrAbr*)value_;
- (void)removeAbrsObject:(ETGEccrAbr*)value_;

- (void)addAhcs:(NSSet*)value_;
- (void)removeAhcs:(NSSet*)value_;
- (void)addAhcsObject:(ETGMpAhc*)value_;
- (void)removeAhcsObject:(ETGMpAhc*)value_;

- (void)addCpbs:(NSSet*)value_;
- (void)removeCpbs:(NSSet*)value_;
- (void)addCpbsObject:(ETGEccrCpb*)value_;
- (void)removeCpbsObject:(ETGEccrCpb*)value_;

- (void)addKeyHighlights:(NSSet*)value_;
- (void)removeKeyHighlights:(NSSet*)value_;
- (void)addKeyHighlightsObject:(ETGKeyHighlight*)value_;
- (void)removeKeyHighlightsObject:(ETGKeyHighlight*)value_;

- (void)addMaps:(NSSet*)value_;
- (void)removeMaps:(NSSet*)value_;
- (void)addMapsObject:(ETGMap*)value_;
- (void)removeMapsObject:(ETGMap*)value_;

- (void)addPlrs:(NSSet*)value_;
- (void)removePlrs:(NSSet*)value_;
- (void)addPlrsObject:(ETGMpPlr*)value_;
- (void)removePlrsObject:(ETGMpPlr*)value_;

- (void)addPnechcrs:(NSSet*)value_;
- (void)removePnechcrs:(NSSet*)value_;
- (void)addPnechcrsObject:(ETGMpPnechcr*)value_;
- (void)removePnechcrsObject:(ETGMpPnechcr*)value_;

- (void)addPortfolios:(NSSet*)value_;
- (void)removePortfolios:(NSSet*)value_;
- (void)addPortfoliosObject:(ETGPortfolio*)value_;
- (void)removePortfoliosObject:(ETGPortfolio*)value_;

- (void)addProjectSummarys:(NSSet*)value_;
- (void)removeProjectSummarys:(NSSet*)value_;
- (void)addProjectSummarysObject:(ETGProjectSummary*)value_;
- (void)removeProjectSummarysObject:(ETGProjectSummary*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(ETGProject*)value_;
- (void)removeProjectsObject:(ETGProject*)value_;

- (void)addScorecards:(NSSet*)value_;
- (void)removeScorecards:(NSSet*)value_;
- (void)addScorecardsObject:(ETGScorecard*)value_;
- (void)removeScorecardsObject:(ETGScorecard*)value_;

- (void)addTimeStamps:(NSSet*)value_;
- (void)removeTimeStamps:(NSSet*)value_;
- (void)addTimeStampsObject:(ETGTimestamp*)value_;
- (void)removeTimeStampsObject:(ETGTimestamp*)value_;

@end

@interface _ETGReportingMonth (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveKey;
- (void)setPrimitiveKey:(NSNumber*)value;

- (int32_t)primitiveKeyValue;
- (void)setPrimitiveKeyValue:(int32_t)value_;




- (NSDate*)primitiveName;
- (void)setPrimitiveName:(NSDate*)value;





- (NSMutableSet*)primitiveAbrs;
- (void)setPrimitiveAbrs:(NSMutableSet*)value;



- (NSMutableSet*)primitiveAhcs;
- (void)setPrimitiveAhcs:(NSMutableSet*)value;



- (NSMutableSet*)primitiveCpbs;
- (void)setPrimitiveCpbs:(NSMutableSet*)value;



- (NSMutableSet*)primitiveKeyHighlights;
- (void)setPrimitiveKeyHighlights:(NSMutableSet*)value;



- (NSMutableSet*)primitiveMaps;
- (void)setPrimitiveMaps:(NSMutableSet*)value;



- (NSMutableSet*)primitivePlrs;
- (void)setPrimitivePlrs:(NSMutableSet*)value;



- (NSMutableSet*)primitivePnechcrs;
- (void)setPrimitivePnechcrs:(NSMutableSet*)value;



- (NSMutableSet*)primitivePortfolios;
- (void)setPrimitivePortfolios:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjectSummarys;
- (void)setPrimitiveProjectSummarys:(NSMutableSet*)value;



- (ETGProjectSummaryForMap*)primitiveProjectSummarysForMap;
- (void)setPrimitiveProjectSummarysForMap:(ETGProjectSummaryForMap*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveScorecards;
- (void)setPrimitiveScorecards:(NSMutableSet*)value;



- (NSMutableSet*)primitiveTimeStamps;
- (void)setPrimitiveTimeStamps:(NSMutableSet*)value;


@end
