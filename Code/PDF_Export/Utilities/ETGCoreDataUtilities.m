//
//  ETGCoreDataUtilities.m
//  PDF_Export
//
//  Created by patrick.j.d.medina on 11/21/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGCoreDataUtilities.h"
#import "CommonMethods.h"
#import <AFNetworking.h>
#import "ETGReportingMonth.h"
#import "ETGTimestamp.h"
#import "ETGWebService.h"

@interface ETGCoreDataUtilities ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) RKObjectManager* managedObject;

@property (nonatomic) BOOL haveUAC;

@end

@implementation ETGCoreDataUtilities

+ (instancetype)sharedCoreDataUtilities {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.managedObject = [[ETGWebService sharedWebService] objectManager];
    }
    
    return self;
}

- (BOOL)coreDataHasEntriesForEntityName:(NSString *)entityName {
    _managedObjectContext = [NSManagedObjectContext defaultContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    [request setFetchLimit:1];
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error != nil) {
        DDLogError(fetchError, error);
        abort();
    }
    if ([results count] == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)coreDataHasUACForWebService:(NSString *)webServicePath reportingMonth:(NSString *)reportingMonth{
    // Add code here for UAC
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:reportingMonth forKey:@"inpReportingMonth"];
    NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:webServicePath httpMethod:@"POST"];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                                         ^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
                                             [self setValueHaveUAC];
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSDictionary *responseHeadersDict = [response allHeaderFields];
                                             NSString *strXErrorMsg = [responseHeadersDict valueForKey:@"X-Message"];
                                             DDLogError(@"%@%@", logErrorPrefix, strXErrorMsg);
                                             DDLogError(@"%@%@", logErrorPrefix, responseHeadersDict);
                                             [self setValueHaveNoUAC];
                                         }];
    operation.SSLPinningMode = AFSSLPinningModeCertificate;
    [operation start];
    
    return _haveUAC;
}

- (void) setValueHaveUAC{
    _haveUAC = YES;
}

- (void) setValueHaveNoUAC{
    _haveUAC = NO;
}

- (NSString *)getTimeStampForModule:(NSString *)moduleName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"moduleName == %@", moduleName];
    ETGTimestamp *timestamp = [ETGTimestamp findFirstWithPredicate:predicate];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd MMM yyyy"];
    
    if (timestamp.timeStamp) {
        return [formatter stringFromDate:timestamp.timeStamp];
    } else {
        return [formatter stringFromDate:[NSDate date]];
    }
    
//    return [formatter stringFromDate:timestamp.timeStamp];
}

-(void)storeTimeStampInUserDefaults:(NSString *)moduleName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSDate date] forKey:moduleName];
    [defaults synchronize];
}

-(BOOL)isTimeStampInUserDefaultsMoreThanNumberOfDays:(int)days inModuleName:(NSString *)moduleName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *date = [defaults objectForKey:moduleName];
    if(nil == date)
    {
        return YES;
    }
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval diff = now - timeInterval;
    if(diff > (60 * 60 * 24 * days))
    {
        return YES;
    }
    return NO;
}

-(void)clearAllTimeStampInUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"ECCRFilter"];
    [defaults removeObjectForKey:@"MasterDataFilter"];
    [defaults removeObjectForKey:@"PllBaseFilter"];
    [defaults removeObjectForKey:@"ManpowerFilter"];

    NSDictionary * dict = [defaults dictionaryRepresentation];
    for (NSString *key in dict)
    {
        if([key hasPrefix:@"ManPowerFilter"])
        {
            [defaults removeObjectForKey:key];
        }
    }
    [defaults synchronize];
}

- (void)storeTimeStamp:(NSString *)reportMonth
            moduleName:(NSString *)moduleName{
    
    NSManagedObjectContext* context = [NSManagedObjectContext contextForCurrentThread];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@", [reportMonth toDate]];
    ETGReportingMonth* reportingMonth = [ETGReportingMonth findFirstWithPredicate:predicate inContext:[NSManagedObjectContext defaultContext]];

    // If reporting month does not exist, set a new one
    if (reportingMonth == nil) {
        reportingMonth = [ETGReportingMonth createInContext:_managedObjectContext];
        reportingMonth.name = [reportMonth toDate];
    }

    predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count !=0) AND moduleName == %@", [reportMonth toDate], moduleName];
    ETGTimestamp* timeStamp = [ETGTimestamp findFirstWithPredicate:predicate inContext:[NSManagedObjectContext defaultContext]];

    if (timeStamp == nil) {
        
        timeStamp = [ETGTimestamp createInContext:[NSManagedObjectContext defaultContext]];
        timeStamp.moduleName = moduleName;
        timeStamp.timeStamp = [[NSString stringWithFormat:@"%@", [NSDate date]] toDate];
        
        //Relationship
        [timeStamp setReportingMonth:reportingMonth];
        //Inverse Relationship
        [reportingMonth addTimeStampsObject:timeStamp];
    } else {
        timeStamp.timeStamp = [[NSString stringWithFormat:@"%@", [NSDate date]] toDate];
    }
    
    // Save to persistent store
    NSError* error;
    [context saveToPersistentStore:&error];
    if (error) {
        DDLogWarn(@"%@%@", logWarnPrefix, persistentStoreError);
        DDLogWarn(@"%@%@", logWarnPrefix, fetchedDataPersistentError);
    }

}

- (NSDate *)retrieveTimeStampForModule:(NSString *)moduleName withReportingMonth:(NSString *)reportMonth {
    
    _managedObjectContext = [NSManagedObjectContext defaultContext];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count > 0) AND moduleName == %@", [reportMonth toDate], moduleName];
    
    ETGTimestamp* timeStamp = [ETGTimestamp findFirstWithPredicate:predicate inContext:[NSManagedObjectContext defaultContext]];
    
    return timeStamp.timeStamp;
}

- (BOOL)isTimeStampMoreThanOneDayForModule:(NSString *)moduleName reportingMonth:(NSString *)reportMonth {
    
//    _managedObjectContext = [NSManagedObjectContext defaultContext];
//    
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count > 0) AND moduleName == %@", [reportMonth toDate], moduleName];
//    
//    ETGTimestamp* timeStamp = [ETGTimestamp findFirstWithPredicate:predicate inContext:[NSManagedObjectContext defaultContext]];
    
    //Get the current date
    NSDate *currentDay = [NSDate date];
    
    //Get the timestamp of a module from Core Data
//    NSDate *currentTimeStamp = timeStamp.timeStamp;
    NSDate *currentTimeStamp = [self retrieveTimeStampForModule:moduleName withReportingMonth:reportMonth];
    
    NSDate *currentTimeStampDate;
    NSDate *currentDayDate;
    int daysDifference;
    
    if (currentTimeStamp) {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        [calendar rangeOfUnit:NSDayCalendarUnit startDate:&currentTimeStampDate interval:NULL forDate:currentTimeStamp];
        [calendar rangeOfUnit:NSDayCalendarUnit startDate:&currentDayDate interval:NULL forDate:currentDay];
        
        NSDateComponents *difference = [calendar components:NSDayCalendarUnit fromDate:currentTimeStampDate toDate:currentDayDate options:0];
        daysDifference = difference.day;
       // NSLog(@"%d", daysDifference);

    } else {
        daysDifference = kTimestampDateDifference;
    }
    
    if (daysDifference >= kTimestampDateDifference) {
        return YES;
    } else {
        return NO;
    }
}


- (BOOL)isTimeStampForModule:(NSString *)moduleName hasMoreThanNumberOfDays:(NSInteger)days inReportingMonth:(NSString *)reportMonth {
    
    _managedObjectContext = [NSManagedObjectContext defaultContext];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(reportingMonth, $reportingMonth, ANY $reportingMonth.name == %@).@count > 0) AND moduleName == %@", [reportMonth toDate], moduleName];
    
    ETGTimestamp* timeStamp = [ETGTimestamp findFirstWithPredicate:predicate inContext:[NSManagedObjectContext defaultContext]];
    
    //Get the timestamp of a module from Core Data
    NSDate *currentTimeStamp = timeStamp.timeStamp;
    
    // Check if timestamp is empty
    if (currentTimeStamp == nil) {
        return YES;
    }
    else {
        //Get the difference between the current date and timestamp
        NSTimeInterval timeInterval = [currentTimeStamp timeIntervalSince1970];
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval diff = now - timeInterval;
        if(diff > (60 * 60 * 24 * days))
        {
            return YES;
        }
        //DDLogInfo(@"%@ Hour difference between timestamp and current time: %f", logInfoPrefix,diff);
    }
    
    return NO;
}

@end
