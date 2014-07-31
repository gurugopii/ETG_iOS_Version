// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPortfolio.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPortfolioAttributes {
	__unsafe_unretained NSString *projectKey;
	__unsafe_unretained NSString *reportMonth;
} ETGPortfolioAttributes;

extern const struct ETGPortfolioRelationships {
	__unsafe_unretained NSString *etgApcPortfolios;
	__unsafe_unretained NSString *etgCpbPortfolios;
	__unsafe_unretained NSString *etgHsePortfolios;
	__unsafe_unretained NSString *etgHydrocarbonPortfolios;
	__unsafe_unretained NSString *etgMLPortfolios;
	__unsafe_unretained NSString *etgProductionRtbdPortfolios;
	__unsafe_unretained NSString *etgWpbPortfolios;
	__unsafe_unretained NSString *project;
	__unsafe_unretained NSString *reportingMonth;
} ETGPortfolioRelationships;

extern const struct ETGPortfolioFetchedProperties {
} ETGPortfolioFetchedProperties;

@class ETGApc;
@class ETGCpb;
@class ETGHsePortfolio;
@class ETGHydrocarbon;
@class ETGMLPortfolio;
@class ETGProductionRtbd_Portfolio;
@class ETGWpb;
@class ETGProject;
@class ETGReportingMonth;




@interface ETGPortfolioID : NSManagedObjectID {}
@end

@interface _ETGPortfolio : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPortfolioID*)objectID;




@property (nonatomic, strong) NSNumber* projectKey;


@property int32_t projectKeyValue;
- (int32_t)projectKeyValue;
- (void)setProjectKeyValue:(int32_t)value_;

//- (BOOL)validateProjectKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* reportMonth;


//- (BOOL)validateReportMonth:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* etgApcPortfolios;

- (NSMutableSet*)etgApcPortfoliosSet;




@property (nonatomic, strong) NSSet* etgCpbPortfolios;

- (NSMutableSet*)etgCpbPortfoliosSet;




@property (nonatomic, strong) NSSet* etgHsePortfolios;

- (NSMutableSet*)etgHsePortfoliosSet;




@property (nonatomic, strong) NSSet* etgHydrocarbonPortfolios;

- (NSMutableSet*)etgHydrocarbonPortfoliosSet;




@property (nonatomic, strong) NSSet* etgMLPortfolios;

- (NSMutableSet*)etgMLPortfoliosSet;




@property (nonatomic, strong) NSSet* etgProductionRtbdPortfolios;

- (NSMutableSet*)etgProductionRtbdPortfoliosSet;




@property (nonatomic, strong) NSSet* etgWpbPortfolios;

- (NSMutableSet*)etgWpbPortfoliosSet;




@property (nonatomic, strong) ETGProject* project;

//- (BOOL)validateProject:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) ETGReportingMonth* reportingMonth;

//- (BOOL)validateReportingMonth:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGPortfolio (CoreDataGeneratedAccessors)

- (void)addEtgApcPortfolios:(NSSet*)value_;
- (void)removeEtgApcPortfolios:(NSSet*)value_;
- (void)addEtgApcPortfoliosObject:(ETGApc*)value_;
- (void)removeEtgApcPortfoliosObject:(ETGApc*)value_;

- (void)addEtgCpbPortfolios:(NSSet*)value_;
- (void)removeEtgCpbPortfolios:(NSSet*)value_;
- (void)addEtgCpbPortfoliosObject:(ETGCpb*)value_;
- (void)removeEtgCpbPortfoliosObject:(ETGCpb*)value_;

- (void)addEtgHsePortfolios:(NSSet*)value_;
- (void)removeEtgHsePortfolios:(NSSet*)value_;
- (void)addEtgHsePortfoliosObject:(ETGHsePortfolio*)value_;
- (void)removeEtgHsePortfoliosObject:(ETGHsePortfolio*)value_;

- (void)addEtgHydrocarbonPortfolios:(NSSet*)value_;
- (void)removeEtgHydrocarbonPortfolios:(NSSet*)value_;
- (void)addEtgHydrocarbonPortfoliosObject:(ETGHydrocarbon*)value_;
- (void)removeEtgHydrocarbonPortfoliosObject:(ETGHydrocarbon*)value_;

- (void)addEtgMLPortfolios:(NSSet*)value_;
- (void)removeEtgMLPortfolios:(NSSet*)value_;
- (void)addEtgMLPortfoliosObject:(ETGMLPortfolio*)value_;
- (void)removeEtgMLPortfoliosObject:(ETGMLPortfolio*)value_;

- (void)addEtgProductionRtbdPortfolios:(NSSet*)value_;
- (void)removeEtgProductionRtbdPortfolios:(NSSet*)value_;
- (void)addEtgProductionRtbdPortfoliosObject:(ETGProductionRtbd_Portfolio*)value_;
- (void)removeEtgProductionRtbdPortfoliosObject:(ETGProductionRtbd_Portfolio*)value_;

- (void)addEtgWpbPortfolios:(NSSet*)value_;
- (void)removeEtgWpbPortfolios:(NSSet*)value_;
- (void)addEtgWpbPortfoliosObject:(ETGWpb*)value_;
- (void)removeEtgWpbPortfoliosObject:(ETGWpb*)value_;

@end

@interface _ETGPortfolio (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveProjectKey;
- (void)setPrimitiveProjectKey:(NSNumber*)value;

- (int32_t)primitiveProjectKeyValue;
- (void)setPrimitiveProjectKeyValue:(int32_t)value_;




- (NSDate*)primitiveReportMonth;
- (void)setPrimitiveReportMonth:(NSDate*)value;





- (NSMutableSet*)primitiveEtgApcPortfolios;
- (void)setPrimitiveEtgApcPortfolios:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgCpbPortfolios;
- (void)setPrimitiveEtgCpbPortfolios:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgHsePortfolios;
- (void)setPrimitiveEtgHsePortfolios:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgHydrocarbonPortfolios;
- (void)setPrimitiveEtgHydrocarbonPortfolios:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgMLPortfolios;
- (void)setPrimitiveEtgMLPortfolios:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgProductionRtbdPortfolios;
- (void)setPrimitiveEtgProductionRtbdPortfolios:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEtgWpbPortfolios;
- (void)setPrimitiveEtgWpbPortfolios:(NSMutableSet*)value;



- (ETGProject*)primitiveProject;
- (void)setPrimitiveProject:(ETGProject*)value;



- (ETGReportingMonth*)primitiveReportingMonth;
- (void)setPrimitiveReportingMonth:(ETGReportingMonth*)value;


@end
