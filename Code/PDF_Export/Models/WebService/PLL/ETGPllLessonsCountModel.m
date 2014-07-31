//
//  ETGLessonsCountModel.m
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPllLessonsCountModel.h"
#import "ETGPllReviewsModel.h"
#import "ETGPllProjectsModel.h"

@implementation ETGPllLessonsCountModel

+(ETGPllLessonsCountModel *)pllLessonsCountModelFromJson:(NSDictionary *)json
{
    ETGPllLessonsCountModel *model = [ETGPllLessonsCountModel new];
    
    NSArray *reviewsJson = json[@"pllReviews"];
    NSArray *projectsJson = json[@"projects"];
    
    NSMutableArray *reviews = [NSMutableArray new];
    for(NSDictionary *reviewJson in reviewsJson)
    {
        [reviews addObject:[ETGPllReviewsModel reviewsModelFromJson:reviewJson]];
    }
    
    NSMutableArray *projects = [NSMutableArray new];
    for(NSDictionary *projectJson in projectsJson)
    {
        [projects addObject:[ETGPllProjectsModel projectsModelFromJson:projectJson]];
    }
    
    model.pllReviews = reviews;
    model.pllProjects = projects;
    return model;
}

-(NSString *)getPllAllLessonCountJson
{
    NSString *allData = [NSString stringWithFormat:@"\{%@,%@}", [self getPllReviewsJson], [self getPllProjectsJson]];
    return allData;
}

-(NSString *)getPllProjectsJson
{
    NSMutableString *jsonString = [[NSMutableString alloc] initWithFormat:@"\"projects\" : ["];
    int i = 0;
    for(ETGPllReviewsModel *project in self.pllProjects)
    {
        i++;
        [jsonString appendString:[project toJSONString]];
        if(i < [self.pllProjects count])
            [jsonString appendString:@","];
    }
    [jsonString appendString:@"]"];
    return jsonString;
}

-(NSString *)getPllReviewsJson
{
    NSMutableString *jsonString = [[NSMutableString alloc] initWithFormat:@"\"pllReviews\" : ["];
    int i = 0;
    for(ETGPllReviewsModel *review in self.pllReviews)
    {
        i++;
        [jsonString appendString:[review toJSONString]];
        if(i < [self.pllReviews count])
            [jsonString appendString:@","];
    }
    [jsonString appendString:@"]"];
    return jsonString;
}


@end
