// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMpAhc.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMpAhcAttributes {
	__unsafe_unretained NSString *departmentKey;
	__unsafe_unretained NSString *departmentName;
	__unsafe_unretained NSString *divisionKey;
	__unsafe_unretained NSString *divisionName;
	__unsafe_unretained NSString *filledHeadcount;
	__unsafe_unretained NSString *sectionKey;
	__unsafe_unretained NSString *sectionName;
	__unsafe_unretained NSString *vacantHeadcount;
	__unsafe_unretained NSString *year;
} ETGMpAhcAttributes;

extern const struct ETGMpAhcRelationships {
	__unsafe_unretained NSString *reportingMonth;
} ETGMpAhcRelationships;

extern const struct ETGMpAhcFetchedProperties {
} ETGMpAhcFetchedProperties;

@class ETGReportingMonth;











@interface ETGMpAhcID : NSManagedObjectID {}
@end

@interface _ETGMpAhc : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMpAhcID*)objectID;




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




@property (nonatomic, strong) NSNumber* filledHeadcount;


@property int32_t filledHeadcountValue;
- (int32_t)filledHeadcountValue;
- (void)setFilledHeadcountValue:(int32_t)value_;

//- (BOOL)validateFilledHeadcount:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* sectionKey;


@property int32_t sectionKeyValue;
- (int32_t)sectionKeyValue;
- (void)setSectionKeyValue:(int32_t)value_;

//- (BOOL)validateSectionKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* sectionName;


//- (BOOL)validateSectionName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* vacantHeadcount;


@property int32_t vacantHeadcountValue;
- (int32_t)vacantHeadcountValue;
- (void)setVacantHeadcountValue:(int32_t)value_;

//- (BOOL)validateVacantHeadcount:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* year;


@property int32_t yearValue;
- (int32_t)yearValue;
- (void)setYearValue:(int32_t)value_;

//- (BOOL)validateYear:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGMpAhc (CoreDataGeneratedAccessors)

@end

@interface _ETGMpAhc (CoreDataGeneratedPrimitiveAccessors)


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




- (NSNumber*)primitiveFilledHeadcount;
- (void)setPrimitiveFilledHeadcount:(NSNumber*)value;

- (int32_t)primitiveFilledHeadcountValue;
- (void)setPrimitiveFilledHeadcountValue:(int32_t)value_;




- (NSNumber*)primitiveSectionKey;
- (void)setPrimitiveSectionKey:(NSNumber*)value;

- (int32_t)primitiveSectionKeyValue;
- (void)setPrimitiveSectionKeyValue:(int32_t)value_;




- (NSString*)primitiveSectionName;
- (void)setPrimitiveSectionName:(NSString*)value;




- (NSNumber*)primitiveVacantHeadcount;
- (void)setPrimitiveVacantHeadcount:(NSNumber*)value;

- (int32_t)primitiveVacantHeadcountValue;
- (void)setPrimitiveVacantHeadcountValue:(int32_t)value_;




- (NSNumber*)primitiveYear;
- (void)setPrimitiveYear:(NSNumber*)value;

- (int32_t)primitiveYearValue;
- (void)setPrimitiveYearValue:(int32_t)value_;





- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;


@end
