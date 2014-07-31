//
//  ETGPllLessonsCount.m
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPllLessonsCount.h"
#import "ETGAppDelegate.h"
#import "ETGNetworkConnection.h"
#import "ETGPllLessonsCountModel.h"
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

@interface ETGPllLessonsCount ()
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@end

@implementation ETGPllLessonsCount

- (void)sendRequestWithUserId:(NSString*)userId
                      success:(void (^)(ETGPllLessonsCountModel *))success
                      failure:(void (^)(NSError *error))failure
{
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"Y"];
    [ETGNetworkConnection checkAvailability];
    _appDelegate = (ETGAppDelegate *)[[UIApplication sharedApplication] delegate];    
    if (_appDelegate.isNetworkServerAvailable == YES)  {
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPllService, ETG_PLL_LESSONS_COUNT];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"GET"];
        
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        requestOperation.SSLPinningMode = AFSSLPinningModeCertificate;
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if([[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:nil])
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadPllShouldAutoRefresh object:nil];
                 failure(nil);
                 return;
             }
             NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
             success([self performMapping:json]);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(error.code == kNoConnectionErrorCode)
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadPllShouldAutoRefresh object:nil];
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
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadPllShouldAutoRefresh object:nil];
        failure(nil);
        DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
    }
}

-(ETGPllLessonsCountModel *)performMapping:(NSDictionary *)json
{
    ETGPllLessonsCountModel *model = [ETGPllLessonsCountModel pllLessonsCountModelFromJson:json];
    return model;
}

@end
