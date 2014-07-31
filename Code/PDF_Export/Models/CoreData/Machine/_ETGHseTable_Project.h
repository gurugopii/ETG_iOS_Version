// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGHseTable_Project.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGHseTable_ProjectAttributes {
	__unsafe_unretained NSString *hseDescription;
	__unsafe_unretained NSString *hseId;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *kpi;
	__unsafe_unretained NSString *ytdCase;
	__unsafe_unretained NSString *ytdFrequency;
} ETGHseTable_ProjectAttributes;

extern const struct ETGHseTable_ProjectRelationships {
	__unsafe_unretained NSString *projectSummary;
	__unsafe_unretained NSString *scorecard;
} ETGHseTable_ProjectRelationships;

extern const struct ETGHseTable_ProjectFetchedProperties {
} ETGHseTable_ProjectFetchedProperties;

@class ETGProjectSummary;
@class ETGScorecard;








@interface ETGHseTable_ProjectID : NSManagedObjectID {}
@end

@interface _ETGHseTable_Project : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGHseTable_ProjectID*)objectID;




@property (nonatomic, strong) NSString* hseDescription;


//- (BOOL)validateHseDescription:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* hseId;


//- (BOOL)validateHseId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* kpi;


@property int32_t kpiValue;
- (int32_t)kpiValue;
- (void)setKpiValue:(int32_t)value_;

//- (BOOL)validateKpi:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* ytdCase;


@property int32_t ytdCaseValue;
- (int32_t)ytdCaseValue;
- (void)setYtdCaseValue:(int32_t)value_;

//- (BOOL)validateYtdCase:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* ytdFrequency;


//- (BOOL)validateYtdFrequency:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGHseTable_Project (CoreDataGeneratedAccessors)

@end

@interface _ETGHseTable_Project (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveHseDescription;
- (void)setPrimitiveHseDescription:(NSString*)value;




- (NSString*)primitiveHseId;
- (void)setPrimitiveHseId:(NSString*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSNumber*)primitiveKpi;
- (void)setPrimitiveKpi:(NSNumber*)value;

- (int32_t)primitiveKpiValue;
- (void)setPrimitiveKpiValue:(int32_t)value_;




- (NSNumber*)primitiveYtdCase;
- (void)setPrimitiveYtdCase:(NSNumber*)value;

- (int32_t)primitiveYtdCaseValue;
- (void)setPrimitiveYtdCaseValue:(int32_t)value_;




- (NSDecimalNumber*)primitiveYtdFrequency;
- (void)setPrimitiveYtdFrequency:(NSDecimalNumber*)value;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;



- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
