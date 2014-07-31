//
//  ETGPortfolioHydrocarbon.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
//CATH 09.18.2013
#import "ETGPortfolioHydrocarbon.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h"
//Models
#import "ETGHydrocarbon.h"
#import "ETGPortfolio.h"
#import "ETGRegion.h"
#import "ETGReportingMonth.h"

#import "ETGToken.h"

#import "ETGCoreDataUtilities.h"
#import "ETGJSONKeyReplaceManipulation.h"


@interface ETGPortfolioHydrocarbon ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;
@property (nonatomic) BOOL isEmpty;
@property (nonatomic) BOOL haveUAC;
@property (nonatomic) BOOL isReportEnabled;

@end

@implementation ETGPortfolioHydrocarbon

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupHydrocarbonMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupHydrocarbonMappings {
    
    // Attribute Mappings for Hydrocarbon
    RKEntityMapping *hydrocarbonMapping = [[RKEntityMapping alloc] initWithEntity:[ETGHydrocarbon entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [hydrocarbonMapping addAttributeMappingsFromDictionary:@{
     @"actualForeCast": @"actualforecast",
     @"indicator": @"indicator",
     @"planDate": @"plan",
     @"milestoneType" : @"group"
     }];
    
    RKEntityMapping *portfolioMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPortfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [portfolioMapping addAttributeMappingsFromDictionary:@{
                                                           @"projectKey"  : @"projectKey",
                                                           @"@metadata.reportingMonth"   : @"reportMonth"
                                                           }];
    portfolioMapping.identificationAttributes = @[@"projectKey", @"reportMonth"];
    
    RKEntityMapping *projectMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectMapping addAttributeMappingsFromDictionary:@{
     @"projectKey"  : @"key",
     @"projectName" : @"name"
     }];
    projectMapping.identificationAttributes = @[@"key", @"name"];
    
    RKEntityMapping *reportingMonthMapping = [[RKEntityMapping alloc] initWithEntity:[ETGReportingMonth entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [reportingMonthMapping addAttributeMappingsFromDictionary:@{
                                                                @"@metadata.reportingMonth"   : @"name"
                                                                }];
    reportingMonthMapping.identificationAttributes = @[@"name"];
    
    // Relationship Mappings of Project to Region
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
    
    // Relationship mapping of ETGPortfolio to ETGHydrocarbon
    [hydrocarbonMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"portfolio" withMapping:portfolioMapping]];
    
    // Add ETGHydrocarbon to Response descriptor
    RKResponseDescriptor *portfolioHydrocarbonDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:hydrocarbonMapping method:RKRequestMethodPOST pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_PORTFOLIO_HYDROCARBON_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:portfolioHydrocarbonDescriptor];
    
    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *hydrocarbonMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGHydrocarbon entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [hydrocarbonMapping_ addAttributeMappingsFromDictionary:@{
     @"actualforecast": @"actualforecast",
     @"indicator": @"indicator",
     @"plan": @"plan",
     @"group" : @"group"
     }];
    
    [hydrocarbonMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"projectKey" toKeyPath:@"portfolio.project.key"]];
    [hydrocarbonMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"name" toKeyPath:@"portfolio.project.name"]];
    [hydrocarbonMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"region" toKeyPath:@"portfolio.project.region.name"]];
    
    _inverseMapping = [hydrocarbonMapping_ inverseMapping];
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
        DDLogError(@"%@%@", logErrorPrefix,[NSString stringWithFormat:serializationError, error]);
        return nil;
    }
    return json;
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
                           projectKey:(NSNumber *)projectKey
                              success:(void (^)(NSMutableArray *inputData))success
                              failure:(void (^)(NSError *error))failure{
 
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
        
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_HYDROCARBON_PATH];
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
            
            NSMutableArray *inputData = nil;
            success(inputData);
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            
            NSHTTPURLResponse *response = [[operation HTTPRequestOperation] response];
            NSDictionary *responseHeadersDict = [response allHeaderFields];
            [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];
            DDLogWarn(@"%@%@ - %@",logWarnPrefix,hcPrefix, webServiceFetchError);
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

}

// Delete existing data
- (void) removeDuplicatesForReportingMonth:(NSString *)reportingMonth {
    
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    //TODO: Verify date conversion
//    NSString* query = [NSString stringWithFormat:@"(SUBQUERY(portfolio, $portfolio, ANY $portfolio.reportingMonth.name LIKE[cd] \"%@\").@count != 0)", reportingMonth];
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(portfolio, $portfolio, ANY $portfolio.reportingMonth.name == %@).@count != 0)", [reportingMonth toDate]];
    
    [ETGHydrocarbon deleteAllMatchingPredicate:predicate inContext:context];
    
    NSError* error;
    [context saveToPersistentStore:&error];

}

- (BOOL)uacCanSeeReport:(NSString *)reportingMonth{
    _haveUAC = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasUACForWebService:[NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_HYDROCARBON_PATH] reportingMonth:reportingMonth];
    _haveUAC = YES;
    return _haveUAC;
}

- (BOOL)entityIsEmpty{
    _isEmpty = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasEntriesForEntityName:@"ETGHydrocarbon"];
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
                      success:(void (^)(NSMutableArray *))success
                      failure:(void (^)(NSError *))failure{
    
    // Create Core Data to JSON mapping
    NSError* error;
    NSMutableArray *jsonDict = [NSMutableArray array];
    
//    if (_isReportEnabled) {
        if (cachedData.count == 0) {
            id noData = @"no data";
            jsonDict = noData;
        } else {
            for (ETGHydrocarbon *hydrocarbon in cachedData) {
                NSDictionary* json = [self serializeObject:hydrocarbon];
                if (!json) {
                    //An error occurred
                    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                    [errorDetail setValue:coreDataToJSONError forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:@"ETG" code:100 userInfo:errorDetail];
                    DDLogError(@"%@%@", logErrorPrefix,error.description);
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
            
            success([self replaceMutableArrayNSDateWithNSString:jsonDict]);
        } else {
            
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
            NSError *noDataerror = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
            failure(noDataerror);
            DDLogError(@"%@%@", logErrorPrefix,noDataerror.description);
        }
    }

}
- (NSMutableArray *)replaceMutableArrayNSDateWithNSString:(NSMutableArray *)json{
    for(NSMutableDictionary *dict in json){
        for (NSString *key in [dict allKeys]){
            if ([[dict valueForKey:key] isKindOfClass:[NSDate class]]) {
              
                NSString *strDate = [NSString stringWithFormat:@"%@", [dict valueForKey:key]];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
                NSDate *date = [dateFormatter dateFromString:strDate];
                
                [dateFormatter setDateFormat:@"dd MMM yyyy"];
                NSString *dateWithNewFormat = [dateFormatter stringFromDate:date];
                //NSLog(@"dateWithNewFormat: %@", dateWithNewFormat);
                
                [dict removeObjectForKey:key];
                [dict setObject:dateWithNewFormat forKey:key];
            }
        }
        
    }
    
    return  json;
}

@end
