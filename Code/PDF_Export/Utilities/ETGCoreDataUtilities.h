//
//  ETGCoreDataUtilities.h
//  PDF_Export
//
//  Created by patrick.j.d.medina on 11/21/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGCoreDataUtilities : NSObject

+ (instancetype)sharedCoreDataUtilities;

- (BOOL)coreDataHasEntriesForEntityName:(NSString *)entityName;
- (BOOL)coreDataHasUACForWebService:(NSString *)webServicePath reportingMonth:(NSString *)reportingMonth;
- (void) setValueHaveUAC;
- (void) setValueHaveNoUAC;
- (NSString *)getTimeStampForModule:(NSString *)moduleName;
-(void)storeTimeStampInUserDefaults:(NSString *)moduleName;
-(BOOL)isTimeStampInUserDefaultsMoreThanNumberOfDays:(int)days inModuleName:(NSString *)moduleName;
- (BOOL)isTimeStampForModule:(NSString *)moduleName hasMoreThanNumberOfDays:(NSInteger)days inReportingMonth:(NSString *)reportMonth;
- (void)storeTimeStamp:(NSString *)reportMonth moduleName:(NSString *)moduleName;
- (BOOL)isTimeStampMoreThanOneDayForModule:(NSString *)moduleName reportingMonth:(NSString *)reportingMonth;
-(void)clearAllTimeStampInUserDefaults;
- (NSDate *)retrieveTimeStampForModule:(NSString *)moduleName withReportingMonth:(NSString *)reportMonth;
//- (NSArray *)fetchEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate sortDescriptorBy:(NSString *)sortDescriptorKey inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
