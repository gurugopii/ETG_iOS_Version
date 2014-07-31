//
//  ETGEccrCpbWebService.h
//  ETG
//
//  Created by Tan Aik Keong on 1/28/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGEccrCpbWebService : NSObject

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString *jsonString))success
                              failure:(void (^)(NSError *error))failure;
-(BOOL)needRefreshDataWithReportingMonth:(NSString *)reportingMonth;
-(NSString *)getOfflineData:(NSString *)reportingMonth;

@property (nonatomic, strong) NSArray *budgetHolderKeys;
@property (nonatomic, strong) NSArray *filteredProjects;
@property (nonatomic, strong) NSArray *filteredCostCategories;

@end
