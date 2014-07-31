//
//  ETGScoreCardManpower.m
//  ETG
//
//  Created by Helmi Hasan on 3/10/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGScoreCardManpower.h"

#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h"
// Models
#import "ETGManpowerTable_Project.h"
// Relationships

@interface ETGScoreCardManpower ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGScoreCardManpower

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
    RKEntityMapping *manpowerMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGManpowerTable_Project entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [manpowerMapping_ addAttributeMappingsFromDictionary:@{
                                                      @"totalCritical"         : @"totalCritical",
                                                      @"totalRequirement"           : @"totalRequirement",
                                                      @"indicatorTotalCriticalBar"    : @"indicatorTotalCriticalBar",
                                                      @"indicatorTotalRequirementBar" : @"indicatorTotalRequirementBar"
                                                      }];
    
    _inverseMapping = [manpowerMapping_ inverseMapping];
    
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
    //    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(project, $project, ANY $project.key == %@).@count != 0) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)", projectKey, [reportingMonth toDate]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(scorecard, $scorecard, ANY $scorecard.projectKey == %@).@count != 0) AND (SUBQUERY(scorecard, $scorecard, ANY $scorecard.reportMonth == %@).@count != 0)", projectKey, [reportingMonth toDate]];
    NSArray *foundProjects = [ETGManpowerTable_Project findAllWithPredicate:predicate inContext:context];
    NSError* error;
    
    NSMutableArray *jsonDict = [NSMutableArray array];
    if ([foundProjects count]) {
        // Create Core Data to JSON mapping
        for (ETGManpowerTable_Project* card in foundProjects) {
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
                
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"yy"];
                NSString *date = [NSString stringWithFormat:@"FY%@",[format stringFromDate:[reportingMonth toDate]]];
                
                id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSMutableDictionary *dictionaryOrArrayToOutput = [NSMutableDictionary dictionaryWithDictionary:[dict objectAtIndex:0]];
                [dictionaryOrArrayToOutput setObject:[NSString stringWithFormat:@"Manning Status (%@)",date] forKey:@"title"];
                
                
                NSData *jsonD = [NSJSONSerialization dataWithJSONObject:dictionaryOrArrayToOutput
                                                                   options:0 // Pass 0 if you don't care about the readability of the generated string
                                                                     error:&error];
              
                NSString *jsonS = [[NSString alloc] initWithData:jsonD encoding:NSUTF8StringEncoding];
            
                //NSLog(@"jsonStringg %@",jsonS);

                success(jsonS);
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
