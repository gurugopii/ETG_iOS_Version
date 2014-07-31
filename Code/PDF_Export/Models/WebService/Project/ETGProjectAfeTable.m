//
//  ETGProjectAfeTable.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/20/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
//CATH 09.20.2013
#import "ETGProjectAfeTable.h"
#import "ETGWebServiceCommonImports.h"
//Models
#import "ETGProjectSummary.h"
#import "ETGAfeTable_Project.h"

#define ETG_PROJECT_AFE_TABLE_PATH @"/Service1.svc/"

@interface ETGProjectAFETable ()

@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGProjectAFETable

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupAfeTableMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupAfeTableMappings {
    
    // Attribute Mappings for AFE Table
    RKEntityMapping *afeTableMapping = [[RKEntityMapping alloc] initWithEntity:[ETGAfeTable_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [afeTableMapping addAttributeMappingsFromDictionary:@{
     @"AFC"                 : @"afc",
     @"Description"         : @"afeDescription",
     @"Indicator"           : @"afeDescription",
     @"Itd"                 : @"itd",
     @"LatestApprovedAfe"   : @"latestApprovedAfe",
     @"Variance"            : @"variance"
     }];
    
    RKResponseDescriptor *projectAfeTableDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:afeTableMapping method:RKRequestMethodGET pathPattern:ETG_PROJECT_AFE_TABLE_PATH keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:projectAfeTableDescriptor];
    
    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *afeTableMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGAfeTable_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [afeTableMapping_ addAttributeMappingsFromDictionary:@{
     @"AFC"                 : @"afc",
     @"Description"         : @"afeDescription",
     @"Indicator"           : @"afeDescription",
     @"Itd"                 : @"itd",
     @"LatestApprovedAfe"   : @"latestApprovedAfe",
     @"Variance"            : @"variance"
     }];
    
    // Create Core Data to JSON mapping
    _inverseMapping = [afeTableMapping_ inverseMapping];
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
    RKManagedObjectRequestOperation *afeTableOperation = [_managedObject appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:ETG_PROJECT_AFE_TABLE_PATH parameters:params];
    
    void (^successBlock)(RKObjectRequestOperation*, RKMappingResult*) = ^(RKObjectRequestOperation *afeTableOperation, RKMappingResult *mappingResult) {
        
        // Fetch or insert ETGReportingMonth from paramater
        NSManagedObjectContext *context = [[ETGWebService sharedWebService] managedObjectContext];
        NSString* query = [NSString stringWithFormat:
                           @"(SUBQUERY(project, $project, ANY $project.key == %@).@count != 0) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)",
                           [params valueForKey:@"ProjectKey"], [params valueForKey:@"ReportingMonth"]];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
        ETGProjectSummary *project = [ETGProjectSummary findFirstWithPredicate:predicate inContext:context];
        
        // Add all ETGAfeTable_Project to ETGProjectSummary
        [project addEtgAfeTable_Projects:[mappingResult set]];
        
        // Add ETGProjectSummary to ETGAfeTable_Project
        for (ETGAfeTable_Project *afeTable in [mappingResult set]) {
            afeTable.projectSummary = project;
        }
        // Save to persistent store
        NSError* error;
        [context saveToPersistentStore:&error];
        
        if (error) {
            NSLog(@"Error in saving to persistent store");
        }
        
        // Create Core Data to JSON mapping
        NSMutableArray *jsonDict = [NSMutableArray array];
        for (ETGAfeTable_Project *afeTable in [mappingResult set]) {
            NSDictionary* json = [self serializeObject:afeTable];
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
    void (^errorBlock)(RKObjectRequestOperation*, NSError*) = ^(RKObjectRequestOperation *afeTableOperation, NSError *error) {
        failure(error);
    };
    [afeTableOperation setCompletionBlockWithSuccess:successBlock failure:errorBlock];
    [_managedObject enqueueObjectRequestOperation:afeTableOperation];
}

@end
