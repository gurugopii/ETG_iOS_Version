//
//  ETGPortfolioCpb.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGPortfolioCpb.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h"
//Models
#import "ETGPortfolio.h"
#import "ETGCpb.h"
#import "ETGRegion.h"
#import "ETGReportingMonth.h"
#import "ETGCostAllocation.h"
//Utilities
#import "NSDate+ETGDateFormatter.h"
#import "NSString+ETGStringFormatter.h"
#import "NSSet+ETGMonthCompare.h"

#import "ETGToken.h"
#import "ETGJSONKeyReplaceManipulation.h"

#import "ETGCoreDataUtilities.h"


@interface ETGPortfolioCpb ()

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

@implementation ETGPortfolioCpb

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupCpbMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupCpbMappings {
    
    // Attribute Mappings for ETGCpb
    RKEntityMapping *cpbMapping = [[RKEntityMapping alloc] initWithEntity:[ETGCpb entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [cpbMapping addAttributeMappingsFromDictionary:@{
     @"latestCPB"       : @"latestCpb",
     @"fyyep"           : @"fyYep",
     @"fyytd"           : @"fyYtd",
     @"indicator"       : @"indicator",
     @"variance"        : @"variance",
     @"reportingDate"   : @"reportingDate"
     }];
    
    // Attribute Mappings for ETGCostAllocation
    RKEntityMapping *costAllocationMapping = [[RKEntityMapping alloc] initWithEntity:[ETGCostAllocation entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [costAllocationMapping addAttributeMappingsFromDictionary:@{
                                                                @"costAllocationKey"   : @"key",
                                                                @"costAllocation"   : @"name"
                                                                }];
    costAllocationMapping.identificationAttributes = @[@"name"];

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
    
    // Relationship mapping of ETGPortfolio to ETGCpb
    [cpbMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"portfolio" withMapping:portfolioMapping]];
    
    // Relationship mapping of ETGCostAllocation to ETGCpb
    [cpbMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"costAllocation" withMapping:costAllocationMapping]];
    
    // Add ETGCpb to Response descriptor
    RKResponseDescriptor *portfolioCpbDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:cpbMapping method:RKRequestMethodPOST pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_PORTFOLIO_CPB_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:portfolioCpbDescriptor];
    
    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *cpbMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGCpb entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [cpbMapping_ addAttributeMappingsFromDictionary:@{
     @"approvedcpbequity"     : @"latestCpb",
     @"fyyepequity"           : @"fyYep",
     @"fyytdequity"           : @"fyYtd",
     @"indicator"             : @"indicator",
     @"variance"              : @"variance",
     @"reportingdate"         : @"reportingDate",
     }];
    
    [cpbMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"projectKey" toKeyPath:@"portfolio.project.key"]];
    [cpbMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"name" toKeyPath:@"portfolio.project.name"]];
    [cpbMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"region" toKeyPath:@"portfolio.project.region.name"]];
   
    // Create Core Data to JSON mapping
    _inverseMapping = [cpbMapping_ inverseMapping];
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
//  
//    NSNumberFormatter *chartformatter = [[NSNumberFormatter alloc] init];
//    [chartformatter setNumberStyle:NSNumberFormatterPercentStyle];
//    
//    
//    NSString *strVariance = [NSString stringWithFormat:@"%@", [json valueForKey:@"variance"]];
//    NSString *actualStr = [chartformatter stringFromNumber:numberFromString(strVariance)];
//
//    [json removeObjectForKey:@"variance"];
//    [json setObject:actualStr forKey:@"variance"];

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
            
            NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_CPB_PATH];
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
               
                DDLogWarn(@"%@%@ - %@",logWarnPrefix,cpbPrefix, webServiceFetchError);
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
    
    [ETGCpb deleteAllMatchingPredicate:predicate inContext:context];
    
    NSError* error;
    [context saveToPersistentStore:&error];

}

- (NSArray *)aggregateDataForChartFrom:(NSSet *)cachedData reportingMonth:(NSString *)reportingMonth {
    
    NSArray *dataArray = [[NSArray alloc] initWithArray:cachedData.allObjects];
    NSArray *uniqueMonths = [[NSArray alloc] initWithArray:[dataArray valueForKeyPath:@"@distinctUnionOfObjects.reportingDate"]];
    NSMutableArray *aggregatedTotal = [[NSMutableArray alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ddMMMyyyy"];

    for (int i = 0; i < [uniqueMonths count]; i++) {
        
        NSMutableArray *results = [NSMutableArray array];
        NSMutableDictionary *aggregatedDict = [[NSMutableDictionary alloc] init];

        // Get data by Reporting Date
        for (int j = 0; j < dataArray.count; j++) {
            //NSDate *dateUniqueMonth = [dateFormatter dateFromString:[uniqueMonths objectAtIndex:i]];
            //NSDate *dateReportingDate = [dateFormatter dateFromString:[[dataArray objectAtIndex:j] valueForKey:@"reportingDate"]];
            NSDate *dateUniqueMonth = [uniqueMonths objectAtIndex:i];
            NSDate *dateReportingDate = [[dataArray objectAtIndex:j] valueForKey:@"reportingDate"];
            //NSLog(@"%@", [[dataArray objectAtIndex:j] valueForKey:@"reportingDate"]);
            
            if ([[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] isMonthOfDate:dateReportingDate equalToDate:dateUniqueMonth]) {
                [results addObject:[dataArray objectAtIndex:j]];
            }
        }

        if ([results count]) {
            
            // YEP - Check if all values are nil
            NSPredicate *nullPredicate = [NSPredicate predicateWithFormat:@"fyYep == %@", nil];
            NSArray *nullObjectsYep = [results filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalYEP;
            
            if ([results count] == [nullObjectsYep count]) {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalYEP"];
            }else {
                totalYEP = [NSNumber numberWithFloat:[[results valueForKeyPath:@"@sum.fyYep"] floatValue]/1000000000];
                [aggregatedDict setValue:totalYEP forKey:@"totalYEP"];
            }

            // YTD - Check if all values are nil
            nullPredicate = [NSPredicate predicateWithFormat:@"fyYtd == %@", nil];
            NSArray *nullObjectsYtd = [results filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalYTD;
            
            if ([results count] == [nullObjectsYtd count]) {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalYTD"];
            }else {
                totalYTD = [NSNumber numberWithFloat:[[results valueForKeyPath:@"@sum.fyYtd"] floatValue]/1000000000];
                [aggregatedDict setValue:totalYTD forKey:@"totalYTD"];
            }

            // Approved CPB - Check if all values are nil
            nullPredicate = [NSPredicate predicateWithFormat:@"latestCpb == %@", nil];
            NSArray *nullObjectsApprovedCpb = [results filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalCPB;
            
            if ([results count] == [nullObjectsApprovedCpb count]) {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalCPB"];
            }else {
                totalCPB = [NSNumber numberWithFloat:[[results valueForKeyPath:@"@sum.latestCpb"] floatValue]/1000000000];
                [aggregatedDict setValue:totalCPB forKey:@"totalCPB"];
            }

            [aggregatedDict setValue:[uniqueMonths objectAtIndex:i] forKey:@"month"];
            [aggregatedTotal addObject:aggregatedDict];

        } else {
            [aggregatedDict setValue:[NSNull null] forKey:@"totalYEP"];
            [aggregatedDict setValue:[NSNull null] forKey:@"totalYTD"];
            [aggregatedDict setValue:[NSNull null] forKey:@"totalCPB"];
            [aggregatedDict setValue:[uniqueMonths objectAtIndex:i] forKey:@"month"];
            [aggregatedTotal addObject:aggregatedDict];
        }
    }
    
    aggregatedTotal = [aggregatedTotal toConsecutiveMonthsForCpb:reportingMonth];
    
    NSMutableDictionary *processedYTD = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                        @"name":@"FY YTD Actual Equity",
                                                                                        @"data":[aggregatedTotal valueForKey:@"totalYTD"]}];
    NSMutableDictionary *processedCPB = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                        @"name":@"Approved CPB Equity",
                                                                                        @"data":[aggregatedTotal valueForKey:@"totalCPB"]}];
    NSMutableDictionary *processedYEP = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                        @"name":@"FY YEP Equity",
                                                                                        @"data":[aggregatedTotal valueForKey:@"totalYEP"]}];
    
    NSArray *processedJSON = [NSArray arrayWithObjects:processedYTD, processedCPB, processedYEP, nil];
    
    return processedJSON;
}

- (NSArray *)aggregateDataForTableFrom:(NSMutableArray *)jsonDict reportingMonth:(NSString *)reportingMonth {
    
    if (![jsonDict isEqual:@"no data"]) {

        NSMutableArray *matchedRecords = [NSMutableArray array];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        //TODO: Verify date conversion
//        NSDate *dateReportingMonth = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",reportingMonth]];
        NSDate *dateReportingMonth = [reportingMonth toDate];

        for (int i = 0; i < [jsonDict count]; i++) {
            [dateFormatter setDateFormat:@"ddMMMyyyy"];
            //NSDate *dateReportingDate = [dateFormatter dateFromString:[[jsonDict objectAtIndex:i] valueForKey:@"reportingdate"]];
            NSDate *dateReportingDate = [[jsonDict objectAtIndex:i] valueForKey:@"reportingdate"];

            if ([[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] isMonthOfDate:dateReportingDate equalToDate:dateReportingMonth]) {
                
                [matchedRecords addObject:[jsonDict objectAtIndex:i]];
            }
        }
        
        // Convert to percent
        for (int i = 0; i < [matchedRecords count]; i++) {

            if ([[matchedRecords objectAtIndex:i] valueForKey:@"variance"]) {
                
                NSDecimalNumber *variance = [[matchedRecords objectAtIndex:i] valueForKey:@"variance"];
                NSDecimalNumber *percentageDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:[@100.0 decimalValue]];
                variance = [variance decimalNumberByMultiplyingBy:percentageDecimalNumber];
                
                [[matchedRecords objectAtIndex:i] removeObjectForKey:@"variance"];
                [[matchedRecords objectAtIndex:i] setObject:variance forKey:@"variance"];
                
            }
        }

        NSArray *results = [[NSArray alloc] initWithArray:matchedRecords];
        return results;
    }

    return 0;
}

- (BOOL)uacCanSeeReport:(NSString *)reportingMonth{
    /*_haveUAC = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasUACForWebService:[NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_CPB_PATH] reportingMonth:reportingMonth];*/
    _haveUAC = YES;
    return _haveUAC;
}

- (BOOL)entityIsEmpty{
    _isEmpty = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasEntriesForEntityName:@"ETGCpb"];
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
               reportingMonth:(NSString *)reportingMonth
              withTableReport:(BOOL)yesNo
                      success:(void (^)(NSMutableDictionary *))success
                      failure:(void (^)(NSError *))failure{
    
    // Create Core Data to JSON mapping
    NSError* error;
    NSMutableArray *jsonDict = [NSMutableArray array];
    BOOL isTableEnabled = yesNo;

    if (cachedData.count == 0) {
        id noData = @"no data";
        jsonDict = noData;
    } else {
        for (ETGCpb* cpb in cachedData) {
            NSDictionary* json = [self serializeObject:cpb];
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
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    } else {
        
        if (![jsonDict isEqual: @"no data"]) {
            
            NSMutableDictionary *processedJSON;
            
            if (isTableEnabled) {
                processedJSON = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                @"tabledata": [self aggregateDataForTableFrom:jsonDict reportingMonth:reportingMonth],
                                                                                @"chartdata": [self aggregateDataForChartFrom:cachedData reportingMonth:reportingMonth]}];
            } else {
                processedJSON = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                @"tabledata": @"disabled",
                                                                                @"chartdata": [self aggregateDataForChartFrom:cachedData reportingMonth:reportingMonth]}];
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
