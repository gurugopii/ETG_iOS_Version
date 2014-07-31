//
//  ETGMpAhcWebService.h
//  ETG
//
//  Created by Ahmad on 2/27/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGMpAhcWebService : NSObject

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString *jsonString))success
                              failure:(void (^)(NSError *error))failure;
-(BOOL)needRefreshDataForReportingMonth:(NSString *)reportingMonth;
-(NSString *)getOfflineData:(NSString *)reportingMonth;

@property (nonatomic, strong) NSArray *filteredDepartments;
@property (nonatomic, strong) NSArray *filteredSections;
@property (nonatomic, strong) NSArray *filteredYears;
@property (nonatomic, strong) NSArray *filteredDivisions;

@end
