//
//  ETGPllProjectsModel.h
//  ETG
//
//  Created by Tan Aik Keong on 1/2/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "JSONModel.h"

@interface ETGPllProjectsModel : JSONModel
+(id)projectsModelFromJson:(NSDictionary *)json;

@property (nonatomic) int avoidLessons;
@property (nonatomic) int projectKey;
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic) int replicateLessons;

@end
