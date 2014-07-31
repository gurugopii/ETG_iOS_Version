//
//  ETGProjectAfe.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/20/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
//CATH 09.20.2013
#import "ETGProjectAFE.h"
#import "ETGWebServiceCommonImports.h"
//Models
#import "ETGProjectSummary.h"
#import "ETGAfe_Project.h"

#define ETG_PROJECT_AFE_PATH @"/Service1.svc/"

@interface ETGProjectAFE ()

@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGProjectAFE

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupAfeMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupAfeMappings {
    
    // Attribute Mappings for AFE
    RKEntityMapping *afeMapping = [[RKEntityMapping alloc] initWithEntity:[ETGAfe_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [afeMapping addAttributeMappingsFromDictionary:@{
     @"AFE"         : @"afe",
     @"Indicator"   : @"indicator",
     @"Status"      : @"status"
     }];
    
    RKResponseDescriptor *projectAfeDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:afeMapping method:RKRequestMethodGET pathPattern:ETG_PROJECT_AFE_PATH keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:projectAfeDescriptor];
    
    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *afeMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGAfe_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [afeMapping_ addAttributeMappingsFromDictionary:@{
     @"AFE"         : @"afe",
     @"Indicator"   : @"indicator",
     @"Status"      : @"status"
     }];
    
    // Create Core Data to JSON mapping
    _inverseMapping = [afeMapping_ inverseMapping];
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
    RKManagedObjectRequestOperation *afeOperation = [_managedObject appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:ETG_PROJECT_AFE_PATH parameters:params];
    
    void (^successBlock)(RKObjectRequestOperation*, RKMappingResult*) = ^(RKObjectRequestOperation *afeOperation, RKMappingResult *mappingResult) {
        
        // Fetch or insert ETGReportingMonth from paramater
        NSManagedObjectContext *context = [[ETGWebService sharedWebService] managedObjectContext];
        NSString* query = [NSString stringWithFormat:
                           @"(SUBQUERY(project, $project, ANY $project.key == %@).@count != 0) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)",
                           [params valueForKey:@"ProjectKey"], [params valueForKey:@"ReportingMonth"]];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
        ETGProjectSummary *project = [ETGProjectSummary findFirstWithPredicate:predicate inContext:context];
        
        // Add all ETGAfe_Project to ETGProjectSummary
        [project addEtgAfe_Projects:[mappingResult set]];
        
        // Add ETGProjectSummary to ETGAfe_Project
        for (ETGAfe_Project *afe in [mappingResult set]) {
            afe.projectSummary = project;
        }
        // Save to persistent store
        NSError* error;
        [context saveToPersistentStore:&error];
        
        if (error) {
            NSLog(@"Error in saving to persistent store");
        }
        
        // Create Core Data to JSON mapping
        NSMutableArray *jsonDict = [NSMutableArray array];
        for (ETGAfe_Project *afe in [mappingResult set]) {
            NSDictionary* json = [self serializeObject:afe];
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
    void (^errorBlock)(RKObjectRequestOperation*, NSError*) = ^(RKObjectRequestOperation *afeOperation, NSError *error) {
        failure(error);
    };
    [afeOperation setCompletionBlockWithSuccess:successBlock failure:errorBlock];
    [_managedObject enqueueObjectRequestOperation:afeOperation];
}

@end
