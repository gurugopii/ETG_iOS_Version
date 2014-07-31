//
//  ETGPllReviewsModel.m
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGPllReviewsModel.h"
#import "ETGJsonHelper.h"

@implementation ETGPllReviewsModel

+(id)reviewsModelFromJson:(NSDictionary *)json
{
    ETGPllReviewsModel *model = [ETGPllReviewsModel new];
    model.avoidLessons = [[ETGJsonHelper resetToZeroIfRequired:json[@"avoidLessons"]] intValue];
    model.pllReview = [ETGJsonHelper resetToEmptyStringIfRequired:json[@"pllReview"]];
    model.pllReviewKey = [[ETGJsonHelper resetToZeroIfRequired:json[@"pllReviewKey"]] intValue];
    model.replicateLessons = [[ETGJsonHelper resetToZeroIfRequired:json[@"replicateLessons"]] intValue];
    return model;
}

@end
