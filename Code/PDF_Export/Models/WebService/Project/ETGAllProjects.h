//
//  ETGAllProjects.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/19/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface ETGAllProjects : NSObject

//Properties
@property (nonatomic, strong) NSArray *keyMilestones;
@property (nonatomic, strong) NSDictionary *filterDictionary;

//Methods
- (RKManagedObjectRequestOperation*)sendRequestWithReportingMonth:(NSString *)reportingMonth
                           projectKey:(NSNumber *)projectKey
                withKeyMilestonesData:(NSArray*)keyMilestones
                    withProjectReports:(NSDictionary*)enabledReports
                              success:(void (^)(NSString *projectData))success
                              failure:(void (^)(NSError *error))failure;

- (void)fetchOfflineDataWithReportingMonth:(NSString *)reportingMonth
                                projectKey:(NSNumber *)projectKey
                     withKeyMilestonesData:(NSArray*)keyMilestones
                        withProjectReports:(NSDictionary*)enabledReports
                                   success:(void (^)(NSString *projectData))success
                                   failure:(void (^)(NSError *error))failure;

-(void)setFirstProjectBoolValue:(BOOL)boolValue;
- (BOOL)uacCanSeeReport:(NSString *)reportingMonth;
- (BOOL)entityIsEmpty;
- (void)setBaseFilters;
- (void)populateEnableReportsArray:(NSDictionary *)enablePortfolioReports;

@end
