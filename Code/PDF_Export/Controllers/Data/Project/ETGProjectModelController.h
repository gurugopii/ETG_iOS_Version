//
//  ETGProjectModelController.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/19/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ETGProjectModelController : NSObject

#pragma mark - Model Controller Class methods
+ (instancetype)sharedModel;

@property (nonatomic, strong) NSDictionary *filterDictionary;

// For Project
- (void) syncProject;
- (void)setKeyMilestones:(NSArray*)keyMilestones;

#pragma mark - Web service accessors
- (void)getProjectForReportingMonth:(NSString*)reportingMonth
                     withProjectKey:(NSString*)projectKey
              withKeyMilestonesData:(NSArray*)keyMilestones
                 withProjectReports:(NSDictionary*)enabledReports
                            success:(void (^)(NSString* jsonString))success
                            failure:(void (^)(NSError *error))failure;

- (void)getProjectOfflineForReportingMonth:(NSString*)reportingMonth
                            withProjectKey:(NSString*)projectKey
                     withKeyMilestonesData:(NSArray*)keyMilestones
                        withProjectReports:(NSDictionary*)enabledReports
                                   success:(void (^)(NSString* jsonString))success
                                   failure:(void (^)(NSError *error))failure;

- (void)setTimestampAgeMoreThanOneDay:(BOOL)boolValue;

- (void)getBackgroundProjectForReportingMonth:(NSString*)reportingMonth
                               withProjectKey:(NSString*)projectKey
                        withKeyMilestonesData:(NSArray*)keyMilestones
                           withProjectReports:(NSDictionary*)enabledReports
                                      success:(void (^)(void))success
                                      failure:(void (^)(NSError *error))failure;

- (void)startProjectDownloadInBackgroundForReportingMonth:(NSString*)reportingMonth;
- (void)stopProjectDownloadInBackgroundForReportingMonth:(NSString*)reportingMonth;
- (void)setQueuepriorityForProject:(NSString *)reportingMonth;

@end

