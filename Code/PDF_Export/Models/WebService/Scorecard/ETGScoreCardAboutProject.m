//
//  ETGScoreCardAboutProject.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGWebServiceCommonImports.h"
#import "ETGScoreCardAboutProject.h"
#import "ETGNetworkConnection.h"
// Models
#import "ETGProjectBackground.h"
// Relationships
#import "ETGScorecard.h"
#import "ETGRegion.h"
#import "ETGProjectSummary.h"


@interface ETGScoreCardAboutProject ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) ETGWebService *webService;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGScoreCardAboutProject

- (id)init
{
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupMappings
{
    // Attribute Mappings from web service to core data for Project Background
    RKEntityMapping *projectBackgroundMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProjectBackground entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectBackgroundMapping addAttributeMappingsFromDictionary:@{
                                                                   @"clusterName"             : @"clusterName",
                                                                   @"country"                 : @"country",
                                                                   @"currencyName"            : @"currencyName",
                                                                   @"endDate"                 : @"endDate",
                                                                   @"equity"                  : @"equity",
                                                                   @"fdpAmt"                  : @"fdpAmt",
                                                                   @"fdpDate"                 : @"fdpDate",
                                                                   @"fdpStatus"               : @"fdpStatus",
                                                                   @"firAmt"                  : @"firAmt",
                                                                   @"firDate"                 : @"firDate",
                                                                   @"firStatus"               : @"firStatus",
                                                                   @"objective"               : @"objective",
                                                                   //                                                                   @"operatorShipName"        : @"operatorshipName",
                                                                   @"operatorship"        : @"operatorshipName",
                                                                   //                                                                   @"projectCostCategoryName" : @"projectCostCategoryName",
                                                                   @"costCategory" : @"projectCostCategoryName",
                                                                   @"projectEndDate"          : @"projectEndDate",
                                                                   @"projectID"              : @"projectId",
                                                                   @"projectName"             : @"projectName",
                                                                   //                                                                   @"projectNatureName"       : @"projectNatureName",
                                                                   @"nature"       : @"projectNatureName",
                                                                   @"projectStartDate"        : @"projectStartDate",
                                                                   //                                                                   @"projectStatusName"       : @"projectStatusName",
                                                                   @"status"       : @"projectStatusName",
                                                                   //                                                                   @"projectTypeName"         : @"projectTypeName",
                                                                   @"type"         : @"projectTypeName",
                                                                   @"region"                  : @"region",
                                                                   @"startDate"               : @"startDate",
                                                                   @"projectImage"            : @"projectImage"
                                                                   }];
    
    RKResponseDescriptor *projectBackgroundMappingDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:projectBackgroundMapping method:RKRequestMethodGET pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_SCORECARD_PROJECT_BACKGROUND_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:projectBackgroundMappingDescriptor];
    
    RKEntityMapping *projectBackgroundMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGProjectBackground entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectBackgroundMapping_ addAttributeMappingsFromDictionary:@{
                                                                    @"clusterName"             : @"clusterName",
                                                                    @"country"                 : @"country",
                                                                    @"currencyName"            : @"currencyName",
                                                                    @"endDate"                 : @"endDate",
                                                                    @"equity"                  : @"equity",
                                                                    @"fdpAmt"                  : @"fdpAmt",
                                                                    @"fdpDate"                 : @"fdpDate",
                                                                    @"fdpStatus"               : @"fdpStatus",
                                                                    @"firAmt"                  : @"firAmt",
                                                                    @"firDate"                 : @"firDate",
                                                                    @"firStatus"               : @"firStatus",
                                                                    @"objective"               : @"objective",
                                                                    @"operatorShipName"        : @"operatorshipName",
                                                                    @"projectCostCategoryName" : @"projectCostCategoryName",
                                                                    @"projectEndDate"          : @"projectEndDate",
                                                                    @"projectId"               : @"projectId",
                                                                    @"projectName"             : @"projectName",
                                                                    @"projectNatureName"       : @"projectNatureName",
                                                                    @"projectStartDate"        : @"projectStartDate",
                                                                    @"projectStatusName"       : @"projectStatusName",
                                                                    @"projectTypeName"         : @"projectTypeName",
                                                                    @"region"                  : @"region",
                                                                    @"startDate"               : @"startDate",
                                                                    @"projectImage"            : @"projectImage"
                                                                    }];
    _inverseMapping = [projectBackgroundMapping_ inverseMapping];
}

-(NSDictionary *)fetchProjectBackgroundCoreData:(NSManagedObject *)object {
    
    NSMutableDictionary *projectBackground = [NSMutableDictionary dictionary];
    RKObjectMappingOperationDataSource *dataSource = [RKObjectMappingOperationDataSource new];
    RKMappingOperation *mappingOperation = [[RKMappingOperation alloc] initWithSourceObject:object destinationObject:projectBackground mapping:_inverseMapping];
    
    mappingOperation.dataSource = dataSource;
    NSError *error = nil;
    
    [mappingOperation performMapping:&error];
    if (error) {
        DDLogError(serializationError, error);
        return nil;
    }
    
    return projectBackground;
}

- (void)sendRequestWithReportingMonth:(NSString*)reportingMonth
                           projectKey:(NSNumber*)projectKey
                              success:(void (^)(NSMutableArray *))success
                              failure:(void (^)(NSError *error))failure {
    
    _appDelegate = [[UIApplication sharedApplication] delegate];
    [ETGNetworkConnection checkAvailability];
    if (_appDelegate.isNetworkServerAvailable == YES) {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"inpReportingMonth"];
    [params setObject:[projectKey stringValue] forKey:@"inpProjectKey"];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_SCORECARD_PROJECT_BACKGROUND_PATH];
    NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    RKManagedObjectRequestOperation *projectBackgroundoperation = [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:[[ETGWebService sharedWebService] managedObjectContext] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
       
        // Get the managed object context
        NSManagedObjectContext* context = [[ETGWebService sharedWebService] managedObjectContext];
        
        // Additional mappings for ETGProjectBackground
        ETGProjectBackground* projectBackgroundFromWS = (ETGProjectBackground*)mappingResult;
        
        // Get the ETGProject by project key
        NSString* query = [NSString stringWithFormat:@"(key == %@) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name LIKE[cd] \"%@\").@count !=0)", [params valueForKey:@"inpProjectKey"], [params valueForKey:@"inpReportingMonth"]];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
        ETGProject* project = [ETGProject findFirstWithPredicate:predicate inContext:context];
        // If ETGProject exist, add ETGKeyHighlight to the ETGProject
        if (project) {
            // Set ETGProjectBackground relationship to ETGProject
            [project setProjectBackground:projectBackgroundFromWS];
            // Set inverse relationship
            [projectBackgroundFromWS setProject:project];
        }
        
        // Save to persistent store
        NSError* error;
        [context saveToPersistentStore:&error];
        if (error) {
            DDLogWarn(@"%@%@", logWarnPrefix, persistentStoreError);
        }
        
        NSMutableArray *projectBackground = [NSMutableArray array];
        NSDictionary *projectBackgroundResult = [NSDictionary dictionary];
        for (ETGProjectBackground *projBackground in [mappingResult set]) {
            projectBackgroundResult = [self fetchProjectBackgroundCoreData:projBackground];
            [projectBackground addObject:projectBackgroundResult];
        }
        
        success(projectBackground);

    } failure:^(RKObjectRequestOperation *operation, NSError *error) {

        NSHTTPURLResponse *response = [[operation HTTPRequestOperation] response];
        NSDictionary *responseHeadersDict = [response allHeaderFields];
//        NSString *strXErrorMsg = [responseHeadersDict valueForKey:@"X-Message"];

        [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];

        DDLogWarn(@"%@%@", logWarnPrefix,webServiceFetchError);
//        DDLogError(@"%@", strXErrorMsg);
        DDLogError(@"%@%@", logErrorPrefix, responseHeadersDict);
        
        [self fetchOfflineDataWithReportingMonth:reportingMonth projectKey:projectKey success:^(NSMutableArray *backgroundArray) {
            success(backgroundArray);
        } failure:^(NSError *error) {
            failure(error);
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        }];
    }];

    [_managedObject enqueueObjectRequestOperation:projectBackgroundoperation];
    }
    else {
        DDLogWarn(@"%@%@",logWarnPrefix,serverCannotBeReachedWarn);
    }
}

- (void)fetchOfflineDataWithReportingMonth:(NSString*)reportingMonth
                                projectKey:(NSNumber*)projectKey
                                   success:(void (^)(NSMutableArray *))success
                                   failure:(void (^)(NSError *error))failure {
    
    // Get the managed object context
    NSManagedObjectContext* context = [NSManagedObjectContext contextForCurrentThread];
    // Fetch ETGProjectBackground from cache using paramater(ProjectKey and ReportingMonth)
    NSString* query = [NSString stringWithFormat:@"(SUBQUERY(project, $project, ANY $project.key == %@).@count !=0)", projectKey];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
    ETGProjectBackground* projectBackground = [ETGProjectBackground findFirstWithPredicate:predicate inContext:context];

    if (projectBackground) {
        // Call success with cached ETGKeyHighlight
        success([NSMutableArray arrayWithObject:projectBackground]);
    } else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
        NSError *noDataError = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
        failure(noDataError);
        DDLogError(@"%@%@", logErrorPrefix, noDataError.description);
    }
}

@end
