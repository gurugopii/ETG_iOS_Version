// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGEccrAbr.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGEccrAbrAttributes {
	__unsafe_unretained NSString *approvedABR;
	__unsafe_unretained NSString *dataTimeNm;
	__unsafe_unretained NSString *indicator;
	__unsafe_unretained NSString *projectCostCategoryKey;
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *regionKey;
	__unsafe_unretained NSString *submittedABR;
} ETGEccrAbrAttributes;

extern const struct ETGEccrAbrRelationships {
	__unsafe_unretained NSString *reportingMonth;
} ETGEccrAbrRelationships;

extern const struct ETGEccrAbrFetchedProperties {
} ETGEccrAbrFetchedProperties;

@class ETGReportingMonth;









@interface ETGEccrAbrID : NSManagedObjectID {}
@end

@interface _ETGEccrAbr : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGEccrAbrID*)objectID;




@property (nonatomic, strong) NSNumber* approvedABR;


@property int32_t approvedABRValue;
- (int32_t)approvedABRValue;
- (void)setApprovedABRValue:(int32_t)value_;

//- (BOOL)validateApprovedABR:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* dataTimeNm;


//- (BOOL)validateDataTimeNm:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indicator;


//- (BOOL)validateIndicator:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectCostCategoryKey;


@property int32_t projectCostCategoryKeyValue;
- (int32_t)projectCostCategoryKeyValue;
- (void)setProjectCostCategoryKeyValue:(int32_t)value_;

//- (BOOL)validateProjectCostCategoryKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* regionKey;


@property int32_t regionKeyValue;
- (int32_t)regionKeyValue;
- (void)setRegionKeyValue:(int32_t)value_;

//- (BOOL)validateRegionKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* submittedABR;


@property int32_t submittedABRValue;
- (int32_t)submittedABRValue;
- (void)setSubmittedABRValue:(int32_t)value_;

//- (BOOL)validateSubmittedABR:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGEccrAbr (CoreDataGeneratedAccessors)

@end

@interface _ETGEccrAbr (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveApprovedABR;
- (void)setPrimitiveApprovedABR:(NSNumber*)value;

- (int32_t)primitiveApprovedABRValue;
- (void)setPrimitiveApprovedABRValue:(int32_t)value_;




- (NSString*)primitiveDataTimeNm;
- (void)setPrimitiveDataTimeNm:(NSString*)value;




- (NSString*)primitiveIndicator;
- (void)setPrimitiveIndicator:(NSString*)value;




- (NSNumber*)primitiveProjectCostCategoryKey;
- (void)setPrimitiveProjectCostCategoryKey:(NSNumber*)value;

- (int32_t)primitiveProjectCostCategoryKeyValue;
- (void)setPrimitiveProjectCostCategoryKeyValue:(int32_t)value_;




- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSNumber*)primitiveRegionKey;
- (void)setPrimitiveRegionKey:(NSNumber*)value;

- (int32_t)primitiveRegionKeyValue;
- (void)setPrimitiveRegionKeyValue:(int32_t)value_;




- (NSNumber*)primitiveSubmittedABR;
- (void)setPrimitiveSubmittedABR:(NSNumber*)value;

- (int32_t)primitiveSubmittedABRValue;
- (void)setPrimitiveSubmittedABRValue:(int32_t)value_;





- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;


@end
