//
//  ETGFilterDataController.m
//
//
//  Created by Tony Pham on 11/28/13.
//
//

#import "ETGFilterModelController.h"
#import <AFNetworking.h>
#import "CommonMethods.h"
#import "ETGReportingMonth.h"
#import "ETGProjectSummary.h"
#import "ETGPortfolio.h"
#import "ETGOperatorship.h"
#import "ETGPhase.h"
#import "ETGRegion.h"
#import "ETGProjectStatus.h"
#import "ETGCostAllocation.h"
#import "ETGKeyMilestone.h"
#import "ETGRevision.h"
#import "ETGProjetComplexities.h"
#import "ETGCountries.h"
#import "ETGProjectNatures.h"
#import "ETGProjectTypes.h"
#import "ETGPllImpactLevels.h"
#import "ETGPllLessonRatings.h"
#import "ETGPllLessonValues.h"
#import "ETGPllReviews.h"
#import "ETGPllPpmsActivity.h"
#import "ETGPllPraElements.h"
#import "ETGProject.h"
#import "ETGCluster.h"
#import "ETGPllAreasDisciplines.h"
#import "ETGPllDisciplines.h"
#import "ETGCoreDataUtilities.h"
#import "ETGAppDelegate.h"
#import "ETGNetworkConnection.h"
#import "ETGJsonHelper.h"
#import "ETGCostCategory.h"
#import "ETGMpCluster.h"
#import "ETGMpProject.h"
#import "ETGMpRegion.h"

#import "ETGSection.h" //new manpower section
#import "ETGDepartment.h"
#import "ETGDivision.h"
#import "ETGYear.h"
#import "ETGReportingPeriod.h"
#import "ETGProjectPosition.h"
#import "ETGDepartmentSection.h"
#import "ETGProject_ProjPosition.h"
#import "ETGCluster_ProjPosition.h"

//BaseFilter Keys
#define kOperatorShipKey @"operatorShipKey"
#define kOperatorShipName @"operatorShipName"
#define kProjectKey @"projectKey"
#define kProjectName @"projectName"
#define kProjectPhaseKey @"projectPhaseKey"
#define kProjectPhaseName @"projectPhaseName"
#define kProjectStatusKey @"projectStatusKey"
#define kProjectStatusName @"projectStatusName"
#define kProjectTypeKey @"projectTypeKey"
#define kProjectTypeName @"projectTypeName"
#define kBudgetHolder @"budgetHolder"
#define kBaselineType @"baseLineType"
#define kRevisionNo @"revisionNo"

#define kMasterDataFilterRootKey @"region"
#define kMasterDataFilterClustersKey @"clusters"
#define kMasterDataFilterClusterName @"cluster"
#define kMasterDataFilterClusterKey @"clusterKey"
#define kMasterDataFilterRegionName @"region"
#define kMasterDataFilterRegionKey @"regionKey"
#define kPllFilterRootKey @"filters"
#define kPllFilterComplexitiesRootKey @"complexities"
#define kPllFilterComplexityKey @"complexityKey"
#define kPllFilterComplexityName @"complexity"
#define kPllFilterCountriesRootKey @"countries"
#define kPllFilterCountryKey @"countryKey"
#define kPllFilterCountryName @"country"
#define kPllFilterRegionsRootKey @"regions"
#define kPllFilterClustersRootKey @"clusters"
#define kPllFilterClusterKey @"clusterKey"
#define kPllFilterClusterName @"cluster"
#define kPllFilterRegionKey @"regionKey"
#define kPllFilterRegionName @"region"
#define kPllFilterNatureRootKey @"natures"
#define kPllFilterNatureKey @"natureKey"
#define kPllFilterNatureName @"nature"
#define kPllFilterProjectsRootKey @"projects"
#define kPllFilterProjectClusterKey @"clusterKey"
#define kPllFilterProjectComplexityKey @"complexityKey"
#define kPllFilterProjectNameKey @"project"
#define kPllFilterProjectKey @"projectKey"
#define kPllFilterProjectNatureKey @"projectNatureKey"
#define kPllFilterProjectTypeKey @"projectTypeKey"
#define kPllFilterProjectRegionKey @"regionKey"
#define kPllFilterTypesRootKey @"types"
#define kPllFilterTypeKey @"typeKey"
#define kPllFilterTypeName @"type"

#define kPllPllFiltersRootKey @"pllFilters"
#define kPllFilterAreasDisciplinesRootKey @"areasDisciplines"
#define kPllFilterAreaName @"area"
#define kPllFilterAreaKey @"areaKey"
#define kPllFilterDisciplinesRootKey @"disciplines"
#define kPllFilterDisciplineKey @"disciplineKey"
#define kPllFilterDisciplineName @"discipline"
#define kPllFilterImpactLevelsRootKey @"impactLevels"
#define kPllFilterImpactLevelKey @"impactLevelKey"
#define kPllFilterImpactLevelName @"impactLevel"
#define kPllFilterLessonRatingsRootKey @"lessonRatings"
#define kPllFilterLessonRatingName @"lessonRating"
#define kPllFilterLessonRatingKey @"lessonRatingKey"
#define kPllFilterLessonValuesRootKey @"lessonValues"
#define kPllFilterLessonValueName @"lessonValue"
#define kPllFilterLessonValueKey @"lessonValueKey"
#define kPllFilterPllReviewsRootKey @"pllReviews"
#define kPllFilterPllReviewName @"review"
#define kPllFilterPllReviewKey @"reviewKey"
#define kPllFilterPpmsActivityRootKey @"ppmsActivity"
#define kPllFilterPpmsActivityName @"activity"
#define kPllFilterPpmsActiviyKey @"activityKey"
#define kPllFilterPraElementsRootKey @"praElements"
#define kPllFilterRiskCategoryKey @"riskCategoryKey"
#define kPllFilterRiskCategoryName @"riskCategory"

#define kEccrFilterAbrRootKey @"filterABR"
#define kEccrFilterCpbRootKey @"filterCPB"
#define kEccrFilterCpsRootKey @"filterCPS"

#define kManpowerFilterAHCRootKey @"filterAverageHeadCount"
#define kManpowerFilterHCRRootKey @"filterHeadCountRequired"
#define kManpowerFilterLRRootKey @"filterLoadingRequired"

#define kManpowerFilterReportingPeriod @"reportingPeriod"
#define kManpowerFilterYearsRootKey @"years"
#define kManpowerFilterDivisionsRootKey @"divisions"
#define kManpowerFilterDepartmentsRootKey @"departments"
#define kManpowerFilterSectionsRootKey @"sections"
#define kManpowerFilterCountriesRootKey @"countries"
#define kManpowerFilterRegionsRootKey @"regions"
#define kManpowerFilterClustersRootKey @"clusters"
#define kManpowerFilterProjectsRootKey @"projects"
#define kManpowerFilterProjectPositionRootKey @"projectPositions"

#define kManpowerFilterYear @"year"
#define kManpowerFilterSectionKey @"sectionKey"
#define kManpowerFilterSectionName @"sectionName"
#define kManpowerFilterDepartmentKey @"departmentKey"
#define kManpowerFilterDepartmentName @"departmentName"
#define kManpowerFilterDivisionKey @"divisionKey"
#define kManpowerFilterDivisionName @"divisionName"
#define kManpowerFilterProjectPositionKey @"projectJobTitleKey"
#define kManpowerFilterProjectPositionName @"projectPosition"
#define kManpowerFilterClusterKey @"clusterKey"
#define kManpowerFilterClusterName @"cluster"
#define kManpowerFilterRegionKey @"regionKey"
#define kManpowerFilterRegionName @"region"
#define kManpowerFilterProjectKey @"projectKey"
#define kManpowerFilterProjectName @"project"
#define kManpowerFilterCountryKey @"countryKey"
#define kManpowerFilterCountryName @"country"

#define kRegion @"region"
#define kRegionKey @"regionKey"

@interface ETGFilterModelController ()
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSDateFormatter *dateFormatter;
@property (nonatomic) int currentEccrPageNumber;
@end

@implementation ETGFilterModelController

+ (id)sharedController
{
    static ETGFilterModelController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[self alloc] init];
    });
    
    return sharedController;
}

- (id)init
{
    self = [super init];
    if (self) {
        _managedObjectContext = [NSManagedObjectContext defaultContext];
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyyMMdd"];
        self.currentEccrPageNumber = 1;
    }
    
    return self;
}

- (void)getProjectInfosBaseFiltersForReportingMonth:(NSString *)reportingMonth
{
    NSString *urlPath = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, kFilters];
    NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:urlPath httpMethod:@"POST"];
    
    NSError *error = nil;
    NSDictionary *inputDict = @{kInputReportingMonth: reportingMonth};
    NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        DDLogError(@"Generate input JSON data error: %@", error);
    } else {
        [request setHTTPBody:inputData];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                                             ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                 [self saveProjectInfosBaseFilters:JSON forReportingMonth:reportingMonth];
                                                 
                                                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForGivenReportingMonthCompleted object:nil];

                                             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForGivenReportingMonthFailed object:nil];
                                                 [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:response.allHeaderFields];
                                                 
                                                 DDLogError(requestFailedError, error, error.userInfo);
                                             }];
        operation.SSLPinningMode = AFSSLPinningModeCertificate;
     
        [operation start];
    }
}

- (void)saveProjectInfosBaseFilters:(id)JSON forReportingMonth:(NSString *)selectedReportingMonth
{
    //DDLogInfo(@"ReportingMonth: %@ - ProjectBaseFilters: %@", selectedReportingMonth, JSON);
    
    //ReportingMonth
    ETGReportingMonth *reportingMonth;
    //TODO: Verify date conversion
//    NSArray *fetchedReportingMonth = [CommonMethods searchEntityForName:@"ETGReportingMonth" withTitle:selectedReportingMonth context:_managedObjectContext];
    NSArray *fetchedReportingMonth = [ETGReportingMonth findAllWithPredicate:[NSPredicate predicateWithFormat:@"name == %@", [selectedReportingMonth toDate]] inContext:_managedObjectContext];
    if ([fetchedReportingMonth count] > 0) {
        reportingMonth = fetchedReportingMonth[0];
    } else {
        reportingMonth = [NSEntityDescription insertNewObjectForEntityForName:@"ETGReportingMonth" inManagedObjectContext:_managedObjectContext];
        //TODO: Verify date conversion
//        reportingMonth.name = selectedReportingMonth;
        reportingMonth.name = [selectedReportingMonth toDate];
    }
    
    for (NSDictionary *projectInfo in JSON) {
        
        //Check project exist
        if ([CommonMethods validateNumberValue:projectInfo[kProjectKey]]) {
            
            ETGProject *projectObject;
            
            NSArray *projectFetchedObjects = [CommonMethods searchEntityForName:@"ETGProject" withID:projectInfo[kProjectKey] context:_managedObjectContext];
            if ([projectFetchedObjects count] > 0) {
                projectObject = [projectFetchedObjects objectAtIndex:0];
            } else {
                projectObject = [NSEntityDescription insertNewObjectForEntityForName:@"ETGProject" inManagedObjectContext:_managedObjectContext];
            }
            projectObject.key = projectInfo[kProjectKey];
            if ([CommonMethods validateStringValue:projectInfo[kProjectName]]) {
                projectObject.name = projectInfo[kProjectName];
            }

            [projectObject addReportingMonths:[NSSet setWithObject:reportingMonth]];
            
            
            //Operatorship
            if ([CommonMethods validateNumberValue:projectInfo[kOperatorShipKey]]) {
                NSArray *operatorshipFetchedObjects = [CommonMethods searchEntityForName:@"ETGOperatorship" withID:projectInfo[kOperatorShipKey] context:_managedObjectContext];
                if ([operatorshipFetchedObjects count] > 0) {
                    ETGOperatorship *operatorshipObject = [operatorshipFetchedObjects objectAtIndex:0];
                    projectObject.operatorship = operatorshipObject;
                } else {
                    ETGOperatorship *newOperatorshipObject = [NSEntityDescription insertNewObjectForEntityForName:@"ETGOperatorship" inManagedObjectContext:_managedObjectContext];
                    newOperatorshipObject.key = projectInfo[kOperatorShipKey];
                    if ([CommonMethods validateStringValue:projectInfo[kOperatorShipName]]) {
                        newOperatorshipObject.name = projectInfo[kOperatorShipName];
                    }
                    projectObject.operatorship = newOperatorshipObject;
                }
            } else {
                DDLogWarn(@"%@%@ operationshipKey: %@", logWarnPrefix, incorrectDataType, projectInfo[kOperatorShipKey]);
            }
            
            //Phase
            if ([CommonMethods validateNumberValue:projectInfo[kProjectPhaseKey]]) {
                NSArray *phaseFetchedObjects = [CommonMethods searchEntityForName:@"ETGPhase" withID:projectInfo[kProjectPhaseKey] context:_managedObjectContext];
                if ([phaseFetchedObjects count] > 0) {
                    ETGPhase *phaseObject = [phaseFetchedObjects objectAtIndex:0];
                    projectObject.phase = phaseObject;
                } else {
                    ETGPhase *newPhaseObject = [NSEntityDescription insertNewObjectForEntityForName:@"ETGPhase" inManagedObjectContext:_managedObjectContext];
                    newPhaseObject.key = projectInfo[kProjectPhaseKey];
                    if ([CommonMethods validateStringValue:projectInfo[kProjectPhaseName]]) {
                        newPhaseObject.name = projectInfo[kProjectPhaseName];
                    }
                    projectObject.phase = newPhaseObject;
                }
            } else {
                DDLogWarn(@"%@%@ projectPhaseKey: %@", logWarnPrefix, incorrectDataType, projectInfo[kProjectPhaseKey]);
            }
            
            //Region
            if ([CommonMethods validateNumberValue:projectInfo[kRegionKey]]) {
                NSArray *regionFetchedObjects = [CommonMethods searchEntityForName:@"ETGRegion" withID:projectInfo[kRegionKey] context:_managedObjectContext];
                if ([regionFetchedObjects count] > 0) {
                    ETGRegion *regionObject = [regionFetchedObjects objectAtIndex:0];
                    projectObject.region = regionObject;
                } else {
                    ETGRegion *newRegionObject = [NSEntityDescription insertNewObjectForEntityForName:@"ETGRegion" inManagedObjectContext:_managedObjectContext];
                    newRegionObject.key = projectInfo[kRegionKey];
                   if ([CommonMethods validateStringValue:projectInfo[kRegion]]) {
                        newRegionObject.name = projectInfo[kRegion];
                    }
                    projectObject.region = newRegionObject;
                }
            } else {
                DDLogWarn(@"%@%@ regionKey: %@", logWarnPrefix, incorrectDataType, projectInfo[kRegionKey]);
            }
            
            //Project Status
            if ([CommonMethods validateNumberValue:projectInfo[kProjectStatusKey]]) {
                NSArray *projectStatusFetchedObjects = [CommonMethods searchEntityForName:@"ETGProjectStatus" withID:projectInfo[kProjectStatusKey] context:_managedObjectContext];
                if ([projectStatusFetchedObjects count] > 0) {
                    ETGProjectStatus *projectStatusObject = [projectStatusFetchedObjects objectAtIndex:0];
                    projectObject.projectStatus = projectStatusObject;
                } else {
                    ETGProjectStatus *newProjectStatusObject = [NSEntityDescription insertNewObjectForEntityForName:@"ETGProjectStatus" inManagedObjectContext:_managedObjectContext];
                    newProjectStatusObject.key = projectInfo[kProjectStatusKey];
                   if ([CommonMethods validateStringValue:projectInfo[kProjectStatusName]]) {
                        newProjectStatusObject.name = projectInfo[kProjectStatusName];
                    }
                    projectObject.projectStatus = newProjectStatusObject;
                }
            } else {
                DDLogWarn(@"%@%@ projectStatusKey: %@", logWarnPrefix, incorrectDataType, projectInfo[kProjectStatusKey]);
            }
            
            //Budget Holder
//            NSNumber *budgetHolderKey = projectInfo[kBudgetHolderKey];
            for (NSDictionary *budgetHolderDict in projectInfo[kBudgetHolder]) {
               
                NSNumber *budgetHolderKey = budgetHolderDict[@"key"];
                if ([CommonMethods validateNumberValue:budgetHolderKey]) {
                    NSArray *fetchedBudgetHolders = [CommonMethods searchEntityForName:@"ETGCostAllocation" withID:budgetHolderKey context:_managedObjectContext];
                    
                    ETGCostAllocation *budgetHolder;
                    if ([fetchedBudgetHolders count] > 0) {
                        budgetHolder = fetchedBudgetHolders[0];
                    } else {
                        budgetHolder = [NSEntityDescription insertNewObjectForEntityForName:@"ETGCostAllocation" inManagedObjectContext:_managedObjectContext];
                        budgetHolder.key = budgetHolderKey;
                        
                        if ([CommonMethods validateStringValue:budgetHolderDict[@"name"]]) {
                            budgetHolder.name = budgetHolderDict[@"name"];
                        }
                    }
                    
                    [projectObject addBudgetHolders:[NSSet setWithObject:budgetHolder]];
                } else {
                    DDLogWarn(@"%@%@ BudgetHolderKey: %@", logWarnPrefix, incorrectDataType, projectInfo[kBudgetHolder]);
                }
            }
            
            //Baseline Type
            
            //RevisionNo
            
        } else {
            DDLogWarn(@"%@%@ projectKey: %@", logWarnPrefix, incorrectDataType, projectInfo[kProjectKey]);
      }
    }
    
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        DDLogError(@"%@%@%@",logErrorPrefix, saveEntityError, error);
    }
}

- (void)getMasterDataFilter
{
    ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (appDelegate.isNetworkServerAvailable == YES) {
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kMasterService, ETG_MASTER_ALL_MASTER_DATA];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"GET"];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                 ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                     // Save it
                     [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStampInUserDefaults:@"MasterDataFilter"];
                     [self saveMasterDataFilters:JSON];
                     [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForMapCompleted object:nil];
                 } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                     [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithUrlResponse:response error:error];
                     [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForMapFailed object:nil];
                 }];
        operation.SSLPinningMode = AFSSLPinningModeCertificate;
        [operation start];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadMapShouldAutoRefresh object:nil];
        DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
    }
}

-(void)getEccrFilter
{
    ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (appDelegate.isNetworkServerAvailable == YES) {
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kEccrService, ETG_ECCR_FILTER];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
        NSDictionary *inputDict = @{kInputPageSize: @(200), kInputPageNumber: @(self.currentEccrPageNumber)};
        NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:inputData];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                                             ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                 // Save it
                                                 NSDictionary *filterABR = JSON[@"filterABR"];
                                                 if(filterABR != (id)[NSNull null] && [filterABR count] > 0)
                                                 {
                                                     [self saveEccrFilters:JSON];
                                                     self.currentEccrPageNumber ++;
                                                     [self getEccrFilter];
                                                 }
                                                 else
                                                 {
                                                     [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStampInUserDefaults:@"ECCRFilter"];
                                                     self.currentEccrPageNumber = 1;
                                                     [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForEccrCompleted object:nil];
                                                 }
                                             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithUrlResponse:response error:error];
                                                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForEccrFailed object:nil];
                                             }];
        operation.SSLPinningMode = AFSSLPinningModeCertificate;
        [operation start];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadEccrShouldAutoRefresh object:nil];
        DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
    }
}

-(void)saveEccrFilters:(id)json
{
    NSDictionary *abrFilter = json[kEccrFilterAbrRootKey];
    if(abrFilter != (id)[NSNull null])
    {
        for(NSDictionary *p in abrFilter)
        {
            ETGProject *project = [self findOrCreateProject:p[@"projectKey"] name:p[@"projectName"] startDate:p[@"minReportingPeriod"] endDate:p[@"maxReportingPeriod"]];
            ETGCostCategory *costCategory = [self findOrCreateCostCategory:p[@"projectCostCategoryKey"] name:p[@"projectCostCategoryName"]];
            if(nil == costCategory)
            {
                continue;
            }
            project.costCategory = costCategory;
            ETGRegion *region = [self findOrCreateRegion:p[@"regionKey"] name:p[@"regionName"]];
            project.region = region;
            [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                if(error)
                {
                    DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                }
            }];
        }
    }
    
    NSDictionary *cpbFilter = json[kEccrFilterCpbRootKey];
    if(cpbFilter != (id)[NSNull null])
    {
        for(NSDictionary *p in cpbFilter)
        {
            ETGProject *project = [self findOrCreateProject:p[@"projectKey"] name:p[@"projectName"] startDate:p[@"minReportingPeriod"] endDate:p[@"maxReportingPeriod"]];
            ETGCostAllocation *costAllocation = [self findOrCreateCostAllocationKey:p[@"budgetHolderKey"] name:p[@"budgetHolderName"]];
            ETGRegion *region = [self findOrCreateRegion:p[@"regionKey"] name:p[@"regionName"]];
            ETGOperatorship *operatorship = [self findOrCreateOperatorship:p[@"operatorShipKey"] name:p[@"operatorShipName"]];
            ETGCostCategory *costCategory = [self findOrCreateCostCategory:p[@"projectCostCategoryKey"] name:p[@"projectCostCategoryName"]];
            if(nil == costCategory)
            {
                continue;
            }
            project.costCategory = costCategory;
            if(nil != costAllocation)
            {
                [project.budgetHoldersSet addObject:costAllocation];                
            }
            project.region = region;
            project.operatorship = operatorship;
            [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                if(error)
                {
                    DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                }
            }];
        }
    }
    
    NSDictionary *cpsFilter = json[kEccrFilterCpsRootKey];
    if(cpsFilter != (id)[NSNull null])
    {
        for(NSDictionary *p in cpsFilter)
        {
            [self findOrCreateProject:p[@"projectKey"] name:p[@"projectName"] startDate:p[@"minReportingPeriod"] endDate:p[@"maxReportingPeriod"]];
        }
    }
}

-(ETGCostCategory *)findOrCreateCostCategory:(NSString *)key name:(NSString *)name
{
    if(nil == key || [NSNull null] == (id)key)
    {
        return nil;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", key];
    ETGCostCategory *costCategory = [ETGCostCategory findFirstWithPredicate:predicate];
    if(nil == costCategory)
    {
        costCategory = [ETGCostCategory insertInManagedObjectContext:self.managedObjectContext];
        costCategory.key = @([[ETGJsonHelper resetToNilIfRequired:key] integerValue]);
    }
    costCategory.name = [ETGJsonHelper resetToNilIfRequired:name];
    [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    return costCategory;
}

-(ETGRegion *)findOrCreateRegion:(NSString *)key name:(NSString *)name
{
    if(nil == key || [NSNull null] == (id)key)
    {
        return nil;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", key];
    ETGRegion *region = [ETGRegion findFirstWithPredicate:predicate];
    if(nil == region)
    {
        region = [ETGRegion insertInManagedObjectContext:self.managedObjectContext];
        region.key = @([[ETGJsonHelper resetToNilIfRequired:key] integerValue]);
    }
    region.name = [ETGJsonHelper resetToNilIfRequired:name];
    [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    return region;
}

-(ETGOperatorship *)findOrCreateOperatorship:(NSString *)key name:(NSString *)name
{
    if(nil == key || [NSNull null] == (id)key)
    {
        return nil;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", key];
    ETGOperatorship *operatorShip = [ETGOperatorship findFirstWithPredicate:predicate];
    if(nil == operatorShip)
    {
        operatorShip = [ETGOperatorship insertInManagedObjectContext:self.managedObjectContext];
        operatorShip.key = @([[ETGJsonHelper resetToNilIfRequired:key] integerValue]);
    }
    operatorShip.name = [ETGJsonHelper resetToNilIfRequired:name];
    [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    return operatorShip;
}

-(ETGCostAllocation *)findOrCreateCostAllocationKey:(NSString *)key name:(NSString *)name
{
    if(nil == key || [NSNull null] == (id)key)
    {
        return nil;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", key];
    ETGCostAllocation *costAllocation = [ETGCostAllocation findFirstWithPredicate:predicate];
    if(nil == costAllocation)
    {
        costAllocation = [ETGCostAllocation insertInManagedObjectContext:self.managedObjectContext];
        costAllocation.key = @([[ETGJsonHelper resetToNilIfRequired:key] integerValue]);
    }
    costAllocation.name = [ETGJsonHelper resetToNilIfRequired:name];
    [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    return costAllocation;
}

-(NSDate *) toLocalTime:(NSDate *)date
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: date];
    return [NSDate dateWithTimeInterval: seconds sinceDate: date];
}

-(NSDate *)toLocalDate:(NSDateComponents *)toDateComponents
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *newDate = [cal dateFromComponents:toDateComponents];
    return [self toLocalTime:newDate];
}

-(ETGProject *)findOrCreateProject:(NSString *)projectKey name:(NSString *)projectName startDate:(NSString *)startDate endDate:(NSString *)endDate
{
    if(nil == projectKey || projectKey == (id)[NSNull null] || startDate == (id)[NSNull null] || endDate == (id)[NSNull null])
    {
        return nil;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", projectKey];
    ETGProject *project = [ETGProject findFirstWithPredicate:predicate];
    if(nil == project)
    {
        project = [ETGProject insertInManagedObjectContext:self.managedObjectContext];
        project.key = @([[ETGJsonHelper resetToNilIfRequired:projectKey] integerValue]);
    }
    project.name = [ETGJsonHelper resetToNilIfRequired:projectName];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *minDate = [formatter dateFromString:[ETGJsonHelper truncateString:startDate withLength:10]];
    NSDate *maxDate = [formatter dateFromString:[ETGJsonHelper truncateString:endDate withLength:10]];
    minDate = [self toLocalTime:minDate];
    maxDate = [self toLocalTime:maxDate];
    
    //NSDateComponents *minDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:minDate];
    //NSDateComponents *maxDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:maxDate];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    
    project.startDateValue = [[formatter stringFromDate:minDate] integerValue];
    project.endDateValue = [[formatter stringFromDate:maxDate] integerValue];
    
//    int yearDiff = maxDateComponents.year - minDateComponents.year;
//    if(yearDiff > 0)
//    {
//        for(int j = 0; j <= yearDiff; j++)
//        {
//            if(j == 0)
//            {
//                // First year
//                int monthDiff = 12 - minDateComponents.month;
//                for(int i = 0; i  <= monthDiff; i++)
//                {
//                    NSDate *date = [self toLocalDate:minDateComponents];
//                    NSString *dateString = [formatter stringFromDate:date];
//                    ETGReportingMonth *reportingMonth = [self findOrCreateReportingMonth:dateString];
//                    [reportingMonth.projectsSet addObject:project];
//                    [project.reportingMonthsSet addObject:reportingMonth];
//                    minDateComponents.month++;
//                    [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
//                        if(error)
//                        {
//                            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
//                        }
//                    }];
//                }
//            }
//            else if(j < yearDiff)
//            {
//                // Subsequent year
//                minDateComponents.year += 1;
//                minDateComponents.month = 1;
//                for(int i = 0; i  < 12; i++)
//                {
//                    NSDate *date = [self toLocalDate:minDateComponents];
//                    NSString *dateString = [formatter stringFromDate:date];
//                    ETGReportingMonth *reportingMonth = [self findOrCreateReportingMonth:dateString];
//                    [reportingMonth.projectsSet addObject:project];
//                    [project.reportingMonthsSet addObject:reportingMonth];
//                    minDateComponents.month++;
//                    [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
//                        if(error)
//                        {
//                            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
//                        }
//                    }];
//                }
//            }
//            else if(j == yearDiff)
//            {
//                // Last year
//                minDateComponents.year += 1;
//                minDateComponents.month = 1;
//                for(int i = 0; i  < maxDateComponents.month; i++)
//                {
//                    NSDate *date = [self toLocalDate:minDateComponents];
//                    NSString *dateString = [formatter stringFromDate:date];
//                    ETGReportingMonth *reportingMonth = [self findOrCreateReportingMonth:dateString];
//                    [reportingMonth.projectsSet addObject:project];
//                    [project.reportingMonthsSet addObject:reportingMonth];
//                    minDateComponents.month++;
//                    [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
//                        if(error)
//                        {
//                            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
//                        }
//                    }];
//                }
//            }
//        }
//    }
//    else if(yearDiff == 0)
//    {
//        int monthDiff = maxDateComponents.month - minDateComponents.month;
//        for(int i = 0; i  <= monthDiff; i++)
//        {
//            NSDate *date = [self toLocalDate:minDateComponents];
//            NSString *dateString = [formatter stringFromDate:date];
//            ETGReportingMonth *reportingMonth = [self findOrCreateReportingMonth:dateString];
//            [reportingMonth.projectsSet addObject:project];
//            [project.reportingMonthsSet addObject:reportingMonth];
//            minDateComponents.month++;
//            [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
//                if(error)
//                {
//                    DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
//                }
//            }];
//        }
//    }
    
    [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
    return project;
}

-(ETGReportingMonth *)findOrCreateReportingMonth:(NSString *)reportingMonth
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [reportingMonth toDate]];
    ETGReportingMonth *targetReportingMonth = [ETGReportingMonth findFirstWithPredicate:predicate];
    if(nil == targetReportingMonth)
    {
        targetReportingMonth = [ETGReportingMonth insertInManagedObjectContext:self.managedObjectContext];
        targetReportingMonth.name = [ETGJsonHelper resetToNilIfRequired:reportingMonth];
        [self.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    }
    return targetReportingMonth;
}

//-(void)getManpowerFilter
//{
//    ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
//    [ETGNetworkConnection checkAvailability];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForManpowerStarting object:nil];
//    
//    if (appDelegate.isNetworkServerAvailable == YES)
//    {
//        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kManPowerService, kFilters];
//        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"GET"];
//        [request setTimeoutInterval:600];
//        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
//                                             ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//                                                 // Save it
//                                                 [self saveManpowerFilters:JSON];
//                                                 [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStampInUserDefaults:@"ManpowerFilter"];
//                                                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForManpowerCompleted object:nil];
//                                                 
//                                             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//                                                 [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithUrlResponse:response error:error];
//                                                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadManpowerFilterDataForGivenReportingMonthFailed object:nil];
//                                             }];
//        operation.SSLPinningMode = AFSSLPinningModeCertificate;
//        [operation start];
//    }
//    else
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadManpowerFilterDataForGivenReportingMonthFailed object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadManpowerShouldAutoRefresh object:nil];
//        DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
//    }
//}

-(void)getManpowerFilter:(NSString *)reportingMonth reportType:(ManpowerTab)reportType isFromFilter:(BOOL)isFromFilter
{
    NSString *moduleName = [NSString stringWithFormat:@"ManPowerFilter_%@_%d", reportingMonth, reportType];
    BOOL isExpired = [[ETGCoreDataUtilities sharedCoreDataUtilities] isTimeStampInUserDefaultsMoreThanNumberOfDays:(int)kNumberOfExpiryDaysCoreData inModuleName:moduleName];
    if(!isExpired)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForManpowerCompleted object:nil];
        return;
    }
    
    ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForManpowerStarting object:nil];
    
    if (appDelegate.isNetworkServerAvailable == YES)
    {
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kManPowerService, kFilters];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
        NSDictionary *inputDict = @{kInputReportingMonth: reportingMonth, kInputReportType: @(reportType)};
        NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:inputData];
        //[request setTimeoutInterval:600];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                                             ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                 // Save it
                                                 [self saveManpowerFilters:JSON reportType:reportType];
                                                 [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStampInUserDefaults:moduleName];
                                                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForManpowerCompleted object:nil];
                                                 
                                             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithUrlResponse:response error:error];
                                                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadManpowerFilterDataForGivenReportingMonthFailed object:nil];
                                             }];
        operation.SSLPinningMode = AFSSLPinningModeCertificate;
        [operation start];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadManpowerFilterDataForGivenReportingMonthFailed object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadManpowerShouldAutoRefresh object:nil];
        DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
    }
}

-(void)saveManpowerFilters:(id)json reportType:(ManpowerTab)reportType
{
    switch(reportType)
    {
        case ManpowerTabAHC:
            [self saveAhcFilterWithJson:json];
            break;
        case ManpowerTabHCR:
            [self saveHcrFilterWithJson:json];
            break;
        case ManpowerTabLR:
            [self saveLrFilterWithJson:json];
            break;
    }
}

-(void)saveManpowerFilters:(id)json
{
    [self saveAhcFilterWithJson:json];
    [self saveHcrFilterWithJson:json];
    [self saveLrFilterWithJson:json];
}
#pragma mark - Manpower Filter
-(void)saveAhcFilterWithJson:(id)json
{
    NSArray *ahcFilters = json[kManpowerFilterAHCRootKey];
    if(ahcFilters == (id)[NSNull null])
    {
        return;
    }
    for(NSDictionary *dictionary in ahcFilters) {
        //        NSMutableSet *tempDivisions = [NSMutableSet set];
        NSMutableSet *tempYears = [NSMutableSet set];
        NSMutableSet *tempDepartments = [NSMutableSet set];
        NSMutableSet *tempSections  = [NSMutableSet set];
        
        NSDictionary *years = dictionary[kManpowerFilterYearsRootKey];
        tempYears = [self findOrCreateYearsSetWithInputJson:years];
        
        
        NSDictionary *divisions = dictionary[kManpowerFilterDivisionsRootKey];
        tempDepartments = [self findOrCreateDeparmentsSetWithInputDivisionJson:divisions];
        tempSections = [self findOrCreateSectionsSetWithInputDivisionJson:divisions reportingPeriod:[dictionary[kManpowerFilterReportingPeriod] toDate] filterName:kManpowerFilterAHCRootKey];
        
        //saving Reporting Period
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", [dictionary[kManpowerFilterReportingPeriod] toDate],kManpowerFilterAHCRootKey]; //save it base on the filter name
        ETGReportingPeriod *reportingPeriodCoreDataObject = [ETGReportingPeriod findFirstWithPredicate:predicate];
        if (reportingPeriodCoreDataObject == nil)
        {
            
            reportingPeriodCoreDataObject = [ETGReportingPeriod insertInManagedObjectContext:_managedObjectContext];
            [reportingPeriodCoreDataObject setValue:[dictionary[kManpowerFilterReportingPeriod] toDate] forKey:@"date"];
            [reportingPeriodCoreDataObject setValue:kManpowerFilterAHCRootKey forKey:@"filterName"];
            //                    [reportingPeriodCoreDataObject addDivisions:tempDivisions];
            [reportingPeriodCoreDataObject addDepartments:tempDepartments];
            [reportingPeriodCoreDataObject addSections:tempSections];
            [reportingPeriodCoreDataObject addYears:tempYears];
            
            
        }
        //
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        [tempYears removeAllObjects];
        //                [tempDivisions removeAllObjects];
        [tempDepartments removeAllObjects];
        [tempSections removeAllObjects];
        
    } // end AHC filter
    
}

-(void)saveHcrFilterWithJson:(id)json
{
    NSArray *hcrFilters = json[kManpowerFilterHCRRootKey];
    if(hcrFilters == (id)[NSNull null])
    {
        return;
    }
    for(NSDictionary *dictionary in hcrFilters) {
        //        NSMutableSet *tempDivisions = [NSMutableSet set];
        NSMutableSet *tempDepartments = [NSMutableSet set];
        NSMutableSet *tempSections = [NSMutableSet set];
        NSMutableSet *tempYears = [NSMutableSet set];
        NSMutableSet *tempRegions = [NSMutableSet set];
        NSMutableSet *tempClusters = [NSMutableSet set];
        NSMutableSet *tempProjectPositions = [NSMutableSet set];
        
        NSDictionary *regions = dictionary[kManpowerFilterRegionsRootKey];
        tempRegions = [self findOrCreateRegionsSetWithInputJson:regions isLRFilter:NO];
        
        NSDictionary *years = dictionary[kManpowerFilterYearsRootKey];
        tempYears = [self findOrCreateYearsSetWithInputJson:years];
        
        NSDictionary *divisions = dictionary[kManpowerFilterDivisionsRootKey];
        tempDepartments = [self findOrCreateDeparmentsSetWithInputDivisionJson:divisions];
        tempSections = [self findOrCreateSectionsSetWithInputDivisionJson:divisions reportingPeriod:[dictionary[kManpowerFilterReportingPeriod] toDate] filterName:kManpowerFilterHCRRootKey];
        
        tempClusters = [self findOrCreateClustersSetWithRegionJson:regions];
        tempProjectPositions = [self findOrCreateProjectPositionsSetWithRegionJson:regions reportingPeriod:[dictionary[kManpowerFilterReportingPeriod] toDate] filterName:kManpowerFilterHCRRootKey];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", [dictionary[kManpowerFilterReportingPeriod] toDate],kManpowerFilterHCRRootKey]; //save it base on the filter name
        ETGReportingPeriod *reportingPeriodCoreDataObject = [ETGReportingPeriod findFirstWithPredicate:predicate];
        if (reportingPeriodCoreDataObject == nil)
        {
            reportingPeriodCoreDataObject = [ETGReportingPeriod insertInManagedObjectContext:_managedObjectContext];
            [reportingPeriodCoreDataObject setValue:[dictionary[kManpowerFilterReportingPeriod] toDate] forKey:@"date"];
            [reportingPeriodCoreDataObject setValue:kManpowerFilterHCRRootKey forKey:@"filterName"];
            //            [reportingPeriodCoreDataObject addDivisions:tempDivisions];
            [reportingPeriodCoreDataObject addDepartments:tempDepartments];
            [reportingPeriodCoreDataObject addSections:tempSections];
            [reportingPeriodCoreDataObject addYears:tempYears];
            [reportingPeriodCoreDataObject addRegions:tempRegions];
            [reportingPeriodCoreDataObject addClusters:tempClusters];
            [reportingPeriodCoreDataObject addProjectPositions:tempProjectPositions];
            
        }
        //
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        [tempYears removeAllObjects];
        //        [tempDivisions removeAllObjects];
        [tempDepartments removeAllObjects];
        [tempSections removeAllObjects];
        [tempRegions removeAllObjects];
        [tempClusters removeAllObjects];
        [tempProjectPositions removeAllObjects];
    } // end HCR filter
}

-(void)saveLrFilterWithJson:(id)json
{
    NSArray *lrFilters = json[kManpowerFilterLRRootKey];
    if(lrFilters == (id)[NSNull null])
    {
        return;
    }
    for(NSDictionary *dictionary in lrFilters) {
        //        NSMutableSet *tempDivisions = [NSMutableSet set];
        NSMutableSet *tempDepartments =[NSMutableSet set];
        NSMutableSet *tempSections = [NSMutableSet set];
        NSMutableSet *tempYears = [NSMutableSet set];
        //        NSMutableSet *tempCountries = [NSMutableSet set];
        NSMutableSet *tempRegions = [NSMutableSet set];
        NSMutableSet *tempClusters = [NSMutableSet set];
        NSMutableSet *tempProjects = [NSMutableSet set];
        NSMutableSet *tempProjectPositions = [NSMutableSet set];
        
        NSDictionary *years = dictionary[kManpowerFilterYearsRootKey];
        tempYears = [self findOrCreateYearsSetWithInputJson:years];
        
        NSDictionary *divisions = dictionary[kManpowerFilterDivisionsRootKey];
        tempDepartments = [self findOrCreateDeparmentsSetWithInputDivisionJson:divisions];
        tempSections = [self findOrCreateSectionsSetWithInputDivisionJson:divisions reportingPeriod:[dictionary[kManpowerFilterReportingPeriod] toDate] filterName:kManpowerFilterLRRootKey];
        
        NSDictionary *countries = dictionary[kManpowerFilterCountriesRootKey];
        //        tempCountries = [self findOrCreateCountriesSetWithInputJson:countries];
        tempRegions = [self findOrCreateRegionsSetWithCountriesJson:countries];
        tempClusters = [self findOrCreateClustersSetWithCountriesJson:countries];
        
        
        NSDictionary *projects = dictionary[kManpowerFilterProjectsRootKey];
        tempProjects = [self findOrCreateProjectsSetWithInputJson:projects];
        tempProjectPositions = [self findOrCreateProjectPositionsSetWithProjectJson:projects reportingPeriod:[dictionary[kManpowerFilterReportingPeriod] toDate] filterName:kManpowerFilterLRRootKey];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", [dictionary[kManpowerFilterReportingPeriod] toDate],kManpowerFilterLRRootKey]; //save it base on the filter name
        ETGReportingPeriod *reportingPeriodCoreDataObject = [ETGReportingPeriod findFirstWithPredicate:predicate];
        if (reportingPeriodCoreDataObject == nil)
        {
            
            reportingPeriodCoreDataObject = [ETGReportingPeriod insertInManagedObjectContext:_managedObjectContext];
            [reportingPeriodCoreDataObject setValue:[dictionary[kManpowerFilterReportingPeriod] toDate] forKey:@"date"];
            [reportingPeriodCoreDataObject setValue:kManpowerFilterLRRootKey forKey:@"filterName"];
            //            [reportingPeriodCoreDataObject addDivisions:tempDivisions];
            [reportingPeriodCoreDataObject addDepartments:tempDepartments];
            [reportingPeriodCoreDataObject addSections:tempSections];
            [reportingPeriodCoreDataObject addYears:tempYears];
            //            [reportingPeriodCoreDataObject addCountries:tempCountries];
            [reportingPeriodCoreDataObject addRegions:tempRegions];
            [reportingPeriodCoreDataObject addClusters:tempClusters];
            [reportingPeriodCoreDataObject addProjects:tempProjects];
            [reportingPeriodCoreDataObject addProjectPositions:tempProjectPositions];
            
        }
        //
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        [tempYears removeAllObjects];
        //        [tempDivisions removeAllObjects];
        [tempDepartments removeAllObjects];
        [tempSections removeAllObjects];
        //        [tempCountries removeAllObjects];
        [tempRegions removeAllObjects];
        [tempClusters removeAllObjects];
        [tempProjects removeAllObjects];
        [tempProjectPositions removeAllObjects];
        
    } // end PLR filter
}

-(NSMutableSet*)findOrCreateYearsSetWithInputJson:(NSDictionary*)years {
    
    NSMutableSet *tempYears = [NSMutableSet set];
    
    for (NSDictionary *year in years) {
        NSArray *fetchedYearObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGYear class]) withID:year[kManpowerFilterYear] context:_managedObjectContext];
        ETGYear *yearCoreDataObject;
        if ([fetchedYearObjects count] > 0)
        {
            yearCoreDataObject = [fetchedYearObjects objectAtIndex:0];
            [yearCoreDataObject setValue:[NSString stringWithFormat:@"%@",year[kManpowerFilterYear]]forKey:@"name"];
            
        }
        else
        {
            yearCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGYear class]) inManagedObjectContext:_managedObjectContext];
            [yearCoreDataObject setValue:year[kManpowerFilterYear] forKey:@"key"];
            if ([CommonMethods validateStringValue:[NSString stringWithFormat:@"%@",year[kManpowerFilterYear]]])
            {
                [yearCoreDataObject setValue:[NSString stringWithFormat:@"%@",year[kManpowerFilterYear]]forKey:@"name"];
            }
        }
        [tempYears addObject:yearCoreDataObject];
        //
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    }
    
    return tempYears;
}

-(NSMutableSet*)findOrCreateSectionsSetWithInputJson:(NSDictionary*)sections {
    NSMutableSet *tempSections = [NSMutableSet set];
    
    for (NSDictionary *section in sections) {
        NSArray *fetchedSectionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGSection class]) withID:section[kManpowerFilterSectionKey] context:_managedObjectContext];
        ETGSection *sectionCoreDataObject;
        if ([fetchedSectionObjects count] > 0)
        {
            sectionCoreDataObject = [fetchedSectionObjects objectAtIndex:0];
            [sectionCoreDataObject setValue:section[kManpowerFilterSectionName] forKey:@"name"];
        }
        else
        {
            sectionCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGSection class]) inManagedObjectContext:_managedObjectContext];
            [sectionCoreDataObject setValue:section[kManpowerFilterSectionKey] forKey:@"key"];
            if ([CommonMethods validateStringValue:section[kManpowerFilterSectionName]])
            {
                [sectionCoreDataObject setValue:section[kManpowerFilterSectionName] forKey:@"name"];
            }
        }
        [tempSections addObject:sectionCoreDataObject];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    } // end section loop
    
    return tempSections;
}

-(NSMutableSet*)findOrCreateDepartmentsSetWithInputJson:(NSDictionary*)departments {
    NSMutableSet *tempDepartments = [NSMutableSet set];
    
    for (NSDictionary *department in departments) {
        NSMutableSet *tempSections = [NSMutableSet set];
        
        NSDictionary *sections = department[kManpowerFilterSectionsRootKey];
        tempSections = [self findOrCreateSectionsSetWithInputJson:sections];
        NSArray *fetchedDepartmentObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGDepartment class]) withID:department[kManpowerFilterDepartmentKey] context:_managedObjectContext];
        ETGDepartment *departmentCoreDataObject;
        if ([fetchedDepartmentObjects count] > 0)
        {
            departmentCoreDataObject = [fetchedDepartmentObjects objectAtIndex:0];
            [departmentCoreDataObject setValue:department[kManpowerFilterDepartmentName] forKey:@"name"];
        }
        else
        {
            departmentCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGDepartment class]) inManagedObjectContext:_managedObjectContext];
            [departmentCoreDataObject setValue:department[kManpowerFilterDepartmentKey] forKey:@"key"];
            if ([CommonMethods validateStringValue:department[kManpowerFilterDepartmentName]])
            {
                [departmentCoreDataObject setValue:department[kManpowerFilterDepartmentName] forKey:@"name"];
            }
        }
        [departmentCoreDataObject addSections:tempSections];

        [tempDepartments addObject:departmentCoreDataObject];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        [tempSections removeAllObjects];
        
        
    } // end department loop
    
    return tempDepartments;
}

-(NSMutableSet*)findOrCreateSectionsSetWithInputDivisionJson:(NSDictionary*)divisions reportingPeriod:(NSDate*)reportingPeriod filterName:(NSString*)filterName {
    NSMutableSet *finalSections = [NSMutableSet set];
    
    for(NSDictionary *division in divisions) {
        NSDictionary *departments = division[kManpowerFilterDepartmentsRootKey];
        
        for (NSDictionary *department in departments) {
            NSMutableSet *tempSections = [NSMutableSet set];
            
            NSDictionary *sections = department[kManpowerFilterSectionsRootKey];
            tempSections = [self findOrCreateSectionsSetWithInputJson:sections];
            
            for (ETGSection *section in tempSections) {
                NSArray *fetchedSectionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGSection class]) withID:section.key context:_managedObjectContext];
                ETGSection *sectionCoreDataObject = [fetchedSectionObjects objectAtIndex:0];
                [finalSections addObject:sectionCoreDataObject];
            }
            
            //add to the database
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([ETGDepartmentSection class]) inManagedObjectContext:_managedObjectContext];
            [fetchRequest setEntity:entity];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@ AND reportingPeriod == %@ AND filterName == %@", department[kManpowerFilterDepartmentKey],reportingPeriod,filterName];
            [fetchRequest setPredicate:predicate];
            
            NSError *error = nil;
            NSArray *fetchedDepartmentSectionObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
            if (error != nil) {
                DDLogError(fetchError, error);
            }
            
            ETGDepartmentSection *departmentSectionCoreDataObject;
            if ([fetchedDepartmentSectionObjects count] > 0)
            {
                departmentSectionCoreDataObject = [fetchedDepartmentSectionObjects objectAtIndex:0];
            }
            else
            {
                departmentSectionCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGDepartmentSection class]) inManagedObjectContext:_managedObjectContext];
                [departmentSectionCoreDataObject setValue:department[kManpowerFilterDepartmentKey] forKey:@"key"];
                [departmentSectionCoreDataObject setValue:filterName forKey:@"filterName"];
                [departmentSectionCoreDataObject setValue:reportingPeriod forKey:@"reportingPeriod"];
                [departmentSectionCoreDataObject addSections:tempSections];
            }
            [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                if(error)
                {
                    DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                }
            }];

            [tempSections removeAllObjects];
            
        } // end section loop
        
    }
    
    return finalSections;
    
}

-(NSMutableSet*)findOrCreateDeparmentsSetWithInputDivisionJson:(NSDictionary*)divisions {
    NSMutableSet *finalDepartments = [NSMutableSet set];
    
    for (NSDictionary *division in divisions) {
        NSMutableSet *tempDepartments = [NSMutableSet set];
        
        NSDictionary *departments = division[kManpowerFilterDepartmentsRootKey];
        tempDepartments = [self findOrCreateDepartmentsSetWithInputJson:departments];
        
        for (ETGDepartment *department in tempDepartments) {
            NSArray *fetchedDepartmentObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGDepartment class]) withID:department.key context:_managedObjectContext];
            ETGDepartment *departmentCoreDataObject = [fetchedDepartmentObjects objectAtIndex:0];
            [finalDepartments addObject:departmentCoreDataObject];
        }
        
        
        //        [tempDepartments removeAllObjects];
        
    } // end division loop
    
    return finalDepartments;
    
}

-(NSMutableSet*)findOrCreateDivisionsSetWithInputJson:(NSDictionary*)divisions {
    NSMutableSet *tempDivisions = [NSMutableSet set];
    
    for (NSDictionary *division in divisions) {
        NSMutableSet *tempDepartments = [NSMutableSet set];
        
        NSDictionary *departments = division[kManpowerFilterDepartmentsRootKey];
        tempDepartments = [self findOrCreateDepartmentsSetWithInputJson:departments];
        
        NSArray *fetchedDivisionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGDivision class]) withID:division[kManpowerFilterDivisionKey] context:_managedObjectContext];
        ETGDivision *divisionCoreDataObject;
        if ([fetchedDivisionObjects count] > 0)
        {
            divisionCoreDataObject = [fetchedDivisionObjects objectAtIndex:0];
            [divisionCoreDataObject setValue:division[kManpowerFilterDivisionName] forKey:@"name"];
        }
        else
        {
            divisionCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGDivision class]) inManagedObjectContext:_managedObjectContext];
            [divisionCoreDataObject setValue:division[kManpowerFilterDivisionKey] forKey:@"key"];
            if ([CommonMethods validateStringValue:division[kManpowerFilterDivisionName]])
            {
                [divisionCoreDataObject setValue:division[kManpowerFilterDivisionName] forKey:@"name"];
            }
            [divisionCoreDataObject addDepartments:tempDepartments];
        }
        [tempDivisions addObject:divisionCoreDataObject];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        [tempDepartments removeAllObjects];
        
    } // end division loop
    
    return tempDivisions;
}

-(NSMutableSet *)findOrCreateProjectPositionsSetWithProjectJson:(NSDictionary*)projects
                                                reportingPeriod:(NSDate*)reportingPeriod
                                                     filterName:(NSString*)filterName{
    
    NSMutableSet *finalProjectPositions = [NSMutableSet set];
    
    for (NSDictionary *project in projects) {
        NSMutableSet *tempProjectPosition = [NSMutableSet set];
        
        NSDictionary *projectPositions = project[kManpowerFilterProjectPositionRootKey];
        tempProjectPosition = [self findOrCreateProjectPositionsSetWithInputJson:projectPositions];
        
        for (ETGProjectPosition *projectPosition in tempProjectPosition) {
            NSArray *fetchedProjectPositionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGProjectPosition class]) withID:projectPosition.key context:_managedObjectContext];
            
            ETGProjectPosition *projectPositionCoreDataObject = [fetchedProjectPositionObjects objectAtIndex:0];
            [finalProjectPositions addObject:projectPositionCoreDataObject];
        }
        
        //add to the database
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([ETGProject_ProjPosition class]) inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@ AND reportingPeriod == %@ AND filterName == %@", project[kManpowerFilterProjectKey],reportingPeriod,filterName];
        [fetchRequest setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *fetchedProject_ProjPositionObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        if (error != nil) {
            DDLogError(fetchError, error);
        }
        
        ETGProject_ProjPosition *project_ProjPositionCoreDataObject;
        if ([fetchedProject_ProjPositionObjects count] > 0)
        {
            project_ProjPositionCoreDataObject = [fetchedProject_ProjPositionObjects objectAtIndex:0];
        }
        else
        {
            project_ProjPositionCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGProject_ProjPosition class]) inManagedObjectContext:_managedObjectContext];
            [project_ProjPositionCoreDataObject setValue:project[kManpowerFilterProjectKey] forKey:@"key"];
            [project_ProjPositionCoreDataObject setValue:filterName forKey:@"filterName"];
            [project_ProjPositionCoreDataObject setValue:reportingPeriod forKey:@"reportingPeriod"];
            [project_ProjPositionCoreDataObject addProjectPositions:tempProjectPosition];
        }
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        
        [tempProjectPosition removeAllObjects];
        
    } // end section loop
    
    
    
    return finalProjectPositions;
    
    
}

-(NSMutableSet *)findOrCreateProjectPositionsSetWithRegionJson:(NSDictionary*)regions
                                               reportingPeriod:(NSDate*)reportingPeriod
                                                    filterName:(NSString*)filterName{
    
    NSMutableSet *finalProjectPositions = [NSMutableSet set];
    
    for(NSDictionary *region in regions) {
        NSDictionary *clusters = region[kManpowerFilterClustersRootKey];
        
        for (NSDictionary *cluster in clusters) {
            NSMutableSet *tempProjectPosition = [NSMutableSet set];
            
            NSDictionary *projectPositions = cluster[kManpowerFilterProjectPositionRootKey];
            tempProjectPosition = [self findOrCreateProjectPositionsSetWithInputJson:projectPositions];
            //NSLog(@"Temp ProjectPosition: %@",tempProjectPosition);
            for (ETGProjectPosition *projectPosition in tempProjectPosition) {
                NSArray *fetchedProjectPositionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGProjectPosition class]) withID:projectPosition.key context:_managedObjectContext];
                
                ETGProjectPosition *projectPositionCoreDataObject = [fetchedProjectPositionObjects objectAtIndex:0];
                [finalProjectPositions addObject:projectPositionCoreDataObject];
            }
            
            //add to the database
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([ETGCluster_ProjPosition class]) inManagedObjectContext:_managedObjectContext];
            [fetchRequest setEntity:entity];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@ AND reportingPeriod == %@ AND filterName == %@", cluster[kManpowerFilterClusterKey],reportingPeriod,filterName];
            [fetchRequest setPredicate:predicate];
            
            NSError *error = nil;
            NSArray *fetchedCluster_ProjPositionObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
            if (error != nil) {
                DDLogError(fetchError, error);
            }
            
            ETGCluster_ProjPosition *cluster_ProjPositionCoreDataObject;
            if ([fetchedCluster_ProjPositionObjects count] > 0)
            {
                cluster_ProjPositionCoreDataObject = [fetchedCluster_ProjPositionObjects objectAtIndex:0];
            }
            else
            {
                cluster_ProjPositionCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGCluster_ProjPosition class]) inManagedObjectContext:_managedObjectContext];
                [cluster_ProjPositionCoreDataObject setValue:cluster[kManpowerFilterClusterKey] forKey:@"key"];
                [cluster_ProjPositionCoreDataObject setValue:filterName forKey:@"filterName"];
                [cluster_ProjPositionCoreDataObject setValue:reportingPeriod forKey:@"reportingPeriod"];
                [cluster_ProjPositionCoreDataObject addProjectPositions:tempProjectPosition];
            }
            [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                if(error)
                {
                    DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                }
            }];
            
            [tempProjectPosition removeAllObjects];

            
        }
        
    }
    
    return finalProjectPositions;
    
    
}

-(NSMutableSet *)findOrCreateProjectPositionsSetWithInputJson:(NSDictionary*)projectPositions {
    NSMutableSet *tempProjectPositions = [NSMutableSet set];
    
    for (NSDictionary *projectPosition in projectPositions) {
        NSArray *fetchedProjectPositionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGProjectPosition class]) withID:projectPosition[kManpowerFilterProjectPositionKey] context:_managedObjectContext];
        ETGProjectPosition *projectPositionCoreDataObject;
        
        if ([fetchedProjectPositionObjects count] > 0)
        {
            projectPositionCoreDataObject = [fetchedProjectPositionObjects objectAtIndex:0];
            [projectPositionCoreDataObject setValue:projectPosition[kManpowerFilterProjectPositionName] forKey:@"name"];
        }
        else
        {
            projectPositionCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGProjectPosition class]) inManagedObjectContext:_managedObjectContext];
            [projectPositionCoreDataObject setValue:projectPosition[kManpowerFilterProjectPositionKey] forKey:@"key"];
            if ([CommonMethods validateStringValue:projectPosition[kManpowerFilterProjectPositionName]])
            {
                [projectPositionCoreDataObject setValue:projectPosition[kManpowerFilterProjectPositionName] forKey:@"name"];
            }
        }
        [tempProjectPositions addObject:projectPositionCoreDataObject];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    } // end section loop
    
    return tempProjectPositions;
    
}

-(NSMutableSet *)findOrCreateProjectsSetWithInputJson:(NSDictionary*)projects {
    NSMutableSet *tempProjects = [NSMutableSet set];
    
    for (NSDictionary *project in projects) {
        NSMutableSet *tempProjectPositions = [NSMutableSet set];
        
        NSDictionary *projectPositions = project[kManpowerFilterProjectPositionRootKey];
        tempProjectPositions = [self findOrCreateProjectPositionsSetWithInputJson:projectPositions];
        
        NSArray *fetchedProjectObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpProject class]) withID:project[kManpowerFilterProjectKey] context:_managedObjectContext];
        ETGMpProject *projectCoreDataObject;
        if ([fetchedProjectObjects count] > 0)
        {
            projectCoreDataObject = [fetchedProjectObjects objectAtIndex:0];
            [projectCoreDataObject setValue:project[kManpowerFilterProjectName] forKey:@"name"];
        }
        else
        {
            projectCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGMpProject class]) inManagedObjectContext:_managedObjectContext];
            [projectCoreDataObject setValue:project[kManpowerFilterProjectKey] forKey:@"key"];
            if ([CommonMethods validateStringValue:project[kManpowerFilterProjectName]])
            {
                [projectCoreDataObject setValue:project[kManpowerFilterProjectName] forKey:@"name"];
            }
            
            NSArray *fetchedClusterObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpCluster class]) withID:project[kManpowerFilterClusterKey] context:_managedObjectContext];
            ETGMpCluster *clusterCoreDataObject;
            if ([fetchedClusterObjects count] > 0)
            {
                clusterCoreDataObject = [fetchedClusterObjects objectAtIndex:0];
                [projectCoreDataObject setCluster:clusterCoreDataObject];
            }
            
            NSArray *fetchedRegionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpRegion class]) withID:project[kManpowerFilterRegionKey] context:_managedObjectContext];
            ETGMpRegion *regionCoreDataObject;
            if ([fetchedRegionObjects count] > 0)
            {
                regionCoreDataObject = [fetchedRegionObjects objectAtIndex:0];
                [projectCoreDataObject setRegion:regionCoreDataObject];
            }
            //            [projectCoreDataObject]
            [projectCoreDataObject addProjectPositions:tempProjectPositions];
        }
        [tempProjects addObject:projectCoreDataObject];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        [tempProjectPositions removeAllObjects];
        
    } // end cluster loop
    
    return tempProjects;
}

-(NSMutableSet *)findOrCreateClustersSetWithCountriesJson:(NSDictionary*)countries {
    
    NSMutableSet *finalClusters = [NSMutableSet set];
    
    for(NSDictionary *country in countries) {
        
        NSDictionary *regions = country[kManpowerFilterRegionsRootKey];
        
        for (NSDictionary *region in regions) {
            NSMutableSet *tempClusters = [NSMutableSet set];
            
            NSDictionary *clusters = region[kManpowerFilterClustersRootKey];
            tempClusters = [self findOrCreateClustersSetWithInputJson:clusters];
            
            for (ETGMpCluster *cluster in tempClusters) {
                NSArray *fetchedClusterObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpCluster class]) withID:cluster.key context:_managedObjectContext];
                ETGMpCluster *clusterCoreDataObject = [fetchedClusterObjects objectAtIndex:0];
                [finalClusters addObject:clusterCoreDataObject];
            }
            
            NSArray *fetchedRegionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpRegion class]) withID:region[@"regionKey"] context:_managedObjectContext];
            ETGMpRegion *regionCoreDataObject = [fetchedRegionObjects objectAtIndex:0];
            [regionCoreDataObject addClusters:tempClusters];            
        } // end region loop
    }
    return finalClusters;
    
}


-(NSMutableSet *)findOrCreateClustersSetWithRegionJson:(NSDictionary*)regions {
    NSMutableSet *finalClusters = [NSMutableSet set];
    
    for (NSDictionary *region in regions) {
        NSMutableSet *tempClusters = [NSMutableSet set];
        
        NSDictionary *clusters = region[kManpowerFilterClustersRootKey];
        tempClusters = [self findOrCreateClustersSetWithInputJson:clusters];
        
        for (ETGMpCluster *cluster in tempClusters) {
            NSArray *fetchedClusterObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpCluster class]) withID:cluster.key context:_managedObjectContext];
            ETGMpCluster *clusterCoreDataObject = [fetchedClusterObjects objectAtIndex:0];
            [finalClusters addObject:clusterCoreDataObject];
        }
        
    } // end region loop
    
    return finalClusters;
    
}
-(NSMutableSet *)findOrCreateClustersSetWithInputJson:(NSDictionary*)clusters {
    NSMutableSet *tempClusters = [NSMutableSet set];
    
    for (NSDictionary *cluster in clusters) {
        NSMutableSet *tempProjectPositions = [NSMutableSet set];
        
        NSDictionary *projectPositions = cluster[kManpowerFilterProjectPositionRootKey];
        tempProjectPositions = [self findOrCreateProjectPositionsSetWithInputJson:projectPositions];
        
        NSArray *fetchedClusterObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpCluster class]) withID:cluster[kManpowerFilterClusterKey] context:_managedObjectContext];
        ETGMpCluster *clusterCoreDataObject;
        if ([fetchedClusterObjects count] > 0)
        {
            clusterCoreDataObject = [fetchedClusterObjects objectAtIndex:0];
            [clusterCoreDataObject setValue:cluster[kManpowerFilterClusterName] forKey:@"name"];
        }
        else
        {
            clusterCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGMpCluster class]) inManagedObjectContext:_managedObjectContext];
            [clusterCoreDataObject setValue:cluster[kManpowerFilterClusterKey] forKey:@"key"];
            if ([CommonMethods validateStringValue:cluster[kManpowerFilterClusterName]])
            {
                [clusterCoreDataObject setValue:cluster[kManpowerFilterClusterName] forKey:@"name"];
            }
            [clusterCoreDataObject addProjectPositions:tempProjectPositions];
        }
        [tempClusters addObject:clusterCoreDataObject];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        [tempProjectPositions removeAllObjects];
        
    } // end cluster loop
    
    return tempClusters;
}

-(NSMutableSet *)LRfindOrCreateClustersSetWithInputJson:(NSDictionary*)clusters {
    NSMutableSet *tempClusters = [NSMutableSet set];
    
    for (NSDictionary *cluster in clusters) {
        //        NSMutableSet *tempProjectPositions = [NSMutableSet set];
        //
        //        NSDictionary *projectPositions = cluster[kManpowerFilterProjectPositionRootKey];
        //        tempProjectPositions = [self findOrCreateProjectPositionsSetWithInputJson:projectPositions];
        
        NSArray *fetchedClusterObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpCluster class]) withID:cluster[kManpowerFilterClusterKey] context:_managedObjectContext];
        ETGMpCluster *clusterCoreDataObject;
        if ([fetchedClusterObjects count] > 0)
        {
            clusterCoreDataObject = [fetchedClusterObjects objectAtIndex:0];
            [clusterCoreDataObject setValue:cluster[kManpowerFilterClusterName] forKey:@"name"];
        }
        else
        {
            clusterCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGMpCluster class]) inManagedObjectContext:_managedObjectContext];
            [clusterCoreDataObject setValue:cluster[kManpowerFilterClusterKey] forKey:@"key"];
            if ([CommonMethods validateStringValue:cluster[kManpowerFilterClusterName]])
            {
                [clusterCoreDataObject setValue:cluster[kManpowerFilterClusterName] forKey:@"name"];
            }
            //            [clusterCoreDataObject addProjectPositions:tempProjectPositions];
        }
        [tempClusters addObject:clusterCoreDataObject];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        //        [tempProjectPositions removeAllObjects];
        
    } // end cluster loop
    
    return tempClusters;
}

-(NSMutableSet *)findOrCreateRegionsSetWithCountriesJson:(NSDictionary*)countries {
    NSMutableSet *finalRegions = [NSMutableSet set];
    
    for (NSDictionary *country in countries) {
        NSMutableSet *tempRegion = [NSMutableSet set];
        
        NSDictionary *regions = country[kManpowerFilterRegionsRootKey];
        tempRegion = [self findOrCreateRegionsSetWithInputJson:regions];
        
        for (ETGMpRegion *region in tempRegion) {
            NSArray *fetchedRegionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpRegion class]) withID:region.key context:_managedObjectContext];
            
            ETGMpRegion *regionCoreDataObject = [fetchedRegionObjects objectAtIndex:0];
            [finalRegions addObject:regionCoreDataObject];
        }
        
        
        //        [tempDepartments removeAllObjects];
        
    } // end section loop
    
    
    
    return finalRegions;
    
}

-(NSMutableSet *)findOrCreateRegionsSetWithInputJson:(NSDictionary*)regions {
    
    NSMutableSet *tempRegions = [NSMutableSet set];
    
    for (NSDictionary *region in regions) {
        NSMutableSet *tempClusters = [NSMutableSet set];
        
        
        NSArray *fetchedRegionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpRegion class]) withID:region[kManpowerFilterRegionKey] context:_managedObjectContext];
        ETGMpRegion *regionCoreDataObject;
        if ([fetchedRegionObjects count] > 0)
        {
            regionCoreDataObject = [fetchedRegionObjects objectAtIndex:0];
            [regionCoreDataObject setValue:region[kManpowerFilterRegionName] forKey:@"name"];
        }
        else
        {
            regionCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGMpRegion class]) inManagedObjectContext:_managedObjectContext];
            [regionCoreDataObject setValue:region[kManpowerFilterRegionKey] forKey:@"key"];
            if ([CommonMethods validateStringValue:region[kManpowerFilterRegionName]])
            {
                [regionCoreDataObject setValue:region[kManpowerFilterRegionName] forKey:@"name"];
            }
            [regionCoreDataObject addClusters:tempClusters];
            
        }
        //        //add cluster
        //        NSMutableSet *finalClusters = [NSMutableSet set];
        //        for (ETGCluster *clusterTemp in tempClusters) {
        //            for (ETGCluster *clusterRegion in regionCoreDataObject.clusters) {
        //                if (![clusterTemp.key isEqualToNumber:clusterRegion.key]) {
        //                    [finalClusters addObject:clusterTemp];
        //                }
        //            }
        //        }
        [regionCoreDataObject addClusters:tempClusters];
        
        [tempRegions addObject:regionCoreDataObject];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        [tempClusters removeAllObjects];
        
    } // end region loop
    
    return tempRegions;
}


-(NSMutableSet *)findOrCreateRegionsSetWithInputJson:(NSDictionary*)regions isLRFilter:(BOOL)isLrFilter {
    NSMutableSet *tempRegions = [NSMutableSet set];
    
    for (NSDictionary *region in regions) {
        NSMutableSet *tempClusters = [NSMutableSet set];
        
        NSDictionary *clusters = region[kManpowerFilterClustersRootKey];
        
        //Get cluster for LR Filter
        if (isLrFilter) {
            tempClusters = [self LRfindOrCreateClustersSetWithInputJson:clusters];
        }
        else {
            tempClusters = [self findOrCreateClustersSetWithInputJson:clusters];
        }
        
        NSArray *fetchedRegionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGMpRegion class]) withID:region[kManpowerFilterRegionKey] context:_managedObjectContext];
        ETGMpRegion *regionCoreDataObject;
        if ([fetchedRegionObjects count] > 0)
        {
            regionCoreDataObject = [fetchedRegionObjects objectAtIndex:0];
            [regionCoreDataObject setValue:region[kManpowerFilterRegionName] forKey:@"name"];
        }
        else
        {
            regionCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGMpRegion class]) inManagedObjectContext:_managedObjectContext];
            [regionCoreDataObject setValue:region[kManpowerFilterRegionKey] forKey:@"key"];
            if ([CommonMethods validateStringValue:region[kManpowerFilterRegionName]])
            {
                [regionCoreDataObject setValue:region[kManpowerFilterRegionName] forKey:@"name"];
            }
            //            [regionCoreDataObject addClusters:tempClusters];
        }
        //        //add cluster
        //        NSMutableSet *finalClusters = [NSMutableSet set];
        //        for (ETGCluster *clusterTemp in tempClusters) {
        //            for (ETGCluster *clusterRegion in regionCoreDataObject.clusters) {
        //                if (![clusterTemp.key isEqualToNumber:clusterRegion.key]) {
        //                    [finalClusters addObject:clusterTemp];
        //                }
        //            }
        //        }
        [regionCoreDataObject addClusters:tempClusters];
        
        [tempRegions addObject:regionCoreDataObject];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        [tempClusters removeAllObjects];
        
    } // end region loop
    
    return tempRegions;
}

-(NSMutableSet *)findOrCreateCountriesSetWithInputJson:(NSDictionary*)countries {
    NSMutableSet *tempCountries = [NSMutableSet set];
    
    for (NSDictionary *country in countries) {
        NSMutableSet *tempRegions = [NSMutableSet set];
        
        NSDictionary *regions = country[kManpowerFilterRegionsRootKey];
        tempRegions = [self findOrCreateRegionsSetWithInputJson:regions isLRFilter:YES];
        
        NSArray *fetchedCountryObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGCountries class]) withID:country[kManpowerFilterCountryKey] context:_managedObjectContext];
        ETGCountries *countryCoreDataObject;
        if ([fetchedCountryObjects count] > 0)
        {
            countryCoreDataObject = [fetchedCountryObjects objectAtIndex:0];
            [countryCoreDataObject setValue:country[kManpowerFilterCountryName] forKey:@"name"];
        }
        else
        {
            countryCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGCountries class]) inManagedObjectContext:_managedObjectContext];
            [countryCoreDataObject setValue:country[kManpowerFilterCountryKey] forKey:@"key"];
            if ([CommonMethods validateStringValue:country[kManpowerFilterCountryName]])
            {
                [countryCoreDataObject setValue:country[kManpowerFilterCountryName] forKey:@"name"];
            }
            [countryCoreDataObject addRegions:tempRegions];
        }
        [tempCountries addObject:countryCoreDataObject];
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
        [tempRegions removeAllObjects];
        
    } // end region loop
    
    return tempCountries;
}

-(NSArray *)fetchYearsBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
    ETGReportingPeriod *reportingPeriod = [ETGReportingPeriod findFirstWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    //    for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
    //    {
    //        [temp addObjectsFromArray:[reportingPeriod.years allObjects]];
    //        NSLog(@"Year count %d reportingPeriod %@",[temp count],reportingPeriodDate);
    //    }
    if (reportingPeriod != nil)
    {
        [temp addObjectsFromArray:[reportingPeriod.years allObjects]];
    }
    
    NSArray *years = temp;
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    years= [years sortedArrayUsingDescriptors:@[sorter]];
    
    
    return years;
    
}

-(NSArray *)fetchDivisionsBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
    NSArray *reportingPeriods = [ETGReportingPeriod findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    if ([reportingPeriods count] >0) {
        
        
        for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
        {
            [temp addObjectsFromArray:[reportingPeriod.divisions allObjects]];
            
        }
    }
    
    return temp;
    
}

-(NSArray *)fetchDepartmentsBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
    NSArray *reportingPeriods = [ETGReportingPeriod findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    if ([reportingPeriods count] >0) {
        
        
        for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
        {
            [temp addObjectsFromArray:[reportingPeriod.departments allObjects]];
            
        }
    }
    NSArray *departments = temp;
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    departments= [departments sortedArrayUsingDescriptors:@[sorter]];
    
    
    return departments;
}


-(NSArray *)fetchRegionsBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
    NSArray *reportingPeriods = [ETGReportingPeriod findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    if ([reportingPeriods count] >0) {
        
        
        for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
        {
            [temp addObjectsFromArray:[reportingPeriod.regions allObjects]];
            
        }
    }
    NSArray *regions = temp;
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    regions= [regions sortedArrayUsingDescriptors:@[sorter]];
    
    return regions;
    
}

-(NSArray *)fetchCountriesBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
    NSArray *reportingPeriods = [ETGReportingPeriod findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    if ([reportingPeriods count] >0) {
        
        
        for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
        {
            [temp addObjectsFromArray:[reportingPeriod.countries allObjects]];
            
        }
    }
    
    return temp;
    
}

-(NSArray *)fetchProjectsBasedOnReportingPeriod:(NSDate*)reportingPeriodDate andFilterName:(NSString*)filterName {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
    NSArray *reportingPeriods = [ETGReportingPeriod findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    if ([reportingPeriods count] >0) {
        
        
        for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
        {
            [temp addObjectsFromArray:[reportingPeriod.projects allObjects]];
            
        }
    }
    
    NSArray *projects = temp;
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    projects= [projects sortedArrayUsingDescriptors:@[sorter]];
    
    return projects;
}

-(NSArray *)fetchProjectBasedOnClusters:(NSArray*)clusterKeys
                                regions:(NSArray *)regionKeys
                        reportingPeriod:(NSDate*)reportingPeriodDate
                          andFilterName:(NSString*)filterName {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@", clusterKeys];
    NSArray *clusters = [ETGMpCluster findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    NSMutableArray *finalProjects = [NSMutableArray new];
    for(ETGMpCluster *cluster in clusters)
    {
        [temp addObjectsFromArray:[cluster.projects allObjects]];
    }
    NSPredicate *predicateReportingPeriod = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
    NSArray *reportingPeriods = [ETGReportingPeriod findAllWithPredicate:predicateReportingPeriod];
    
    NSMutableArray *tempProjects = [NSMutableArray new];
    if ([reportingPeriods count] >0) {
        
        
        for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
        {
            [tempProjects addObjectsFromArray:[reportingPeriod.projects allObjects]];
            
        }
    }
    
    
    for (ETGMpProject *ProjectReportingPeriod in tempProjects) {
        for (ETGMpProject *ProjectCluster in temp) {
            if ([ProjectCluster.key isEqualToNumber:ProjectReportingPeriod.key]) {
                if([regionKeys containsObject:ProjectCluster.region.key])
                {
                    [finalProjects addObject:ProjectCluster];
                    break;
                }
            }
        }
    }
    
    NSArray *projects = finalProjects;
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    projects= [projects sortedArrayUsingDescriptors:@[sorter]];
    
    NSMutableArray *uniqueProjects = [NSMutableArray array];
    
    for (id obj in projects) {
        if (![uniqueProjects containsObject:obj]) {
            [uniqueProjects addObject:obj];
        }
    }
    
    return uniqueProjects;
    
}

-(NSArray *)fetchDepartmentBasedOnDivisions:(NSArray*)divisionKeys{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@", divisionKeys];
    NSArray *divisions = [ETGDivision findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    for(ETGDivision *division in divisions)
    {
        [temp addObjectsFromArray:[division.departments allObjects]];
    }
    
    NSArray *departments = temp;
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    departments= [departments sortedArrayUsingDescriptors:@[sorter]];
    
    
    return departments;
    
}


-(NSArray *)fetchSectionsBasedOnDepartments:(NSArray*)departmentKeys
                            reportingPeriod:(NSDate*)reportingPeriodDate
                              andFilterName:(NSString*)filterName{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@ AND reportingPeriod == %@ AND filterName == %@", departmentKeys,reportingPeriodDate,filterName];
    NSArray *departments = [ETGDepartmentSection findAllWithPredicate:predicate];
    
//    NSMutableArray *temp = [NSMutableArray new];
//    NSArray *temp = [NSArray new];

    NSMutableArray *temporary = [NSMutableArray new];
//    NSMutableArray *finalSections = [NSMutableArray new];
    for(ETGDepartmentSection *department in departments)
    {
        [temporary addObjectsFromArray:[department.sections allObjects]];
    }
//    for(ETGSection *sec in temporary) {
//        NSLog(@"section Name: %@",sec.name);
//    }
////    %@ IN reportingMonths.name
//    NSPredicate *predicateSelected = [NSPredicate predicateWithFormat:@"(SUBQUERY(reportingPeriods, $report, $report.date == %@).@count != 0) AND (SUBQUERY(reportingPeriods, $report, $report.filterName == %@).@count != 0) AND (SUBQUERY(department, $depart, $depart.key IN %@).@count != 0) ", reportingPeriodDate,filterName,departmentKeys];
////        NSPredicate *predicateSelected = [NSPredicate predicateWithFormat:@"ANY %@ IN department.key AND (SUBQUERY(reportingPeriods, $report, ANY $report.date == %@).@count != 0) AND (SUBQUERY(reportingPeriods, $report, ANY $report.filterName == %@).@count != 0) ",departmentKeys, reportingPeriodDate,filterName];
//
//    temp = [ETGSection findAllWithPredicate:predicateSelected];
////
//    for(ETGSection *sect in temp) {
//        NSLog(@"sectionName: %@",sect.name);
//    }
//    NSPredicate *predicateReportingPeriod = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
//    NSArray *reportingPeriods = [ETGReportingPeriod findAllWithPredicate:predicateReportingPeriod];
//    
//    NSMutableArray *tempSection = [NSMutableArray new];
//    if ([reportingPeriods count] >0) {
//        
//        
//        for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
//        {
//            [tempSection addObjectsFromArray:[reportingPeriod.sections allObjects]];
//            
//        }
//    }
//    
//    for (ETGSection *SectionDepartment in temp) {
//
//    for (ETGSection *SectionReportingPeriod in tempSection) {
//            if ([SectionDepartment.key isEqualToNumber:SectionReportingPeriod.key]) {
//                [finalSections addObject:SectionReportingPeriod];
//                break;
//            }
//        }
//    }
    
//    NSPredicate *predicateSelected = [NSPredicate predicateWithFormat:@"reportingPeriods.date == %@ AND reportingPeriods.filterName == %@ AND department.key IN %@",reportingPeriodDate,filterName];
    
    NSArray *sections = temporary;
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    sections= [sections sortedArrayUsingDescriptors:@[sorter]];
    
    NSMutableArray *uniqueSections = [NSMutableArray array];
    
    for (id obj in sections) {
        if (![uniqueSections containsObject:obj]) {
            [uniqueSections addObject:obj];
        }
    }
    
    return uniqueSections;
    
}

-(NSArray *)fetchProjectPositionsBasedOnClusters:(NSArray*)clusterKeys
                                 reportingPeriod:(NSDate*)reportingPeriodDate
                                   andFilterName:(NSString*)filterName {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@ AND reportingPeriod == %@ AND filterName == %@", clusterKeys,reportingPeriodDate,filterName];
    NSArray *clusters = [ETGCluster_ProjPosition findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
//    NSMutableArray *finalProjectPositions = [NSMutableArray new];
    
    for(ETGCluster_ProjPosition *cluster in clusters)
    {
        [temp addObjectsFromArray:[cluster.projectPositions allObjects]];
    }
    
//    NSPredicate *predicateReportingPeriod = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
//    NSArray *reportingPeriods = [ETGReportingPeriod findAllWithPredicate:predicateReportingPeriod];
//    
//    NSMutableArray *tempProjectPositions = [NSMutableArray new];
//    if ([reportingPeriods count] >0) {
//        
//        
//        for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
//        {
//            [tempProjectPositions addObjectsFromArray:[reportingPeriod.projectPositions allObjects]];
//            
//        }
//    }
//    
//    
//    for (ETGProjectPosition *projectPosition in temp) {
//        for (ETGProjectPosition *projectPositionReportingPeriod in tempProjectPositions) {
//            if ([projectPosition.key isEqualToNumber:projectPositionReportingPeriod.key]) {
//                [finalProjectPositions addObject:projectPosition];
//                break;
//            }
//        }
//    }
    
    
    NSArray *projectPositions = temp;
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    projectPositions= [projectPositions sortedArrayUsingDescriptors:@[sorter]];
    
    NSMutableArray *uniqueProjectPositions = [NSMutableArray array];
    
    for (id obj in projectPositions) {
        if (![uniqueProjectPositions containsObject:obj]) {
            [uniqueProjectPositions addObject:obj];
        }
    }
    
    return uniqueProjectPositions;
    
}

-(NSArray *)fetchProjectPositionsBasedOnProjects:(NSArray*)projectKeys
                                 reportingPeriod:(NSDate*)reportingPeriodDate
                                   andFilterName:(NSString*)filterName
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@ AND reportingPeriod == %@ AND filterName == %@", projectKeys,reportingPeriodDate,filterName];
    NSArray *projects = [ETGProject_ProjPosition findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
//    NSMutableArray *finalProjectPositions = [NSMutableArray new];
    
    for(ETGProject_ProjPosition *project in projects)
    {
        [temp addObjectsFromArray:[project.projectPositions allObjects]];
    }
    
//    NSPredicate *predicateReportingPeriod = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
//    NSArray *reportingPeriods = [ETGReportingPeriod findAllWithPredicate:predicateReportingPeriod];
//    
//    NSMutableArray *tempProjectPositions = [NSMutableArray new];
//    if ([reportingPeriods count] >0) {
//        
//        
//        for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
//        {
//            [tempProjectPositions addObjectsFromArray:[reportingPeriod.projectPositions allObjects]];
//            
//        }
//    }
//    
//    
//    for (ETGProjectPosition *projectPosition in temp) {
//        for (ETGProjectPosition *projectPositionReportingPeriod in tempProjectPositions) {
//            if ([projectPosition.key isEqualToNumber:projectPositionReportingPeriod.key]) {
//                [finalProjectPositions addObject:projectPosition];
//                break;
//            }
//        }
//    }
    
    
    NSArray *projectPositions = temp;
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    projectPositions= [projectPositions sortedArrayUsingDescriptors:@[sorter]];
    
    NSMutableArray *uniqueProjectPositions = [NSMutableArray array];
    
    for (id obj in projectPositions) {
        if (![uniqueProjectPositions containsObject:obj]) {
            [uniqueProjectPositions addObject:obj];
        }
    }
    
    return uniqueProjectPositions;
}


-(NSArray *)fetchClustersBasedOnRegions:(NSArray *)regionKeys
                        reportingPeriod:(NSDate*)reportingPeriodDate
                          andFilterName:(NSString*)filterName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@", regionKeys];
    NSArray *regions = [ETGMpRegion findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    NSMutableArray *finalClusters = [NSMutableArray new];
    for(ETGMpRegion *region in regions)
    {
        [temp addObjectsFromArray:[region.clusters allObjects]];
    }
    
    
    NSPredicate *predicateReportingPeriod = [NSPredicate predicateWithFormat:@"date == %@ AND filterName == %@", reportingPeriodDate,filterName];
    NSArray *reportingPeriods = [ETGReportingPeriod findAllWithPredicate:predicateReportingPeriod];
    
    NSMutableArray *tempClusters = [NSMutableArray new];
    if ([reportingPeriods count] >0) {
        
        
        for(ETGReportingPeriod *reportingPeriod in reportingPeriods)
        {
            [tempClusters addObjectsFromArray:[reportingPeriod.clusters allObjects]];
            
        }
    }
    
    
    for (ETGMpCluster *cluster in temp) {
        for (ETGMpCluster *clusterReportingPeriod in tempClusters) {
            if ([cluster.key isEqualToNumber:clusterReportingPeriod.key]) {
                [finalClusters addObject:cluster];
                break;
            }
        }
    }
    
    
    NSArray *clusters = finalClusters;
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    clusters= [clusters sortedArrayUsingDescriptors:@[sorter]];
    
    NSMutableArray *uniqueClusters = [NSMutableArray array];
    
    for (id obj in clusters) {
        if (![uniqueClusters containsObject:obj]) {
            [uniqueClusters addObject:obj];
        }
    }
    
    return uniqueClusters;
}


- (void)saveMasterDataFilters:(id)json
{
    NSDictionary *filters = json[kMasterDataFilterRootKey];
    if(filters == (id)[NSNull null])
    {
        return;
    }
    for(NSDictionary *regionAndCluster in filters)
    {
        NSMutableSet *tempClusters = [NSMutableSet set];
        NSArray *clusters = regionAndCluster[kMasterDataFilterClustersKey];
        if(clusters != (id)[NSNull null])
        {
            for(NSDictionary *clusterJson in clusters)
            {
                NSString *clusterName = clusterJson[kMasterDataFilterClusterName];
                NSNumber *clusterKey = clusterJson[kMasterDataFilterClusterKey];
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %d", [clusterKey intValue]];
                ETGCluster *clusterCoreDataObject = [ETGCluster findFirstWithPredicate:predicate];
                if (clusterCoreDataObject != nil)
                {
                    [clusterCoreDataObject setValue:clusterName forKey:@"name"];
                }
                else
                {
                    clusterCoreDataObject = [ETGCluster insertInManagedObjectContext:_managedObjectContext];
                    [clusterCoreDataObject setValue:clusterKey forKey:@"key"];
                    if ([CommonMethods validateStringValue:clusterName])
                    {
                        [clusterCoreDataObject setValue:clusterName forKey:@"name"];
                    }
                }
                [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                    if(error)
                    {
                        DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                    }
                }];
                [tempClusters addObject:clusterCoreDataObject];
            }
        }
        NSString *region = regionAndCluster[kMasterDataFilterRegionName];
        NSNumber *regionKey = regionAndCluster[kMasterDataFilterRegionKey];
        
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"key == %d", [regionKey intValue]];
        ETGRegion *regionCoreDataObject = [ETGRegion findFirstWithPredicate:predicate2];
        if (regionCoreDataObject != nil)
        {
            [regionCoreDataObject setValue:region forKey:@"name"];
        }
        else
        {
            regionCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGRegion class]) inManagedObjectContext:_managedObjectContext];
            [regionCoreDataObject setValue:regionKey forKey:@"key"];
            if ([CommonMethods validateStringValue:region])
            {
                [regionCoreDataObject setValue:region forKey:@"name"];
            }
        }
        [regionCoreDataObject.clustersSet removeAllObjects];
        [regionCoreDataObject addClusters:tempClusters];        
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    }
}

- (void)getPllBaseFilters
{
    ETGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (appDelegate.isNetworkServerAvailable == YES)
    {
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPllService, ETG_PLL_BASE_FILTERS];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"GET"];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
             ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                 // Save it
                 [[ETGCoreDataUtilities sharedCoreDataUtilities] storeTimeStampInUserDefaults:@"PllBaseFilter"];
                 [self savePllBaseFilters:JSON];
                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForPllCompleted object:nil];
             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                 [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithUrlResponse:response error:error];
                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForPllFailed object:nil];
             }];
        operation.SSLPinningMode = AFSSLPinningModeCertificate;
        [operation start];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFilterDataForPllFailed object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadPllShouldAutoRefresh object:nil];
        DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
    }
}

-(void)upsertDataWithClassName:(Class)className keyName:(NSString *)keyName valueName:(NSString *)valueName inputJson:(NSDictionary *)resultsJson
{
    // Complexities
    for(NSDictionary *resultJson in resultsJson)
    {
        NSArray *fetchedObjects = [CommonMethods searchEntityForName:NSStringFromClass(className) withID:resultJson[keyName] context:_managedObjectContext];
        NSManagedObject *coreDataObject;
        if ([fetchedObjects count] > 0)
        {
            coreDataObject = [fetchedObjects objectAtIndex:0];
            [coreDataObject setValue:resultJson[valueName] forKey:@"name"];
        }
        else
        {
            coreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(className) inManagedObjectContext:_managedObjectContext];
            [coreDataObject setValue:resultJson[keyName] forKey:@"key"];
            if ([CommonMethods validateStringValue:resultJson[valueName]])
            {
                [coreDataObject setValue:resultJson[valueName] forKey:@"name"];
            }
        }
        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if(error)
            {
                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
            }
        }];
    }
}

- (void)savePllBaseFilters:(id)json
{
    NSDictionary *filters = json[kPllFilterRootKey];
    NSDictionary *pllFilters = json[kPllPllFiltersRootKey];
    
    for(NSString *key in filters)
    {
        if([key isEqualToString:kPllFilterComplexitiesRootKey])
        {
            [self upsertDataWithClassName:[ETGProjetComplexities class] keyName:kPllFilterComplexityKey valueName:kPllFilterComplexityName inputJson:filters[key]];
        }
        else if([key isEqualToString:kPllFilterCountriesRootKey])
        {
            NSDictionary *countries = filters[kPllFilterCountriesRootKey];
            for(NSDictionary *country in countries)
            {
                NSMutableSet *tempRegions = [NSMutableSet set];
                NSMutableSet *tempClusters = [NSMutableSet set];
                NSDictionary *regions = country[kPllFilterRegionsRootKey];
                for(NSDictionary *region in regions)
                {
                    NSDictionary *clusters = region[kPllFilterClustersRootKey];
                    for(NSDictionary *cluster in clusters)
                    {
                        NSArray *fetchedClusterObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGCluster class]) withID:cluster[kPllFilterClusterKey] context:_managedObjectContext];
                        ETGCluster *clusterCoreDataObject;
                        if ([fetchedClusterObjects count] > 0)
                        {
                            clusterCoreDataObject = [fetchedClusterObjects objectAtIndex:0];
                            [clusterCoreDataObject setValue:cluster[kPllFilterClusterName] forKey:@"name"];
                        }
                        else
                        {
                            clusterCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGCluster class]) inManagedObjectContext:_managedObjectContext];
                            [clusterCoreDataObject setValue:cluster[kPllFilterClusterKey] forKey:@"key"];
                            if ([CommonMethods validateStringValue:cluster[kPllFilterClusterName]])
                            {
                                [clusterCoreDataObject setValue:cluster[kPllFilterClusterName] forKey:@"name"];
                            }
                            [tempClusters addObject:clusterCoreDataObject];
                        }
                        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                            if(error)
                            {
                                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                            }
                        }];
                    }
                    
                    NSArray *fetchedRegionObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGRegion class]) withID:region[kPllFilterRegionKey] context:_managedObjectContext];
                    ETGRegion *regionCoreDataObject;
                    if ([fetchedRegionObjects count] > 0)
                    {
                        regionCoreDataObject = [fetchedRegionObjects objectAtIndex:0];
                        [regionCoreDataObject setValue:region[kPllFilterRegionName] forKey:@"name"];
                    }
                    else
                    {
                        regionCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGRegion class]) inManagedObjectContext:_managedObjectContext];
                        [regionCoreDataObject setValue:region[kPllFilterRegionKey] forKey:@"key"];
                        if ([CommonMethods validateStringValue:region[kPllFilterRegionName]])
                        {
                            [regionCoreDataObject setValue:region[kPllFilterRegionName] forKey:@"name"];
                        }
                        [regionCoreDataObject addClusters:tempClusters];
                    }
                    [tempRegions addObject:regionCoreDataObject];
                    [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                        if(error)
                        {
                            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                        }
                    }];
                    [tempClusters removeAllObjects];
                }
                NSArray *fetchedCountryObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGCountries class]) withID:country[kPllFilterCountryKey] context:_managedObjectContext];
                ETGCountries *countryCoreDataObject;
                if ([fetchedCountryObjects count] > 0)
                {
                    countryCoreDataObject = [fetchedCountryObjects objectAtIndex:0];
                    [countryCoreDataObject setValue:country[kPllFilterCountryName] forKey:@"name"];
                }
                else
                {
                    countryCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGCountries class]) inManagedObjectContext:_managedObjectContext];
                    [countryCoreDataObject setValue:country[kPllFilterCountryKey] forKey:@"key"];
                    if ([CommonMethods validateStringValue:country[kPllFilterCountryName]])
                    {
                        [countryCoreDataObject setValue:country[kPllFilterCountryName] forKey:@"name"];
                    }
                }
                [countryCoreDataObject addRegions:tempRegions];
                [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                    if(error)
                    {
                        DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                    }
                }];
                [tempRegions removeAllObjects];
            }
        }
        else if([key isEqualToString:kPllFilterNatureRootKey])
        {
            [self upsertDataWithClassName:[ETGProjectNatures class] keyName:kPllFilterNatureKey valueName:kPllFilterNatureName inputJson:filters[key]];
        }
        else if([key isEqualToString:kPllFilterTypesRootKey])
        {
            [self upsertDataWithClassName:[ETGProjectTypes class] keyName:kPllFilterTypeKey valueName:kPllFilterTypeName inputJson:filters[key]];
        }
    }
    
    // Now update project
    NSDictionary *projects = filters[kPllFilterProjectsRootKey];
    for(NSDictionary *project in projects)
    {
        if ([CommonMethods validateNumberValue:project[kPllFilterProjectKey]])
        {
            NSArray *fetchedObjects = [CommonMethods searchEntityForName:@"ETGProject" withID:project[kPllFilterProjectKey] context:_managedObjectContext];
            NSArray *fetchedClusters = [CommonMethods searchEntityForName:@"ETGCluster" withID:project[kPllFilterProjectClusterKey] context:_managedObjectContext];
            NSArray *fetchedComplexities = [CommonMethods searchEntityForName:@"ETGProjetComplexities" withID:project[kPllFilterProjectComplexityKey] context:_managedObjectContext];
            NSArray *fetchedNatures = [CommonMethods searchEntityForName:@"ETGProjectNatures" withID:project[kPllFilterProjectNatureKey] context:_managedObjectContext];
            NSArray *fetchedTypes = [CommonMethods searchEntityForName:@"ETGProjectTypes" withID:project[kPllFilterProjectTypeKey] context:_managedObjectContext];
            NSArray *fetchedRegions = [CommonMethods searchEntityForName:@"ETGRegion" withID:project[kPllFilterProjectRegionKey] context:_managedObjectContext];
            
            ETGProject *projectCoreData;
            
            if ([fetchedObjects count] > 0)
            {
                projectCoreData = [fetchedObjects objectAtIndex:0];
            }
            else
            {
                projectCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"ETGProject" inManagedObjectContext:_managedObjectContext];
                projectCoreData.key = project[kPllFilterProjectKey];
                if ([CommonMethods validateStringValue:project[kPllFilterProjectNameKey]])
                {
                    projectCoreData.name = project[kPllFilterProjectNameKey];
                }
            }
            
            if([fetchedClusters count] > 0)
            {
                projectCoreData.cluster = fetchedClusters[0];
            }
            if([fetchedComplexities count] > 0)
            {
                projectCoreData.complexities = fetchedComplexities[0];
            }
            if([fetchedNatures count] > 0)
            {
                projectCoreData.natures = fetchedNatures[0];
            }
            if([fetchedTypes count] > 0)
            {
                projectCoreData.types = fetchedTypes[0];
            }
            if([fetchedRegions count] > 0)
            {
                projectCoreData.region = fetchedRegions[0];
            }
        }
    }
    
    // Now update pll
    for(NSString *key in pllFilters)
    {
        if([key isEqualToString:kPllFilterImpactLevelsRootKey])
        {
            [self upsertDataWithClassName:[ETGPllImpactLevels class] keyName:kPllFilterImpactLevelKey valueName:kPllFilterImpactLevelName inputJson:pllFilters[key]];
        }
        else if([key isEqualToString:kPllFilterLessonRatingsRootKey])
        {
            [self upsertDataWithClassName:[ETGPllLessonRatings class] keyName:kPllFilterLessonRatingKey valueName:kPllFilterLessonRatingName inputJson:pllFilters[key]];
        }
        else if([key isEqualToString:kPllFilterLessonValuesRootKey])
        {
            [self upsertDataWithClassName:[ETGPllLessonValues class] keyName:kPllFilterLessonValueKey valueName:kPllFilterLessonValueName inputJson:pllFilters[key]];
        }
        else if([key isEqualToString:kPllFilterPllReviewsRootKey])
        {
            [self upsertDataWithClassName:[ETGPllReviews class] keyName:kPllFilterPllReviewKey valueName:kPllFilterPllReviewName inputJson:pllFilters[key]];
        }
        else if([key isEqualToString:kPllFilterPpmsActivityRootKey])
        {
            [self upsertDataWithClassName:[ETGPllPpmsActivity class] keyName:kPllFilterPpmsActiviyKey valueName:kPllFilterPpmsActivityName inputJson:pllFilters[key]];
        }
        else if([key isEqualToString:kPllFilterPraElementsRootKey])
        {
            [self upsertDataWithClassName:[ETGPllPraElements class] keyName:kPllFilterRiskCategoryKey valueName:kPllFilterRiskCategoryName inputJson:pllFilters[key]];
        }
        else if([key isEqualToString:kPllFilterAreasDisciplinesRootKey])
        {
            NSDictionary *areasDisciplines = pllFilters[key];
            for(NSDictionary *area in areasDisciplines)
            {
                NSArray *fetchedObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGPllAreasDisciplines class]) withID:area[kPllFilterAreaKey] context:_managedObjectContext];
                ETGPllAreasDisciplines *coreDataObject;
                if ([fetchedObjects count] > 0)
                {
                    coreDataObject = [fetchedObjects objectAtIndex:0];
                    [coreDataObject setValue:area[kPllFilterAreaName] forKey:@"name"];
                }
                else
                {
                    coreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGPllAreasDisciplines class]) inManagedObjectContext:_managedObjectContext];
                    [coreDataObject setValue:area[kPllFilterAreaKey] forKey:@"key"];
                    if ([CommonMethods validateStringValue:area[kPllFilterAreaName]])
                    {
                        [coreDataObject setValue:area[kPllFilterAreaName] forKey:@"name"];
                    }
                }
                
                NSMutableSet *tempDisciplines = [NSMutableSet set];
                NSDictionary *disciplines = area[kPllFilterDisciplinesRootKey];
                for(NSDictionary *discipline in disciplines)
                {
                    NSArray *fetchedDisciplineObjects = [CommonMethods searchEntityForName:NSStringFromClass([ETGPllDisciplines class]) withID:discipline[kPllFilterDisciplineKey] context:_managedObjectContext];
                    NSManagedObject *disciplineCoreDataObject;
                    if ([fetchedDisciplineObjects count] > 0)
                    {
                        disciplineCoreDataObject = [fetchedDisciplineObjects objectAtIndex:0];
                        [disciplineCoreDataObject setValue:discipline[kPllFilterDisciplineName] forKey:@"name"];
                    }
                    else
                    {
                        disciplineCoreDataObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ETGPllDisciplines class]) inManagedObjectContext:_managedObjectContext];
                        [disciplineCoreDataObject setValue:discipline[kPllFilterDisciplineKey] forKey:@"key"];
                        if ([CommonMethods validateStringValue:discipline[kPllFilterDisciplineName]])
                        {
                            [disciplineCoreDataObject setValue:discipline[kPllFilterDisciplineName] forKey:@"name"];
                        }
                        [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                            if(error)
                            {
                                DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                            }
                        }];
                    }
                    [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                        if(error)
                        {
                            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                        }
                    }];
                    [tempDisciplines addObject:disciplineCoreDataObject];
                }
                [coreDataObject addDisciplines:tempDisciplines];
                [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                    if(error)
                    {
                        DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
                    }
                }];
                [tempDisciplines removeAllObjects];
            }
        }
    }
    [_managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if(error)
        {
            DDLogError(@"%@%@%@", logErrorPrefix, persistentStoreError, error.description);
        }
    }];
}


- (NSDictionary *)getDefaultProjectsDictionary
{
    NSMutableDictionary *projectsDictionary = [[NSMutableDictionary alloc] initWithCapacity:5];
    
    //Default Reporting Month
    NSDate *latestReportingMonth = [CommonMethods latestReportingMonth];
    [projectsDictionary setObject:latestReportingMonth forKey:kSelectedReportingMonth];
    
    //Default Operatorship
    NSMutableArray *defaultOperatorshipKeys = [[NSMutableArray alloc] init];
    ETGOperatorship *defaultOperatorship;
    NSArray *fetchedOperatorships = [CommonMethods fetchEntity:@"ETGOperatorship" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext];
    for (ETGOperatorship *operatorship in fetchedOperatorships) {
        if ([operatorship.key isEqualToNumber:kDefaultOperatorshipKey]) {
            defaultOperatorship = operatorship;
            break;
        }
    }
    if (defaultOperatorship == nil && fetchedOperatorships.count > 0) {
        defaultOperatorship = [fetchedOperatorships objectAtIndex:0];
    }
    if (defaultOperatorship) {
        [projectsDictionary setObject:defaultOperatorship forKey:kSelectedOperatorship];
        [defaultOperatorshipKeys addObject:defaultOperatorship.key];
    }
    
    //Default Phase
    NSMutableArray *defaultPhaseKeys = [[NSMutableArray alloc] init];
    ETGPhase *defaultPhase;
    NSArray *fetchedPhases = [CommonMethods fetchEntity:@"ETGPhase" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext];
    for (ETGPhase *phase in fetchedPhases) {
        if ([phase.key isEqualToNumber:kDefaultProjectPhaseKey]) {
            defaultPhase = phase;
            break;
        }
    }
    if (defaultPhase == nil && fetchedPhases.count > 0) {
        defaultPhase = [fetchedPhases objectAtIndex:0];
    }
    if (defaultPhase) {
        [projectsDictionary setObject:defaultPhase forKey:kSelectedPhase];
        [defaultPhaseKeys addObject:defaultPhase.key];
    }
    
    //Regions
    NSArray *fetchedRegions = [CommonMethods fetchEntity:@"ETGRegion" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext];
    NSMutableArray *defaultRegionKeys = [[NSMutableArray alloc] init];
    for (ETGRegion *region in fetchedRegions) {
        [defaultRegionKeys addObject:region.key];
    }
    
    //Default ProjectStatus
    NSMutableArray *defaultProjectStatusKeys = [[NSMutableArray alloc] init];
    ETGProjectStatus *defaultProjectStatus;
    NSArray *fetchedProjectStatus = [CommonMethods fetchEntity:@"ETGProjectStatus" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext];
    for (ETGProjectStatus *projectStatus in fetchedProjectStatus) {
        if ([projectStatus.key isEqualToNumber:kDefaultProjectStatusKey]) {
            defaultProjectStatus = projectStatus;
            break;
        }
    }
    if (defaultProjectStatus == nil && fetchedProjectStatus.count > 0) {
        defaultProjectStatus = [fetchedProjectStatus objectAtIndex:0];
    }
    if (defaultProjectStatus) {
        [defaultProjectStatusKeys addObject:defaultProjectStatus.key];
    }
    
    //Filtered Projects
    NSArray *fetchedProjects = [self fetchProjectsBaseOnOperatorships:defaultOperatorshipKeys phases:defaultPhaseKeys regions:defaultRegionKeys projectStatuses:defaultProjectStatusKeys reportingMonth:[_dateFormatter stringFromDate:latestReportingMonth]];
    if (fetchedProjects.count > 0) {
        [projectsDictionary setObject:fetchedProjects forKey:kSelectedProjects];
    }
    
    //Default Budget Holder
    ETGCostAllocation *defaultBudgetHolder;
    NSArray *fetchedBudgetHolders = [CommonMethods fetchEntity:@"ETGCostAllocation" sortDescriptorKey:@"name" inManagedObjectContext:_managedObjectContext];
    for (ETGCostAllocation *budgetHolder in fetchedBudgetHolders) {
        if ([budgetHolder.key isEqualToNumber:kDefaultBudgetHolderKey]) {
            defaultBudgetHolder = budgetHolder;
            break;
        }
    }
    if (defaultBudgetHolder == nil && fetchedBudgetHolders.count > 0) {
        defaultBudgetHolder = [fetchedBudgetHolders objectAtIndex:0];
    }
    if (defaultBudgetHolder) {
        [projectsDictionary setObject:defaultBudgetHolder forKey:kSelectedBudgetHolder];
    }
    
    return projectsDictionary;
}

- (NSArray *)fetchEccrProjectsBaseOnOperatorships:(NSArray *)operatorshipKeys regions:(NSArray *)regionKeys reportingMonth:(NSString *)reportingMonth
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"operatorship.key IN %@ AND region.key IN %@ AND startDate <= %d AND endDate >= %d", operatorshipKeys, regionKeys, [reportingMonth integerValue], [reportingMonth integerValue]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray *projects = [ETGProject findAllWithPredicate:predicate];
    NSArray *fetchedObjects = [projects sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    return fetchedObjects;
}

- (NSArray *)fetchEccrProjectsBaseOnRegions:(NSArray *)regionKeys reportingMonth:(NSString *)reportingMonth
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"region.key IN %@ AND startDate <= %d AND endDate >= %d", regionKeys, [reportingMonth integerValue], [reportingMonth integerValue]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray *projects = [ETGProject findAllWithPredicate:predicate];
    NSArray *fetchedObjects = [projects sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    return fetchedObjects;
}

- (NSArray *)fetchEccrProjectsBaseOnReportingMonth:(NSString *)reportingMonth
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %d AND endDate >= %d", [reportingMonth integerValue], [reportingMonth integerValue]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray *projects = [ETGProject findAllWithPredicate:predicate];
    NSArray *fetchedObjects = [projects sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    return fetchedObjects;
}

- (NSArray *)fetchProjectsBaseOnOperatorships:(NSArray *)operatorshipKeys phases:(NSArray *)phaseKeys regions:(NSArray *)regionKeys projectStatuses:(NSArray *)projectStatusKeys reportingMonth:(NSString *)reportingMonth {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ETGProject" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //TODO: Verify date conversion
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reportingMonths.name CONTAINS %@ AND operatorship.key IN %@ AND phase.key IN %@ AND region.key IN %@ AND projectStatus.key IN %@", reportingMonth, operatorshipKeys, phaseKeys, regionKeys, projectStatusKeys];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ IN reportingMonths.name AND operatorship.key IN %@ AND phase.key IN %@ AND region.key IN %@ AND projectStatus.key IN %@", [reportingMonth toDate], operatorshipKeys, phaseKeys, regionKeys, projectStatusKeys];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        DDLogError(fetchProjectError, error);
    }
    
    return fetchedObjects;
}

- (NSArray *)fetchProjectsBaseOnClusters:(NSArray *)clusterKeys complexities:(NSArray *)complexityKeys natures:(NSArray *)natureKeys type:(NSArray *)typesKey region:(NSArray *)regionKeys {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ETGProject" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cluster.key IN %@ AND complexities.key IN %@ AND natures.key IN %@ AND types.key IN %@ AND region.key IN %@", clusterKeys, complexityKeys, natureKeys, typesKey, regionKeys];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        DDLogError(fetchProjectError, error);
    }
    
    return fetchedObjects;
}

- (NSArray *)fetchProjectsBaseOnRegions:(NSArray *)regionKeys reportingMonth:(NSString *)reportingMonth {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ETGProject" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //TODO: Verify date conversion
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reportingMonths.name CONTAINS %@ AND region.key IN %@", reportingMonth, regionKeys];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ IN reportingMonths.name AND region.key IN %@", [reportingMonth toDate], regionKeys];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        DDLogError(fetchProjectError, error);
    }
    
    return fetchedObjects;
}


- (NSArray *)getBaselineTypesOfProject:(ETGProject *)project forReportingMonth:(NSDate *)reportingMonth
{
    //NSLog(@"Project Name: %@", project.name);
    //NSLog(@"Number of ProjectSummary: %d", [[project.projects allObjects] count]);
    for (ETGProjectSummary *projectSummary in project.projects)
    {
        //TODO: Verify date conversion
//        NSDate *reportingMonthDate = [_dateFormatter dateFromString:projectSummary.reportingMonth.name];
        NSDate *reportingMonthDate = projectSummary.reportingMonth.name;
        //NSLog(@"selectedReportingMonh: %@ - projectSummary.ReportingMongth: %@", reportingMonth, reportingMonthDate);
        
        if ([CommonMethods isMonthOfDate:reportingMonthDate equalToDate:reportingMonth] )
        {
            //NSLog(@"Number of BaselineTypes: %d", [[projectSummary.baselineTypes allObjects] count]);
            NSArray *sortedBaselineTypes = [[projectSummary.baselineTypes allObjects] sortedArrayUsingComparator:^NSComparisonResult(ETGBaselineType *obj1, ETGBaselineType *obj2) {
                return [obj1.createdTime compare:obj2.createdTime];
            }];
            NSArray *baselineTypes = [[sortedBaselineTypes reverseObjectEnumerator] allObjects];
            
            //Test Revision and keymilestone
            for (ETGBaselineType *baselineType in baselineTypes) {
                //NSLog(@"Baseline type: %@", baselineType.name);
                //NSLog(@"Total number of Revision: %@", [baselineType valueForKeyPath:@"revisions.@count"]);
                for (ETGRevision *revision in baselineType.revisions) {
                    //NSLog(@"  Revision: %@", revision.number);
                    //NSLog(@"  Keymilestones: %d", [revision.keyMilestones count]);
                }
            }
            
            return baselineTypes;
        }
    }
    
    return nil;
}

- (NSArray *)getRevisionNumbersForABaselineTypes:(ETGBaselineType *)baselineType
{
    NSArray *revisionNumbers = [baselineType.revisions allObjects];
    if ([revisionNumbers count] > 0) {
        revisionNumbers = [revisionNumbers sortedArrayUsingComparator:^NSComparisonResult(ETGRevision *obj1, ETGRevision *obj2) {
            return [obj1.number compare:obj2.number];
        }];
        
        revisionNumbers = [[revisionNumbers reverseObjectEnumerator] allObjects];
    }
    
    return revisionNumbers;
}

- (NSArray *)getKeyMilestoneWithBaselineType:(ETGBaselineType *)baselineType revision:(ETGRevision *)revision
{
    return [revision.keyMilestones allObjects];
}

- (NSArray *)getLatestKeyMilestoneOfProject:(ETGProject *)project forReportingMonth:(NSDate *)reportingMonth
{
    NSArray *baselineTypeArray = [self getBaselineTypesOfProject:project forReportingMonth:reportingMonth];
    
    if ([baselineTypeArray count] > 0) {
        ETGBaselineType *latestBaselineType = [baselineTypeArray objectAtIndex:0];
        
        NSArray *revisionNumbers = [self getRevisionNumbersForABaselineTypes:latestBaselineType];
        if ([revisionNumbers count] > 0) {
            ETGRevision *latestRevision = [revisionNumbers objectAtIndex:0];
        
            NSArray *latestKeyMilestones = [self getKeyMilestoneWithBaselineType:latestBaselineType revision:latestRevision];
            return latestKeyMilestones;
        }
    }
    
    return nil;
}

-(NSArray *)fetchDisciplinesBasedOnAreas:(NSArray *)areaKeys
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@", areaKeys];
    NSArray *areas = [ETGPllAreasDisciplines findAllWithPredicate:predicate];
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    areas = [areas sortedArrayUsingDescriptors:@[sorter]];
    
    NSMutableArray *filteredDisciplines = [NSMutableArray new];
    NSMutableArray *fullArray = [NSMutableArray new];
    for(ETGPllAreasDisciplines *area in areas)
    {
        [fullArray addObject:area];
        NSArray *sortedDisciplines = [[area.disciplines allObjects] sortedArrayUsingDescriptors:@[sorter]];
        if([sortedDisciplines count] > 0)
        {
            [fullArray addObjectsFromArray:sortedDisciplines];
            [filteredDisciplines addObjectsFromArray:sortedDisciplines];
        }
    }
    
    NSMutableArray *result = [NSMutableArray new];
    [result addObject:filteredDisciplines];
    [result addObject:fullArray];
    return result;
}

-(NSArray *)fetchRegionsBasedOnCountries:(NSArray *)countryKeys
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@", countryKeys];
    NSArray *countries = [ETGCountries findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    for(ETGCountries *country in countries)
    {
        [temp addObjectsFromArray:[country.regions allObjects]];
    }
    
    return temp;
}

-(NSArray *)fetchClustersBasedOnRegions:(NSArray *)regionKeys
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@", regionKeys];
    NSArray *regions = [ETGRegion findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    for(ETGRegion *region in regions)
    {
        [temp addObjectsFromArray:[region.clusters allObjects]];
    }
    
    return temp;
}

@end
