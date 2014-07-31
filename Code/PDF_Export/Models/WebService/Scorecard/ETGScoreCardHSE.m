//
//  ETGScoreCardHSE.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGWebServiceCommonImports.h"
#import "ETGScoreCardHSE.h"
#import "ETGNetworkConnection.h"
// Models
#import "ETGProjectSummary.h"
#import "ETGHseTable_Project.h"
// Relationships

@interface ETGScoreCardHSE ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGScoreCardHSE

- (id)init
{
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupMappings
{
    // Attribute Mappings for ETGHseTable_Project
    RKEntityMapping *hseMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGHseTable_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [hseMapping_ addAttributeMappingsFromDictionary:@{
                                                     @"ytdCriteria"         : @"hseId",
                                                     @"indicator"           : @"indicator",
                                                     @"ytdCriteriaValue"    : @"ytdCase"
                                                     }];
    
    
    
    _inverseMapping = [hseMapping_ inverseMapping];

}

- (NSDictionary*)serializeObject:(NSManagedObject*)object
{
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    RKObjectMappingOperationDataSource *dataSource = [RKObjectMappingOperationDataSource new];
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
    
    return json;
}

- (void)fetchOfflineDataWithReportingMonth:(NSString *)reportingMonth
                           withProjectKeys:(NSNumber *) projectKey
                                   success:(void (^)(NSString* scorecards))success
                                   failure:(void (^)(NSError *error))failure {
    
    //Fetch scorecard with reporting month
    NSManagedObjectContext* context = [NSManagedObjectContext contextForCurrentThread];
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(projectSummary, $projectSummary, ANY $projectSummary.project.key == %@).@count != 0) AND (SUBQUERY(projectSummary, $projectSummary, ANY $projectSummary.reportingMonth.name == %@).@count != 0)", projectKey, [reportingMonth toDate]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(scorecard, $scorecard, ANY $scorecard.projectKey == %@).@count != 0) AND (SUBQUERY(scorecard, $scorecard, ANY $scorecard.reportMonth == %@).@count != 0)", projectKey, [reportingMonth toDate]];
    NSArray *foundProjects = [ETGHseTable_Project findAllWithPredicate:predicate inContext:context];
    NSError* error;
    
    NSMutableArray *jsonDict = [NSMutableArray array];
    if ([foundProjects count]) {
        // Create Core Data to JSON mapping
        for (ETGHseTable_Project* card in foundProjects) {
            NSDictionary* json = [self serializeObject:card];
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
            
            NSError* parsingError;
            NSData *data = [RKMIMETypeSerialization dataFromObject:jsonDict MIMEType:RKMIMETypeJSON error:&parsingError];
            
            if (parsingError) {
                failure(parsingError);
                DDLogError(@"%@%@", logErrorPrefix, parsingError.description);
            } else {
                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                success(jsonString);
            }
        }
    } else {
        
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
        NSError *noDataerror = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
        failure(noDataerror);
        DDLogError(@"%@%@", logErrorPrefix, noDataerror.description);
        
    }
}

@end
