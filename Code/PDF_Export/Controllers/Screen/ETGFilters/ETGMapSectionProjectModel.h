//
//  ETGMapSectionProjectModel.h
//  ETG
//
//  Created by Tan Aik Keong on 1/9/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGMapSectionProjectModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *key;
@property (nonatomic) int regionKey;
@property (nonatomic) int clusterKey;

+(ETGMapSectionProjectModel *)mapSectionProjectModelFromName:(NSString *)name key:(NSString *)key region:(int)region cluster:(int)cluster;

@end
