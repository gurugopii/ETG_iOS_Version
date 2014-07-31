// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGReportingPeriod.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGReportingPeriodAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *filterName;
} ETGReportingPeriodAttributes;

extern const struct ETGReportingPeriodRelationships {
	__unsafe_unretained NSString *clusters;
	__unsafe_unretained NSString *countries;
	__unsafe_unretained NSString *departments;
	__unsafe_unretained NSString *divisions;
	__unsafe_unretained NSString *projectPositions;
	__unsafe_unretained NSString *projects;
	__unsafe_unretained NSString *regions;
	__unsafe_unretained NSString *sections;
	__unsafe_unretained NSString *years;
} ETGReportingPeriodRelationships;

extern const struct ETGReportingPeriodFetchedProperties {
} ETGReportingPeriodFetchedProperties;

@class ETGMpCluster;
@class ETGCountries;
@class NSManagedObject;
@class NSManagedObject;
@class ETGProjectPosition;
@class ETGMpProject;
@class ETGMpRegion;
@class ETGSection;
@class ETGYear;




@interface ETGReportingPeriodID : NSManagedObjectID {}
@end

@interface _ETGReportingPeriod : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGReportingPeriodID*)objectID;




@property (nonatomic, strong) NSDate* date;


//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* filterName;


//- (BOOL)validateFilterName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* clusters;

- (NSMutableSet*)clustersSet;




@property (nonatomic, strong) NSSet* countries;

- (NSMutableSet*)countriesSet;




@property (nonatomic, strong) NSSet* departments;

- (NSMutableSet*)departmentsSet;




@property (nonatomic, strong) NSSet* divisions;

- (NSMutableSet*)divisionsSet;




@property (nonatomic, strong) NSSet* projectPositions;

- (NSMutableSet*)projectPositionsSet;




@property (nonatomic, strong) NSSet* projects;

- (NSMutableSet*)projectsSet;




@property (nonatomic, strong) NSSet* regions;

- (NSMutableSet*)regionsSet;




@property (nonatomic, strong) NSSet* sections;

- (NSMutableSet*)sectionsSet;




@property (nonatomic, strong) NSSet* years;

- (NSMutableSet*)yearsSet;





@end

@interface _ETGReportingPeriod (CoreDataGeneratedAccessors)

- (void)addClusters:(NSSet*)value_;
- (void)removeClusters:(NSSet*)value_;
- (void)addClustersObject:(ETGMpCluster*)value_;
- (void)removeClustersObject:(ETGMpCluster*)value_;

- (void)addCountries:(NSSet*)value_;
- (void)removeCountries:(NSSet*)value_;
- (void)addCountriesObject:(ETGCountries*)value_;
- (void)removeCountriesObject:(ETGCountries*)value_;

- (void)addDepartments:(NSSet*)value_;
- (void)removeDepartments:(NSSet*)value_;
- (void)addDepartmentsObject:(NSManagedObject*)value_;
- (void)removeDepartmentsObject:(NSManagedObject*)value_;

- (void)addDivisions:(NSSet*)value_;
- (void)removeDivisions:(NSSet*)value_;
- (void)addDivisionsObject:(NSManagedObject*)value_;
- (void)removeDivisionsObject:(NSManagedObject*)value_;

- (void)addProjectPositions:(NSSet*)value_;
- (void)removeProjectPositions:(NSSet*)value_;
- (void)addProjectPositionsObject:(ETGProjectPosition*)value_;
- (void)removeProjectPositionsObject:(ETGProjectPosition*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(ETGMpProject*)value_;
- (void)removeProjectsObject:(ETGMpProject*)value_;

- (void)addRegions:(NSSet*)value_;
- (void)removeRegions:(NSSet*)value_;
- (void)addRegionsObject:(ETGMpRegion*)value_;
- (void)removeRegionsObject:(ETGMpRegion*)value_;

- (void)addSections:(NSSet*)value_;
- (void)removeSections:(NSSet*)value_;
- (void)addSectionsObject:(ETGSection*)value_;
- (void)removeSectionsObject:(ETGSection*)value_;

- (void)addYears:(NSSet*)value_;
- (void)removeYears:(NSSet*)value_;
- (void)addYearsObject:(ETGYear*)value_;
- (void)removeYearsObject:(ETGYear*)value_;

@end

@interface _ETGReportingPeriod (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;




- (NSString*)primitiveFilterName;
- (void)setPrimitiveFilterName:(NSString*)value;





- (NSMutableSet*)primitiveClusters;
- (void)setPrimitiveClusters:(NSMutableSet*)value;



- (NSMutableSet*)primitiveCountries;
- (void)setPrimitiveCountries:(NSMutableSet*)value;



- (NSMutableSet*)primitiveDepartments;
- (void)setPrimitiveDepartments:(NSMutableSet*)value;



- (NSMutableSet*)primitiveDivisions;
- (void)setPrimitiveDivisions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjectPositions;
- (void)setPrimitiveProjectPositions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveRegions;
- (void)setPrimitiveRegions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveSections;
- (void)setPrimitiveSections:(NSMutableSet*)value;



- (NSMutableSet*)primitiveYears;
- (void)setPrimitiveYears:(NSMutableSet*)value;


@end
