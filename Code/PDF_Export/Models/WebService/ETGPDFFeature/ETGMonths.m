//
//  ETGMonths.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 10/8/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGMonths.h"
#import "ETGWebServiceCommonImports.h"
#import "ETGNetworkConnection.h"// Network checking
// Models
#import "ETGPDFMonths.h"

@interface ETGMonths ()

@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@property (nonatomic, strong) RKObjectManager* managedObject;
@property (nonatomic) BOOL isMapped;

@end

@implementation ETGMonths

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
    // Attribute Mappings from web service to core data
    RKEntityMapping *monthsMapping = [[RKEntityMapping alloc] initWithEntity:[ETGPDFMonths entityInManagedObjectContext:[NSManagedObjectContext defaultContext]]];
    [monthsMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"Month" toKeyPath:@"month"]];
    monthsMapping.identificationAttributes = @[@"month"];

    RKResponseDescriptor *monthsDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:monthsMapping method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [_managedObject addResponseDescriptor:monthsDescriptor];
}

- (void)sendRequestWithUserId:(NSString*)userId andToken:(NSString*)token success:(void (^)(void))success failure:(void (^)(NSError *error))failure
{

    _appDelegate = [[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"P"];
    [ETGNetworkConnection checkAvailability];
    if (_appDelegate.isNetworkServerAvailable == YES) {
        NSManagedObjectContext* context = [NSManagedObjectContext contextForCurrentThread];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBaseURL, @"/Service1.svc/GetReportingMonth"]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:userId forHTTPHeaderField:@"user_id"];
        [request setValue:token forHTTPHeaderField:@"token"];
        [request setTimeoutInterval:10.0];
        RKManagedObjectRequestOperation *operation =
        [_managedObject managedObjectRequestOperationWithRequest:request managedObjectContext:context success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            NSError* error;
            [context saveToPersistentStore:&error];
            if (error) {
                DDLogWarn(@"%@%@",logWarnPrefix,persistentStoreError);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DecksDataUpdated" object:self];
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            ETGAlert *timeOut = [ETGAlert sharedAlert];
            timeOut.alertDescription = [NSString stringWithFormat:pdfFeatureError, error.localizedDescription];
            [timeOut showDeckAlert];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DecksDataUpdated" object:self];
        }];
        [_managedObject enqueueObjectRequestOperation:operation];
    }
    else {
        DDLogWarn(@"%@%@",logWarnPrefix,serverCannotBeReachedWarn);
    }
}

@end
