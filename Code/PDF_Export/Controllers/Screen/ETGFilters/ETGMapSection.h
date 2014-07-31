//
//  ETGMapSection.h
//  ETG
//
//  Created by Tan Aik Keong on 1/9/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    kMapDurationLessThanOneMonth,
    kMapDurationBetweenOneToSixMonth,
    kMapDurationMoreThanSixMonths,
} kMapDuration;

// Refer to status in MAP Pem
typedef enum
{
    kMapSpeedSlowFdpSlowExecution = 58,
    kMapSpeedSlowFdpFastExeuction,
    kMapSpeedFastFdpSlowExecution,
    kMapSpeedFastFdpFastExecution,
} kMapSpeed;


@interface ETGMapSection : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) int value;

+(id)mapSectionWithName:(NSString *)name andValue:(int)value;
+(NSMutableArray *)getDurationValues;
+(NSMutableArray *)getSpeedValues;
+(NSMutableArray *)getProjectValuesWithReportingMonth:(NSString *)reportingMonth;
+(NSArray *)fetchProjectsBaseOnRegions:(NSArray *)regionKeys clusters:(NSArray *)clusterKeys reportingMonth:(NSString *)reportingMonth;
+(NSArray *)fetchClustersBasedOnRegions:(NSArray *)regionKeys;
@end

