//
//  ETGPortfolioHse.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGPortfolioHSE.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h"
//Models
#import "ETGPortfolio.h"
#import "ETGHsePortfolio.h"
#import "ETGRegion.h"
#import "ETGReportingMonth.h"

#import "ETGToken.h"
#import "ETGJSONKeyReplaceManipulation.h"

#import "ETGCoreDataUtilities.h"


@interface ETGPortfolioHSE ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;
@property (nonatomic) BOOL isEmpty;
@property (nonatomic) BOOL haveUAC;
@property (nonatomic) BOOL isReportEnabled;

@end

@implementation ETGPortfolioHSE

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupHSEMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupHSEMappings {
    
    // Attribute Mappings for ETGHsePortfolio
    RKEntityMapping *hseMapping = [[RKEntityMapping alloc] initWithEntity:[ETGHsePortfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [hseMapping addAttributeMappingsFromDictionary:@{
     @"fatality"            : @"fatality",
     @"fireIncident"        : @"fireincident",
     @"lostTimeInjuries"    : @"losttimeinjuries",
     @"totalRecordableCase" : @"totalrecordable",
     }];
    
    // Attribute Mappings for ETGPortfolio
    RKEntityMapping *portfolioMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPortfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [portfolioMapping addAttributeMappingsFromDictionary:@{
                                                           @"projectKey"  : @"projectKey",
                                                           @"@metadata.reportingMonth"   : @"reportMonth"
                                                           }];
    portfolioMapping.identificationAttributes = @[@"projectKey", @"reportMonth"];
    
    // Attribute Mappings for ETGProject
    RKEntityMapping *projectMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectMapping addAttributeMappingsFromDictionary:@{
     @"projectKey"   : @"key",
     @"projectName" : @"name"
     }];
    projectMapping.identificationAttributes = @[@"key", @"name"];
    
    // Attribute Mappings for ETGReportingMonth
    RKEntityMapping *reportingMonthMapping = [[RKEntityMapping alloc] initWithEntity:[ETGReportingMonth entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [reportingMonthMapping addAttributeMappingsFromDictionary:@{
                                                                @"@metadata.reportingMonth"   : @"name"
                                                                }];
    reportingMonthMapping.identificationAttributes = @[@"name"];
    
    // Attribute Mappings for ETGRegion
    RKEntityMapping *regionMapping = [[RKEntityMapping alloc] initWithEntity:[ETGRegion entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [regionMapping addAttributeMappingsFromDictionary:@{
     @"region"  : @"name"
     }];
    regionMapping.identificationAttributes = @[@"name"];
    
    // Relationship mapping of ETGRegion to ETGProject
    [projectMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"region" withMapping:regionMapping]];
    
    // Relationship mapping of ETGProject to ETGPortfolio
    [portfolioMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"project" withMapping:projectMapping]];
    
    // Relationship mapping of ETGReportingMonth to ETGPortfolio
    [portfolioMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"reportingMonth" withMapping:reportingMonthMapping]];
    
    // Relationship mapping of ETGPortfolio to ETGHsePortfolio
    [hseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"portfolio" withMapping:portfolioMapping]];
    
    // Add ETGHsePortfolio to Response descriptor
    RKResponseDescriptor *portfolioHseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:hseMapping method:RKRequestMethodPOST pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_PORTFOLIO_HSE_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:portfolioHseDescriptor];
    
    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *hseMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGHsePortfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [hseMapping_ addAttributeMappingsFromDictionary:@{
     @"fatality"            : @"fatality",
     @"fireincident"        : @"fireincident",
     @"losttimeinjuries"    : @"losttimeinjuries",
     @"totalrecordable"     : @"totalrecordable",
     }];
    
    [hseMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"projectKey" toKeyPath:@"portfolio.project.key"]];
    [hseMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"name" toKeyPath:@"portfolio.project.name"]];
    [hseMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"region" toKeyPath:@"portfolio.project.region.name"]];
    
    // Create Core Data to JSON mapping
    _inverseMapping = [hseMapping_ inverseMapping];
}

- (NSDictionary*)serializeObject:(NSManagedObject*)object {
    //Convert coredata to JSON
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    RKManagedObjectMappingOperationDataSource *dataSource = [RKManagedObjectMappingOperationDataSource new];
    RKMappingOperation *mappingOperation = [[RKMappingOperation alloc] initWithSourceObject:object
                                                                          destinationObject:json
                                                                                    mapping:_inverseMapping];
    mappingOperation.dataSource = dataSource;
    NSError *error = nil;
    [mappingOperation performMapping:&error];
    if (error) {
        DDLogError(@"%@%@", logErrorPrefix, [NSString stringWithFormat:serializationError, error]);
        return nil;
    }
//    json = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] detectNumericJSONByKeyValue:json];
    return json;
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
                           projectKey:(NSNumber *)projectKey
                              success:(void (^)(NSMutableDictionary *inputData))success
                              failure:(void (^)(NSError *error))failure{

//    if (_isReportEnabled) {
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        if (_appDelegate.isNetworkServerAvailable == YES) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:reportingMonth forKey:@"inpReportingMonth"];
            
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];
            
            NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_HSE_PATH];
            NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
            [request setHTTPBody:jsonData];
            
            RKManagedObjectRequestOperation *operation = [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:[[ETGWebService sharedWebService] managedObjectContext] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                
                // Fetch or insert ETGReportingMonth from paramater
                NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
               
                // Save to persistent store
                NSError* error;
                [context saveToPersistentStore:&error];
                
                if (error) {
                    DDLogWarn(@"%@%@", logWarnPrefix,persistentStoreError);
                }
                
                NSMutableDictionary *inputData = nil;
                success(inputData);
            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                
                NSHTTPURLResponse *response = [[operation HTTPRequestOperation] response];
                NSDictionary *responseHeadersDict = [response allHeaderFields];
                
                [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];
                //        NSString *strXErrorMsg = [responseHeadersDict valueForKey:@"X-Message"];
                DDLogWarn(@"%@%@ - %@",logWarnPrefix,hsePrefix, webServiceFetchError);
                //        DDLogError(@"%@", strXErrorMsg);
                DDLogError(@"%@%@", logErrorPrefix,responseHeadersDict);
                failure(error);
            }];
            //Set mapping metada
            NSDictionary* metadata = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [reportingMonth toDate], @"reportingMonth", nil];
            [operation setMappingMetadata:metadata];
            [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
            [_managedObject enqueueObjectRequestOperation:operation];
        }
        else {
            DDLogWarn(@"%@%@",logWarnPrefix,serverCannotBeReachedWarn);
        }
//    } else {
//        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
//        [errorDetail setValue:@"UAC - Access Dennied" forKey:NSLocalizedDescriptionKey];
//        NSError *accessDeniederror = [NSError errorWithDomain:@"ETG" code:102 userInfo:errorDetail];
//        failure(accessDeniederror);
//        DDLogError(@"%@", accessDeniederror.description);
//    }
}

// Delete existing data
- (void) removeDuplicatesForReportingMonth:(NSString *)reportingMonth {
    
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    //TODO: Verify date conversion
//    NSString* query = [NSString stringWithFormat:@"(SUBQUERY(portfolio, $portfolio, ANY $portfolio.reportingMonth.name LIKE[cd] \"%@\").@count != 0)", reportingMonth];
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(portfolio, $portfolio, ANY $portfolio.reportingMonth.name == %@).@count != 0)", [reportingMonth toDate]];
    
    [ETGHsePortfolio deleteAllMatchingPredicate:predicate inContext:context];
    
    NSError* error;
    [context saveToPersistentStore:&error];
    
}

- (NSMutableDictionary *)aggregateDataForChartFrom:(NSSet *)cachedData {
    
    NSArray *dataArray = [[NSArray alloc] initWithArray:cachedData.allObjects];
    
    NSNumber *totalFatality = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.fatality"] intValue]];
    NSNumber *totalLTI = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.losttimeinjuries"] intValue]];
    NSNumber *totalFI = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.fireincident"] intValue]];
    NSNumber *totalTRC = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.totalrecordable"] intValue]];
    
    NSMutableDictionary *processedJSON = [NSMutableDictionary dictionaryWithDictionary:@{@"name":@"LTI",@"data":@[totalFatality,totalLTI, totalFI, totalTRC]}];
    
    return processedJSON;
    
}

- (BOOL)uacCanSeeReport:(NSString *)reportingMonth{
    /*_haveUAC = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasUACForWebService:[NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_HSE_PATH] reportingMonth:reportingMonth];*/
    _haveUAC = YES;
    return _haveUAC;
}

- (BOOL)entityIsEmpty{
    _isEmpty = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasEntriesForEntityName:@"ETGHsePortfolio"];
    return _isEmpty;
}

- (void)setBaseFilters{
    // Put code to set base filters here...
    //DDLogInfo(@"%@%@", logInfoPrefix, @"Set Base filter");
}

- (void)setIsReportEnabledFlagTo:(BOOL)yesNo {
    _isReportEnabled = yesNo;
}

- (void)collectReportJSONFrom:(NSSet *)cachedData
                      success:(void (^)(NSMutableDictionary *))success
                      failure:(void (^)(NSError *))failure{
    
    // Create Core Data to JSON mapping
    NSError* error;
    NSMutableArray *jsonDict = [NSMutableArray array];
    
//    if (_isReportEnabled) {
        if (cachedData.count == 0) {
            id noData = @"no data";
            jsonDict = noData;
        } else {
            for (ETGHsePortfolio* hse in cachedData) {
                NSDictionary* json = [self serializeObject:hse];
                if (!json) {
                    //An error occurred
                    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                    [errorDetail setValue:coreDataToJSONError forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:@"ETG" code:100 userInfo:errorDetail];
                    DDLogError(@"%@%@", logErrorPrefix, error.description);
                } else {
                    [jsonDict addObject:json];
                }
            }
        }
        
//    } else {
//        id noData = @"disabled";
//        jsonDict = noData;
//    }
    
    if (error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    } else {
                    
        if (![jsonDict isEqual: @"no data"]) {
            
            NSMutableDictionary *processedJSON = [NSMutableDictionary dictionary];
            NSMutableArray *tableData = [NSMutableArray arrayWithObject:[self aggregateDataForChartFrom:cachedData]];
            
            [processedJSON setValue:jsonDict forKey:@"tabledata"];
            [processedJSON setValue:tableData forKey:@"chartdata"];
            
            success(processedJSON);
        } else {
            
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
            NSError *noDataerror = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
            failure(noDataerror);
            DDLogError(@"%@%@", logErrorPrefix,noDataerror.description);
        }
    }
}

@end
