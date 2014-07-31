//
//  ETGProjectModelController.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/19/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGProjectModelController.h"
#import "ETGWebServiceCommonImports.h"
//Models
#import "ETGAllProjects.h"

#import <dispatch/dispatch.h>
#import "ETGCoreDataUtilities.h"
#import "CommonMethods.h"

@interface ETGProjectModelController ()

@property (nonatomic, strong) ETGWebService* webService;
@property (nonatomic, strong) RKManagedObjectStore* managedObjectStore;
@property (nonatomic) NSString *token;
@property (nonatomic, strong) NSMutableArray *projectArray;
@property (nonatomic) BOOL timestampAgeMoreThanOneDay;
@property (nonatomic) BOOL downloadFail;
@property (nonatomic)int projectCounter;
@property (nonatomic)int totalProjectsInBackground;
@property (nonatomic, strong) NSMutableArray* operations;

@end

@implementation ETGProjectModelController

+ (instancetype)sharedModel {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(id)init {
    self = [super init];
    if (self) {
        // Set web service
        self.webService = [ETGWebService sharedWebService];
        // Set web service operations
        self.operations = [NSMutableArray array];
    }
    return self;
}

#pragma mark - All Project
//UAC

- (void) syncProject {
    
    //set user id and reporting month.
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"20130101" forKey:@"inpReportingMonth"];
    [params setObject:@"191" forKey:@"inpProjectKey"];
    [params setObject:@"12" forKey:@"inpFileKey"];
    _projectArray = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:96], [NSNumber numberWithInt:97], [NSNumber numberWithInt:98], [NSNumber numberWithInt:99], [NSNumber numberWithInt:101],nil];
    
}

- (void) setupProject:(NSString *)reportingMonth
           cachedData:(NSSet *)cachedData{
    
    //set user id and reporting month.
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"20130101" forKey:@"inpReportingMonth"];
    [params setObject:@"191" forKey:@"inpProjectKey"];
    [params setObject:@"12" forKey:@"inpFileKey"];
    _projectArray = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:96], [NSNumber numberWithInt:97], [NSNumber numberWithInt:98], [NSNumber numberWithInt:99], [NSNumber numberWithInt:101],nil];
    
}

- (void)setKeyMilestones:(NSArray*)keyMilestones {
    ETGAllProjects *project = [[ETGAllProjects alloc] init];
    project.keyMilestones = nil;
    project.keyMilestones = keyMilestones;
}

- (void)getProjectForReportingMonth:(NSString*)reportingMonth
                     withProjectKey:(NSString*)projectKey
              withKeyMilestonesData:(NSArray*)keyMilestones
                 withProjectReports:(NSDictionary*)enabledReports
                            success:(void (^)(NSString* jsonString))success
                            failure:(void (^)(NSError *error))failure{
    
    // Create web service with mapping to model
    ETGAllProjects *project = [[ETGAllProjects alloc] init];
    
    project.filterDictionary = _filterDictionary;

    // Create request
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"inpReportingMonth"];
    [params setObject:projectKey forKey:@"inpProjectKey"];
    //[params setObject:PDFField forKey:@"inpFileKey"];
    
    if ([project entityIsEmpty] == YES){
        if(_timestampAgeMoreThanOneDay == YES){
            [project setBaseFilters];
        }
    }
    
    // Download and show first project
    [project setFirstProjectBoolValue:YES];
    RKManagedObjectRequestOperation* operation = [project sendRequestWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] withKeyMilestonesData:keyMilestones withProjectReports:enabledReports success:^(NSString *projectData) {
        success(projectData);
    } failure: ^(NSError *error) {
        failure(error);
//        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
    // Set to very high priority
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    // Immediately start the request
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
}

- (void)getProjectOfflineForReportingMonth:(NSString*)reportingMonth
                     withProjectKey:(NSString*)projectKey
                     withKeyMilestonesData:(NSArray*)keyMilestones
                        withProjectReports:(NSDictionary*)enabledReports
                            success:(void (^)(NSString* jsonString))success
                            failure:(void (^)(NSError *error))failure {
    
    // Create web service with mapping to model
    ETGAllProjects *project = [[ETGAllProjects alloc] init];
    
    project.filterDictionary = _filterDictionary;
    
    [project fetchOfflineDataWithReportingMonth:reportingMonth projectKey:[NSNumber numberWithInteger:[projectKey integerValue]] withKeyMilestonesData:keyMilestones withProjectReports:enabledReports success:^(NSString *projectData) {
        success(projectData);
    } failure: ^(NSError *error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    }];
    
}

- (void)setTimestampAgeMoreThanOneDay:(BOOL)boolValue{
    _timestampAgeMoreThanOneDay = boolValue;
}

- (void)getBackgroundProjectForReportingMonth:(NSString*)reportingMonth
                               withProjectKey:(NSString*)projectKey
                        withKeyMilestonesData:(NSArray*)keyMilestones
                           withProjectReports:(NSDictionary*)enabledReports
                                      success:(void (^)(void))success
                                      failure:(void (^)(NSError *error))failure{
    @try {
        // Create web service with mapping to model
        ETGAllProjects *allProjectWs = [[ETGAllProjects alloc] init];
        
        // Get projects to fetch
        NSArray *projects = [CommonMethods fetchEntity:@"ETGProject" sortDescriptorKey:@"key" inManagedObjectContext:[NSManagedObjectContext contextForCurrentThread]];
        
        // Create an array of operations for the selected reporting month
        NSMutableArray* projectRequests = [NSMutableArray array];
        
        // Loop through the list of projects to download
        for (ETGProject* project in projects) {
            if (project.key != nil){
                if ([[project.key stringValue] isEqualToString:projectKey]) {
                   // NSLog(@"Skipping default project %@", project.key);
                } else {
                    //NSLog(@"Will download project with key %@", project.key);
                    
                    [projectRequests addObject:[allProjectWs sendRequestWithReportingMonth:reportingMonth projectKey:project.key withKeyMilestonesData:keyMilestones withProjectReports:enabledReports success:^(NSString* projectData){
                        
                    }failure:^(NSError* error) {
                        failure(error);
                    }]];
                }
            }
        }
    
        // Set request concurrency
        [[RKObjectManager sharedManager].operationQueue setMaxConcurrentOperationCount:5];
        
        // Set high priority for background download
        for (RKObjectRequestOperation* operation in projectRequests) {
            [operation setQueuePriority:NSOperationQueuePriorityNormal];
        }
        
        // Run the request operations in with completion block
        [[RKObjectManager sharedManager] enqueueBatchOfObjectRequestOperations:projectRequests  progress:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
            //NSLog(@"Completed %lu of %lu", (unsigned long)numberOfFinishedOperations, (unsigned long)totalNumberOfOperations);
            
        } completion:^(NSArray *operations) {
            //NSLog(@"Completed");
            success();
        }];
    } @catch (NSException *ex) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",ex.description]
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)startProjectDownloadInBackgroundForReportingMonth:(NSString*)reportingMonth
{
    //NSLog(@"Setting normal priority background download for reporting month %@", reportingMonth);
    // Set normal priority for background download
    for (RKObjectRequestOperation* operation in [[RKObjectManager sharedManager].operationQueue operations]) {
        [operation setQueuePriority:NSOperationQueuePriorityNormal];
    }
}

- (void)stopProjectDownloadInBackgroundForReportingMonth:(NSString*)reportingMonth
{
    //NSLog(@"Setting low priority background download for reporting month %@", reportingMonth);
    // Set normal priority for background download
    for (RKObjectRequestOperation* operation in [[RKObjectManager sharedManager].operationQueue operations]) {
        [operation setQueuePriority:NSOperationQueuePriorityVeryLow];
    }
}

- (void)setQueuepriorityForProject:(NSString *)reportingMonth
{
    //NSLog(@"Setting normal priority background download for reporting month(Project) %@", reportingMonth);
    // Set normal priority for background download
    
    @try{
        
        for (RKObjectRequestOperation* operation in [[RKObjectManager sharedManager].operationQueue operations]) {
            
            if(![operation isKindOfClass:[NSBlockOperation class]]){
                
                if ([operation.HTTPRequestOperation.request.URL.path rangeOfString:@"AllProject"].location == NSNotFound) {
                    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
                } else {
                    [operation setQueuePriority:NSOperationQueuePriorityNormal];
                }
                
            }
            else{
                
                NSOperation *convertedOperation = (NSOperation*)operation;
                [convertedOperation setQueuePriority:NSOperationQueuePriorityVeryHigh];
            }
        }
    }
    @catch (NSException *ex) {
        NSLog(@"%@", ex.description);
    }
}

@end
