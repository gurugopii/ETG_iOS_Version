//
//  ETGLessonsCountModel.h
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "JSONModel.h"

@interface ETGPllLessonsCountModel : JSONModel

@property (nonatomic, strong) NSArray *pllReviews;
@property (nonatomic, strong) NSArray *pllProjects;

+(ETGPllLessonsCountModel *)pllLessonsCountModelFromJson:(NSDictionary *)json;
-(NSString *)getPllAllLessonCountJson;

@end
