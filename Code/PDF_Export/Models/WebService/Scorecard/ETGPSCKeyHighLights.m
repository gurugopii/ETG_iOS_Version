//
//  ETGPSCKeyHighLights.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGWebServiceCommonImports.h"
#import "ETGPSCKeyHighLights.h"
#import "ETGNetworkConnection.h"
// Models
#import "ETGKeyHighlight.h"
#import "ETGIssuesKeyHighlight.h"
#import "ETGPlannedKeyHighlight.h"
#import "ETGPpaKeyHighlight.h"
#import "ETGMonthlyKeyHighlight.h"
#import "ETGKeyHighlightsProgress.h"
#import "ETGKeyHighlightProgress.h"
#import "ETGKeyHighlightProgressOverall.h"
// Relationships
#import "ETGScorecard.h"
#import "ETGProjectSummary.h"
#import "ETGReportingMonth.h"


@interface ETGPSCKeyHighLights ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGPSCKeyHighLights

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupKeyHighlightsMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupKeyHighlightsMappings {
    // Attribute Mappings for ETGKeyHighlightProgressOverall
    RKEntityMapping *progressOverAllKeyhighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlightProgressOverall entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [progressOverAllKeyhighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                              @"overallCurrActualProgress" :@"overallCurrActualProgress",
                                                                              @"overallCurrPlanProgress"   :@"overallCurrPlanProgress",
                                                                              @"overallCurrVariance"       :@"overallCurrVariance",
                                                                              @"overallPrevActualProgress" :@"overallPrevActualProgress",
                                                                              @"overallPrevPlanProgress"   :@"overallPrevPlanProgress",
                                                                              @"overallPrevVariance"       :@"overallPrevVariance",
                                                                              }];
    
    // Attribute Mappings for ETGKeyHighlightProgress
    RKEntityMapping *progressKeyhighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlightProgress entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [progressKeyhighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                       @"activityID"         :@"activityID",
                                                                       @"activityName"       :@"activityName",
                                                                       @"currActualProgress" :@"currActualProgress",
                                                                       @"currPlanProgress"   :@"currPlanProgress",
                                                                       @"currVariance"       :@"currVariance",
                                                                       @"indicator"          :@"indicator",
                                                                       @"prevActualProgress" :@"prevActualProgress",
                                                                       @"prevPlanProgress"   :@"prevPlanProgress",
                                                                       @"prevVariance"       :@"prevVariance",
                                                                       @"weightage"          :@"weightage"
                                                                       }];
    
    // Attribute Mappings for ETGIssuesKeyHighlight
    RKEntityMapping *issuesKeyHighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGIssuesKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [issuesKeyHighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                     @"activity"      :@"activity",
                                                                     @"description"   :@"desc",
                                                                     @"mitigationPlan":@"mitigationPlan"
                                                                     }];
    
    // Attribute Mappings for ETGMonthlyKeyHighlight
    RKEntityMapping *monthlyKeyHighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGMonthlyKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [monthlyKeyHighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                      @"activity"      :@"activity",
                                                                      @"description"   :@"desc",
                                                                      @"mitigationPlan":@"mitigationPlan"
                                                                      }];
    
    // Attribute Mappings for ETGPlannedKeyHighlight
    RKEntityMapping *plannedKeyHighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPlannedKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [plannedKeyHighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                      @"activity"      :@"activity",
                                                                      @"description"   :@"desc",
                                                                      @"mitigationPlan":@"mitigationPlan"
                                                                      }];
    
    // Attribute Mappings for ETGPpaKeyHighlight
    RKEntityMapping *ppaKeyHighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPpaKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [ppaKeyHighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                  @"activity"      :@"activity",
                                                                  @"description"   :@"desc",
                                                                  @"mitigationPlan":@"mitigationPlan"
                                                                  }];
    
    // Attribute Mappings for ETGKeyHighlight
    RKEntityMapping *scorecardKeyHighlightsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [scorecardKeyHighlightsMapping addAttributeMappingsFromDictionary:@{
                                                                        @"overallPPA" : @"overallPpa",
                                                                        @"@metadata.projectKey"  : @"projectKey",
                                                                        @"@metadata.reportingMonth"   : @"reportMonth"
                                                                        }];
    scorecardKeyHighlightsMapping.identificationAttributes = @[@"projectKey", @"reportMonth"];
    
    
    // Attribute Mappings for ETGProject
    RKEntityMapping *projectMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectMapping addAttributeMappingsFromDictionary:@{
                                                         @"AboutProject.projectKey"  : @"key",
                                                         @"AboutProject.projectName" : @"name"
                                                         }];
    projectMapping.identificationAttributes = @[@"key", @"name"];
    
    
    // Attribute Mappings for ETGReportingMonth
    RKEntityMapping *reportingMonthMapping = [[RKEntityMapping alloc] initWithEntity:[ETGReportingMonth entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [reportingMonthMapping addAttributeMappingsFromDictionary:@{
                                                                @"@metadata.reportingMonth"   : @"name"
                                                                }];
    reportingMonthMapping.identificationAttributes = @[@"name"];
    
    // Relationship mapping of ETGIssuesKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"issuesConcerns" toKeyPath:@"issuesAndConcerns"  withMapping:issuesKeyHighlightsMapping]];
    
    // Relationship mapping of ETGKeyHighlightProgressOverall to ETGKeyHighlightProgress
    [progressOverAllKeyhighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyHighLightsTable" toKeyPath:@"keyHighLightsTable"  withMapping:progressKeyhighlightsMapping]];
    
    // Relationship mapping of ETGKeyHighlightProgressOverall to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"highLightsProgress" toKeyPath:@"keyhighlightsProgress"  withMapping:progressOverAllKeyhighlightsMapping]];
    
    // Relationship mapping of ETGMonthlyKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"monthlyHighLights" toKeyPath:@"monthlyKeyHighlights"  withMapping:monthlyKeyHighlightsMapping]];
    
    // Relationship mapping of ETGPlannedKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"plannedActivitiesforNextMonth" toKeyPath:@"plannedActivitiesforNextMonth"  withMapping:plannedKeyHighlightsMapping]];
    
    // Relationship mapping of ETGPpaKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ppa" toKeyPath:@"ppa"  withMapping:ppaKeyHighlightsMapping]];
    
    // Relationship mapping of ETGReportingMonth to ETGKeyHighlight
    [scorecardKeyHighlightsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"reportingMonth"  withMapping:reportingMonthMapping]];
    
    RKResponseDescriptor *keyHighlightsDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:scorecardKeyHighlightsMapping method:RKRequestMethodGET pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_SCORECARD_KEY_HIGHLIGHTS_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:keyHighlightsDescriptor];
    
    _mapping = scorecardKeyHighlightsMapping;
    
    // Inverse Attribute Mappings for ETGKeyHighlightProgressOverall
    RKEntityMapping *progressOverAllKeyhighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlightProgressOverall entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [progressOverAllKeyhighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                               @"overallCurrActualProgress" :@"overallCurrActualProgress",
                                                                               @"overallCurrPlanProgress"   :@"overallCurrPlanProgress",
                                                                               @"overallCurrVariance"       :@"overallCurrVariance",
                                                                               @"overallPrevActualProgress" :@"overallPrevActualProgress",
                                                                               @"overallPrevPlanProgress"   :@"overallPrevPlanProgress",
                                                                               @"overallPrevVariance"       :@"overallPrevVariance",
                                                                               }];
    
    // Inverse Attribute Mappings for ETGKeyHighlightProgress
    RKEntityMapping *progressKeyhighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlightProgress entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [progressKeyhighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                        @"activityID"         :@"activityID",
                                                                        @"activityName"        :@"activityName",
                                                                        @"currActualProgress" :@"currActualProgress",
                                                                        @"currPlanProgress"   :@"currPlanProgress",
                                                                        @"currVariance"       :@"currVariance",
                                                                        @"indicator"           :@"indicator",
                                                                        @"prevActualProgress" :@"prevActualProgress",
                                                                        @"prevPlanProgress"   :@"prevPlanProgress",
                                                                        @"prevVariance"       :@"prevVariance",
                                                                        @"weightage"           :@"weightage"
                                                                        }];
    
    // Inverse Attribute Mappings for ETGIssuesKeyHighlight
    RKEntityMapping *issuesKeyHighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGIssuesKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [issuesKeyHighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                      @"activity"      : @"activity",
                                                                      @"desc"          :@"desc",
                                                                      @"mitigationPlan":@"mitigationPlan"
                                                                      }];
    
    // Inverse Attribute Mappings for ETGMonthlyKeyHighlight
    RKEntityMapping *monthlyKeyHighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGMonthlyKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [monthlyKeyHighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                       @"activity"      :@"activity",
                                                                       @"desc"   :@"desc",
                                                                       @"mitigationPlan":@"mitigationPlan"
                                                                       }];
    
    // Inverse Attribute Mappings for ETGPlannedKeyHighlight
    RKEntityMapping *plannedKeyHighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGPlannedKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [plannedKeyHighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                       @"activity"      : @"activity",
                                                                       @"desc"   :@"desc",
                                                                       @"mitigationPlan":@"mitigationPlan"
                                                                       }];
    
    // Inverse Attribute Mappings for ETGPpaKeyHighlight
    RKEntityMapping *ppaKeyHighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGPpaKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [ppaKeyHighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                   @"activity"      :@"activity",
                                                                   @"desc"   :@"desc",
                                                                   @"mitigationPlan":@"mitigationPlan"
                                                                   }];
    
    // Inverse Attribute Mappings for ETGKeyHighlight
    RKEntityMapping *scorecardKeyHighlightsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGKeyHighlight entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [scorecardKeyHighlightsMapping_ addAttributeMappingsFromDictionary:@{
                                                                         @"overallPpa" : @"overallPpa",
                                                                         }];
    
    // Inverse Relationship mapping of ETGIssuesKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"issuesConcerns" toKeyPath:@"issuesAndConcerns"  withMapping:issuesKeyHighlightsMapping_]];
    // Inverse Relationship mapping of ETGKeyHighlightProgressOverall to ETGKeyHighlightProgress
    [progressOverAllKeyhighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyhighLightsTable" toKeyPath:@"keyHighLightsTable" withMapping:progressKeyhighlightsMapping_]];
    // Inverse Relationship mapping of ETGKeyHighlightProgressOverall to ETGKeyHighlight
    [scorecardKeyHighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyhighlightsProgress" toKeyPath:@"keyhighlightsProgress"  withMapping:progressOverAllKeyhighlightsMapping_]];
    // Inverse Relationship mapping of ETGMonthlyKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"monthlyHighLights" toKeyPath:@"monthlyKeyHighlights"  withMapping:monthlyKeyHighlightsMapping_]];
    // Inverse Relationship mapping of ETGPlannedKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"plannedActivitiesforNextMonth" toKeyPath:@"plannedActivitiesforNextMonth"  withMapping:plannedKeyHighlightsMapping_]];
    // Inverse Relationship mapping of ETGPpaKeyHighlight to ETGKeyHighlight
    [scorecardKeyHighlightsMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ppa" toKeyPath:@"ppa"  withMapping:ppaKeyHighlightsMapping_]];
    
    _inverseMapping = [scorecardKeyHighlightsMapping_ inverseMapping];
}

-(NSDictionary *)fetchKeyHighlightsCoreData:(NSManagedObject *)object {
    
    NSMutableDictionary *keyHighlights = [NSMutableDictionary dictionary];
    RKObjectMappingOperationDataSource *dataSource = [RKObjectMappingOperationDataSource new];
    RKMappingOperation *mappingOperation = [[RKMappingOperation alloc] initWithSourceObject:object destinationObject:keyHighlights mapping:_inverseMapping];
    
    mappingOperation.dataSource = dataSource;
    NSError *error = nil;
    
    [mappingOperation performMapping:&error];
    if (error) {
        DDLogError(@"%@%@", logErrorPrefix, [NSString stringWithFormat:serializationError, error]);
        return nil;
    }
    
    return keyHighlights;
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
    
    NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_SCORECARD_KEY_HIGHLIGHTS_PATH];
    NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    RKManagedObjectRequestOperation *keyHighlightsOperation = [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:[[ETGWebService sharedWebService] managedObjectContext] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        
        //NSLog(@"Mapping result: %@", [mappingResult set]);
        
        // Get the managed object context
        NSManagedObjectContext* context = [[ETGWebService sharedWebService] managedObjectContext];
        
        // Additional mappings for ETGKeyHighlight
        ETGKeyHighlight* keyHighlight = (ETGKeyHighlight*)mappingResult;
        
        // Get the ETGProject by project key
        NSString* query = [NSString stringWithFormat:@"(key == %@) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name LIKE[cd] \"%@\").@count !=0)", [params valueForKey:@"inpProjectKey"], [params valueForKey:@"inpReportingMonth"]];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
        ETGProject* project = [ETGProject findFirstWithPredicate:predicate inContext:context];
        // If ETGProject exist, add ETGKeyHighlight to the ETGProject
        if (project) {
            // Set ETGKeyHighlight relationship to ETGProject
//#warning Update KeyHighlight mapping, it is not a property of Project entity
//            [project setKeyHighlight:keyHighlight];
            // Set inverse relationship
            [keyHighlight setProject:project];
        }

        // Save to persistent store
        NSError* error;
        [context saveToPersistentStore:&error];
        if (error) {
            DDLogWarn(@"%@%@", logWarnPrefix,persistentStoreError);
        }
        
        NSMutableArray *keyHighlightsArray = [NSMutableArray array];
        NSDictionary *keyHighlightResult = [NSDictionary dictionary];
        for (ETGKeyHighlight *keyHighlights in [mappingResult set]) {
            keyHighlightResult = [self fetchKeyHighlightsCoreData:keyHighlights];
            [keyHighlightsArray addObject:keyHighlightResult];
        }

        success(keyHighlightsArray);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        NSHTTPURLResponse *response = [[operation HTTPRequestOperation] response];
        NSDictionary *responseHeadersDict = [response allHeaderFields];
//        NSString *strXErrorMsg = [responseHeadersDict valueForKey:@"X-Message"];
        
        [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];

        DDLogWarn(@"%@%@", logWarnPrefix,webServiceFetchError);
//        DDLogError(@"%@", strXErrorMsg);
        DDLogError(@"%@%@", logErrorPrefix, responseHeadersDict);
        
        [self fetchOfflineDataWithReportingMonth:reportingMonth projectKey:[projectKey stringValue]  success:^(NSMutableArray *keyHighlightsArray) {
            success(keyHighlightsArray);
        } failure:^(NSError *error) {
            failure(error);
            DDLogError(@"%@%@", logErrorPrefix,  error.description);
        }];
        
    }];
    
    [_managedObject enqueueObjectRequestOperation:keyHighlightsOperation];
    }
    else {
        DDLogWarn(@"%@%@",logWarnPrefix,serverCannotBeReachedWarn);
    }
}

- (void)fetchOfflineDataWithReportingMonth:(NSString*)reportingMonth
                                projectKey:(NSDictionary*)projectKey
                                   success:(void (^)(NSMutableArray *))success
                                   failure:(void (^)(NSError *error))failure {
    
//    // Get the managed object context
    NSManagedObjectContext* context = [NSManagedObjectContext contextForCurrentThread];
    // Fetch ETGKeyHighlight from cache using paramater(ProjectKey and ReportingMonth)
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:reportingMonth];
    //int daysToAdd = 1;
    //dateFromString = [dateFromString dateByAddingTimeInterval:60*60*24*daysToAdd];
    //NSLog(@"%@", [ETGReportingMonth findAll]);
    //NSString* query = [NSString stringWithFormat:@"projectKey == %@ AND reportMonth == %@", projectKey, reportingMonth];
    //NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"projectKey == %@ AND reportMonth == %@", [[projectKey valueForKey:@"key"] objectAtIndex:0], [reportingMonth toDate]];
    ETGKeyHighlight* keyHighlight = [ETGKeyHighlight findFirstWithPredicate:predicate inContext:context];
    
    NSMutableArray *keyHighlightsArray = [NSMutableArray array];
    NSDictionary *keyHighlightResult = [NSDictionary dictionary];

    if (keyHighlight) {
        keyHighlightResult = [self fetchKeyHighlightsCoreData:keyHighlight];
        [keyHighlightsArray addObject:keyHighlightResult];
        success(keyHighlightsArray);
    } else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
        NSError *noDataError = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
        failure(noDataError);
        DDLogError(@"%@%@", logErrorPrefix, noDataError.description);
    }
    
    for (ETGProject *project in projectKey) {
        //NSLog(@"%@", project);
        //DDLogInfo(@"Project: %@", project.name);
        for (ETGKeyHighlight *keyHighlight in project.keyHighlights) {
            
            NSDate *reportMonth = [reportingMonth toDate];
            
            if (reportMonth) {
                if ([CommonMethods isMonthOfDate:keyHighlight.reportingMonth.name equalToDate:reportMonth]) {
                    keyHighlightResult = [self fetchKeyHighlightsCoreData:keyHighlight];
                    [keyHighlightsArray addObject:keyHighlightResult];
                    success(keyHighlightsArray);
                }
            }
        }
    }
    
    if (keyHighlightsArray) {
        success(keyHighlightsArray);
    } else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
        NSError *noDataError = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
        failure(noDataError);
        DDLogError(@"%@%@", logErrorPrefix, noDataError.description);
    }
}

@end
