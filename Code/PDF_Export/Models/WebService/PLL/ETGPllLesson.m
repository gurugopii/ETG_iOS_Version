//
//  ETGPllLesson.m
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPllLesson.h"
#import "ETGAppDelegate.h"
#import "ETGNetworkConnection.h"
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

@interface ETGPllLesson()
@property (strong, nonatomic) ETGAppDelegate *appDelegate;
@end

@implementation ETGPllLesson

- (void)sendRequestWithUserId:(NSString*)userId
                     andProjectKey:(int)key
                      success:(void (^)(ETGPllLessonModel *))success
                      failure:(void (^)(NSError *error))failure
{
    _appDelegate = (ETGAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[ETGUserDefaultManipulation sharedUserDefaultManipulation] storeShowNoServerConnectionInNSUserDefaults:@"N"];
    [ETGNetworkConnection checkAvailability];
    if (_appDelegate.isNetworkServerAvailable == YES)  {
        NSString *path = [NSString stringWithFormat:@"%@%@%@", kBaseURL, kPllService, ETG_PLL_LESSON];
        NSMutableURLRequest *request = [CommonMethods urlRequestWithPath:path httpMethod:@"POST"];
        
        NSDictionary *inputDict = @{kInputProjectLessonDetailKey: @(key)};
        NSData *inputData = [NSJSONSerialization dataWithJSONObject:inputDict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:inputData];
        
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        requestOperation.SSLPinningMode = AFSSLPinningModeCertificate;        
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if([[ETGExpiredTokenCheck sharedAlert] checkExpiredTokenWithRequestOperation:operation error:nil])
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"PllLessonDataFailedUpdated" object:self];
                 failure(nil);
                 return;
             }
             NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
             success([ETGPllLessonModel pllLessonFromJson:json]);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(error.code == kNoConnectionErrorCode)
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"PllLessonDataFailedUpdated" object:self];
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
    else
    {
        DDLogWarn(@"%@%@",logWarnPrefix,@"There's no internet connection");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PllLessonDataFailedUpdated" object:self];
        failure(nil);
    }
}

- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"\"%@\":%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [NSString stringWithFormat:@"{%@}", [parts componentsJoinedByString:@"&"]];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}


@end
