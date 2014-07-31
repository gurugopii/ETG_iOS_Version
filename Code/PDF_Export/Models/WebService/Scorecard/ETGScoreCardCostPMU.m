//
//  ETGScoreCardCostPMU.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGWebServiceCommonImports.h"
#import "ETGScoreCardCostPMU.h"
#import "ETGNetworkConnection.h"
//Models
#import "ETGFdp.h"
#import "ETGWPBCostPMU.h"
//#import "ETGCostPmu.h"
// Relationships
#import "ETGScorecard.h"

#import "ETGJSONKeyReplaceManipulation.h"


@interface ETGScoreCardCostPMU ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGScoreCardCostPMU

- (id)init
{
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupCostPmuMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupCostPmuMappings
{
    RKEntityMapping *scorecardMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGScorecard entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];

    // Attribute Mappings for ETGWPBCostPMU
    RKEntityMapping *wpbMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGWPBCostPMU entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [wpbMapping_ addAttributeMappingsFromDictionary:@{
                                                     @"section"         : @"section",
                                                     @"originalWpb"     : @"originalWpb",
                                                     @"yepG"            : @"yepG",
                                                     @"yerCoApproved"   : @"yercoApproved",
                                                     @"abrApproved"     : @"abrApproved",
                                                     @"latestWpb"       : @"latestWpb",
                                                     @"wpbVariance"     : @"variance",
                                                     @"wpbIndicator"    : @"indicator"
                                                     }];
    
    // Add Relationship Mappings for Cost PMU
    RKEntityMapping *fdpMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGFdp entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [fdpMapping_ addAttributeMappingsFromDictionary:@{
                                                     @"afc"             : @"afc",
                                                     @"fia"             : @"fia",
                                                     @"indicator"       : @"indicator",
                                                     @"tpFipFdp"        : @"tpFipFdp",
                                                     @"variance"        : @"variance",
                                                     @"vowd"            : @"vowd"
                                                     }];

//    [scorecardMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"FDPPerformance.tpFipFdp" toKeyPath:@"fdp.tpFipFdp"]];
//    [scorecardMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"FDPPerformance.fia" toKeyPath:@"fdp.fia"]];
//    [scorecardMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"FDPPerformance.vowd" toKeyPath:@"fdp.vowd"]];
//    [scorecardMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"FDPPerformance.afc" toKeyPath:@"fdp.afc"]];
//    [scorecardMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"FDPPerformance.variance" toKeyPath:@"fdp.variance"]];
//    [scorecardMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"FDPPerformance.indicator" toKeyPath:@"fdp.indicator"]];

    [scorecardMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"FDPPerformance" toKeyPath:@"fdp" withMapping:fdpMapping_]];

    [scorecardMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"WPBDetails" toKeyPath:@"wpbCostPMUs" withMapping:wpbMapping_]];

    _inverseMapping = [scorecardMapping_ inverseMapping];

}

- (NSDictionary*)serializeObject:(NSManagedObject*)object
{
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    RKObjectMappingOperationDataSource *dataSource = [RKObjectMappingOperationDataSource new];
    RKMappingOperation *mappingOperation = [[RKMappingOperation alloc] initWithSourceObject:object destinationObject:json mapping:_inverseMapping];
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
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(project, $project, ANY $project.key == %@).@count != 0) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)", projectKey, [reportingMonth toDate]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"projectKey == %@ AND reportMonth == %@", projectKey, [reportingMonth toDate]];
    NSArray *foundProjects = [ETGScorecard findAllWithPredicate:predicate inContext:context];
    NSError* error;
    
    NSMutableArray *jsonDict = [NSMutableArray array];
    if ([foundProjects count]) {
        // Create Core Data to JSON mapping
        for (ETGScorecard* card in foundProjects) {
            NSDictionary* json = [self serializeObject:card];
            //NSLog(@"%@", json);
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
            
            if ([jsonDict count]) {
                NSError* parsingError;
                NSData *data = [RKMIMETypeSerialization dataFromObject:[jsonDict objectAtIndex:0] MIMEType:RKMIMETypeJSON error:&parsingError];
                
                if (parsingError) {
                    failure(parsingError);
                    DDLogError(@"%@%@", logErrorPrefix, parsingError.description);
                } else {
                    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    success(jsonString);
                }
            } else {
                
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
                NSError *noDataerror = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
                failure(noDataerror);
                DDLogError(@"%@%@", logErrorPrefix,noDataerror.description);
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
