// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMpPlr.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMpPlrAttributes {
	__unsafe_unretained NSString *departmentKey;
	__unsafe_unretained NSString *departmentName;
	__unsafe_unretained NSString *divisionKey;
	__unsafe_unretained NSString *divisionName;
	__unsafe_unretained NSString *filledFTELoading;
	__unsafe_unretained NSString *pneClusterKey;
	__unsafe_unretained NSString *projectJobTitleKey;
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *projectName;
	__unsafe_unretained NSString *regionKey;
	__unsafe_unretained NSString *sectionKey;
	__unsafe_unretained NSString *sectionName;
	__unsafe_unretained NSString *timeKey;
	__unsafe_unretained NSString *vacantFTELoading;
	__unsafe_unretained NSString *year;
} ETGMpPlrAttributes;

extern const struct ETGMpPlrRelationships {
	__unsafe_unretained NSString *reportingMonth;
} ETGMpPlrRelationships;

extern const struct ETGMpPlrFetchedProperties {
} ETGMpPlrFetchedProperties;

@class ETGReportingMonth;

















@interface ETGMpPlrID : NSManagedObjectID {}
@end

@interface _ETGMpPlr : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMpPlrID*)objectID;




@property (nonatomic, strong) NSNumber* departmentKey;


@property int32_t departmentKeyValue;
- (int32_t)departmentKeyValue;
- (void)setDepartmentKeyValue:(int32_t)value_;

//- (BOOL)validateDepartmentKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* departmentName;


//- (BOOL)validateDepartmentName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* divisionKey;


@property int32_t divisionKeyValue;
- (int32_t)divisionKeyValue;
- (void)setDivisionKeyValue:(int32_t)value_;

//- (BOOL)validateDivisionKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* divisionName;


//- (BOOL)validateDivisionName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* filledFTELoading;


//- (BOOL)validateFilledFTELoading:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* pneClusterKey;


@property int32_t pneClusterKeyValue;
- (int32_t)pneClusterKeyValue;
- (void)setPneClusterKeyValue:(int32_t)value_;

//- (BOOL)validatePneClusterKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectJobTitleKey;


@property int32_t projectJobTitleKeyValue;
- (int32_t)projectJobTitleKeyValue;
- (void)setProjectJobTitleKeyValue:(int32_t)value_;

//- (BOOL)validateProjectJobTitleKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectName;


//- (BOOL)validateProjectName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* regionKey;


@property int32_t regionKeyValue;
- (int32_t)regionKeyValue;
- (void)setRegionKeyValue:(int32_t)value_;

//- (BOOL)validateRegionKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* sectionKey;


@property int32_t sectionKeyValue;
- (int32_t)sectionKeyValue;
- (void)setSectionKeyValue:(int32_t)value_;

//- (BOOL)validateSectionKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* sectionName;


//- (BOOL)validateSectionName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* timeKey;


//- (BOOL)validateTimeKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* vacantFTELoading;


//- (BOOL)validateVacantFTELoading:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* year;


@property int32_t yearValue;
- (int32_t)yearValue;
- (void)setYearValue:(int32_t)value_;

//- (BOOL)validateYear:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGMpPlr (CoreDataGeneratedAccessors)

@end

@interface _ETGMpPlr (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveDepartmentKey;
- (void)setPrimitiveDepartmentKey:(NSNumber*)value;

- (int32_t)primitiveDepartmentKeyValue;
- (void)setPrimitiveDepartmentKeyValue:(int32_t)value_;




- (NSString*)primitiveDepartmentName;
- (void)setPrimitiveDepartmentName:(NSString*)value;




- (NSNumber*)primitiveDivisionKey;
- (void)setPrimitiveDivisionKey:(NSNumber*)value;

- (int32_t)primitiveDivisionKeyValue;
- (void)setPrimitiveDivisionKeyValue:(int32_t)value_;




- (NSString*)primitiveDivisionName;
- (void)setPrimitiveDivisionName:(NSString*)value;




- (NSDecimalNumber*)primitiveFilledFTELoading;
- (void)setPrimitiveFilledFTELoading:(NSDecimalNumber*)value;




- (NSNumber*)primitivePneClusterKey;
- (void)setPrimitivePneClusterKey:(NSNumber*)value;

- (int32_t)primitivePneClusterKeyValue;
- (void)setPrimitivePneClusterKeyValue:(int32_t)value_;




- (NSNumber*)primitiveProjectJobTitleKey;
- (void)setPrimitiveProjectJobTitleKey:(NSNumber*)value;

- (int32_t)primitiveProjectJobTitleKeyValue;
- (void)setPrimitiveProjectJobTitleKeyValue:(int32_t)value_;




- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSString*)primitiveProjectName;
- (void)setPrimitiveProjectName:(NSString*)value;




- (NSNumber*)primitiveRegionKey;
- (void)setPrimitiveRegionKey:(NSNumber*)value;

- (int32_t)primitiveRegionKeyValue;
- (void)setPrimitiveRegionKeyValue:(int32_t)value_;




- (NSNumber*)primitiveSectionKey;
- (void)setPrimitiveSectionKey:(NSNumber*)value;

- (int32_t)primitiveSectionKeyValue;
- (void)setPrimitiveSectionKeyValue:(int32_t)value_;




- (NSString*)primitiveSectionName;
- (void)setPrimitiveSectionName:(NSString*)value;




- (NSDate*)primitiveTimeKey;
- (void)setPrimitiveTimeKey:(NSDate*)value;




- (NSDecimalNumber*)primitiveVacantFTELoading;
- (void)setPrimitiveVacantFTELoading:(NSDecimalNumber*)value;




- (NSNumber*)primitiveYear;
- (void)setPrimitiveYear:(NSNumber*)value;

- (int32_t)primitiveYearValue;
- (void)setPrimitiveYearValue:(int32_t)value_;





- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;


@end
