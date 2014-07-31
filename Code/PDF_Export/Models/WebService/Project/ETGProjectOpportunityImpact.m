//
//  ETGProjectOpportunityImpact.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/20/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGProjectOpportunityImpact.h"
#import "ETGWebServiceCommonImports.h"
//Models
#import "ETGProjectSummary.h"
#import "ETGOpportunityImpact_Project.h"

#define ETG_PROJECT_OPPORTUNITY_IMPACT_PATH @"/Service1.svc/"

@interface ETGProjectOpportunityImpact ()

@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGProjectOpportunityImpact

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupOpportunityImpactMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupOpportunityImpactMappings {
    
    // Attribute Mappings for Opportunity Impact
    RKEntityMapping *opportunityImpactMapping = [[RKEntityMapping alloc] initWithEntity:[ETGOpportunityImpact_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [opportunityImpactMapping addAttributeMappingsFromDictionary:@{
     @"Activity"                : @"activity",
     @"Cluster"                 : @"cluster",
     @"Cost"                    : @"cost",
     @"OpportunityDescription"  : @"opportunityDescription",
     @"PositiveImpact"          : @"positiveImpact",
     @"Probability"             : @"probability",
     @"Production"              : @"production"
     }];
    
    RKResponseDescriptor *opportunityImpactDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:opportunityImpactMapping method:RKRequestMethodGET pathPattern:ETG_PROJECT_OPPORTUNITY_IMPACT_PATH keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:opportunityImpactDescriptor];
    
    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *opportunityImpactMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGOpportunityImpact_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [opportunityImpactMapping_ addAttributeMappingsFromDictionary:@{
     @"Activity"                : @"activity",
     @"Cluster"                 : @"cluster",
     @"Cost"                    : @"cost",
     @"OpportunityDescription"  : @"opportunityDescription",
     @"PositiveImpact"          : @"positiveImpact",
     @"Probability"             : @"probability",
     @"Production"              : @"production"
     }];
    
    // Create Core Data to JSON mapping
    _inverseMapping = [opportunityImpactMapping_ inverseMapping];
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
    RKManagedObjectRequestOperation *opportunityImpactOperation = [_managedObject appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:ETG_PROJECT_OPPORTUNITY_IMPACT_PATH parameters:params];
    
    void (^successBlock)(RKObjectRequestOperation*, RKMappingResult*) = ^(RKObjectRequestOperation *opportunityImpactOperation, RKMappingResult *mappingResult) {
        
        // Fetch or insert ETGReportingMonth from paramater
        NSManagedObjectContext *context = [[ETGWebService sharedWebService] managedObjectContext];
        NSString* query = [NSString stringWithFormat:
                           @"(SUBQUERY(project, $project, ANY $project.key == %@).@count != 0) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)",
                           [params valueForKey:@"ProjectKey"], [params valueForKey:@"ReportingMonth"]];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
        ETGProjectSummary *project = [ETGProjectSummary findFirstWithPredicate:predicate inContext:context];
        
        // Add all ETGOpportunityImpact_Project to ETGProjectSummary
        [project addEtgOpportunityImpact_Projects:[mappingResult set]];
        
        // Add ETGProjectSummary to ETGOpportunityImpact_Project
        for (ETGOpportunityImpact_Project *opportunity in [mappingResult set]) {
            opportunity.projectSummary = project;
        }
        // Save to persistent store
        NSError* error;
        [context saveToPersistentStore:&error];
        
        if (error) {
            NSLog(@"Error in saving to persistent store");
        }
        
        // Create Core Data to JSON mapping
        NSMutableArray *jsonDict = [NSMutableArray array];
        for (ETGOpportunityImpact_Project *opportunity in [mappingResult set]) {
            NSDictionary* json = [self serializeObject:opportunity];
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
    void (^errorBlock)(RKObjectRequestOperation*, NSError*) = ^(RKObjectRequestOperation *opportunityImpactOperation, NSError *error) {
        failure(error);
    };
    [opportunityImpactOperation setCompletionBlockWithSuccess:successBlock failure:errorBlock];
    [_managedObject enqueueObjectRequestOperation:opportunityImpactOperation];
}


@end
