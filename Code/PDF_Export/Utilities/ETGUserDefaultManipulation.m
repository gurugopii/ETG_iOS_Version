//
//  ETGUserDefaultManipulation.m
//  PDF_Export
//
//  Created by mobilitySF on 10/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGUserDefaultManipulation.h"

@implementation ETGUserDefaultManipulation

+ (instancetype)sharedUserDefaultManipulation {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - Portfolio and Project
- (BOOL)isTimeStampMoreThanADayForModule:(NSString *)moduleName {
    
    float hoursDifferenceBetweenDates = [self evaluateTimeStampFromNSUserDefaults:moduleName];
   // NSLog(@"%f", hoursDifferenceBetweenDates);
    if (hoursDifferenceBetweenDates >= 24.0) {
        return YES;
    } else {
        return NO;
    }
    
    return 0;
    
}


#pragma mark - PDF Feature
- (BOOL)isTimeStampMoreThanAWeekForModule:(NSString *)moduleName {
    
    int daysDifferenceBetweenDates = [self evaluateTimeStampFromNSUserDefaultsPDF:moduleName];
    
    if (daysDifferenceBetweenDates >= 10) {
        return YES;
    } else {
        return NO;
    }
    
    return 0;
    
}

#pragma mark - Token
- (BOOL)isTimeStampMoreThanHalfHourForModule:(NSString *)moduleName {
    
    float hoursDifferenceBetweenDates = [self evaluateTimeStampFromNSUserDefaults:moduleName];
    
    if (hoursDifferenceBetweenDates >= 0.5) {
        return YES;
    } else {
        return NO;
    }
    
    return 0;
    
}

#pragma mark - Common Methods
- (float)evaluateTimeStampFromNSUserDefaults:(NSString *)moduleName {
    
    //Get the current date
    NSDate *currentDate = [NSDate date];
    
    //Get the timestamp of a module from NSUserDefaults
    NSDate *currentTimeStamp = [self retrieveTimeStampFromNSUserDefaults:moduleName];
    
    // Check if timestamp is empty
    if (currentTimeStamp == nil) {
        return 25.0;
    } else {
        //Get the difference between the current date and timestamp
        NSTimeInterval differenceBetweenDates = [currentDate timeIntervalSinceDate:currentTimeStamp];
        int numberOfSecondsInAnHour =  3600;
        float hoursDifferenceBetweenDates = differenceBetweenDates / numberOfSecondsInAnHour;
        //DDLogInfo(@"%@%f", logInfoPrefix,hoursDifferenceBetweenDates);
        
        return hoursDifferenceBetweenDates;
    }
    
    return 0;
}

- (int)evaluateTimeStampFromNSUserDefaultsPDF:(NSString *)moduleName {
    
    NSDate *currentDate = [NSDate date];
    
    NSDate *currentTimeStamp = [self retrieveTimeStampFromNSUserDefaults:moduleName];
    
    if (currentTimeStamp == nil) {
        return 11;
    } else {
        NSTimeInterval differenceBetweenDates = [currentDate timeIntervalSinceDate:currentTimeStamp];
        int numberOfSecondsInAnHour =  86400;
        float daysDifferenceBetweenDates = differenceBetweenDates / numberOfSecondsInAnHour;
        //DDLogInfo(@"%@%f", logInfoPrefix,daysDifferenceBetweenDates);
        
        return daysDifferenceBetweenDates;
    }
    
    return 0;
}

- (NSDate *)retrieveTimeStampFromNSUserDefaults:(NSString *)moduleName {
    
    //Get the timestamp of a module from NSUserDefaults
    NSDate *timeStamp = [[NSUserDefaults standardUserDefaults] valueForKey:moduleName];
    return timeStamp;
}

- (void)storeTimeStampInNSUserDefaults:(NSDate *)newTimeStamp forModule:(NSString *)moduleName {
    
    //Save the timestamp of a module from NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setValue:newTimeStamp forKey:moduleName];
    
}

- (NSString *)retrieveNewLoginFromNSUserDefaults {
    
    NSString *newLogin = [[NSUserDefaults standardUserDefaults] valueForKey:@"newLogin"];
    return newLogin;
}

- (void)storeNewLoginInNSUserDefaults:(NSString *)newLoginValue {
    
    [[NSUserDefaults standardUserDefaults] setValue:newLoginValue forKey:@"newLogin"];
    
}

- (NSString *)retrieveShowNoServerConnectionFromNSUserDefaults {
    
    NSString *noServerConnection = [[NSUserDefaults standardUserDefaults] valueForKey:@"showNoServerConnection"];
    if (noServerConnection == nil){
        return @"Y";
    }
    return noServerConnection;
}

- (void)storeShowNoServerConnectionInNSUserDefaults:(NSString *)NoServerConnection {
    
    [[NSUserDefaults standardUserDefaults] setValue:NoServerConnection forKey:@"showNoServerConnection"];
    
}

- (NSString *)retrieveEnableBaseFilterNotificationFromNSUserDefaults {
    
    NSString *baseFilterNotification = [[NSUserDefaults standardUserDefaults] valueForKey:@"baseFilterNotification"];
    if (baseFilterNotification == nil){
        return @"N";
    }
    return baseFilterNotification;
}

- (void)storeEnableBaseFilterNotificationInNSUserDefaults:(NSString *)baseFilterNotification {
    
    [[NSUserDefaults standardUserDefaults] setValue:baseFilterNotification forKey:@"baseFilterNotification"];
    
}

@end
