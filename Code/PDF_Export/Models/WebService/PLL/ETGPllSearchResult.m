//
//  ETGPllSearchResult.m
//  ETG
//
//  Created by Tan Aik Keong on 1/3/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPllSearchResult.h"
#import "ETGAppDelegate.h"
#import "ETGNetworkConnection.h"
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

@interface ETGPllSearchResult()
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@end

@implementation ETGPllSearchResult

- (void)sendRequestWithUserId:(NSString*)userId
           andInputJsonData:(NSData *)input
                      success:(void (^)(NSArray *))success
                      failure:(void (^)(NSError *error))failure
{
    _appDelegate = (ETGAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"Y"];
    [ETGNetworkConnection checkAvailability];
    if (_appDelegate.isNetworkServerAvailable == YES)  {
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPllService, ETG_PLL_SEARCH_AND_FILTER];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
        
        [request setHTTPBody:input];
        
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        requestOperation.SSLPinningMode = AFSSLPinningModeCertificate;
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if([[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:nil])
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"PllSearchResultsDataFailedUpdated" object:self];
                 failure(nil);
                 return;
             }
             NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
             success([self convertToLocalModel:json]);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(error.code == kNoConnectionErrorCode)
             {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PllSearchResultsDataFailedUpdated" object:self];
                DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
             }
             else
             {
                 [[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:error];
             }
             failure(error);             
         }];
        [[NSOperationQueue mainQueue] addOperation:requestOperation];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PllSearchResultsDataFailedUpdated" object:self];
        failure(nil);
        DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
    }
}

-(NSArray *)convertToLocalModel:(NSDictionary *)json
{
    NSMutableArray *temp = [NSMutableArray new];
    NSDictionary *searchResults = json[@"searchResults"];
    for(NSDictionary *result in searchResults)
    {
        [temp addObject:[ETGPllSearchResultModel searchResultModelFromJson:result]];
    }
    return temp;
}

@end
