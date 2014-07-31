// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMLProject.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMLProjectAttributes {
	__unsafe_unretained NSString *calendarMonthOfYear;
	__unsafe_unretained NSString *calendarYear;
	__unsafe_unretained NSString *calendarYearEnglishMonth;
	__unsafe_unretained NSString *fTELoading;
	__unsafe_unretained NSString *projectStaffingStatusName;
	__unsafe_unretained NSString *reportingTimeKey;
} ETGMLProjectAttributes;

extern const struct ETGMLProjectRelationships {
	__unsafe_unretained NSString *projectSummary;
} ETGMLProjectRelationships;

extern const struct ETGMLProjectFetchedProperties {
} ETGMLProjectFetchedProperties;

@class ETGProjectSummary;








@interface ETGMLProjectID : NSManagedObjectID {}
@end

@interface _ETGMLProject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMLProjectID*)objectID;




@property (nonatomic, strong) NSNumber* calendarMonthOfYear;


@property int32_t calendarMonthOfYearValue;
- (int32_t)calendarMonthOfYearValue;
- (void)setCalendarMonthOfYearValue:(int32_t)value_;

//- (BOOL)validateCalendarMonthOfYear:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* calendarYear;


@property int32_t calendarYearValue;
- (int32_t)calendarYearValue;
- (void)setCalendarYearValue:(int32_t)value_;

//- (BOOL)validateCalendarYear:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* calendarYearEnglishMonth;


//- (BOOL)validateCalendarYearEnglishMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* fTELoading;


//- (BOOL)validateFTELoading:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectStaffingStatusName;


//- (BOOL)validateProjectStaffingStatusName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* reportingTimeKey;


@property int32_t reportingTimeKeyValue;
- (int32_t)reportingTimeKeyValue;
- (void)setReportingTimeKeyValue:(int32_t)value_;

//- (BOOL)validateReportingTimeKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProjectSummary* projectSummary;

//- (BOOL)validateProjectSummary:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGMLProject (CoreDataGeneratedAccessors)

@end

@interface _ETGMLProject (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCalendarMonthOfYear;
- (void)setPrimitiveCalendarMonthOfYear:(NSNumber*)value;

- (int32_t)primitiveCalendarMonthOfYearValue;
- (void)setPrimitiveCalendarMonthOfYearValue:(int32_t)value_;




- (NSNumber*)primitiveCalendarYear;
- (void)setPrimitiveCalendarYear:(NSNumber*)value;

- (int32_t)primitiveCalendarYearValue;
- (void)setPrimitiveCalendarYearValue:(int32_t)value_;




- (NSString*)primitiveCalendarYearEnglishMonth;
- (void)setPrimitiveCalendarYearEnglishMonth:(NSString*)value;




- (NSDecimalNumber*)primitiveFTELoading;
- (void)setPrimitiveFTELoading:(NSDecimalNumber*)value;




- (NSString*)primitiveProjectStaffingStatusName;
- (void)setPrimitiveProjectStaffingStatusName:(NSString*)value;




- (NSNumber*)primitiveReportingTimeKey;
- (void)setPrimitiveReportingTimeKey:(NSNumber*)value;

- (int32_t)primitiveReportingTimeKeyValue;
- (void)setPrimitiveReportingTimeKeyValue:(int32_t)value_;





- (ETGProjectSummary*)primitiveProjectSummary;
- (void)setPrimitiveProjectSummary:(ETGProjectSummary*)value;


@end
