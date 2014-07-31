//
//  ETGAllPortfolios.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGAllPortfolios.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h" // Network checking
//Models
#import "ETGPortfolio.h"
//Relationships
#import "ETGRegion.h"
#import "ETGReportingMonth.h"

#import "ETGToken.h"


@interface ETGAllPortfolios ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGAllPortfolios

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupPortfolioMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupPortfolioMappings {
    
    // Attribute Mappings for Portfolio
    RKEntityMapping *portfolioMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPortfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [portfolioMapping addAttributeMappingsFromDictionary:@{
                                                           @"projectKey"  : @"projectKey",
                                                           @"@metadata.reportingMonth"   : @"reportMonth"
                                                           }];
    portfolioMapping.identificationAttributes = @[@"projectKey", @"reportMonth"];

    // Relationship Mappings of Portfolio to Project
    RKEntityMapping *projectMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectMapping addAttributeMappingsFromDictionary:@{
     @"projectKey"   : @"key",
     @"projectName" : @"name"
     }];
    projectMapping.identificationAttributes = @[@"key",@"name"];
    
    // Relationship Mappings of Project to Region
    RKEntityMapping *regionMapping = [[RKEntityMapping alloc] initWithEntity:[ETGRegion entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [regionMapping addAttributeMappingsFromDictionary:@{
     @"region"  : @"name"
     }];
    regionMapping.identificationAttributes = @[@"key",@"name"];
    
    //Adding of Relationship Mappings of Portfolio to Project
    [portfolioMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"project" withMapping:projectMapping]];
    //Adding of Relationship Mappings of Project to Region
    [projectMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"region" withMapping:regionMapping]];
    
    RKResponseDescriptor *portfolioDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:portfolioMapping method:RKRequestMethodPOST pathPattern:ETG_PORTFOLIO_PATH keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:portfolioDescriptor];
    
    _mapping = portfolioMapping;
    
    // Create Core Data to JSON mapping
    RKEntityMapping *portfolioMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGPortfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    
    [portfolioMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"projectKey" toKeyPath:@"project.key"]];
    [portfolioMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"projectName" toKeyPath:@"project.name"]];
    [portfolioMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"region" toKeyPath:@"project.region.name"]];
    _inverseMapping = [portfolioMapping_ inverseMapping];
}

- (NSDictionary *)serializeObject:(NSManagedObject *)object {
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
        DDLogError(@"%@%@",logErrorPrefix,[NSString stringWithFormat:serializationError, error]);
        return nil;
    }
    return json;
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
                              success:(void (^)(NSString *inputData))success
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
        
        NSString *path = [NSString stringWithFormat:@"%@%@", kBaseURL, ETG_PORTFOLIO_PATH];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
        [request setHTTPBody:jsonData];
        
        RKManagedObjectRequestOperation *operation = [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:[[ETGWebService sharedWebService] managedObjectContext] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            
            // Fetch or insert ETGReportingMonth from paramater
            NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
            //TODO: Verify date conversion
//            NSString* query = [NSString stringWithFormat:@"name == %@", [params valueForKey:@"inpReportingMonth"]];
//            NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@", [[params valueForKey:@"inpReportingMonth"] toDate]];
            ETGReportingMonth* reportingMonth = [ETGReportingMonth findFirstWithPredicate:predicate inContext:context];
            
            // If reporting month does not exist, set a new one
            if (!reportingMonth.name) {
                reportingMonth = [ETGReportingMonth createInContext:context];
                //TODO: Verify date conversion
//                reportingMonth.name = [params valueForKey:@"ReportingMonth"];
                reportingMonth.name = [[params valueForKey:@"ReportingMonth"] toDate];
            }
            
            // Add all ETGPortfolio to ETGReportingMonth
            [reportingMonth addPortfolios:[mappingResult set]];
            
            // Add ETGReportingMonth to ETGPortfolio
            for (ETGPortfolio *portfolio in [mappingResult set]) {
                portfolio.reportingMonth = reportingMonth;
            }
            
            // Save to persistent store
            NSError* error;
            [context saveToPersistentStore:&error];
            
            if (error) {
                DDLogError(@"%@%@", logErrorPrefix, persistentStoreError);
            }
            
            // Create Core Data to JSON mapping
            NSMutableArray *jsonDict = [NSMutableArray array];
            for (ETGPortfolio *portfolio in [mappingResult set]) {
                NSDictionary* json = [self serializeObject:portfolio];
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
            if (error) {
                failure(error);
                DDLogError(@"%@%@", logErrorPrefix, error.description);
            } else {
                NSData *data = [RKMIMETypeSerialization dataFromObject:jsonDict MIMEType:RKMIMETypeJSON error:&error];
                if (error) {
                    failure(error);
                    DDLogError(@"%@%@", logErrorPrefix, error.description);
                } else {
                    NSString *jsonString = [[NSString alloc] initWithData:data
                                                                 encoding:NSUTF8StringEncoding];
                    success(jsonString);
                }
            }
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            
            DDLogWarn(@"%@%@", logWarnPrefix, webServiceFetchError);
            NSManagedObjectContext* context = [NSManagedObjectContext contextForCurrentThread];
            //TODO: Verify date conversion
//            NSString* query = [NSString stringWithFormat:@"name LIKE[cd] \"%@\"", [params valueForKey:@"inpReportingMonth"]];
//            NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@", [[params valueForKey:@"inpReportingMonth"] toDate]];
            //Check if reporting month from web service is existing in core data
            ETGReportingMonth* reportingMonth = [ETGReportingMonth findFirstWithPredicate:predicate inContext:context];
            if (reportingMonth != nil) {
                NSSet* cachedData = reportingMonth.scorecards;
                // Create Core Data to JSON mapping
                NSMutableArray *jsonDict = [NSMutableArray array];
                for (ETGPortfolio *portfolio in cachedData) {
                    NSDictionary* json = [self serializeObject:portfolio];
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
                NSError* parsingError;
                NSData *data = [RKMIMETypeSerialization dataFromObject:jsonDict MIMEType:RKMIMETypeJSON error:&parsingError];
                if (parsingError) {
                    failure(parsingError);
                    DDLogError(@"%@%@", logErrorPrefix,parsingError.description);
                } else {
                    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    success(jsonString);
                }
            } else {
                failure(error);
                DDLogError(@"%@%@", logErrorPrefix,error.description);
            }
            
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
//- (void) removeDuplicatesForReportingMonth:(NSString *)reportingMonth {
- (void)removeDuplicatesForReportingMonth:(NSString *)reportingMonth
                               withUserId:(NSString *)userId
                                  success:(void (^)(bool removed))success
                                  failure:(void (^)(NSError *))failure {

    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    //TODO: Verify date conversion
//    NSString* query = [NSString stringWithFormat:@"(SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name LIKE[cd] \"%@\").@count != 0)", reportingMonth];
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)", [reportingMonth toDate]];
    
    [ETGPortfolio deleteAllMatchingPredicate:predicate inContext:context];
    
    NSError* error;
    [context saveToPersistentStore:&error];
    
    if (error) {
        failure(error);
    } else {
        success(YES);
    }
}
@end
