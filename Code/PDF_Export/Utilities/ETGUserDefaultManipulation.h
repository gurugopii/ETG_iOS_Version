//
//  ETGUserDefaultManipulation.h
//  PDF_Export
//
//  Created by mobilitySF on 10/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGUserDefaultManipulation : NSObject

#pragma mark - User Defaults Manipulation Class method
+ (instancetype)sharedUserDefaultManipulation;

#pragma mark - User Defaults Manipulation accessor
- (BOOL)isTimeStampMoreThanADayForModule:(NSString *)moduleName;
- (NSDate *)retrieveTimeStampFromNSUserDefaults:(NSString *)moduleName;
- (void)storeTimeStampInNSUserDefaults:(NSDate *)newTimeStamp forModule:(NSString *)moduleName;

- (BOOL)isTimeStampMoreThanAWeekForModule:(NSString *)moduleName;
- (BOOL)isTimeStampMoreThanHalfHourForModule:(NSString *)moduleName;

- (NSString *)retrieveNewLoginFromNSUserDefaults;
- (void)storeNewLoginInNSUserDefaults:(NSString *)newLoginValue;

- (NSString *)retrieveShowNoServerConnectionFromNSUserDefaults;
- (void)storeShowNoServerConnectionInNSUserDefaults:(NSString *)NoServerConnection;

- (NSString *)retrieveEnableBaseFilterNotificationFromNSUserDefaults;
- (void)storeEnableBaseFilterNotificationInNSUserDefaults:(NSString *)baseFilterNotification;


@end
