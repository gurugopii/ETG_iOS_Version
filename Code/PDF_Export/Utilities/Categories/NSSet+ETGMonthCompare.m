//
//  NSSet+ETGMonthCompare.m
//  PDF_Export
//
//  Created by Accenture Mobility Services on 10/4/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "NSSet+ETGMonthCompare.h"
#import "ETGJSONKeyReplaceManipulation.h"

@implementation NSMutableArray (ETGMonthCompare)

- (NSMutableArray*)toConsecutiveMonthsForCpb:(NSString *)reportingMonth {
    NSArray *listOfDates = [NSArray arrayWithArray:[self getListOfMonths:reportingMonth]];

    NSMutableArray *aggregatedValues = [[NSMutableArray alloc] initWithArray:listOfDates copyItems:YES];
    for (int i = 0; i < [listOfDates count]; i++) {
        
        NSMutableArray *foundReportingDate = [[NSMutableArray alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"ddMMMyyyy"];
        
        for (int j = 0; j < [self count]; j++) {
            //NSDate *dateReportingDate = [dateFormatter dateFromString:[[self objectAtIndex:j] valueForKey:@"month"]];
            NSDate *dateReportingDate = [[self objectAtIndex:j] valueForKey:@"month"];
            
            if ([[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] isMonthOfDate:dateReportingDate equalToDate:[listOfDates objectAtIndex:i]]) {
                [foundReportingDate addObject:[self objectAtIndex:j]];
            }
        }
        
        if (![foundReportingDate count]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNull null] forKey:@"totalCPB"];
            [dict setValue:[NSNull null] forKey:@"totalYEP"];
            [dict setValue:[NSNull null] forKey:@"totalYTD"];
            [aggregatedValues replaceObjectAtIndex:i withObject:dict];
        }
        else [aggregatedValues replaceObjectAtIndex:i withObject:[foundReportingDate objectAtIndex:0]];
    }
    
    return aggregatedValues;
}

- (NSMutableArray*)toConsecutiveMonthsForWpb:(NSString *)reportingMonth {
    NSArray *listOfDates = [NSArray arrayWithArray:[self getListOfMonths:reportingMonth]];
    
    NSMutableArray *aggregatedValues = [[NSMutableArray alloc] initWithArray:listOfDates copyItems:YES];
    for (int i = 0; i < [listOfDates count]; i++) {
        
        NSMutableArray *foundReportingDate = [[NSMutableArray alloc] init];
        //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //[dateFormatter setDateFormat:@"ddMMMyyyy"];
        
        for (int j = 0; j < [self count]; j++) {
            //NSDate *dateReportingDate = [dateFormatter dateFromString:[[self objectAtIndex:j] valueForKey:@"month"]];
            NSDate *dateReportingDate = [[self objectAtIndex:j] valueForKey:@"month"];
            
            if ([[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] isMonthOfDate:dateReportingDate equalToDate:[listOfDates objectAtIndex:i]]) {
                [foundReportingDate addObject:[self objectAtIndex:j]];
                break;
            }
        }
        
        if (![foundReportingDate count]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNull null] forKey:@"totalABRApproved"];
            [dict setValue:[NSNull null] forKey:@"totalABRSubmitted"];
            [aggregatedValues replaceObjectAtIndex:i withObject:dict];
        }
        else [aggregatedValues replaceObjectAtIndex:i withObject:[foundReportingDate objectAtIndex:0]];
    }
    
    return aggregatedValues;

}

- (NSMutableArray*)toConsecutiveMonthsForMLH:(NSString *)reportingMonth {
    NSArray *listOfDates = [NSArray arrayWithArray:[self getListOfMonths:reportingMonth]];
    
    NSMutableArray *aggregatedValues = [[NSMutableArray alloc] initWithArray:listOfDates copyItems:YES];
    for (int i = 0; i < [listOfDates count]; i++) {
        
        NSMutableArray *foundReportingDate = [[NSMutableArray alloc] init];
        //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //[dateFormatter setDateFormat:@"ddMMMyyyy"];
        
        for (int j = 0; j < [self count]; j++) {
            //NSLog(@"month at index j=%d and month is %@",j,[self objectAtIndex:j]);
            //NSDate *dateReportingDate = [dateFormatter dateFromString:[[self objectAtIndex:j] valueForKey:@"month"]];
            NSDate *dateReportingDate = [[self objectAtIndex:j] valueForKey:@"month"];
            
            if ([[ETGJSONKeyReplaceManipulation sharedJSONKeyReplacetManipulation] isMonthOfDate:dateReportingDate equalToDate:[listOfDates objectAtIndex:i]]) {
                [foundReportingDate addObject:[self objectAtIndex:j]];
                break;
            }
        }
        
        if (![foundReportingDate count]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNull null] forKey:@"totalFilledFTELoading"];
            [dict setValue:[NSNull null] forKey:@"totalVacantFTELoading"];
            [aggregatedValues replaceObjectAtIndex:i withObject:dict];
        }
        else [aggregatedValues replaceObjectAtIndex:i withObject:[foundReportingDate objectAtIndex:0]];
    }
    
    return aggregatedValues;
    
}

- (NSMutableArray*)getListOfMonths:(NSString *)reportingMonth {
    
    NSMutableArray *listOfMonths = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    //TODO: Verify date compare
//    NSDate *dateReportingMonth = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@", reportingMonth]];
    NSDate *dateReportingMonth = [reportingMonth toDate];
    
    NSUInteger componentFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:dateReportingMonth];
    NSInteger year = [components year];
    NSInteger day = [components day];
    
    for (int mo = 1; mo <= 12; mo++) {
        NSString *d = [NSString stringWithFormat:@"%i", day];
        NSString *m = [NSString stringWithFormat:@"%i", mo];
        
        if (d.length == 1) {
            d = [NSString stringWithFormat:@"0%@", d];
        }
        if (m.length == 1) {
            m = [NSString stringWithFormat:@"0%@", m];
        }
        
        NSString *strDate = [NSString stringWithFormat:@"%i%@%@", year, m, d];
        
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        NSDate *date = [dateFormatter dateFromString:strDate];
        
        [listOfMonths addObject:date];
    }
    
    return listOfMonths;
}

@end
