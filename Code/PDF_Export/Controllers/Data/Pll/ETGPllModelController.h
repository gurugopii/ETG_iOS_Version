//
//  ETGPllModelController.h
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETGPllLessonsCountModel.h"
#import "ETGPllLesson.h"

@interface ETGPllModelController : NSObject

+ (instancetype)sharedModel;
@property (nonatomic, strong) ETGPllLessonsCountModel *lessonsCountModel;
@property (nonatomic, strong) ETGPllLessonModel *lessonModel;
@property (nonatomic, strong) NSArray *searchResultsModel;

#pragma mark - Web service accessors
-(void)getLessonsCountWebServiceData;
-(void)getLessonWebServiceData:(int)projectKey;
-(void)getSearchResultWithJsonData:(NSData *)jsonData;
-(void)getLessonWebServiceData:(int)projectKey
                       success:(void (^)(ETGPllLessonModel *))success
                       failure:(void (^)(NSError *error))failure;
+(NSString *)getBookmarkInd:(int)key;
+(BOOL)isBookmark:(int)key;
@end
