//
//  ETGScoreCardProduction.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGWebServiceCommonImports.h"
#import "ETGScoreCardProduction.h"
#import "ETGNetworkConnection.h"
// Models
#import "ETGFacility.h"
#import "ETGWellDetails.h"
// Relationships
#import "ETGScorecard.h"
#import "ETGJSONKeyReplaceManipulation.h"

@interface ETGScoreCardProduction ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGScoreCardProduction

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
    // Attribute Mappings from core data to webview(html)
    // Attribute Mappings for ETGFacility
    RKEntityMapping *productionMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGFacility entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [productionMapping_ addAttributeMappingsFromDictionary:@{
                                                            @"facilityName"   : @"name"
                                                            }];
    productionMapping_.identificationAttributes = @[@"name"];
    
    // Attribute Mappings for ETGWellDetails
    RKEntityMapping *wellDetailsMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGWellDetails entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [wellDetailsMapping_ addAttributeMappingsFromDictionary:@{
                                                             @"condyIndicator"  : @"condyIndicator",
                                                             @"condyOutlook"    : @"condyOutlook",
                                                             @"condyPlanned"    : @"condyPlanned",
                                                             @"dataTimeKey"     : @"dataTimeKey",
                                                             @"gasIndicator"    : @"gasIndicator",
                                                             @"gasOutlook"      : @"gasOutlook",
                                                             @"gasPlanned"      : @"gasPlanned",
                                                             @"oilIndicator"    : @"oilIndicator",
                                                             @"oilOutlook"      : @"oilOutlook",
                                                             @"oilPlanned"      : @"oilPlanned",
                                                             @"rtbdIndicator"   : @"rtbdIndicator",
                                                             @"rtbdOutlook"     : @"rtbdOutlook",
                                                             @"rtbdPlanned"     : @"rtbdPlanned",
                                                             @"sort"            : @"sort",
                                                             @"wellName"        : @"wellName",
                                                             }];
    
    [productionMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"wellDetails" toKeyPath:@"wellDetails" withMapping:wellDetailsMapping_]];

    _inverseMapping = [productionMapping_ inverseMapping];
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
    json = [[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] detectNumericJSONByKeyValue:json];
    return json;
}

- (void)fetchOfflineDataWithReportingMonth:(NSString *)reportingMonth
                           withProjectKeys:(NSNumber *) projectKey
                                   success:(void (^)(NSString* scorecards))success
                                   failure:(void (^)(NSError *error))failure {
    
    //Fetch scorecard with reporting month
    NSManagedObjectContext* context = [NSManagedObjectContext contextForCurrentThread];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(scorecard, $scorecard, ANY $scorecard.projectKey == %@).@count != 0) AND (SUBQUERY(scorecard, $scorecard, ANY $scorecard.reportMonth == %@).@count != 0)", projectKey, [reportingMonth toDate]];
    NSArray *foundProjects = [ETGFacility findAllWithPredicate:predicate inContext:context];
    NSError* error;
    
    NSMutableArray *jsonDict = [NSMutableArray array];
    if ([foundProjects count]) {
        // Create Core Data to JSON mapping
        for (ETGFacility* card in foundProjects) {
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
