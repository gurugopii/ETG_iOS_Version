//
//  ETGMapPgdAndPem.h
//  ETG
//
//  Created by Tan Aik Keong on 1/7/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETGMapSection.h"
#import "ETGMapSectionProjectModel.h"

@interface ETGMapPgdAndPem : NSObject
- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth isManualRefresh:(BOOL)isManual
                              success:(void (^)(NSString *jsonString))success
                              failure:(void (^)(NSError *error))failure;
-(NSString *)getOfflineData:(NSString *)reportingMonth;

@property (nonatomic, strong) NSArray *filteredProjects;
@property (nonatomic, strong) NSArray *filteredSpeeds;
@property (nonatomic, strong) NSArray *filteredDurations;


@end
