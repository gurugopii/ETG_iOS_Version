//
//  ETGScoreCardSchedule.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGWebServiceCommonImports.h"
#import "ETGScoreCardSchedule.h"
#import "ETGNetworkConnection.h"
#import "ETGFilterModelController.h"
// Models
#import "ETGScoreCardSchedule.h"
#import "ETGScorecard.h"
//#import "ETGPlatform.h"
#import "ETGFirstHydrocarbon.h"
// Relationships
//#import "ETGProjectSummary.h"
#import "ETGScheduleProgress.h"
#import "ETGBaselineType.h"
#import "ETGRevision.h"
#import "ETGKeyMilestone.h"

@interface ETGScoreCardSchedule ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMappingForPlatform;
@property (nonatomic, strong) RKEntityMapping* inverseMappingForProjectSummary;
@property (nonatomic, strong) NSMutableDictionary *jsonForSchedulePopover;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGScoreCardSchedule

- (id)init
{
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupMappings];
//            [self setupMappingsForPlatform];
//            [self setupMappingsForProjectSummary];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupMappings {
    
    RKEntityMapping *scorecardMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGScorecard entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];

    
    // Attribute Mappings for ETGScheduleProgress
    RKEntityMapping *scheduleMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGScheduleProgress entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [scheduleMapping_ addAttributeMappingsFromDictionary:@{
                                                          @"actual"              : @"actualProgress",
                                                          @"indicator"           : @"indicator",
                                                          @"planned"             : @"planProgress",
                                                          @"variance"            : @"variance",
                                                          }];
    
    // Relationship mapping of ETGAfeTable to ETGProjectSummary
    [scorecardMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ScheduleVariance" toKeyPath:@"etgScheduleProgress_Projects" withMapping:scheduleMapping_]];
    
    
    // Attribute Mappings for ETGPlatform
    RKEntityMapping *platformMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGFirstHydrocarbon entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [platformMapping_ addAttributeMappingsFromDictionary:@{
                                                           @"actualDt"       : @"actualDt",
                                                           @"indicator"      : @"indicator",
                                                           @"plannedDt"      : @"plannedDt",
                                                           @"platform"       : @"field"
                                                           }];
    
    // Relationship mapping of ETGAfeTable to ETGProjectSummary
    [scorecardMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"PlatformSchedule" toKeyPath:@"etgFirstHydrocarbon_Projects" withMapping:platformMapping_]];

    // Attribute Mappings for ETGBaselineType
    RKEntityMapping *baselineTypeMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGBaselineType entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [baselineTypeMapping_ addAttributeMappingsFromDictionary:@{
                                                              @"baselineType"               : @"name",
                                                              @"baselineTypeKey"            : @"key",
                                                              @"createdTime"                : @"createdTime",
                                                              @"projectKey"                 : @"projectKey",
                                                              }];
    
    // Attribute Mappings for ETGRevision
    RKEntityMapping *revisionMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGRevision entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [revisionMapping_ addAttributeMappingsFromDictionary:@{
                                                          @"revisionNo"        : @"number"
                                                          }];
    
    // Attribute Mappings for ETGKeyMilestone
    RKEntityMapping *keyMilestoneMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGKeyMilestone entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [keyMilestoneMapping_ addAttributeMappingsFromDictionary:@{
                                                              @"actualDate"      : @"actualDate",
                                                              @"baseLineNum"     : @"baselineNum",
                                                              @"mileStone"       : @"mileStone",
                                                              @"plannedDate"     : @"plannedDate",
                                                              @"indicator"       : @"indicator"
                                                              }];
    

    // Inverse Relationship mapping of ETGBaselineType to ETGProjectSummary
    [scorecardMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"baselineTypes" toKeyPath:@"baselineTypes" withMapping:baselineTypeMapping_]];
    // Inverse Relationship mapping of ETGRevision to ETGProjectSummary
    [baselineTypeMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"revisions" toKeyPath:@"revisions" withMapping:revisionMapping_]];
    // Inverse Relationship mapping of ETGKeyMilestone to ETGBaselineType
    [revisionMapping_ addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"keyMilestones" toKeyPath:@"keyMilestones" withMapping:keyMilestoneMapping_]];
    
    [scorecardMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"phase" toKeyPath:@"etgKeyMilestone_ProjectPhase.projectPhase"]];

    _inverseMappingForProjectSummary = [scorecardMapping_ inverseMapping];

}

- (void)serializeObject:(NSManagedObject*)object inverseMapping:(RKEntityMapping *)inverseMapping
{
//    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    RKObjectMappingOperationDataSource *dataSource = [RKObjectMappingOperationDataSource new];
    RKMappingOperation *mappingOperation = [[RKMappingOperation alloc] initWithSourceObject:object destinationObject:_jsonForSchedulePopover mapping:inverseMapping];
    mappingOperation.dataSource = dataSource;
    NSError *error = nil;
    
    [mappingOperation performMapping:&error];
    if (error) {
        DDLogError(@"%@%@", logErrorPrefix, [NSString stringWithFormat:serializationError, error]);
    }
}

-(NSMutableDictionary *) getRootName:(NSMutableDictionary*)json reportingMonth:(NSString *)reportingMonth projectKey:(NSNumber *)projectKey {

    //Platform
    if ([[json valueForKey:@"PlatformSchedule"] count]) {

        for(NSMutableDictionary *dict in [json valueForKey:@"PlatformSchedule"]){
            for (NSString *key in [dict allKeys]){
                if (![[dict valueForKey:key] isKindOfClass:[NSString class]]) {
                    NSString *valueToBeConvertedToString = [NSString stringWithFormat:@"%@", [dict valueForKey:key]];
                    [dict removeObjectForKey:key];
                    [dict setObject:valueToBeConvertedToString forKey:key];
                }
            }
            
        }
        
    }

    //Schedule
    if ([[json valueForKey:@"ScheduleVariance"] count]) {
        NSMutableDictionary *valueToBeConverted = [[json valueForKey:@"ScheduleVariance"] objectAtIndex:0];
        //NSLog(@"%@", valueToBeConverted);
        
        for (NSString *key in [valueToBeConverted allKeys]){
            if (![[valueToBeConverted valueForKey:key] isKindOfClass:[NSString class]]) {
                NSString *valueToBeConvertedToString = [NSString stringWithFormat:@"%@", [valueToBeConverted valueForKey:key]];
                [valueToBeConverted removeObjectForKey:key];
                [valueToBeConverted setObject:valueToBeConvertedToString forKey:key];
            }
        }

        [json removeObjectForKey:@"ScheduleVariance"];
        [json setObject:valueToBeConverted forKey:@"ScheduleVariance"];
    }
    
    //Key Milestone
    if ([[json objectForKey:@"baselineTypes"] count])
    {
        // Chart Data
        NSMutableDictionary *chartData = [[NSMutableDictionary alloc] init];
        NSMutableArray *KeyMileStoneDetails = [NSMutableArray array];
        NSArray *chartDataArray = [[NSArray alloc]init];
        NSArray *KeyMileStoneDetailsArray = nil;
        
        //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", projectKey];
        //ETGProject *project = [ETGProject findFirstWithPredicate:predicate];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        //NSDate *dateReportingMonth = [dateFormatter dateFromString:reportingMonth];
        
        
//        NSArray *keyMilestones = [[ETGFilterModelController sharedController] getLatestKeyMilestoneOfProject:project forReportingMonth:dateReportingMonth];
        NSArray *keyMilestones = [json valueForKeyPath:@"baselineTypes.revisions.keyMilestones"];
        
        if (keyMilestones) {
            for (NSDictionary *keyM in [keyMilestones objectAtIndex:0]) {
            
//            NSArray *keys = [[[km entity] attributesByName] allKeys];
//            NSArray *keys = [[km valueForKeyPath:@"revisions.keyMilestones"]];
//            NSDictionary *dict = [km dictionaryWithValuesForKeys:keys];
//            NSMutableDictionary *dictKm = [NSMutableDictionary dictionaryWithDictionary:dict];
//            
//            [dictKm setValue:[dictKm valueForKey: @"actualDate"] forKey: @"actualDt"];
//            [dictKm removeObjectForKey: @"actualDate"];
//            [dictKm setValue:[dictKm valueForKey: @"plannedDate"] forKey: @"plannedDt"];
//            [dictKm removeObjectForKey: @"plannedDate"];
//            [dictKm setValue:[dictKm valueForKey: @"baselineNum"] forKey: @"baseLineNum"];
//            [dictKm removeObjectForKey: @"baselineNum"];
//            
//            [KeyMileStoneDetails addObject:dictKm];
            
            for (NSMutableDictionary *km in keyM) {
                [km setValue:[km valueForKey: @"actualDate"] forKey: @"actualDt"];
                [km removeObjectForKey: @"actualDate"];
                [km setValue:[km valueForKey: @"plannedDate"] forKey: @"plannedDt"];
                [km removeObjectForKey: @"plannedDate"];
//                [km setValue:[km valueForKey: @"baseLineNum"] forKey: @"baseLineNum"];
//                [km removeObjectForKey: @"baselineNum"];
                
                [KeyMileStoneDetails addObject:km];
            }
            }
        }
        
//        //Try to get value for projectPhase
        NSString *projectPhase = [json valueForKey:@"phase"];
        
        KeyMileStoneDetailsArray = [NSArray arrayWithArray:KeyMileStoneDetails];
        chartDataArray = [self formatChartContents:KeyMileStoneDetailsArray];
        [chartData setValue:@"Key Milestone" forKey:@"chartTitle"];
        [chartData setValue:projectPhase forKey:@"chartSubtitle"];
        [chartData setValue:chartDataArray forKey:@"chartContents"];
        
        [json removeObjectForKey:@"baselineTypes"];
        [json setObject:chartData forKey:@"KeyMileStone"];
    }
    
    return json;
    
}

/**Updates formatting for Key Milestone to the acceptable HTML format**/
-(NSMutableDictionary *)processJSON:(NSDictionary *)json {
    
    NSArray *chartContents = [NSArray array];
    chartContents = [self formatChartContents:[json valueForKey:@"chartContents"]];
    
    NSMutableDictionary *processedJSON = [NSMutableDictionary dictionaryWithDictionary:@{@"KeyMileStone": @{@"chartTitle": @"Key Milestone",@"chartSubtitle": @"Project Phase Fid Rev 0",@"chartContents": chartContents},@"PlatformSchedule": [json valueForKey:@"PlatformSchedule"], @"ScheduleVariance":[json valueForKey:@"ScheduleVariance"]}];
    
    return processedJSON;
}

/**Format Chart Contents to Determine if data is Actual Progress, Plan or Original Baseline**/
-(NSArray *)formatChartContents:(NSArray *)chartContents {
    
    NSMutableArray *outlookBehind = [NSMutableArray array]; // Outlook Behind Schedule
    NSMutableArray *outlookOn = [NSMutableArray array];      // Outlook On Schedule
    NSMutableArray *baseline = [NSMutableArray array];       // Baseline
    
    for (NSArray *rec in chartContents) {
        //Define the date and mutable dictionary
        NSDate *plannedDt;
        NSDate *actualDt;
        NSMutableDictionary *planData;
        NSMutableDictionary *actualData;
        
        if ([rec valueForKey:@"plannedDt"]!= [NSNull null]) {
            //Define the planned date in Date format
            plannedDt = [rec valueForKey:@"plannedDt"];
            //Prepopulate the plannedDt into dictionary
            planData = [NSMutableDictionary dictionary];
            NSString *plannedDtStr = [NSString stringWithFormat:@"%@", plannedDt];
            NSString *value = [plannedDtStr substringWithRange:NSMakeRange(0, 10)];
            plannedDtStr = [NSString stringWithFormat:@"%@%@", value, @"T00:00:00"];
            [planData setValue:[rec valueForKey:@"mileStone"] forKey:@"name"];
            [planData setValue:plannedDtStr forKey:@"x"];
            [planData setValue:[rec valueForKey:@"baseLineNum"] forKey:@"y"];
        }
        if ([rec valueForKey:@"actualDt"]!= [NSNull null]) {
            //Define the actual date in Date format
            actualDt = [rec valueForKey:@"actualDt"];
            //Prepopulate the actualDt into dictionary
            actualData = [NSMutableDictionary dictionary];
            NSString *actualDtStr = [NSString stringWithFormat:@"%@", actualDt];
            NSString *value = [actualDtStr substringWithRange:NSMakeRange(0, 10)];
            actualDtStr = [NSString stringWithFormat:@"%@%@", value, @"T00:00:00"];
            [actualData setValue:[rec valueForKey:@"mileStone"] forKey:@"name"];
            [actualData setValue:actualDtStr forKey:@"x"];
            [actualData setValue:[rec valueForKey:@"baseLineNum"] forKey:@"y"];
        }
        
        //If plannedDt not null
        if ([rec valueForKey:@"plannedDt"]!= [NSNull null]) {
            //Can store the plannedDt in planned array to show for Original Baseline
            [baseline addObject:planData];
            
            //If actualDt is not null
            if ([rec valueForKey:@"actualDt"]!= [NSNull null]) {
                //Depending on whether actual date before or after planned Date
                if ([actualDt compare:plannedDt] == NSOrderedDescending) {
                    //IF actualDt > plannedDt, put the actualDt in actualProgress array
                    [outlookBehind addObject:actualData];
                } else {
                    //If actualDt <= plannedDt, put the it in original array
                    [outlookOn addObject:actualData];
                }
            }
            //If actualDt is null
            else {
                //Dont do anything
            }
            
        }
        //If plannedDt is null
        else {
            //If actualDt is not null
            if ([rec valueForKey:@"actualDt"]!= [NSNull null]) {
                //Put the actualDt in actual array
                [outlookBehind addObject:actualData];
            }
            //If actualDt is null
            else {
                //Dont do anything
            }
        }
    }
    
    chartContents = @[@{@"name": @"Actual Progress", @"data": outlookBehind}, @{@"name": @"Original Baseline", @"data": baseline}, @{@"name": @"Plan", @"data": outlookOn}];
    
    return chartContents;
}

- (void)fetchOfflineDataWithReportingMonth:(NSString *)reportingMonth
                           withProjectKeys:(NSNumber *) projectKey
                                   success:(void (^)(NSString* scorecards))success
                                   failure:(void (^)(NSError *error))failure {
    
    //Fetch scorecard with reporting month
    NSManagedObjectContext* context = [NSManagedObjectContext contextForCurrentThread];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(project, $project, ANY $project.key == %@).@count != 0) AND (SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count != 0)", projectKey, [reportingMonth toDate]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"projectKey == %@ AND reportMonth == %@", projectKey, [reportingMonth toDate]];
    NSArray *foundProjects = [ETGScorecard findAllWithPredicate:predicate inContext:context];
//    NSArray *foundProjectsInProjectSummary = [ETGScorecard findAllWithPredicate:predicate inContext:context];
  
    NSError* error;
    
    if ([foundProjects count]) {

        NSMutableArray *jsonDict = [NSMutableArray array];
        _jsonForSchedulePopover = [NSMutableDictionary dictionary];
        
//        if ([foundProjects count]) {
//            // Create Core Data to JSON mapping
//            for (ETGPlatform* card in foundProjects) {
//                [self serializeObject:card inverseMapping:_inverseMappingForPlatform];
//            }
//        }
        
        // Create Core Data to JSON mapping
        for (ETGScorecard* card in foundProjects) {
            [self serializeObject:card inverseMapping:_inverseMappingForProjectSummary];
        }
        
        if (!_jsonForSchedulePopover) {
            //An error occurred
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:coreDataToJSONError forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"ETG" code:100 userInfo:errorDetail];
            DDLogError(@"%@%@", logErrorPrefix, error.description);
        } else {
            _jsonForSchedulePopover = [self getRootName:_jsonForSchedulePopover reportingMonth:reportingMonth projectKey:projectKey];
            [jsonDict addObject:_jsonForSchedulePopover];
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
