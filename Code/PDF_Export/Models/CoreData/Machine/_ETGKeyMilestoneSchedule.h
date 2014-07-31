// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyMilestoneSchedule.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGKeyMilestoneScheduleAttributes {
	__unsafe_unretained NSString *actualDate;
	__unsafe_unretained NSString *baselineNum;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *markerValue;
	__unsafe_unretained NSString *milestone;
	__unsafe_unretained NSString *milestoneDesc;
	__unsafe_unretained NSString *milestoneKey;
	__unsafe_unretained NSString *milestoneStatus;
	__unsafe_unretained NSString *outlookNum;
	__unsafe_unretained NSString *plannedDate;
	__unsafe_unretained NSString *projectEndDate;
	__unsafe_unretained NSString *projectStartDate;
	__unsafe_unretained NSString *reportingPeriod;
	__unsafe_unretained NSString *rowNum;
} ETGKeyMilestoneScheduleAttributes;

extern const struct ETGKeyMilestoneScheduleRelationships {
	__unsafe_unretained NSString *scheduleScorecard;
} ETGKeyMilestoneScheduleRelationships;

extern const struct ETGKeyMilestoneScheduleFetchedProperties {
} ETGKeyMilestoneScheduleFetchedProperties;

@class ;
















@interface ETGKeyMilestoneScheduleID : NSManagedObjectID {}
@end

@interface _ETGKeyMilestoneSchedule : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGKeyMilestoneScheduleID*)objectID;





@property (nonatomic, strong) NSString* actualDate;



//- (BOOL)validateActualDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* baselineNum;



@property int32_t baselineNumValue;
- (int32_t)baselineNumValue;
- (void)setBaselineNumValue:(int32_t)value_;

//- (BOOL)validateBaselineNum:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* indicator;



//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* markerValue;



@property int32_t markerValueValue;
- (int32_t)markerValueValue;
- (void)setMarkerValueValue:(int32_t)value_;

//- (BOOL)validateMarkerValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* milestone;



//- (BOOL)validateMilestone:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* milestoneDesc;



//- (BOOL)validateMilestoneDesc:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* milestoneKey;



@property int32_t milestoneKeyValue;
- (int32_t)milestoneKeyValue;
- (void)setMilestoneKeyValue:(int32_t)value_;

//- (BOOL)validateMilestoneKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* milestoneStatus;



@property int32_t milestoneStatusValue;
- (int32_t)milestoneStatusValue;
- (void)setMilestoneStatusValue:(int32_t)value_;

//- (BOOL)validateMilestoneStatus:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* outlookNum;



@property int32_t outlookNumValue;
- (int32_t)outlookNumValue;
- (void)setOutlookNumValue:(int32_t)value_;

//- (BOOL)validateOutlookNum:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* plannedDate;



//- (BOOL)validatePlannedDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* projectEndDate;



//- (BOOL)validateProjectEndDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* projectStartDate;



//- (BOOL)validateProjectStartDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* reportingPeriod;



//- (BOOL)validateReportingPeriod:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* rowNum;



@property int32_t rowNumValue;
- (int32_t)rowNumValue;
- (void)setRowNumValue:(int32_t)value_;

//- (BOOL)validateRowNum:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong)  *scheduleScorecard;

//- (BOOL)validateScheduleScorecard:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGKeyMilestoneSchedule (CoreDataGeneratedAccessors)

@end

@interface _ETGKeyMilestoneSchedule (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveActualDate;
- (void)setPrimitiveActualDate:(NSString*)value;




- (NSNumber*)primitiveBaselineNum;
- (void)setPrimitiveBaselineNum:(NSNumber*)value;

- (int32_t)primitiveBaselineNumValue;
- (void)setPrimitiveBaselineNumValue:(int32_t)value_;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSNumber*)primitiveMarkerValue;
- (void)setPrimitiveMarkerValue:(NSNumber*)value;

- (int32_t)primitiveMarkerValueValue;
- (void)setPrimitiveMarkerValueValue:(int32_t)value_;




- (NSString*)primitiveMilestone;
- (void)setPrimitiveMilestone:(NSString*)value;




- (NSString*)primitiveMilestoneDesc;
- (void)setPrimitiveMilestoneDesc:(NSString*)value;




- (NSNumber*)primitiveMilestoneKey;
- (void)setPrimitiveMilestoneKey:(NSNumber*)value;

- (int32_t)primitiveMilestoneKeyValue;
- (void)setPrimitiveMilestoneKeyValue:(int32_t)value_;




- (NSNumber*)primitiveMilestoneStatus;
- (void)setPrimitiveMilestoneStatus:(NSNumber*)value;

- (int32_t)primitiveMilestoneStatusValue;
- (void)setPrimitiveMilestoneStatusValue:(int32_t)value_;




- (NSNumber*)primitiveOutlookNum;
- (void)setPrimitiveOutlookNum:(NSNumber*)value;

- (int32_t)primitiveOutlookNumValue;
- (void)setPrimitiveOutlookNumValue:(int32_t)value_;




- (NSString*)primitivePlannedDate;
- (void)setPrimitivePlannedDate:(NSString*)value;




- (NSString*)primitiveProjectEndDate;
- (void)setPrimitiveProjectEndDate:(NSString*)value;




- (NSString*)primitiveProjectStartDate;
- (void)setPrimitiveProjectStartDate:(NSString*)value;




- (NSString*)primitiveReportingPeriod;
- (void)setPrimitiveReportingPeriod:(NSString*)value;




- (NSNumber*)primitiveRowNum;
- (void)setPrimitiveRowNum:(NSNumber*)value;

- (int32_t)primitiveRowNumValue;
- (void)setPrimitiveRowNumValue:(int32_t)value_;





- (*)primitiveScheduleScorecard;
- (void)setPrimitiveScheduleScorecard:(*)value;


@end
