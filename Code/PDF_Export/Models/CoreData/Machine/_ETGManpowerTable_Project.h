// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGManpowerTable_Project.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGManpowerTable_ProjectAttributes {
	__unsafe_unretained NSString *indicatorTotalCriticalBar;
	__unsafe_unretained NSString *indicatorTotalRequirementBar;
	__unsafe_unretained NSString *totalCritical;
	__unsafe_unretained NSString *totalRequirement;
} ETGManpowerTable_ProjectAttributes;

extern const struct ETGManpowerTable_ProjectRelationships {
	__unsafe_unretained NSString *projectSummary;
	__unsafe_unretained NSString *scorecard;
} ETGManpowerTable_ProjectRelationships;

extern const struct ETGManpowerTable_ProjectFetchedProperties {
} ETGManpowerTable_ProjectFetchedProperties;

@class ETGProjectSummary;
@class ETGScorecard;






@interface ETGManpowerTable_ProjectID : NSManagedObjectID {}
@end

@interface _ETGManpowerTable_Project : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGManpowerTable_ProjectID*)objectID;




@property (nonatomic, strong) NSString* indicatorTotalCriticalBar;


//- (BOOL)validateIndicatorTotalCriticalBar:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicatorTotalRequirementBar;


//- (BOOL)validateIndicatorTotalRequirementBar:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* totalCritical;


@property int32_t totalCriticalValue;
- (int32_t)totalCriticalValue;
- (void)setTotalCriticalValue:(int32_t)value_;

//- (BOOL)validateTotalCritical:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* totalRequirement;


@property int32_t totalRequirementValue;
- (int32_t)totalRequirementValue;
- (void)setTotalRequirementValue:(int32_t)value_;

//- (BOOL)validateTotalRequirement:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGScorecard* scorecard;

//- (BOOL)validateScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGManpowerTable_Project (CoreDataGeneratedAccessors)

@end

@interface _ETGManpowerTable_Project (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveIndicatorTotalCriticalBar;
- (void)setPrimitiveIndicatorTotalCriticalBar:(NSString*)value;




- (NSString*)primitiveIndicatorTotalRequirementBar;
- (void)setPrimitiveIndicatorTotalRequirementBar:(NSString*)value;




- (NSNumber*)primitiveTotalCritical;
- (void)setPrimitiveTotalCritical:(NSNumber*)value;

- (int32_t)primitiveTotalCriticalValue;
- (void)setPrimitiveTotalCriticalValue:(int32_t)value_;




- (NSNumber*)primitiveTotalRequirement;
- (void)setPrimitiveTotalRequirement:(NSNumber*)value;

- (int32_t)primitiveTotalRequirementValue;
- (void)setPrimitiveTotalRequirementValue:(int32_t)value_;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;



- (ETGScorecard*)primitiveScorecard;
- (void)setPrimitiveScorecard:(ETGScorecard*)value;


@end
