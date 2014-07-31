//
//  ETGDecks.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 10/8/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGDecks.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h"// Network checking
// Models
#import "ETGPDFDecks.h"
#import "ETGToken.h"
#import "PDFDocumentsDirectory.h"

@interface ETGDecks ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGDecks

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
    // Attribute Mappings for ETGPDFDecks
    RKEntityMapping *decksMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPDFDecks entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [decksMapping addAttributeMappingsFromDictionary:@{
                                                                @"dateAddedToServer": @"dateAddedToServer",
                                                                @"fileId": @"fileId",
                                                                @"fileName": @"fileName",
                                                                @"category": @"category",
                                                                @"subCategory": @"subCategory",
                                                                @"reportingMonth": @"reportingMonth",
                                                                @"tags": @"tags",
                                                                @"identification": @"identification"
                                                                }];
    decksMapping.identificationAttributes = @[@"fileId", @"fileName"];
    

    // Add ETGPDFDecks to Response descriptor
    RKResponseDescriptor *portfolioProductionRtbdDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:decksMapping method:RKRequestMethodGET pathPattern:[NSString stringWithFormat:@"%@%@", kPortfolioService, ETG_MCDECK_METADATA_PATH] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [_managedObject addResponseDescriptor:portfolioProductionRtbdDescriptor];
}

- (void)sendRequestWithUserId:(NSString*)userId andToken:(NSString*)token success:(void (^)(void))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPortfolioService, ETG_MCDECK_METADATA_PATH];
    NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"GET"];
    
    RKManagedObjectRequestOperation *operation = [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:[NSManagedObjectContext contextForCurrentThread] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        // Save to persistent store
        NSError* error;
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStore:&error];
        [self checkDownloadedDeck];
        
        if (error) {
            DDLogWarn(@"%@%@", logWarnPrefix,persistentStoreError);
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"callCategories" object:self];
        success();
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        NSDictionary *responseHeadersDict = operation.HTTPRequestOperation.response.allHeaderFields;
        NSString *xMessage = responseHeadersDict[@"X-Message"];
        UIAlertView *alertView;
        if (xMessage && [xMessage compare:@"DatabaseNoRecord" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            alertView = [[UIAlertView alloc] initWithTitle:@"Library" message:@"No data available" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        } else {
            alertView = [[UIAlertView alloc] initWithTitle:@"Offline" message:serverCannotBeReachedAlert delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        }
        [alertView show];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"callCategories" object:self];
        
        [[ETGExpiredTokenCheck sharedAlert] checkExpiredToken:responseHeadersDict];
        DDLogWarn(@"%@%@ - %@",logWarnPrefix,rtbdPrefix, webServiceFetchError);
        DDLogError(@"%@%@", logErrorPrefix,responseHeadersDict);
        failure(error);
    }];
    [_managedObject enqueueObjectRequestOperation:operation];
}

- (void) checkDownloadedDeck
{
    NSArray *downloadArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[PDFDocumentsDirectory applicationDocumentsPDFDirectory] error:nil];
    NSManagedObjectContext* context = [NSManagedObjectContext contextForCurrentThread];
    
    if (downloadArray == nil) {
        return;
    }
    
    for (NSString *fileId in downloadArray) {
        NSString* query = [NSString stringWithFormat:@"fileId = %@", fileId];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:query];
        ETGPDFDecks* pdfDecks = [ETGPDFDecks findFirstWithPredicate:predicate inContext:context];
        
        if (pdfDecks != nil) {
            pdfDecks.isOffline = [NSNumber numberWithBool:1];
//            if ([pdfDecks.isOffline isEqualToNumber:[NSNumber numberWithBool:1]]) {
//                pdfDecks.isOffline = [NSNumber numberWithBool:0];
//            } else {
//                pdfDecks.isOffline = [NSNumber numberWithBool:1];
//            }
        }
        else //delete from disk
        {
            NSString *filePath = [[PDFDocumentsDirectory applicationDocumentsPDFDirectory] stringByAppendingPathComponent:fileId];
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
    
    NSError* error;
    [context saveToPersistentStore:&error];
}

- (void) removeAll {
    
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    
    
    
    [ETGPDFDecks truncateAllInContext:context];
    
    NSError* error;
    [context saveToPersistentStore:&error];
    
}

- (void) removeNotOffline
{
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isOffline == NULL or isOffline == NO"];
    
    [ETGPDFDecks deleteAllMatchingPredicate:predicate inContext:context];
    
    NSError* error;
    [context saveToPersistentStore:&error];
}

@end
