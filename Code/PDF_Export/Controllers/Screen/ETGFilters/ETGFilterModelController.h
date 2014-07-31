//
//  ETGFilterDataController.h
//  
//
//  Created by Tony Pham on 11/28/13.
//
//

#import <Foundation/Foundation.h>
#import "ETGProject.h"
#import "ETGBaselineType.h"

typedef enum
{
    ManpowerTabAHC = 1,
    ManpowerTabHCR,
    ManpowerTabLR,
} ManpowerTab;

@interface ETGFilterModelController : NSObject

+ (id)sharedController;

- (void)getProjectInfosBaseFiltersForReportingMonth:(NSString *)reportingMonth;
- (void)getPllBaseFilters;
-(void)getMasterDataFilter;
-(void)getEccrFilter;
//-(void)getManpowerFilter;
-(void)getManpowerFilter:(NSString *)reportingMonth reportType:(ManpowerTab)reportType isFromFilter:(BOOL)isFromFilter;

-(NSArray *)fetchYearsBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName;
-(NSArray *)fetchDivisionsBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName;
-(NSArray *)fetchDepartmentsBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName;

-(NSArray *)fetchClustersBasedOnRegions:(NSArray *)regionKeys
                        reportingPeriod:(NSDate*)reportingPeriodDate
                          andFilterName:(NSString*)filterName;

-(NSArray *)fetchDepartmentBasedOnDivisions:(NSArray*)divisionKeys;
//-(NSArray *)fetchSectionsBasedOnDepartments:(NSArray*)departmentKeys;
-(NSArray *)fetchSectionsBasedOnDepartments:(NSArray*)departmentKeys
                            reportingPeriod:(NSDate*)reportingPeriodDate
                              andFilterName:(NSString*)filterName;

-(NSArray *)fetchRegionsBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName;
//-(NSArray *)fetchProjectPositionsBasedOnClusters:(NSArray*)clusterKeys;
-(NSArray *)fetchProjectPositionsBasedOnClusters:(NSArray*)clusterKeys
                                 reportingPeriod:(NSDate*)reportingPeriodDate
                                   andFilterName:(NSString*)filterName;

-(NSArray *)fetchCountriesBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName;
-(NSArray *)fetchProjectsBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName;
-(NSArray *)fetchProjectPositionsBasedOnProjects:(NSArray*)projectKeys
                                 reportingPeriod:(NSDate*)reportingPeriodDate
                                   andFilterName:(NSString*)filterName;
-(NSArray *)fetchProjectBasedOnClusters:(NSArray*)clusterKeys
                                regions:(NSArray *)regionKeys
                        reportingPeriod:(NSDate*)reportingPeriodDate
                          andFilterName:(NSString*)filterName;

- (NSDictionary *)getDefaultProjectsDictionary;
- (NSArray *)fetchEccrProjectsBaseOnOperatorships:(NSArray *)operatorshipKeys regions:(NSArray *)regionKeys reportingMonth:(NSString *)reportingMonth;
- (NSArray *)fetchEccrProjectsBaseOnRegions:(NSArray *)regionKeys reportingMonth:(NSString *)reportingMonth;
- (NSArray *)fetchEccrProjectsBaseOnReportingMonth:(NSString *)reportingMonth;
- (NSArray *)fetchProjectsBaseOnOperatorships:(NSArray *)operatorshipKeys phases:(NSArray *)phaseKeys regions:(NSArray *)regionKeys projectStatuses:(NSArray *)projectStatusKeys reportingMonth:(NSString *)reportingMonth;
- (NSArray *)fetchProjectsBaseOnRegions:(NSArray *)regionKeys reportingMonth:(NSString *)reportingMonth;
- (NSArray *)fetchProjectsBaseOnClusters:(NSArray *)clusterKeys complexities:(NSArray *)complexityKeys natures:(NSArray *)natureKeys type:(NSArray *)typesKey region:(NSArray *)regionKeys;
- (NSArray *)getBaselineTypesOfProject:(ETGProject *)project forReportingMonth:(NSDate *)reportingMonth;
- (NSArray *)getRevisionNumbersForABaselineTypes:(ETGBaselineType *)baselineType;
- (NSArray *)getKeyMilestoneWithBaselineType:(ETGBaselineType *)baselineType revision:(ETGRevision *)revision;
- (NSArray *)getLatestKeyMilestoneOfProject:(ETGProject *)project forReportingMonth:(NSDate *)reportingMonth;
-(NSArray *)fetchRegionsBasedOnCountries:(NSArray *)countryKeys;
-(NSArray *)fetchClustersBasedOnRegions:(NSArray *)regionKeys;
-(NSArray *)fetchDisciplinesBasedOnAreas:(NSArray *)areaKeys;

@end
