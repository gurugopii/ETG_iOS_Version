//
//  ETGCategories.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 10/8/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGCategories.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h" // Network checking
// Models
#import "ETGPDFCategories.h"
#import "ETGPDFSubCategories.h"
#import "ETGToken.h"
#import "ETGPDFMonths.h"

@interface ETGCategories ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGCategories

- (id)init {
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
    // Attribute Mappings for ETGPDFCategories
    RKEntityMapping *categoriesMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPDFCategories entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [categoriesMapping addAttributeMappingsFromDictionary:@{
                                                           @"categoryId"  : @"categoryId",
                                                           @"categoryName"   : @"categoryName"
                                                           }];
    categoriesMapping.identificationAttributes = @[@"categoryId", @"categoryName"];
    
    // Attribute Mappings for ETGPDFSubCategories
    RKEntityMapping *subCategoryMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPDFSubCategories entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [subCategoryMapping addAttributeMappingsFromDictionary:@{
                                                            @"subCategoryId"  : @"subCategoryId",
                                                            @"subCategoryName"   : @"subCategoryName"
                                                            }];
    subCategoryMapping.identificationAttributes = @[@"subCategoryId", @"subCategoryId"];
    
    // Attribute Mappings for ETGPDFMonths
    RKEntityMapping *monthsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPDFMonths entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [monthsMapping addAttributeMappingsFromDictionary:@{
                                                             @"month"  : @"month",
                                                             @"monthId"   : @"monthId"
                                                             }];
    monthsMapping.identificationAttributes = @[@"month", @"monthId"];
    
    // Relationship mapping of ETGPDFSubCategories to ETGPDFCategories
    [categoriesMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"subCategory" toKeyPath:@"subCategory" withMapping:subCategoryMapping]];
    
    // Add ETGPDFCategories to Response descriptor
    RKResponseDescriptor *categoriesDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:categoriesMapping method:RKRequestMethodGET pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_BASIC_FILLERS_PATH] keyPath:@"category" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [_managedObject addResponseDescriptor:categoriesDescriptor];
    
    // Add ETGPDFMonths to Response descriptor
    RKResponseDescriptor *monthsDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:monthsMapping method:RKRequestMethodGET pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_BASIC_FILLERS_PATH] keyPath:@"reportingMonth" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [_managedObject addResponseDescriptor:monthsDescriptor];
}


- (void)sendRequestWithUserId:(NSString*)userId
                     andToken:(NSString*)token
                      success:(void (^)(void))success
                      failure:(void (^)(NSError *error))failure
{
    _appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"P"];
    [ETGNetworkConnection checkAvailability];
    if (_appDelegate.isNetworkServerAvailable == YES) {
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_BASIC_FILLERS_PATH];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"GET"];
        
        RKManagedObjectRequestOperation *operation = [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:[NSManagedObjectContext contextForCurrentThread] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
            // Save to persistent store
            NSError* error;
            [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStore:&error];
            
            if (error) {
                DDLogWarn(@"%@%@", logWarnPrefix,persistentStoreError);
            }

            [[NSNotificationCenter defaultCenter] postNotificationName:@"DecksDataUpdated" object:self];
            success();
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Offline" message:serverCannotBeReachedAlert delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
//            ETGAlert *timeOut = [ETGAlert sharedAlert];
//            timeOut.alertDescription = [NSString stringWithFormat:pdfFeatureError, error.localizedDescription];
//            [timeOut showDeckAlert];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"DecksDataUpdated" object:self];
            
            NSHTTPURLResponse *response = [[operation HTTPRequestOperation] response];
            NSDictionary *responseHeadersDict = [response allHeaderFields];
            [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];
            DDLogWarn(@"%@%@ - %@",logWarnPrefix,rtbdPrefix, webServiceFetchError);
            DDLogError(@"%@%@", logErrorPrefix,responseHeadersDict);
            failure(error);
        }];
        [_managedObject enqueueObjectRequestOperation:operation];
    }
    else {
        DDLogWarn(@"%@%@",logWarnPrefix,serverCannotBeReachedWarn);
    }
}


- (void) removeAll {
    
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    
    [ETGPDFCategories truncateAllInContext:context];
    
    NSError* error;
    [context saveToPersistentStore:&error];
    
}



@end
