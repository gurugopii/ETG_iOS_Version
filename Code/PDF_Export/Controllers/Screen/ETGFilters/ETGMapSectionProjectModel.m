//
//  ETGMapSectionProjectModel.m
//  ETG
//
//  Created by Tan Aik Keong on 1/9/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGMapSectionProjectModel.h"

@implementation ETGMapSectionProjectModel

+(ETGMapSectionProjectModel *)mapSectionProjectModelFromName:(NSString *)name key:(NSString *)key region:(int)region cluster:(int)cluster
{
    ETGMapSectionProjectModel *model = [ETGMapSectionProjectModel new];
    model.name = name;
    model.key = @([key integerValue]);
    model.regionKey = region;
    model.clusterKey = cluster;
    return model;
}


@end
