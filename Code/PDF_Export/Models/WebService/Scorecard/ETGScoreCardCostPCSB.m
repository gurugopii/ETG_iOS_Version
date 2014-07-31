//
//  ETGScoreCardCostPCSB.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGWebServiceCommonImports.h"
#import "ETGScoreCardCostPCSB.h"
#import "ETGNetworkConnection.h"
// Relationships
#import "ETGScorecard.h"
//#import "ETGProjectSummary.h"
#import "ETGAfeTable.h"
#import "ETGProject.h"
//#import "ETGPortfolio.h"
#import "ETGApc.h"
#import "ETGCpb.h"

@interface ETGScoreCardCostPCSB ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
//@property (nonatomic, strong) RKEntityMapping* inverseMappingForApcCpb;
@property (nonatomic, strong) NSMutableDictionary *jsonForCostPcsb;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGScoreCardCostPCSB

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupCostPcsbMappings];
//            [self setupAfeMappings];
//            [self setupApcCpbMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

//- (void)setupAfeMappings {
//    
//    RKEntityMapping *projectSummaryMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGProjectSummary entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
//    
//    // Attribute Mappings for ETGAfeTable
//    RKEntityMapping *afeMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGAfeTable entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
//    [afeMapping_ addAttributeMappingsFromDictionary:@{
//                                                      @"afeSection"      : @"afeDescription",
//                                                      @"latestAfe"       : @"latestApprovedAfe",
//                                                      @"afeVowd"         : @"itd",
//                                                      @"afeAfc"          : @"afc",
//                                                      @"afeVariance"     : @"variance",
//                                                      @"afeIndicator"    : @"indicator",
//                                                      }];
//    
//    // Relationship mapping of ETGAfeTable to ETGProjectSummary
//    [projectSummaryMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"AFEPerformance" toKeyPath:@"etgAfeTable_Projects" withMapping:afeMapping_]];
//    
//    _inverseMappingForAfe = [projectSummaryMapping_ inverseMapping];
//    
//}
//
//- (void)setupApcCpbMappings {
//    
//    RKEntityMapping *portfolioMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGScorecard entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
//
//    // Attribute Mappings for ETGApc
//    RKEntityMapping *apcMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGApc entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
//    [apcMapping_ addAttributeMappingsFromDictionary:@{
//                                                     @"afc"             : @"afc",
//                                                     @"apcIndicator"    : @"indicator",
//                                                     @"latestApc"       : @"apc",
//                                                     @"apcVariance"     : @"variance",
//                                                     @"vowd"            : @"itd",
//                                                     }];
//    
//    // Attribute Mappings for ETGCpb
//    RKEntityMapping *cpbMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGCpb entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
//    [cpbMapping_ addAttributeMappingsFromDictionary:@{
//                                                     @"indicator"     : @"indicator",
//                                                     @"originalCpb"   : @"originalCpb",
//                                                     @"latestCpb"     : @"latestCpb",
//                                                     @"variance"      : @"variance",
//                                                     @"yep_e"         : @"fyYep",
//                                                     @"ytdActual"     : @"fyYtd",
//                                                     }];
//
//    [portfolioMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"APCPerformance" toKeyPath:@"etgApcPortfolios" withMapping:apcMapping_]];
//    [portfolioMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"CPBPerformance" toKeyPath:@"etgCpbPortfolios" withMapping:cpbMapping_]];
//
//    _inverseMappingForApcCpb = [portfolioMapping_ inverseMapping];
//    
//}

- (void)setupCostPcsbMappings {
    
    RKEntityMapping *scorecardMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGScorecard entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    
    // Attribute Mappings for ETGApc
    RKEntityMapping *apcMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGApc entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [apcMapping_ addAttributeMappingsFromDictionary:@{
                                                      @"afc"             : @"afc",
                                                      @"apcIndicator"    : @"indicator",
                                                      @"latestApc"       : @"apc",
                                                      @"apcVariance"     : @"variance",
                                                      @"vowd"            : @"itd",
                                                      }];
    
    // Attribute Mappings for ETGCpb
    RKEntityMapping *cpbMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGCpb entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [cpbMapping_ addAttributeMappingsFromDictionary:@{
                                                      @"indicator"     : @"indicator",
                                                      @"originalCpb"   : @"originalCpb",
                                                      @"latestCpb"     : @"latestCpb",
                                                      @"variance"      : @"variance",
                                                      @"yep_e"         : @"fyYep",
                                                      @"ytdActual"     : @"fyYtd",
                                                      }];

    // Attribute Mappings for ETGAfeTable
    RKEntityMapping *afeMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGAfeTable entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [afeMapping_ addAttributeMappingsFromDictionary:@{
                                                      @"afeSection"      : @"afeDescription",
                                                      @"latestAfe"       : @"latestApprovedAfe",
                                                      @"afeVowd"         : @"itd",
                                                      @"afeAfc"          : @"afc",
                                                      @"afeVariance"     : @"variance",
                                                      @"afeIndicator"    : @"indicator",
                                                      }];
    
    // Relationship mapping of ETGAfeTable to ETGProjectSummary
    [scorecardMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"APCPerformance" toKeyPath:@"etgApcPortfolios" withMapping:apcMapping_]];
    [scorecardMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"CPBPerformance" toKeyPath:@"etgCpbPortfolios" withMapping:cpbMapping_]];
    [scorecardMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"AFEPerformance" toKeyPath:@"etgAfeTable_Projects" withMapping:afeMapping_]];
    
    _inverseMapping = [scorecardMapping_ inverseMapping];
    
}

//- (NSDictionary*)serializeObject:(NSManagedObject*)object inverseMapping:(RKEntityMapping *)inverseMapping {
- (void)serializeObject:(NSManagedObject*)object inverseMapping:(RKEntityMapping *)inverseMapping {

//    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    RKObjectMappingOperationDataSource *dataSource = [RKObjectMappingOperationDataSource new];
    RKMappingOperation *mappingOperation = [[RKMappingOperation alloc] initWithSourceObject:object destinationObject:_jsonForCostPcsb mapping:inverseMapping];
    mappingOperation.dataSource = dataSource;
    NSError *error = nil;
    
    [mappingOperation performMapping:&error];
    if (error) {
        DDLogError(@"%@%@", logErrorPrefix, [NSString stringWithFormat:serializationError, error]);
//        return nil;
    }
    
//    return _jsonForCostPcsb;
}

-(NSMutableArray *) getRootName:(NSMutableArray*)json {

    //APC
    if ([[json valueForKey:@"APCPerformance"] count]) {
        if ([[[json valueForKey:@"APCPerformance"] objectAtIndex:0] count]) {
            
            NSDictionary *valueToBeConverted = [[[json valueForKey:@"APCPerformance"] objectAtIndex:0] objectAtIndex:0];
//            NSLog(@"%@", valueToBeConverted);
            
            [[json objectAtIndex:0] removeObjectForKey:@"APCPerformance"];
            [[json objectAtIndex:0] setObject:valueToBeConverted forKey:@"APCPerformance"];
        }
    }
    
    //CPB
    if ([[json valueForKey:@"CPBPerformance"] count]) {
        if ([[[json valueForKey:@"CPBPerformance"] objectAtIndex:0] count]) {
            
            NSMutableDictionary *valueToBeConverted = [[[json valueForKey:@"CPBPerformance"] objectAtIndex:0] objectAtIndex:0];
//            NSLog(@"%@", valueToBeConverted);
            
            if ([valueToBeConverted valueForKey:@"variance"]) {
                NSNumber *convertedCPB = [NSNumber numberWithFloat:[[valueToBeConverted valueForKeyPath:@"variance"] floatValue] * 100];
                [valueToBeConverted removeObjectForKey:@"variance"];
                [valueToBeConverted setObject:convertedCPB forKey:@"variance"];
            }
            
            [[json objectAtIndex:0] removeObjectForKey:@"CPBPerformance"];
            [[json objectAtIndex:0] setObject:valueToBeConverted forKey:@"CPBPerformance"];
        }
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
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(scorecard, $scorecard, ANY $scorecard.projectSummary.projectKey == %@).@count != 0) AND (SUBQUERY(scorecard, $scorecard, ANY $scorecard.projectSummary.reportMonth == %@).@count != 0)", projectKey, [reportingMonth toDate]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"projectKey == %@ AND reportMonth == %@", projectKey, [reportingMonth toDate]];
    NSArray *foundProjects = [ETGScorecard findAllWithPredicate:predicate inContext:context];

    NSError* error;

//    if ([foundProjectsInProjectSummary count] || [foundProjectsInPortfolio count]) {
    if (foundProjects) {
    
        NSMutableArray *jsonDict = [NSMutableArray array];
        _jsonForCostPcsb = [NSMutableDictionary dictionary];
        
        //Project
        // Create Core Data to JSON mapping
//        for (ETGProjectSummary* card in foundProjectsInProjectSummary) {
//            [self serializeObject:card inverseMapping:_inverseMappingForAfe];
//            //            NSDictionary* json = [self serializeObject:card inverseMapping:_inverseMappingForAfe];
//            //            NSLog(@"%@", json);
//        }

        //Portfolio
        // Create Core Data to JSON mapping
        for (ETGScorecard* card in foundProjects) {
            [self serializeObject:card inverseMapping:_inverseMapping];
            //                NSDictionary* json = [self serializeObject:card inverseMapping:_inverseMappingForApcCpb];
            //                NSLog(@"%@", json);
        }

        if (!_jsonForCostPcsb) {
            //An error occurred
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:coreDataToJSONError forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"ETG" code:100 userInfo:errorDetail];
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        } else {
            [jsonDict addObject:_jsonForCostPcsb];
        }
        
        if (error) {
            failure(error);
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        } else {

            if ([jsonDict count]) {
                
                jsonDict = [self getRootName:jsonDict];
                
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
