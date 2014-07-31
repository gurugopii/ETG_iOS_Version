//
//  ETGProjectBudgetPerfomance.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/20/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
//CATH 09.20.2013
#import "ETGProjectBudgetPerfomance.h"
#import "ETGWebServiceCommonImports.h"
//Models
#import "ETGProjectSummary.h"
#import "ETGBudgetPerformance_Project.h"

#define ETG_PROJECT_BUDGET_PERFORMANCE_PATH @"/Service1.svc/"

@interface ETGProjectBudgetPerfomance ()

@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGProjectBudgetPerfomance

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupBudgetPerformanceMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupBudgetPerformanceMappings {
    
    // Attribute Mappings for Budget Performance
    RKEntityMapping *budgetPerformanceMapping = [[RKEntityMapping alloc] initWithEntity:[ETGBudgetPerformance_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [budgetPerformanceMapping addAttributeMappingsFromDictionary:@{
     @"ForecastDescription" : @"forecastDescription",
     @"ForecastValue"       : @"forecastValue",
     @"ForecastVariance"    : @"forecastVariance",
     @"Indicator"           : @"indicator",
     @"PlanDescription"     : @"planDescription",
     @"PlanValue"           : @"planValue"
     }];
    
    RKResponseDescriptor *budgetPerformanceDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:budgetPerformanceMapping method:RKRequestMethodGET pathPattern:ETG_PROJECT_BUDGET_PERFORMANCE_PATH keyPath:@"tabledata" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:budgetPerformanceDescriptor];
    
    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *budgetPerformanceMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGBudgetPerformance_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [budgetPerformanceMapping_ addAttributeMappingsFromDictionary:@{
     @"ForecastDescription" : @"forecastDescription",
     @"ForecastValue"       : @"forecastValue",
     @"ForecastVariance"    : @"forecastVariance",
     @"Indicator"           : @"indicator",
     @"PlanDescription"     : @"planDescription",
     @"PlanValue"           : @"planValue"
     }];
    
    // Create Core Data to JSON mapping
    _inverseMapping = [budgetPerformanceMapping_ inverseMapping];
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
        NSLog(@"Serialization error: %@", error);
        return nil;
    }
    return json;
}

-(void) sendRequestWithReportingMonth:(NSString *)reportingMonth
                           projectKey:(NSNumber *)projectKey
                              success:(void (^)(NSString *))success
                              failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"ReportingMonth"];
    [params setObject:[projectKey stringValue] forKey:@"ProjectKey"];
    RKManagedObjectRequestOperation *budgetOperation = [_managedObject appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:ETG_PROJECT_BUDGET_PERFORMANCE_PATH parameters:params];
    
    void (^successBlock)(RKObjectRequestOperation*, RKMappingResult*) = ^(RKObjectRequestOperation *budgetOperation, RKMappingResult *mappingResult) {
        
        // Fetch or insert ETGReportingMonth from paramater
        NSManagedObjectContext *context = [[ETGWebService sharedWebService] managedObjectContext];
        NSString* query = [NSString stringWithFormat:
                           @"(SUBQUERY(project, $project, ANY $project.key == %@).@count != 0) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)",
                           [params valueForKey:@"ProjectKey"], [params valueForKey:@"ReportingMonth"]];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
        ETGProjectSummary *project = [ETGProjectSummary findFirstWithPredicate:predicate inContext:context];
        
        // Add all ETGBudgetPerformance_Project to ETGProjectSummary
        [project addEtgBudgetPerformance_Projects:[mappingResult set]];
        
        // Add ETGProjectSummary to ETGBudgetPerformance_Project
        for (ETGBudgetPerformance_Project *budget in [mappingResult set]) {
            budget.projectSummary = project;
        }
        // Save to persistent store
        NSError* error;
        [context saveToPersistentStore:&error];
        
        if (error) {
            NSLog(@"Error in saving to persistent store");
        }
        
        // Create Core Data to JSON mapping
        NSMutableArray *jsonDict = [NSMutableArray array];
        for (ETGBudgetPerformance_Project *budget in [mappingResult set]) {
            NSDictionary* json = [self serializeObject:budget];
            if (!json) {
                //An error occurred
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:@"Failed to convert core data to JSON" forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:@"ETG" code:100 userInfo:errorDetail];
            } else {
                [jsonDict addObject:json];
            }
        }
        if (error) {
            failure(error);
        } else {
            NSData *data = [RKMIMETypeSerialization dataFromObject:jsonDict MIMEType:RKMIMETypeJSON error:&error];
            if (error) {
                failure(error);
            } else {
                NSString *jsonString = [[NSString alloc] initWithData:data
                                                             encoding:NSUTF8StringEncoding];
                success(jsonString);
            }
        }
    };
    void (^errorBlock)(RKObjectRequestOperation*, NSError*) = ^(RKObjectRequestOperation *budgetOperation, NSError *error) {
        failure(error);
    };
    [budgetOperation setCompletionBlockWithSuccess:successBlock failure:errorBlock];
    [_managedObject enqueueObjectRequestOperation:budgetOperation];
}

@end
