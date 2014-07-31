// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProjectBackground.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGProjectBackgroundAttributes {
	__unsafe_unretained NSString *clusterName;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *currencyName;
	__unsafe_unretained NSString *endDate;
	__unsafe_unretained NSString *equity;
	__unsafe_unretained NSString *fdpAmt;
	__unsafe_unretained NSString *fdpDate;
	__unsafe_unretained NSString *fdpStatus;
	__unsafe_unretained NSString *firAmt;
	__unsafe_unretained NSString *firDate;
	__unsafe_unretained NSString *firStatus;
	__unsafe_unretained NSString *objective;
	__unsafe_unretained NSString *operatorshipName;
	__unsafe_unretained NSString *projectCostCategoryName;
	__unsafe_unretained NSString *projectEndDate;
	__unsafe_unretained NSString *projectId;
	__unsafe_unretained NSString *projectImage;
	__unsafe_unretained NSString *projectName;
	__unsafe_unretained NSString *projectNatureName;
	__unsafe_unretained NSString *projectStartDate;
	__unsafe_unretained NSString *projectStatusName;
	__unsafe_unretained NSString *projectTypeName;
	__unsafe_unretained NSString *region;
	__unsafe_unretained NSString *startDate;
} ETGProjectBackgroundAttributes;

extern const struct ETGProjectBackgroundRelationships {
	__unsafe_unretained NSString *project;
} ETGProjectBackgroundRelationships;

extern const struct ETGProjectBackgroundFetchedProperties {
} ETGProjectBackgroundFetchedProperties;

@class ETGProject;


























@interface ETGProjectBackgroundID : NSManagedObjectID {}
@end

@interface _ETGProjectBackground : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGProjectBackgroundID*)objectID;




@property (nonatomic, strong) NSString* clusterName;


//- (BOOL)validateClusterName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* country;


//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* currencyName;


//- (BOOL)validateCurrencyName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* endDate;


//- (BOOL)validateEndDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* equity;


//- (BOOL)validateEquity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* fdpAmt;


//- (BOOL)validateFdpAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* fdpDate;


//- (BOOL)validateFdpDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* fdpStatus;


//- (BOOL)validateFdpStatus:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* firAmt;


//- (BOOL)validateFirAmt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* firDate;


//- (BOOL)validateFirDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* firStatus;


//- (BOOL)validateFirStatus:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* objective;


//- (BOOL)validateObjective:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* operatorshipName;


//- (BOOL)validateOperatorshipName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectCostCategoryName;


//- (BOOL)validateProjectCostCategoryName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* projectEndDate;


//- (BOOL)validateProjectEndDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectId;


//- (BOOL)validateProjectId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectImage;


//- (BOOL)validateProjectImage:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectName;


//- (BOOL)validateProjectName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectNatureName;


//- (BOOL)validateProjectNatureName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* projectStartDate;


//- (BOOL)validateProjectStartDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectStatusName;


//- (BOOL)validateProjectStatusName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* projectTypeName;


//- (BOOL)validateProjectTypeName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* region;


//- (BOOL)validateRegion:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* startDate;


//- (BOOL)validateStartDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGProject* project;

//- (BOOL)validateProject:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGProjectBackground (CoreDataGeneratedAccessors)

@end

@interface _ETGProjectBackground (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveClusterName;
- (void)setPrimitiveClusterName:(NSString*)value;




- (NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(NSString*)value;




- (NSString*)primitiveCurrencyName;
- (void)setPrimitiveCurrencyName:(NSString*)value;




- (NSDate*)primitiveEndDate;
- (void)setPrimitiveEndDate:(NSDate*)value;




- (NSString*)primitiveEquity;
- (void)setPrimitiveEquity:(NSString*)value;




- (NSString*)primitiveFdpAmt;
- (void)setPrimitiveFdpAmt:(NSString*)value;




- (NSDate*)primitiveFdpDate;
- (void)setPrimitiveFdpDate:(NSDate*)value;




- (NSString*)primitiveFdpStatus;
- (void)setPrimitiveFdpStatus:(NSString*)value;




- (NSString*)primitiveFirAmt;
- (void)setPrimitiveFirAmt:(NSString*)value;




- (NSDate*)primitiveFirDate;
- (void)setPrimitiveFirDate:(NSDate*)value;




- (NSString*)primitiveFirStatus;
- (void)setPrimitiveFirStatus:(NSString*)value;




- (NSString*)primitiveObjective;
- (void)setPrimitiveObjective:(NSString*)value;




- (NSString*)primitiveOperatorshipName;
- (void)setPrimitiveOperatorshipName:(NSString*)value;




- (NSString*)primitiveProjectCostCategoryName;
- (void)setPrimitiveProjectCostCategoryName:(NSString*)value;




- (NSDate*)primitiveProjectEndDate;
- (void)setPrimitiveProjectEndDate:(NSDate*)value;




- (NSString*)primitiveProjectId;
- (void)setPrimitiveProjectId:(NSString*)value;




- (NSString*)primitiveProjectImage;
- (void)setPrimitiveProjectImage:(NSString*)value;




- (NSString*)primitiveProjectName;
- (void)setPrimitiveProjectName:(NSString*)value;




- (NSString*)primitiveProjectNatureName;
- (void)setPrimitiveProjectNatureName:(NSString*)value;




- (NSDate*)primitiveProjectStartDate;
- (void)setPrimitiveProjectStartDate:(NSDate*)value;




- (NSString*)primitiveProjectStatusName;
- (void)setPrimitiveProjectStatusName:(NSString*)value;




- (NSString*)primitiveProjectTypeName;
- (void)setPrimitiveProjectTypeName:(NSString*)value;




- (NSString*)primitiveRegion;
- (void)setPrimitiveRegion:(NSString*)value;




- (NSDate*)primitiveStartDate;
- (void)setPrimitiveStartDate:(NSDate*)value;





- (ETGProject*)primitiveProject;
- (void)setPrimitiveProject:(ETGProject*)value;


@end
