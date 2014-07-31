// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMLPortfolio.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMLPortfolioAttributes {
	__unsafe_unretained NSString *calendarMonthOfYear;
	__unsafe_unretained NSString *calendarYear;
	__unsafe_unretained NSString *calendarYearEnglishMonth;
	__unsafe_unretained NSString *fTELoading;
	__unsafe_unretained NSString *projectStaffingStatusName;
	__unsafe_unretained NSString *reportingtimekey;
} ETGMLPortfolioAttributes;

extern const struct ETGMLPortfolioRelationships {
	__unsafe_unretained NSString *portfolio;
} ETGMLPortfolioRelationships;

extern const struct ETGMLPortfolioFetchedProperties {
} ETGMLPortfolioFetchedProperties;

@class ETGPortfolio;








@interface ETGMLPortfolioID : NSManagedObjectID {}
@end

@interface _ETGMLPortfolio : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMLPortfolioID*)objectID;




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




@property (nonatomic, strong) NSNumber* reportingtimekey;


@property int32_t reportingtimekeyValue;
- (int32_t)reportingtimekeyValue;
- (void)setReportingtimekeyValue:(int32_t)value_;

//- (BOOL)validateReportingtimekey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGPortfolio* portfolio;

//- (BOOL)validatePortfolio:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGMLPortfolio (CoreDataGeneratedAccessors)

@end

@interface _ETGMLPortfolio (CoreDataGeneratedPrimitiveAccessors)


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




- (NSNumber*)primitiveReportingtimekey;
- (void)setPrimitiveReportingtimekey:(NSNumber*)value;

- (int32_t)primitiveReportingtimekeyValue;
- (void)setPrimitiveReportingtimekeyValue:(int32_t)value_;





- (ETGPortfolio*)primitivePortfolio;
- (void)setPrimitivePortfolio:(ETGPortfolio*)value;


@end
