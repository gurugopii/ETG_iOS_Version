//
//  ETGPllModelController.m
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPllModelController.h"
#import "ETGPllLessonsCount.h"
#import "ETGAppDelegate.h"
#import "ETGPllLesson.h"
#import "ETGPllSearchResult.h"

@interface ETGPllModelController()
@property (nonatomic, strong) ETGAppDelegate *appDelegate;
@end

@implementation ETGPllModelController

+ (instancetype)sharedModel {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(id)init {
    self = [super init];
    if (self) {
        // Set web service
        _appDelegate = (ETGAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

#pragma mark - Web Service
-(void)getLessonsCountWebServiceData {
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"ETG" accessGroup:nil];
    // Create web service with mapping to model
    ETGPllLessonsCount *lessonsCount = [[ETGPllLessonsCount alloc] init];
    [lessonsCount sendRequestWithUserId:[keychain objectForKey:(__bridge id)kSecAttrAccount] success:^(ETGPllLessonsCountModel * lessonsCountModel) {
        self.lessonsCountModel = lessonsCountModel;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PllLessonsCountDataUpdated" object:self];
    } failure:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PllLessonsCountDataUpdated" object:self];
    }];
}

-(void)getLessonWebServiceData:(int)projectKey {
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"ETG" accessGroup:nil];
    // Create web service with mapping to model
    ETGPllLesson *lesson = [[ETGPllLesson alloc] init];
    [lesson sendRequestWithUserId:[keychain objectForKey:(__bridge id)kSecAttrAccount] andProjectKey:projectKey success:^(ETGPllLessonModel *lesson) {
        self.lessonModel = lesson;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PllLessonDataUpdated" object:self];
    } failure:^(NSError *error) {
    }];
}

-(void)getLessonWebServiceData:(int)projectKey
                       success:(void (^)(ETGPllLessonModel *))success
                       failure:(void (^)(NSError *error))failure {
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"ETG" accessGroup:nil];
    // Create web service with mapping to model
    ETGPllLesson *lesson = [[ETGPllLesson alloc] init];
    [lesson sendRequestWithUserId:[keychain objectForKey:(__bridge id)kSecAttrAccount] andProjectKey:projectKey success:^(ETGPllLessonModel *lesson) {
        success(lesson);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getSearchResultWithJsonData:(NSData *)jsonData
{
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"ETG" accessGroup:nil];
    // Create web service with mapping to model
    ETGPllSearchResult *searchResult = [[ETGPllSearchResult alloc] init];
    [searchResult sendRequestWithUserId:[keychain objectForKey:(__bridge id)kSecAttrAccount] andInputJsonData:jsonData success:^(NSArray *results) {
        self.searchResultsModel = results;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PllSearchResultsDataUpdated" object:self];
    } failure:^(NSError *error) {
        self.searchResultsModel = nil;
    }];
}

+(NSString *)getBookmarkInd:(int)key
{
    if([ETGPllModelController isBookmark:key])
    {
        return @"Y";
    }
    return @"N";
}

+(BOOL)isBookmark:(int)key
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ETGPllLessons"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectLessonDetailKey == %d", key];
    [request setPredicate:predicate];
    NSManagedObjectContext *context = [NSManagedObjectContext defaultContext];
    NSArray *results = [context executeFetchRequest:request error:nil];
    if([results count] == 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
