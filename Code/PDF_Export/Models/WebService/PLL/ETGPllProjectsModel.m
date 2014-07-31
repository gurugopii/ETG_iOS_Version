//
//  ETGPllProjectsModel.m
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPllProjectsModel.h"
#import "ETGJsonHelper.h"

@implementation ETGPllProjectsModel

+(id)projectsModelFromJson:(NSDictionary *)json
{
    ETGPllProjectsModel *model = [ETGPllProjectsModel new];
    model.avoidLessons = [[ETGJsonHelper resetToZeroIfRequired:json[@"avoidLessons"]] intValue];
    model.projectKey = [[ETGJsonHelper resetToZeroIfRequired:json[@"projectKey"]] intValue];
    model.projectName = json[@"projectName"];
    model.replicateLessons = [[ETGJsonHelper resetToZeroIfRequired:json[@"replicateLessons"]] intValue];
    return model;
}

@end
