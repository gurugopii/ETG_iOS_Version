//
//  ETGPortfolioMLH.m
//  ETG
//
//  Created by Helmi Hasan on 3/9/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPortfolioMLH.h"

#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h"
//Models
#import "ETGPortfolio.h"
#import "ETGMLPortfolio.h"
#import "ETGRegion.h"
#import "ETGReportingMonth.h"
#import "NSSet+ETGMonthCompare.h"

#import "ETGToken.h"
#import "ETGJSONKeyReplaceManipulation.h"

#import "ETGCoreDataUtilities.h"

@interface ETGPortfolioMLH ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic, strong) RKEntityMapping* mapping;
@property (nonatomic, strong) RKEntityMapping* inverseMapping;
@property (nonatomic) BOOL isMapped;
@property (nonatomic) BOOL isEmpty;
@property (nonatomic) BOOL haveUAC;
@property (nonatomic) BOOL isReportEnabled;

@end


@implementation ETGPortfolioMLH

- (id)init {
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
        if (!self.isMapped) {
            [self setupMLHMappings];
            self.isMapped = YES;
        }
    }
    return self;
}

- (void)setupMLHMappings {
    
    // Attribute Mappings for ETGMLPortfolio
    RKEntityMapping *mlMapping = [[RKEntityMapping alloc] initWithEntity:[ETGMLPortfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [mlMapping addAttributeMappingsFromDictionary:@{
                                                    @"calendarMonthOfYear" :@"calendarMonthOfYear",
                                                    @"calendarYear" : @"calendarYear",
                                                     @"calendarYearEnglishMonth"            : @"calendarYearEnglishMonth",
                                                     @"fTELoading"    : @"fTELoading",
                                                     @"projectStaffingStatusName" : @"projectStaffingStatusName",
                                                     @"reportingTimeKey" : @"reportingtimekey"
                                                     }];
    
    // Attribute Mappings for ETGPortfolio
    RKEntityMapping *portfolioMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPortfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [portfolioMapping addAttributeMappingsFromDictionary:@{
                                                           @"projectKey"  : @"projectKey",
                                                           @"@metadata.reportingMonth"   : @"reportMonth"
                                                           }];
    portfolioMapping.identificationAttributes = @[@"projectKey", @"reportMonth"];
    
    // Attribute Mappings for ETGProject
    RKEntityMapping *projectMapping = [[RKEntityMapping alloc] initWithEntity:[ETGProject entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [projectMapping addAttributeMappingsFromDictionary:@{
                                                         @"projectKey"   : @"key",
                                                         @"projectName" : @"name"
                                                         }];
    projectMapping.identificationAttributes = @[@"key", @"name"];
    
    // Attribute Mappings for ETGReportingMonth
    RKEntityMapping *reportingMonthMapping = [[RKEntityMapping alloc] initWithEntity:[ETGReportingMonth entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [reportingMonthMapping addAttributeMappingsFromDictionary:@{
                                                                @"@metadata.reportingMonth"   : @"name"
                                                                }];
    reportingMonthMapping.identificationAttributes = @[@"name"];
    
    // Attribute Mappings for ETGRegion
    RKEntityMapping *regionMapping = [[RKEntityMapping alloc] initWithEntity:[ETGRegion entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [regionMapping addAttributeMappingsFromDictionary:@{
                                                        @"regionID"  : @"name"
                                                        }];
    regionMapping.identificationAttributes = @[@"name"];
    
    // Relationship mapping of ETGRegion to ETGProject
    [projectMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"region" withMapping:regionMapping]];
    
    // Relationship mapping of ETGProject to ETGPortfolio
    [portfolioMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"project" withMapping:projectMapping]];
    
    // Relationship mapping of ETGReportingMonth to ETGPortfolio
    [portfolioMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"reportingMonth" withMapping:reportingMonthMapping]];
    
    // Relationship mapping of ETGPortfolio to ETGMLPortfolio
    [mlMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:nil toKeyPath:@"portfolio" withMapping:portfolioMapping]];
    
    // Add ETGMLPortfolio to Response descriptor
    RKResponseDescriptor *portfolioMlDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mlMapping method:RKRequestMethodPOST pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_PORTFOLIO_ML_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:portfolioMlDescriptor];
    
    // Attribute Mappings from core data to webview(html)
    RKEntityMapping *mlMapping_ = [[RKEntityMapping alloc] initWithEntity:[ETGMLPortfolio entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [mlMapping_ addAttributeMappingsFromDictionary:@{
                                                     @"calendarMonthOfYear" :@"calendarMonthOfYear",
                                                     @"calendarYear" : @"calendarYear",
                                                     @"calendarYearEnglishMonth"            : @"calendarYearEnglishMonth",
                                                     @"fTELoading"    : @"fTELoading",
                                                     @"projectStaffingStatusName" : @"projectStaffingStatusName",
                                                     @"reportingTimeKey" : @"reportingtimekey"
                                                      }];
    
    [mlMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"name" toKeyPath:@"portfolio.project.name"]];
    [mlMapping_ addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"region" toKeyPath:@"portfolio.project.region.name"]];
    
    // Create Core Data to JSON mapping
    _inverseMapping = [mlMapping_ inverseMapping];
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
        DDLogError(@"%@%@", logErrorPrefix, [NSString stringWithFormat:serializationError, error]);
        return nil;
    }
    return json;
}

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
                           projectKey:(NSNumber *)projectKey
                              success:(void (^)(NSMutableDictionary *inputData))success
                              failure:(void (^)(NSError *error))failure{
    
    _appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (_appDelegate.isNetworkServerAvailable == YES) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:reportingMonth forKey:@"inpReportingMonth"];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        //NSLog(@"params %@",params);
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_PORTFOLIO_ML_PATH];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
        [request setHTTPBody:jsonData];
        
        RKManagedObjectRequestOperation *operation = [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:[[ETGWebService sharedWebService] managedObjectContext] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
            
            // Fetch or insert ETGReportingMonth from paramater
            NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
            
            // Save to persistent store
            NSError* error;
            [context saveToPersistentStore:&error];
            
            if (error) {
                DDLogWarn(@"%@%@", logWarnPrefix,persistentStoreError);
            }
            
            NSMutableDictionary *inputData = nil;
            success(inputData);
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            
            NSHTTPURLResponse *response = [[operation HTTPRequestOperation] response];
            NSDictionary *responseHeadersDict = [response allHeaderFields];
            
            [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];
            DDLogWarn(@"%@%@ - %@",logWarnPrefix,hsePrefix, webServiceFetchError);
            DDLogError(@"%@%@", logErrorPrefix,responseHeadersDict);
            failure(error);
        }];
        //Set mapping metada
        NSDictionary* metadata = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [reportingMonth toDate], @"reportingMonth", nil];
        [operation setMappingMetadata:metadata];
        [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
        [_managedObject enqueueObjectRequestOperation:operation];
    }
    else {
        DDLogWarn(@"%@%@",logWarnPrefix,serverCannotBeReachedWarn);
    }
}

// Delete existing data
- (void) removeDuplicatesForReportingMonth:(NSString *)reportingMonth {
    
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];

    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(portfolio, $portfolio, ANY $portfolio.reportingMonth.name == %@).@count != 0)", [reportingMonth toDate]];
    
    [ETGMLPortfolio deleteAllMatchingPredicate:predicate inContext:context];
    
    NSError* error;
    [context saveToPersistentStore:&error];
    
}

- (NSArray *)aggregateDataForChartFrom:(NSSet *)cachedData reportingMonth:(NSString*)reportingMonth {
    
    NSArray *dataArray = [[NSArray alloc] initWithArray:cachedData.allObjects];
    NSSortDescriptor *monthSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"calendarMonthOfYear"
                                                                              ascending:YES];
    
    NSSortDescriptor *yearSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"calendarYear"
                                                                             ascending:YES];

    dataArray= [dataArray sortedArrayUsingDescriptors:@[yearSortDescriptor,monthSortDescriptor]];
    
    NSArray *uniqueMonths = [[NSArray alloc] initWithArray:[dataArray valueForKeyPath:@"@distinctUnionOfObjects.calendarYearEnglishMonth"]];
    NSMutableArray *aggregatedTotal = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [uniqueMonths count]; i++) {
        
        NSMutableArray *results = [NSMutableArray array];
        NSMutableDictionary *aggregatedDict = [[NSMutableDictionary alloc] init];
        
        for (int j = 0; j < dataArray.count; j++) {
            NSString *stringUniqueMonth = [uniqueMonths objectAtIndex:i];
            NSString *stringReportingDate = [[dataArray objectAtIndex:j] valueForKey:@"calendarYearEnglishMonth"];
            
            if ([stringUniqueMonth isEqualToString:stringReportingDate]) {
                [results addObject:[dataArray objectAtIndex:j]];
            }
        }
        
        if ([results count]) {
            
           NSPredicate *vacantPredicate = [NSPredicate predicateWithFormat:@"projectStaffingStatusName == 'Vacant'"];
            NSPredicate *filledPredicate = [NSPredicate predicateWithFormat:@"projectStaffingStatusName == 'Filled'"];
            NSPredicate *nullPredicate = [NSPredicate predicateWithFormat:@"fTELoading == %@",nil];
            
            // Filled
            NSArray *filledArray = [results filteredArrayUsingPredicate:filledPredicate];
            NSArray *nullFilledArray = [filledArray filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalFilledFTELoading;
            
            
            if ([results count] == [nullFilledArray count]) {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalFilledFTELoading"];
            }else {
                totalFilledFTELoading = [NSNumber numberWithFloat:[[filledArray valueForKeyPath:@"@sum.fTELoading"] floatValue]];
                [aggregatedDict setValue:totalFilledFTELoading forKey:@"totalFilledFTELoading"];
            }
            
            // Vacant
            NSArray *vacantArray = [results filteredArrayUsingPredicate:vacantPredicate];
                NSArray *nullVacantArray = [vacantArray filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalVacantFTELoading;
            
            if ([results count] == [nullVacantArray count]) {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalVacantFTELoading"];
            }else {
                totalVacantFTELoading = [NSNumber numberWithFloat:[[vacantArray valueForKeyPath:@"@sum.fTELoading"] floatValue]];
                [aggregatedDict setValue:totalVacantFTELoading forKey:@"totalVacantFTELoading"];
            }
            
            [aggregatedDict setValue:[[NSString stringWithFormat:@"%@",[uniqueMonths objectAtIndex:i]] toDate] forKey:@"month"];
            [aggregatedTotal addObject:aggregatedDict];
        } else {
            NSNumber *totalFilledFTELoading = NULL;
            NSNumber *totalVacantFTELoading = NULL;
            
            [aggregatedDict setValue:totalFilledFTELoading forKey:@"totalFilledFTELoading"];
            [aggregatedDict setValue:totalVacantFTELoading forKey:@"totalVacantFTELoading"];
            [aggregatedDict setValue:[[NSString stringWithFormat:@"%@",[uniqueMonths objectAtIndex:i]] toDate] forKey:@"month"];
            [aggregatedTotal addObject:aggregatedDict];
        }
    }
    
    NSMutableDictionary *processedtotalFilledFTELoading = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                                @"name":@"Filled",
                                                                                                @"data":[aggregatedTotal valueForKey:@"totalFilledFTELoading"]}];
    NSMutableDictionary *processedtotalVacantFTELoading = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                                 @"name":@"Vacant",
                                                                                                 @"data":[aggregatedTotal valueForKey:@"totalVacantFTELoading"]}];
    
    NSMutableDictionary *chartDictData = [NSMutableDictionary dictionaryWithDictionary:@{@"categories": uniqueMonths,
                                                                                           @"yLabel" : @"Headcount",
                                                                                           @"series" :@[processedtotalFilledFTELoading,processedtotalVacantFTELoading]}];
    

   
    NSMutableArray *processedJSON = [NSMutableArray arrayWithObjects:chartDictData, nil];
    NSMutableArray* array =  [self sortChartByDateOfJSON:processedJSON ReportingMonth:reportingMonth];
    
    return array;
}

-(NSMutableArray*)sortChartByDateOfJSON:(NSArray*)json ReportingMonth:(NSString*)reportingMonth
{
    NSMutableArray *unsortedCategories = [[json objectAtIndex:0] objectForKey:@"categories"];
    NSMutableArray *unsortedSeries = [[json objectAtIndex:0] objectForKey:@"series"];
    
    NSMutableArray *unsortedVacant = [[unsortedSeries objectAtIndex:0] objectForKey:@"data"];
    NSMutableArray *unsortedFilled = [[unsortedSeries objectAtIndex:1] objectForKey:@"data"];
    
    NSMutableArray *sortedCategories = [NSMutableArray array];
    NSMutableArray *sortedVacant = [NSMutableArray array];
    NSMutableArray *sortedFilled = [NSMutableArray array];


    for (int i =0; i< [unsortedCategories count] ; i++)
    {
        NSString *dateString = [unsortedCategories objectAtIndex:i];
        NSString *vacant = [unsortedVacant objectAtIndex:i];
        NSString *filled = [unsortedFilled objectAtIndex:i];

        if (![self isSameYearWithDate1:[dateString toDate] date2:[reportingMonth toDate]])
        {
            continue;
        }
            
        if ([sortedCategories count]==0)
        {
            [sortedCategories addObject:dateString];
            [sortedVacant addObject:vacant];
            [sortedFilled addObject:filled];

        }
        else {
            //check date one by one
            BOOL isNewer =NO;
            BOOL isOlder = NO;

            for (int j =0; j< [sortedCategories count]; j++)
            {
                NSString *dateString2 = [sortedCategories objectAtIndex:j];
                
                //check if newwest than before
                //if newest, then keep loading.
                if ([[dateString toDate] compare:[dateString2 toDate]] == NSOrderedDescending)
                {
                    isNewer=YES;
                    
                    //last array
                    if (j == [sortedCategories count]-1)
                    {
                        [sortedCategories addObject:dateString];
                        [sortedFilled addObject:filled];
                        [sortedVacant addObject:vacant];

                        break;
                    }
                }
                //check if oldest than before.
                else{
                    isOlder = YES;
                    
                    if (isNewer)
                    {
                        [sortedCategories insertObject:dateString atIndex:j];
                        [sortedFilled insertObject:filled atIndex:j];
                        [sortedVacant insertObject:vacant atIndex:j];

                        break;
                    }
                    //add at last array
                    else{
                        [sortedCategories insertObject:dateString atIndex:0];
                        [sortedFilled insertObject:filled atIndex:0];
                        [sortedVacant insertObject:vacant atIndex:0];

                        break;
                    }
                  
                }
            }
        }
    }
    
    NSMutableArray *series = [NSMutableArray arrayWithObjects:
                              @{@"name" : [[unsortedSeries objectAtIndex:1] objectForKey:@"name"], @"data" : sortedFilled},
                              @{@"name" : [[unsortedSeries objectAtIndex:0] objectForKey:@"name"], @"data" : sortedVacant},  nil];
    
    NSMutableArray *parent = [NSMutableArray arrayWithObjects:
                              @{@"categories": sortedCategories, @"series": series},
                              @{@"yLabel" : [[json objectAtIndex:0] objectForKey:@"yLabel"]}, nil];
    
    
    return parent;
}

-(NSArray*)sortTableByDateOfJSON:(NSArray*)json ReportingMonth:(NSString*)reportingMonth
{
    NSMutableArray *unsortedHeaders = [[json objectAtIndex:0] objectForKey:@"headers"];
    
    NSMutableArray *unsortedBody = [[json objectAtIndex:0] objectForKey:@"body"];
    
    NSMutableArray *sortedHeaders = [NSMutableArray array];

    for (int a = 0; a<[unsortedBody count]; a++)
    {
        
        for (int i =0; i< [unsortedHeaders count] ; i++)
        {
            NSString *dateString = [unsortedHeaders objectAtIndex:i];
            
            //not same with curretn selected reporting period, ignore them
            if (![self isSameYearWithDate1:[dateString toDate] date2:[reportingMonth toDate]])
            {
                continue;
            }
            
            if ([sortedHeaders count]==0)
            {
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setValue:dateString forKey:@"period"];
                
                NSMutableArray *sortedVacant = [NSMutableArray array];
                NSMutableArray *sortedFilled = [NSMutableArray array];
                
                for (int x=0;x<[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] count]; x++)
                {
                    [sortedVacant addObject:[[[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] objectAtIndex:x] objectForKey:@"vacant"] objectAtIndex:i]];
                    [sortedFilled addObject:[[[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] objectAtIndex:x] objectForKey:@"filled"] objectAtIndex:i]];
                    
                }
                
                [dict setValue:sortedVacant forKey:@"vacant"];
                [dict setValue:sortedFilled forKey:@"filled"];
  
                [sortedHeaders addObject:dict];
                
            }
            else {
                //check date one by one
                BOOL isNewer =NO;
                BOOL isOlder = NO;
                
                for (int j =0; j< [sortedHeaders count]; j++)
                {
                    NSString *dateString2 = [[sortedHeaders objectAtIndex:j] objectForKey:@"period"];
                    
                    //check if newwest than before
                    if ([[dateString toDate] compare:[dateString2 toDate]] == NSOrderedDescending)
                    {
                        isNewer=YES;
                        
                        //last array
                        //just add on top
                        if (j == [sortedHeaders count]-1)
                        {
                            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                            [dict setValue:dateString forKey:@"period"];
                            
                            NSMutableArray *sortedVacant = [NSMutableArray array];
                            NSMutableArray *sortedFilled = [NSMutableArray array];
                            
                            for (int x=0;x<[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] count]; x++)
                            {
                                [sortedVacant addObject:[[[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] objectAtIndex:x] objectForKey:@"vacant"] objectAtIndex:i]];
                                [sortedFilled addObject:[[[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] objectAtIndex:x] objectForKey:@"filled"] objectAtIndex:i]];
                                
                            }
                            
                            [dict setValue:sortedVacant forKey:@"vacant"];
                            [dict setValue:sortedFilled forKey:@"filled"];
                            
                            if (a == 0)
                            {
                                [sortedHeaders addObject:dict];
                            }
                            else{
                                [[[sortedHeaders objectAtIndex:j] objectForKey:@"vacant"] addObjectsFromArray:sortedVacant];
                                [[[sortedHeaders objectAtIndex:j] objectForKey:@"filled"] addObjectsFromArray:sortedFilled];
                            }
                            
                            break;
                            
                        }
                    } else{  //check if oldest than before.
                        isOlder = YES;
                        
                        if (isNewer)
                        {
                            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                            [dict setValue:dateString forKey:@"period"];
                            
                            NSMutableArray *sortedVacant = [NSMutableArray array];
                            NSMutableArray *sortedFilled = [NSMutableArray array];
                            
                            for (int x=0;x<[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] count]; x++)
                            {
                                
                                [sortedVacant addObject:[[[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] objectAtIndex:x] objectForKey:@"vacant"] objectAtIndex:i]];
                                [sortedFilled addObject:[[[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] objectAtIndex:x] objectForKey:@"filled"] objectAtIndex:i]];
                                
                            }
                            
                            [dict setValue:sortedVacant forKey:@"vacant"];
                            [dict setValue:sortedFilled forKey:@"filled"];
                            
                            if (a == 0)
                            {
                                [sortedHeaders insertObject:dict atIndex:j];
                            }
                            else{
                                [[[sortedHeaders objectAtIndex:j] objectForKey:@"filled"] addObjectsFromArray:sortedFilled];
                                [[[sortedHeaders objectAtIndex:j] objectForKey:@"vacant"] addObjectsFromArray:sortedVacant];
                            }
                            break;
                            
                            
                        }
                        //add at last array
                        else{
                            
                            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                            [dict setValue:dateString forKey:@"period"];
                            
                            NSMutableArray *sortedVacant = [NSMutableArray array];
                            NSMutableArray *sortedFilled = [NSMutableArray array];
                            
                            for (int x=0;x<[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] count]; x++)
                            {
                                
                                [sortedVacant addObject:[[[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] objectAtIndex:x] objectForKey:@"vacant"] objectAtIndex:i]];
                                [sortedFilled addObject:[[[[[unsortedBody objectAtIndex:a] objectForKey:@"projects"] objectAtIndex:x] objectForKey:@"filled"] objectAtIndex:i]];
                                
                            }
                            
                            [dict setValue:sortedVacant forKey:@"vacant"];
                            [dict setValue:sortedFilled forKey:@"filled"];
                            
                            
                            if (a == 0)
                            {
                                [sortedHeaders insertObject:dict atIndex:0];
                            }
                            else{
                                [[[sortedHeaders objectAtIndex:0] objectForKey:@"filled"] addObjectsFromArray:sortedFilled];
                                [[[sortedHeaders objectAtIndex:0] objectForKey:@"vacant"] addObjectsFromArray:sortedVacant];
                            }

                            break;
                        }
                    }
                }
            }
        }//end all looping
    
    }
    
    NSMutableArray *sortedArray =  [NSMutableArray arrayWithObject:@{@"header": sortedHeaders, @"body": unsortedBody}];

    return [self sortTableByProjectOfJSON:sortedArray];
}

-(NSArray*)sortTableByProjectOfJSON:(NSArray*)json
{
    NSMutableArray *unsortedBody = [[json objectAtIndex:0] objectForKey:@"body"];
    NSMutableArray *unsortedHeader = [[json objectAtIndex:0] objectForKey:@"header"];

    NSMutableArray *sortedProjects = [NSMutableArray array];
    NSMutableArray *sortedHeaders = [NSMutableArray array];

    int i =0;
    for (int a = 0; a < [unsortedBody count] ; a++)
    {
        NSArray *unsortedProjects = [[unsortedBody objectAtIndex:a] objectForKey:@"projects"];
        NSString *regionName = [[unsortedBody objectAtIndex:a] objectForKey:@"region"];
        
        //NSLog(@"region %@",regionName);
        
        for (int b =0; b< [unsortedProjects count] ; b++, i++)
        {
            NSString *projectName = [[unsortedProjects objectAtIndex:b] objectForKey:@"name"];
            
            
            if ([sortedProjects count]==0)
            {
                
                for (int x=0;x<[unsortedHeader  count]; x++)
                {
                    
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    [dict setObject:[NSMutableArray arrayWithObject:[[[unsortedHeader objectAtIndex:x] objectForKey:@"vacant"] objectAtIndex:i]] forKey:@"vacant"];
                    [dict setObject:[NSMutableArray arrayWithObject:[[[unsortedHeader objectAtIndex:x] objectForKey:@"filled"] objectAtIndex:i]] forKey:@"filled"];
                    [dict setObject:[[unsortedHeader objectAtIndex:x] objectForKey:@"period"]  forKey:@"period"];
                    
                    [sortedHeaders addObject:dict];
                }
                
                
                [sortedProjects addObject:@{@"name":projectName,@"region":regionName}];
                
            }
            else {
                
                //check date one by one
                BOOL isNewer =NO;
                BOOL isOlder = NO;
                
                for (int j =0; j< [sortedProjects count]; j++)
                {
                    NSString *projectName2 = [[sortedProjects objectAtIndex:j] objectForKey:@"name"];
                    
                    //check if newwest than before
                    if ([projectName compare:projectName2 options:NSCaseInsensitiveSearch] == NSOrderedDescending)
                    {
                        isNewer=YES;
                        
                        //last array
                        //just add on top
                        if (j == [sortedProjects count]-1)
                        {
                            
                            for (int x=0;x<[unsortedHeader  count]; x++)
                            {
                                
                                NSMutableArray *sortedVacant = [[sortedHeaders objectAtIndex:x] objectForKey:@"vacant"];
                                NSMutableArray *sortedFilled = [[sortedHeaders objectAtIndex:x] objectForKey:@"filled"];
                                
                                
                                [sortedVacant addObject:[[[unsortedHeader objectAtIndex:x] objectForKey:@"vacant"] objectAtIndex:i]];
                                [sortedFilled addObject:[[[unsortedHeader objectAtIndex:x] objectForKey:@"filled"] objectAtIndex:i]];
                            }
                            
                            
                            [sortedProjects addObject:@{@"name":projectName,@"region":regionName}];
                            break;
                            
                        }
                    }
                    else{  //check if oldest than before.
                        isOlder = YES;
                        
                        if (isNewer)
                        {
                            for (int x=0;x<[unsortedHeader  count]; x++)
                            {
                                
                                NSMutableArray *sortedVacant = [[sortedHeaders objectAtIndex:x] objectForKey:@"vacant"];
                                NSMutableArray *sortedFilled = [[sortedHeaders objectAtIndex:x] objectForKey:@"filled"];
                                
                                [sortedVacant insertObject:[[[unsortedHeader objectAtIndex:x] objectForKey:@"vacant"] objectAtIndex:i] atIndex:j];
                                [sortedFilled insertObject:[[[unsortedHeader objectAtIndex:x] objectForKey:@"filled"] objectAtIndex:i] atIndex:j];
                            }
                            
                            [sortedProjects insertObject:@{@"name":projectName,@"region":regionName} atIndex:j];
                            
                            break;
                        }
                        //add at last array
                        else{
                            
                            for (int x=0;x<[unsortedHeader  count]; x++)
                            {
                                //NSLog(@"unsortedHeader %@",unsortedHeader);
                                NSMutableArray *sortedVacant = [[sortedHeaders objectAtIndex:x] objectForKey:@"vacant"];
                                NSMutableArray *sortedFilled = [[sortedHeaders objectAtIndex:x] objectForKey:@"filled"];

                                [sortedVacant insertObject:[[[unsortedHeader objectAtIndex:x] objectForKey:@"vacant"] objectAtIndex:i] atIndex:0];
                                [sortedFilled insertObject:[[[unsortedHeader objectAtIndex:x] objectForKey:@"filled"] objectAtIndex:i] atIndex:0];
                            }
                            
                            [sortedProjects insertObject:@{@"name":projectName,@"region":regionName} atIndex:0];
                            
                            break;
                        }
                    }
                }
            }
        }//end all looping
    
    }
    NSMutableArray *sortedArray =  [NSMutableArray arrayWithObject:@{@"header": sortedHeaders, @"body": sortedProjects}];
    
    return sortedArray;
}

- (BOOL)isSameYearWithDate1:(NSDate*)date1 date2:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 year]  == [comp2 year];
}

- (NSArray *)aggregateDataForTableFrom:(NSArray *)dataArray reportingMonth:(NSString*)reportingMonth {
    
    NSSortDescriptor *monthSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"calendarMonthOfYear"
                                                                          ascending:YES];
    
    NSSortDescriptor *yearSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"calendarYear"
                                                                         ascending:YES];
    
    dataArray= [dataArray sortedArrayUsingDescriptors:@[yearSortDescriptor,monthSortDescriptor]];
    
    NSArray *uniqueMonths = [[NSArray alloc] initWithArray:[dataArray valueForKeyPath:@"@distinctUnionOfObjects.calendarYearEnglishMonth"]];
    NSArray *uniqueRegion = [[NSArray alloc] initWithArray:[dataArray valueForKeyPath:@"@distinctUnionOfObjects.region"]];
    
    NSMutableArray *aggregatedRegion = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [uniqueRegion count]; i++) {
        
        NSMutableArray *results = [NSMutableArray array];
        NSMutableDictionary *aggregatedDict = [[NSMutableDictionary alloc] init];
        
        for (int j = 0; j < dataArray.count; j++) {
            NSString *stringUniqueRegion = [uniqueRegion objectAtIndex:i];
            NSString *stringDataRegion = [[dataArray objectAtIndex:j] valueForKey:@"region"];
            
            if ([stringUniqueRegion isEqualToString:stringDataRegion]) {
                [results addObject:[dataArray objectAtIndex:j]];
            }
        }
        
        if ([results count]) {
            NSArray *uniqueProject = [[NSArray alloc] initWithArray:[results valueForKeyPath:@"@distinctUnionOfObjects.name"]];
            NSArray *projects = [self aggregateProjectsForTableBasedOnUniqueProjects:uniqueProject ResultRegion:results andUniqueMonth:uniqueMonths];

            [aggregatedDict setValue:[uniqueRegion objectAtIndex:i] forKey:@"region"];
            [aggregatedDict setValue:projects forKey:@"projects"];
            [aggregatedRegion addObject:aggregatedDict];

            
        } else {
            NSNumber *totalFilledFTELoading = NULL;
            NSNumber *totalVacantFTELoading = NULL;
            
            [aggregatedDict setValue:totalFilledFTELoading forKey:@"totalFilledFTELoading"];
            [aggregatedDict setValue:totalVacantFTELoading forKey:@"totalVacantFTELoading"];
            [aggregatedDict setValue:[[NSString stringWithFormat:@"%@",[uniqueMonths objectAtIndex:i]] toDate] forKey:@"month"];
            [aggregatedRegion addObject:aggregatedDict];
        }
    }
    
    NSMutableDictionary *tableDictData = [NSMutableDictionary dictionaryWithDictionary:@{@"headers" : uniqueMonths,
                                                                                       @"body" : aggregatedRegion}];
    
    NSArray *processedJSON = [NSArray arrayWithObjects:tableDictData, nil];
    
    //NSLog(@"table processedJSON %@",processedJSON);
    
    return  [self sortTableByDateOfJSON:processedJSON ReportingMonth:reportingMonth];
}

-(NSArray *)aggregateProjectsForTableBasedOnUniqueProjects:(NSArray *)uniqueProjects
                                              ResultRegion:(NSArray *)resultRegion
                                            andUniqueMonth:(NSArray *)uniqueMonth{
    
    NSMutableArray *aggregatedProject = [[NSMutableArray alloc] init];

    for (int i = 0; i< [uniqueProjects count]; i++) {
        NSMutableArray *result_projects = [NSMutableArray array];
        NSMutableDictionary *aggregatedDict = [[NSMutableDictionary alloc] init];
        
        for (int j = 0; j < resultRegion.count; j++) {
            NSString *stringUniqueProject = [uniqueProjects objectAtIndex:i];
            NSString *stringResultProject = [[resultRegion objectAtIndex:j] valueForKey:@"name"];
            
            if ([stringUniqueProject isEqualToString:stringResultProject]) {
                [result_projects addObject:[resultRegion objectAtIndex:j]];
            }
        }
        
        if ([result_projects count]) {
            
            NSArray *fteLoadings  =[self aggregateFTELoadingForTableBasedOnUniqueMonths:uniqueMonth andResultProject:result_projects];
         
            [aggregatedDict setValue:[uniqueProjects objectAtIndex:i] forKey:@"name"];
            [aggregatedDict setValue:[fteLoadings valueForKey:@"totalFilledFTELoading"] forKey:@"filled"];
            [aggregatedDict setValue:[fteLoadings valueForKey:@"totalVacantFTELoading"] forKey:@"vacant"];
            [aggregatedProject addObject:aggregatedDict];

        }
    }
    
    return aggregatedProject;
}

-(NSArray *)aggregateFTELoadingForTableBasedOnUniqueMonths:(NSArray *)uniqueMonths andResultProject:(NSArray*)resultProjects {
    
    NSMutableArray *aggregatedTotal = [[NSMutableArray alloc] init];

    for (int i = 0; i < [uniqueMonths count]; i++) {
        
        NSMutableArray *results = [NSMutableArray array];
        NSMutableDictionary *aggregatedDict = [[NSMutableDictionary alloc] init];
        
        for (int j = 0; j < resultProjects.count; j++) {
            NSString *stringUniqueMonth = [uniqueMonths objectAtIndex:i];
            NSString *stringReportingDate = [[resultProjects objectAtIndex:j] valueForKey:@"calendarYearEnglishMonth"];
            
            if ([stringUniqueMonth isEqualToString:stringReportingDate]) {
                [results addObject:[resultProjects objectAtIndex:j]];
            }
        }
        
        if ([results count]) {
            
            NSPredicate *vacantPredicate = [NSPredicate predicateWithFormat:@"projectStaffingStatusName == 'Vacant'"];
            NSPredicate *filledPredicate = [NSPredicate predicateWithFormat:@"projectStaffingStatusName == 'Filled'"];
            NSPredicate *nullPredicate = [NSPredicate predicateWithFormat:@"fTELoading == %@",nil];
            
            // Filled
            NSArray *filledArray = [results filteredArrayUsingPredicate:filledPredicate];
            NSArray *nullFilledArray = [filledArray filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalFilledFTELoading;
            
            
            if ([results count] == [nullFilledArray count]) {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalFilledFTELoading"];
            }else {
                totalFilledFTELoading = [NSNumber numberWithFloat:[[filledArray valueForKeyPath:@"@sum.fTELoading"] floatValue]];
                [aggregatedDict setValue:totalFilledFTELoading forKey:@"totalFilledFTELoading"];
            }
            
            // Vacant
            NSArray *vacantArray = [results filteredArrayUsingPredicate:vacantPredicate];
            NSArray *nullVacantArray = [vacantArray filteredArrayUsingPredicate:nullPredicate];
            NSNumber *totalVacantFTELoading;
            
            if ([results count] == [nullVacantArray count]) {
                [aggregatedDict setValue:[NSNull null] forKey:@"totalVacantFTELoading"];
            }else {
                totalVacantFTELoading = [NSNumber numberWithFloat:[[vacantArray valueForKeyPath:@"@sum.fTELoading"] floatValue]];
                [aggregatedDict setValue:totalVacantFTELoading forKey:@"totalVacantFTELoading"];
            }
            
            [aggregatedDict setValue:[[NSString stringWithFormat:@"%@",[uniqueMonths objectAtIndex:i]] toDate] forKey:@"month"];
            [aggregatedTotal addObject:aggregatedDict];
        } else {
            
            [aggregatedDict setValue:@"0" forKey:@"totalFilledFTELoading"];
            [aggregatedDict setValue:@"0" forKey:@"totalVacantFTELoading"];
            [aggregatedDict setValue:[[NSString stringWithFormat:@"%@",[uniqueMonths objectAtIndex:i]] toDate] forKey:@"month"];
            [aggregatedTotal addObject:aggregatedDict];
        }
    }
    
    return aggregatedTotal;

}


- (BOOL)uacCanSeeReport:(NSString *)reportingMonth{

    _haveUAC = YES;
    return _haveUAC;
}

- (BOOL)entityIsEmpty{
    _isEmpty = [[ETGCoreDataUtilities sharedCoreDataUtilities] coreDataHasEntriesForEntityName:@"ETGMlhPortfolio"];
    return _isEmpty;
}

- (void)setBaseFilters{
    // Put code to set base filters here...
    //DDLogInfo(@"%@%@", logInfoPrefix, @"Set Base filter");
}

- (void)setIsReportEnabledFlagTo:(BOOL)yesNo {
    _isReportEnabled = yesNo;
}

- (void)collectReportJSONFrom:(NSSet *)cachedData
               reportingMonth:(NSString *)reportingMonth
                      success:(void (^)(NSMutableDictionary *))success
                      failure:(void (^)(NSError *))failure{
    
    // Create Core Data to JSON mapping
    NSError* error;
    NSMutableArray *jsonDict = [NSMutableArray array];
    
    if (cachedData.count == 0) {
        
        id noData;
        noData = @"no data";
        jsonDict = noData;
        
    } else {
        for (ETGMLPortfolio* ml in cachedData) {
            NSDictionary* json = [self serializeObject:ml];
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
    }
    
    if (error) {
        failure(error);
        DDLogError(@"%@%@", logErrorPrefix,error.description);
    } else {
        if (![jsonDict isEqual: @"no data"]) {
        
            NSMutableDictionary *processedJSON = [NSMutableDictionary dictionary];
            
            __block NSArray *tableData;
            __block NSArray *chartData;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                tableData = [self aggregateDataForTableFrom:jsonDict reportingMonth:reportingMonth];
                chartData = [NSMutableArray arrayWithObject:[self aggregateDataForChartFrom:cachedData reportingMonth:reportingMonth]];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [processedJSON setValue:[tableData objectAtIndex:0] forKey:@"tabledata"];
                    [processedJSON setValue:[[chartData objectAtIndex:0] objectAtIndex:0] forKey:@"chartdata"];
                    
                    success(processedJSON);
                    
                });
            });
           
            //Gopinath - 10 Jul 2014:Commented Runloop Consumes Time
            
           /* NSArray *tableData = [self aggregateDataForTableFrom:jsonDict reportingMonth:reportingMonth];
            NSMutableArray *chartData = [NSMutableArray arrayWithObject:[self aggregateDataForChartFrom:cachedData reportingMonth:reportingMonth]];
            
            [processedJSON setValue:[tableData objectAtIndex:0] forKey:@"tabledata"];
            [processedJSON setValue:[[chartData objectAtIndex:0] objectAtIndex:0] forKey:@"chartdata"];
            
            success(processedJSON);*/
        } else {
            
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:noDataFoundError forKey:NSLocalizedDescriptionKey];
            NSError *noDataerror = [NSError errorWithDomain:@"ETG" code:101 userInfo:errorDetail];
            failure(noDataerror);
            DDLogError(@"%@%@", logErrorPrefix,noDataerror.description);
        }
    }
}

@end
