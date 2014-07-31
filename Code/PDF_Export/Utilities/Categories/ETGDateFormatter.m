//
//  ETGDateFormatter.m
//  ETG
//
//  Created by iscismac001 on 7/18/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGDateFormatter.h"

@implementation ETGDateFormatter


+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
