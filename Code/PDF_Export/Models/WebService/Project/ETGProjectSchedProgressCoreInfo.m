//
//  ETGProjectScheduleProgressCoreInfo.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/20/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGProjectSchedProgressCoreInfo.h"
#import "ETGWebServiceCommonImports.h"
//Models
#import "ETGProjectSummary.h"
#import "ETGScheduleProgressCoreInfo_Project.h"

#define ETG_PROJECT_SCHEDULE_CORE_INFO_PATH @"/Service1.svc/"

@interface ETGProjectSchedProgressCoreInfo ()

@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGProjectSchedProgressCoreInfo

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupScheduleCoreInfoMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupScheduleCoreInfoMappings {
    
    // Attribute Mappings for Schedule Progress
    RKEntityMapping *scheduleMapping = [[RKEntityMapping alloc] initWithEntity:[ETGScheduleProgressCoreInfo_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [scheduleMapping addAttributeMappingsFromDictionary:@{
     @"ActualProgress"  : @"actualProgress",
     @"OriginalBaseline": @"originalBaseline",
     @"PlanProgress"    : @"planProgress",
     @"ReportingDate"   : @"reportingDate"
     }];
    
    RKResponseDescriptor *scheduleDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:scheduleMapping method:RKRequestMethodGET pathPattern:ETG_PROJECT_SCHEDULE_CORE_INFO_PATH keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:scheduleDescriptor];
    
    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *scheduleMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGScheduleProgressCoreInfo_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [scheduleMapping_ addAttributeMappingsFromDictionary:@{
     @"ActualProgress"  : @"actualProgress",
     @"OriginalBaseline": @"originalBaseline",
     @"PlanProgress"    : @"planProgress",
     @"ReportingDate"   : @"reportingDate"
     }];
    
    // Create Core Data to JSON mapping
    _inverseMapping = [scheduleMapping_ inverseMapping];
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
    RKManagedObjectRequestOperation *scheduleOperation = [_managedObject appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:ETG_PROJECT_SCHEDULE_CORE_INFO_PATH parameters:params];
    
    void (^successBlock)(RKObjectRequestOperation*, RKMappingResult*) = ^(RKObjectRequestOperation *scheduleOperation, RKMappingResult *mappingResult) {
        
        // Fetch or insert ETGReportingMonth from paramater
        NSManagedObjectContext *context = [[ETGWebService sharedWebService] managedObjectContext];
        NSString* query = [NSString stringWithFormat:
                           @"(SUBQUERY(project, $project, ANY $project.key == %@).@count != 0) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)",
                           [params valueForKey:@"ProjectKey"], [params valueForKey:@"ReportingMonth"]];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
        ETGProjectSummary *project = [ETGProjectSummary findFirstWithPredicate:predicate inContext:context];
        
        // Add all ETGScheduleProgressCoreInfo_Project to ETGProjectSummary
        [project addEtgScheduleProgressCoreInfo_Projects:[mappingResult set]];
        
        // Add ETGProjectSummary to ETGScheduleProgressCoreInfo_Project
        for (ETGScheduleProgressCoreInfo_Project *schedule in [mappingResult set]) {
            schedule.projectSummary = project;
        }
        // Save to persistent store
        NSError* error;
        [context saveToPersistentStore:&error];
        
        if (error) {
            NSLog(@"Error in saving to persistent store");
        }
        
        // Create Core Data to JSON mapping
        NSMutableArray *jsonDict = [NSMutableArray array];
        for (ETGScheduleProgressCoreInfo_Project *schedule in [mappingResult set]) {
            NSDictionary* json = [self serializeObject:schedule];
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
    void (^errorBlock)(RKObjectRequestOperation*, NSError*) = ^(RKObjectRequestOperation *productionRtbdOperation, NSError *error) {
        failure(error);
    };
    [scheduleOperation setCompletionBlockWithSuccess:successBlock failure:errorBlock];
    [_managedObject enqueueObjectRequestOperation:scheduleOperation];
}

@end
