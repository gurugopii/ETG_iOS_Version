//
//  ETGScoreCardTableSummary.h
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETGScoreCardTableSummary;

@protocol ETGScoreCardTableSummaryDelegate <NSObject>

//- (void)appendJSONToInterface:(NSString *)jsonString;
//- (void)appendJSONOfLastPageToInterface:(NSString *)jsonStringFromInterface;
//- (void)appendJSONOfCurrentPageToInterface:(NSString *)jsonStringFromInterface withError:(NSError *)error;
- (void)appendJSONToInterface:(NSSet *)mappingResult;
- (void)appendJSONOfLastPageToInterface:(NSSet *)mappingResult;
- (void)appendJSONOfCurrentPageToInterface:(NSSet *)mappingResult withError:(NSError *)error;

@end

@interface ETGScoreCardTableSummary : NSObject

@property (nonatomic, strong) id<ETGScoreCardTableSummaryDelegate> delegate;

//- (void)sendRequestWithReportingMonth:(NSString*)reportingMonth success:(void (^)(NSString* scorecards))success failure:(void (^)(NSError *error))failure;
//- (void)sendRequestWithReportingMonthAndReturnJson:(NSString*)reportingMonth userId:(NSString*)userId success:(void (^)(NSString* scorecards))success failure:(void (^)(NSError *error))failure;
- (void)fetchOfflineDataWithReportingMonth:(NSString *)reportingMonth withProjectKeys:(NSDictionary *)projectKeys success:(void (^)(NSString* scorecards))success failure:(void (^)(NSError *error))failure;

- (void)sendRequestWithReportingMonth:(NSString*)reportingMonth
                             pageSize:(int)pageSize
                           pageNumber:(int)pageNumber
             isSelectedReportingMonth:(BOOL)isSelectedReportingMonth
                   filteredDictionary:(NSMutableDictionary*)filteredDictionary
                              success:(void (^)(NSString* scorecards))success
                              failure:(void (^)(NSError *error))failure;

@end
