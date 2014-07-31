//
//  NSDate+PDFEDateFormatter.m
//  PDF_Export
//
//  Created by Mendoza, Christine D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "NSDate+ETGDateFormatter.h"

@implementation NSDate (ETGDateFormatter)

- (NSString*)toString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:self];
}

- (NSString*)toString2 {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    return [dateFormatter stringFromDate:self];
}

- (NSString*)toMonthYearString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    return [dateFormatter stringFromDate:self];
}

- (NSString*)toUpdateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    return [dateFormatter stringFromDate:self];
}

#pragma mark - New date formatters
- (NSString*)toWebServiceDateString
{
    if (self) {
        // Set the date format
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
        // Set the timezone
        [NSTimeZone resetSystemTimeZone];
        [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        // Return NSDate from string
        return [dateFormat stringFromDate:self];
    }
    return nil;
}
- (NSString*)toRfc3339DateString
{
    if (self) {
        // Format to RFC3339 Date format(yyyy-MM-ddTHH:mm:ss)
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        return [dateFormat stringFromDate:self];
    } else {
        return nil;
    }
}
- (NSString*)toReportingMonthDateString
{
    if (self) {
        // Format to RFC3339 Date format(yyyy-MM-ddTHH:mm:ss)
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyyMMdd"];
        return [dateFormat stringFromDate:self];
    } else {
        return nil;
    }
}
- (NSString*)toChartDateString
{
    if (self) {
        // Format to RFC3339 Date format(yyyy-MM-ddTHH:mm:ss)
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd MMM yyyy"];
        return [dateFormat stringFromDate:self];
    } else {
        return nil;
    }
}

-(NSString *)toEccrString
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    return [formatter stringFromDate:self];
}

@end
