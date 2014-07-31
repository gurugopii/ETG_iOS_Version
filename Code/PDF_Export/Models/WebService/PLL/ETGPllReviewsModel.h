//
//  ETGPllReviewsModel.h
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "JSONModel.h"

@interface ETGPllReviewsModel : JSONModel

+(id)reviewsModelFromJson:(NSDictionary *)json;

@property (nonatomic) int avoidLessons;
@property (nonatomic, strong) NSString *pllReview;
@property (nonatomic) int pllReviewKey;
@property (nonatomic) int replicateLessons;

@end
