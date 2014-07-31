//
//  ETGPortfolioProductionRTBD.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
//UPDATE THIS LATER
#import "ETGPortfolioProductionRTBD.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h"
//Models
#import "ETGPortfolio.h"
#import "ETGProductionRtbd_Portfolio.h"
#import "ETGRegion.h"
#import "ETGReportingMonth.h"
#import "ETGProject.h"
#import "ETGToken.h"

#import "ETGCoreDataUtilities.h"


@interface ETGPortfolioProductionRTBD ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;
@property (nonatomic) BOOL isEmpty;
@property (nonatomic) BOOL haveUAC;
@property (nonatomic) BOOL isReportEnabled;

@end

@implementation ETGPortfolioProductionRTBD

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupProductionRTBDMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupProductionRTBDMappings {
    
    // Attribute Mappings for ETGProductionRtbd_Portfolio
    RKEntityMapping *productionRtbdMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProductionRtbd_Portfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [productionRtbdMapping addAttributeMappingsFromDictionary:@{
                                                                @"productionGas.indicator"   : @"gasIndicator",
                                                                @"productionGas.outlook"     : @"gasOutlook",
                                                                @"productionGas.plan"        : @"gasPlan",
                                                                @"productionOil.indicator"   : @"oilIndicator",
                                                                @"productionOil.outlook"     : @"oilOutlook",
                                                                @"productionOil.plan"        : @"oilPlan",
                                                                @"rtbd.indicator"            : @"rtbdIndicator",
                                                                @"rtbd.outlook"              : @"rtbdOutlook",
                                                                @"rtbd.plan"                 : @"rtbdPlan",
                                                                @"productionCondy.indicator" : @"condyIndicator",
                                                                @"productionCondy.outlook"   : @"condyOutlook",
                                                                @"productionCondy.plan"      : @"condyPlan"
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
                                                         @"projectKey"  : @"key",
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
    
    // Relationship mapping of ETGPortfolio to ETGProductionRtbd_Portfolio
    [productionRtbdMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"portfolio" withMapping:portfolioMapping]];

    // Add ETGProductionRtbd_Portfolio to Response descriptor
    RKResponseDescriptor *portfolioProductionRtbdDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productionRtbdMapping method:RKRequestMethodPOST pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_PORTFOLIO_PRODUCTIONRTBD_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [_managedObject addResponseDescriptor:portfolioProductionRtbdDescriptor];

    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *productionRtbdMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGProductionRtbd_Portfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [productionRtbdMapping_ addAttributeMappingsFromDictionary:@{
                                                                 @"productionoil.plan"        : @"oilPlan",
                                                                 @"productionoil.outlook"     : @"oilOutlook",
                                                                 @"productionoil.indicator"   : @"oilIndicator",
                                                                 @"productiongas.plan"        : @"gasPlan",
                                                                 @"productiongas.outlook"     : @"gasOutlook",
                                                                 @"productiongas.indicator"   : @"gasIndicator",
                                                                 @"condy.plan"                : @"condyPlan",
                                                                 @"condy.outlook"             : @"condyOutlook",
                                                                 @"condy.indicator"           : @"condyIndicator",
                                                                 @"rtbd.plan"                 : @"rtbdPlan",
                                                                 @"rtbd.outlook"              : @"rtbdOutlook",
                                                                 @"rtbd.indicator"            : @"rtbdIndicator"
                                                                 }];
    
    [productionRtbdMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"projectKey" toKeyPath:@"portfolio.project.key"]];
    //[productionRtbdMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"key" toKeyPath:@"portfolio.project.key"]];
    [productionRtbdMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"name" toKeyPath:@"portfolio.project.name"]];
    [productionRtbdMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"region" toKeyPath:@"portfolio.project.region.name"]];

    // Create Core Data to JSON mapping
    _inverseMapping = [productionRtbdMapping_ inverseMapping];
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
            //    [params setObject:[projectKey stringValue] forKey:@"inpProjectKey"];
            
            
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];
            
            NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_PRODUCTIONRTBD_PATH];
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
                //        NSString *strXErrorMsg = [responseHeadersDict valueForKey:@"X-Message"];
                
                [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];

                
                DDLogWarn(@"%@%@ - %@",logWarnPrefix,rtbdPrefix, webServiceFetchError);
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
    
    [ETGProductionRtbd_Portfolio deleteAllMatchingPredicate:predicate inContext:context];
    
    NSError* error;
    [context saveToPersistentStore:&error];

}

- (NSMutableDictionary *)aggregateDataForChartFrom:(NSSet *)cachedData {
    
    NSArray *dataArray = [[NSArray alloc] initWithArray:cachedData.allObjects];
    
    NSNumber *totalOilYEP = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.oilOutlook"] floatValue]];
    NSNumber *totalOilCPB = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.oilPlan"] floatValue]];
    NSNumber *totalGasYEP = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.gasOutlook"] floatValue]];
    NSNumber *totalGasCPB = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.gasPlan"] floatValue]];
    NSNumber *totalCondyYEP = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.condyOutlook"] floatValue]];
    NSNumber *totalCondyCPB = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.condyPlan"] floatValue]];
    NSNumber *totalRTBDYEP = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.rtbdOutlook"] floatValue]];
    NSNumber *totalRTBDCPB = [NSNumber numberWithFloat:[[dataArray valueForKeyPath:@"@sum.rtbdPlan"] floatValue]];
    
    NSMutableDictionary *processedJSON = [NSMutableDictionary dictionaryWithDictionary:@{@"newproduction":@[@{@"name":@"YEP",@"data":@[totalOilYEP, totalGasYEP, totalCondyYEP, [NSNull null]]},@{@"name":@"CPB",@"data":@[totalOilCPB, totalGasCPB, totalCondyCPB, [NSNull null]]}],@"rtbd":@[@{@"name":@"YEP",@"data":@[[NSNull null], [NSNull null], [NSNull null], totalRTBDYEP]},@{@"name":@"CPB",@"data":@[[NSNull null],[NSNull null], [NSNull null], totalRTBDCPB]}]}];
    
    return processedJSON;
}

- (NSMutableArray *)aggregateDataForTableFrom:(NSMutableArray *)jsonDict {
    
    NSMutableArray *processedDataArray = [[NSMutableArray alloc] init];

    for (NSDictionary *prod in jsonDict) {
        NSString *condyOutlook = [NSString stringWithFormat:@"%@", [prod valueForKeyPath:@"condy.outlook"]];
        NSString *condyPlan = [NSString stringWithFormat:@"%@", [prod valueForKeyPath:@"condy.plan"]];
        NSString *prodGasOutlook = [NSString stringWithFormat:@"%@", [prod valueForKeyPath:@"productiongas.outlook"]];
        NSString *prodGasPlan = [NSString stringWithFormat:@"%@", [prod valueForKeyPath:@"productiongas.plan"]];
        NSString *prodOilOutlook = [NSString stringWithFormat:@"%@", [prod valueForKeyPath:@"productionoil.outlook"]];
        NSString *prodOilPlan = [NSString stringWithFormat:@"%@", [prod valueForKeyPath:@"productionoil.plan"]];
        NSString *rtbdOutlook = [NSString stringWithFormat:@"%@", [prod valueForKeyPath:@"rtbd.outlook"]];
        NSString *rtbdPlan = [NSString stringWithFormat:@"%@", [prod valueForKeyPath:@"rtbd.plan"]];

        if (![condyOutlook isEqualToString:@"0"] || ![condyPlan isEqualToString:@"0"] || ![prodGasOutlook isEqualToString:@"0"] || ![prodGasPlan isEqualToString:@"0"] || ![prodOilOutlook isEqualToString:@"0"] || ![prodOilPlan isEqualToString:@"0"] || ![rtbdOutlook isEqualToString:@"0"] || ![rtbdPlan isEqualToString:@"0"]) {

            [processedDataArray addObject:prod];
        }
    }
    
    return processedDataArray;
}

- (BOOL)uacCanSeeReport:(NSString *)reportingMonth{
    /*_haveUAC = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasUACForWebService:[NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_PRODUCTIONRTBD_PATH] reportingMonth:reportingMonth];*/
    _haveUAC = YES;
    return _haveUAC;
}

- (BOOL)entityIsEmpty{
    _isEmpty = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasEntriesForEntityName:@"ETGProductionRtbd_Portfolio"];
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
        if (cachedData.count == 0){
            id noData = @"no data";
            jsonDict = noData;
        } else {
            for (ETGProductionRtbd_Portfolio* rtbd in cachedData) {
                NSDictionary* json = [self serializeObject:rtbd];
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
        DDLogError(@"%@", error.description);
    } else {
        
        if (![jsonDict isEqual: @"no data"]) {
            
            NSMutableDictionary *processedJSON = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                                 @"tabledata": [self aggregateDataForTableFrom:jsonDict],
                                                                                                 @"chartdata": [self aggregateDataForChartFrom:cachedData]}];
            success(processedJSON);
        } else {
            
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
            NSError *noDataerror = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
            failure(noDataerror);
            DDLogError(@"%@", noDataerror.description);
        }
    }
}

@end
