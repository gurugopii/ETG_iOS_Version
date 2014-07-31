//
//  ETGMpHcrWebService.h
//  ETG
//
//  Created by Helmi Hasan on 3/6/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGMpHcrWebService : NSObject

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString *jsonString))success
                              failure:(void (^)(NSError *error))failure;
-(BOOL)needRefreshDataForReportingMonth:(NSString *)reportingMonth;
-(NSString *)getOfflineData:(NSString *)reportingMonth;

@property (nonatomic, strong) NSArray *filteredDepartments;
@property (nonatomic, strong) NSArray *filteredSections;
@property (nonatomic, strong) NSArray *filteredYears;
@property (nonatomic, strong) NSArray *filteredRegions;
@property (nonatomic, strong) NSArray *filteredClusters;
@property (nonatomic, strong) NSArray *filteredProjectPositions;

@end