//
//  ETGPortfolioApc.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGPortfolioApc.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h"
//Models
#import "ETGPortfolio.h"
#import "ETGApc.h"
#import "ETGRegion.h"
#import "ETGReportingMonth.h"
#import "ETGPhase.h"
#import "ETGToken.h"
#import "ETGJSONKeyReplaceManipulation.h"
#import "ETGCoreDataUtilities.h"


@interface ETGPortfolioApc ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;
@property (nonatomic) BOOL isEmpty;
@property (nonatomic) BOOL haveUAC;
//@property (nonatomic) BOOL isReportEnabled;
//@property (nonatomic) BOOL isTableReportEnabled;

@end

@implementation ETGPortfolioApc

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupApcMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupApcMappings {
    
    // Attribute Mappings for AFC
    RKEntityMapping *apcMapping = [[RKEntityMapping alloc] initWithEntity:[ETGApc entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [apcMapping addAttributeMappingsFromDictionary:@{
     @"afc"             : @"afc",
     @"apc"             : @"apc",
     @"category"        : @"category",
     @"categoryRange"   : @"categoryRange",
     @"indicator"       : @"indicator",
     @"itd"             : @"itd",
     @"remark"          : @"remark",
     @"revisionType"    : @"phase",
     @"variance"        : @"variance",
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
    
    // Relationship mapping of ETGPortfolio to
    [apcMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"portfolio" withMapping:portfolioMapping]];
    
    // Add ETGApc to Response descriptor
    RKResponseDescriptor *portfolioApcDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:apcMapping method:RKRequestMethodPOST pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_PORTFOLIO_APC_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:portfolioApcDescriptor];
    
    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *apcMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGApc entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [apcMapping_ addAttributeMappingsFromDictionary:@{
     @"AFC"             : @"afc",
     @"APC"             : @"apc",
     @"indicator"       : @"indicator",
     @"ITD"             : @"itd",
     @"remark"          : @"remark",
     @"phase"           : @"phase",
     @"variance"        : @"variance",
     }];
    
    [apcMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"projectKey" toKeyPath:@"portfolio.project.key"]];
    [apcMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"name" toKeyPath:@"portfolio.project.name"]];
    [apcMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"region" toKeyPath:@"portfolio.project.region.name"]];
//    [apcMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"phase" toKeyPath:@"portfolio.project.phase.name"]];

    // Create Core Data to JSON mapping
    _inverseMapping = [apcMapping_ inverseMapping];
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
    
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
//    NSString *strVariance = [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[json valueForKey:@"variance"] integerValue]]];
//    [json removeObjectForKey:@"variance"];
//    [json setObject:strVariance forKey:@"variance"];
    
//    NSString *strVariance = [NSString stringWithFormat:@"%@%@", [json valueForKey:@"variance"], @"%"];
//    [json removeObjectForKey:@"variance"];
//    [json setObject:strVariance forKey:@"variance"];

    return json;
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
                           projectKey:(NSNumber *)projectKey
                              success:(void (^)(NSMutableDictionary *inputData))success
                              failure:(void (^)(NSError *error))failure{
    
//    if (_isReportEnabled) {

        _appDelegate = [[UIApplication sharedApplication] delegate];
        [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeNewLoginInNSUserDefaults:@"N"];
        [ETGNetworkConnection checkAvailability];
        
        if (_appDelegate.isNetworkServerAvailable == YES) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:reportingMonth forKey:@"inpReportingMonth"];
            
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];
            
            NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_APC_PATH];
            NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
            [request setHTTPBody:jsonData];
            
            RKManagedObjectRequestOperation *operation = [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:[[ETGWebService sharedWebService] managedObjectContext] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                
                // Fetch or insert ETGReportingMonth from paramater
                NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
                
                // Save to persistent store
                NSError* error;
                [context saveToPersistentStore:&error];
                
                NSMutableDictionary *inputData = nil;
                success(inputData);
            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                
                NSHTTPURLResponse *response = [[operation HTTPRequestOperation] response];
                NSDictionary *responseHeadersDict = [response allHeaderFields];
                
                [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];
                
                DDLogWarn(@"%@%@ - %@",logWarnPrefix,apcPrefix, webServiceFetchError);
                //        DDLogError(@"%@", strXErrorMsg);
                DDLogError(@"%@%@", logErrorPrefix, responseHeadersDict);
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
    
    [ETGApc deleteAllMatchingPredicate:predicate inContext:context];
    
    NSError* error;
    [context saveToPersistentStore:&error];

}

- (NSMutableArray *)aggregateDataForChartFrom:(NSSet *)cachedData {
    
    NSArray *dataArray = [[NSArray alloc] initWithArray:cachedData.allObjects];
    NSArray *predicateResult = [NSArray array];
    
    NSString* query = [NSString stringWithFormat:@"categoryRange == \"%@\"", @"<-10%"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
    predicateResult = [dataArray filteredArrayUsingPredicate:predicate];
    NSNumber *totalFirstBar = [predicateResult valueForKeyPath:@"@count"];
    
    query = [NSString stringWithFormat:@"categoryRange == \"%@\"", @"(-10%) to (10%)"];
    predicate = [NSPredicate predicateWithFormat:query];
    predicateResult = [dataArray filteredArrayUsingPredicate:predicate];
    NSNumber *totalSecondBar = [predicateResult valueForKeyPath:@"@count"];
    
    query = [NSString stringWithFormat:@"categoryRange == \"%@\"", @">10%"];
    predicate = [NSPredicate predicateWithFormat:query];
    predicateResult = [dataArray filteredArrayUsingPredicate:predicate];
    NSNumber *totalThirdBar = [predicateResult valueForKeyPath:@"@count"];
    
    query = [NSString stringWithFormat:@"categoryRange == \"%@\"", @"<=0%"];
    predicate = [NSPredicate predicateWithFormat:query];
    predicateResult = [dataArray filteredArrayUsingPredicate:predicate];
    NSNumber *totalFourthBar = [predicateResult valueForKeyPath:@"@count"];

    query = [NSString stringWithFormat:@"categoryRange == \"%@\"", @">0%"];
    predicate = [NSPredicate predicateWithFormat:query];
    predicateResult = [dataArray filteredArrayUsingPredicate:predicate];
    NSNumber *totalFifthBar = [predicateResult valueForKeyPath:@"@count"];

    NSMutableDictionary *processedJSON = [NSMutableDictionary dictionaryWithDictionary:@{@"data":@[totalFirstBar,totalSecondBar,totalThirdBar,totalFourthBar, totalFifthBar]}];
    
    NSMutableArray *jsonArray = [NSMutableArray array];
    [jsonArray addObject:processedJSON];
    
    return jsonArray;
    
}

- (BOOL)uacCanSeeReport:(NSString *)reportingMonth{
   /* _haveUAC = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasUACForWebService:[NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_APC_PATH] reportingMonth:reportingMonth];*/
    _haveUAC = YES;
    return _haveUAC;
}

- (BOOL)entityIsEmpty{
    _isEmpty = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasEntriesForEntityName:@"ETGApc"];
    return _isEmpty;
}

- (void)setBaseFilters{
    // Put code to set base filters here...
    //DDLogInfo(@"%@%@", logInfoPrefix, @"Set Base filter");
}

//- (void)setIsReportEnabledFlagTo:(BOOL)yesNo {
//    _isReportEnabled = yesNo;
//}
//
//- (void)setIsTableReportEnabledFlagTo:(BOOL)yesNo {
//    _isTableReportEnabled = yesNo;
//}

- (void)collectReportJSONFrom:(NSSet *)cachedData
              withTableReport:(BOOL)yesNo
                      success:(void (^)(NSMutableDictionary *))success
                      failure:(void (^)(NSError *))failure{
    
    NSError* error;
    NSMutableArray *jsonDict = [NSMutableArray array];
    BOOL isTableEnabled = yesNo;
    
    if (cachedData.count == 0){
        id noData = @"no data";
        jsonDict = noData;

    } else {
        for (ETGApc* apc in cachedData) {
            NSDictionary* json = [self serializeObject:apc];
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
    
    if (error) {
        failure(error);
        DDLogError(@"%@", error.description);
    } else {
        
        if (![jsonDict isEqual: @"no data"]) {
            
            NSMutableDictionary *processedJSON;
            
            if (isTableEnabled) {
                processedJSON = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                @"tabledata": jsonDict,
                                                                                @"chartdata": [self aggregateDataForChartFrom:cachedData]}];
            } else {
                processedJSON = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                @"tabledata": @"disabled",
                                                                                @"chartdata": [self aggregateDataForChartFrom:cachedData]}];
            }
            
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
