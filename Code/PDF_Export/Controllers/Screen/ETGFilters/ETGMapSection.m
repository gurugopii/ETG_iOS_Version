//
//  ETGMapSection.m
//  ETG
//
//  Created by Tan Aik Keong on 1/9/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGMapSection.h"
#import "ETGMapKeyMilestone.h"
#import "ETGProjectSummaryForMap.h"
#import "ETGRevision.h"
#import "ETGBaselineType.h"
#import "ETGMapSectionProjectModel.h"
#import "ETGReportingMonth.h"
#import "ETGMap.h"
#import "ETGMapsPEM.h"
#import "ETGMapsPGD.h"
#import "ETGRegion.h"
#import "ETGCluster.h"
#import "ETGProject.h"

@implementation ETGMapSection

+(id)mapSectionWithName:(NSString *)name andValue:(int)value
{
    ETGMapSection *section = [ETGMapSection new];
    section.name = name;
    section.value = value;
    return section;
}

+(NSMutableArray *)getDurationValues
{
    ETGMapSection *lessThanOneMonthDuration = [ETGMapSection mapSectionWithName:@"< 1 month" andValue:kMapDurationLessThanOneMonth];
    ETGMapSection *betweenOneToSixMonthsDuration = [ETGMapSection mapSectionWithName:@"1 - 6 months" andValue:kMapDurationBetweenOneToSixMonth];
    ETGMapSection *moreThanSixMonthsDuration = [ETGMapSection mapSectionWithName:@"> 6 months" andValue:kMapDurationMoreThanSixMonths];
    return [@[lessThanOneMonthDuration, betweenOneToSixMonthsDuration, moreThanSixMonthsDuration] mutableCopy];
}

+(NSMutableArray *)getSpeedValues
{
    ETGMapSection *slowFdpSlowExecution = [ETGMapSection mapSectionWithName:@"Slow FDP, Slow Execution" andValue:kMapSpeedSlowFdpSlowExecution];
    ETGMapSection *slowFdpFastExecution = [ETGMapSection mapSectionWithName:@"Slow FDP, Fast Execution" andValue:kMapSpeedSlowFdpFastExeuction];
    ETGMapSection *fastFdpSlowExecution = [ETGMapSection mapSectionWithName:@"Fast FDP, Slow Execution" andValue:kMapSpeedFastFdpSlowExecution];
    ETGMapSection *fastFdpFastExecution = [ETGMapSection mapSectionWithName:@"Fast FDP, Fast Execution" andValue:kMapSpeedFastFdpFastExecution];
    
    return [@[slowFdpSlowExecution, slowFdpFastExecution, fastFdpSlowExecution, fastFdpFastExecution] mutableCopy];
}

+(NSMutableArray *)getProjectValuesWithReportingMonth:(NSString *)reportingMonth
{
    NSMutableArray *targetMapSectionProjectModel = [NSMutableArray new];
    
    NSMutableArray *targetProjectKeys = [NSMutableArray new];
    //TODO: Verify date conversion
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"reportMonth = '%@'", reportingMonth]];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reportMonth == %@", [reportingMonth toDate]];
    NSArray *projectSummaries = [ETGProjectSummaryForMap findAllWithPredicate:predicate];
    targetProjectKeys = [projectSummaries valueForKeyPath:@"@distinctUnionOfObjects.projectKey"];
    
    for(NSNumber *projectKey in targetProjectKeys)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectKey = %@", projectKey];
        NSArray *summaries = [projectSummaries filteredArrayUsingPredicate:predicate];
        if([summaries count] > 0)
        {
            ETGProjectSummaryForMap *summary = summaries[0];
            ETGProject *project = summary.project;
            if(project.isUsedByMapValue == NO)
            {
                continue;
            }
            NSString *projectName = project.name;
            
            int regionKey = -1;
            int clusterKey = -1;
            // Find cluster and region now
            //TODO: Verify date conversion
            NSPredicate *mapsPredicate = [NSPredicate predicateWithFormat:@"reportMonth = %@", reportingMonth];
            //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reportMonth == %@", [reportingMonth toDate]];
            ETGMap *map = [ETGMap findFirstWithPredicate:mapsPredicate];
            
            // First see if we can find from PGD
            NSSet *pgds = map.etgMapsPgd;
            NSPredicate *pgdPredicate = [NSPredicate predicateWithFormat:@"projectKey == %@", projectKey];
            NSSet *filteredPgds = [pgds filteredSetUsingPredicate:pgdPredicate];
            if([filteredPgds count] > 0)
            {
                ETGMapsPGD *pgd = [[filteredPgds allObjects] objectAtIndex:0];
                if(pgd.regionKey != nil && pgd.pscKey != nil)
                {
                    regionKey = [pgd.regionKey intValue];
                    clusterKey = [pgd.pscKey intValue];
                }
            }
            
            // If not, find from PEM
            NSSet *pems = map.etgMapsPems;
            if(regionKey == -1 && clusterKey == -1)
            {
                NSPredicate *pemPredicate = [NSPredicate predicateWithFormat:@"projectKey == %@", projectKey];
                NSSet *filteredPems = [pems filteredSetUsingPredicate:pemPredicate];
                if([filteredPems count] > 0)
                {
                    ETGMapsPEM *pem = [[filteredPems allObjects] objectAtIndex:0];
                    if(pem.regionKey != nil && pem.pscKey != nil)
                    {
                        regionKey = [pem.regionKey intValue];
                        clusterKey = [pem.pscKey intValue];
                    }
                }
            }
            
            ETGMapSectionProjectModel *projectModel = [ETGMapSectionProjectModel mapSectionProjectModelFromName:projectName key:[projectKey stringValue] region:regionKey cluster:clusterKey];
            //NSLog(@"Project name is %@, region is %d, cluster is %d", projectName, regionKey, clusterKey);
            [targetMapSectionProjectModel addObject:projectModel];
        }
    }
    
    return targetMapSectionProjectModel;
}

+(NSArray *)fetchProjectsBaseOnRegions:(NSArray *)regionKeys clusters:(NSArray *)clusterKeys reportingMonth:(NSString *)reportingMonth
{
    //reportingMonth = @"20130601";
    NSArray *projects = [self getProjectValuesWithReportingMonth:reportingMonth];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"regionKey IN %@ AND clusterKey IN %@", regionKeys, clusterKeys];
    projects = [projects filteredArrayUsingPredicate:predicate];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    projects = [projects sortedArrayUsingDescriptors:@[sorter]];
    
    return projects;
}

+(NSArray *)fetchClustersBasedOnRegions:(NSArray *)regionKeys
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key IN %@", regionKeys];
    NSArray *regions = [ETGRegion findAllWithPredicate:predicate];
    
    NSMutableArray *temp = [NSMutableArray new];
    for(ETGRegion *region in regions)
    {
        [temp addObjectsFromArray:[region.clusters allObjects]];
    }
    
    NSSet *tempSet = [[NSSet alloc] initWithArray:temp];
    temp = [[tempSet allObjects] mutableCopy];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    return [temp sortedArrayUsingDescriptors:@[sorter]];
}

@end
