//
//  NSString+ETGStringFormatter.m
//  PDF_Export
//
//  Created by Mendoza, Christine D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "NSString+ETGStringFormatter.h"
#import "ETGDateFormatter.h"
#include <time.h>
#include <xlocale.h>

#define ISO8601_MAX_LEN 25

@implementation NSString (ETGStringFormatter)


- (NSString*)decimalFormat {
    NSRange range = [self rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (range.location != NSNotFound) {
        float stringFloat = [self floatValue];
        return [NSString stringWithFormat:@"%.02f", stringFloat];
        
    }

    return self;
}

//TODO: Verify date conversion
//Handle all possible date formats here
//- (NSDate*)toDate {
//    if (self.length) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"dd MMMM yyyy"];
//        
//        NSLog(@"%@", [dateFormatter dateFromString:self]);
//        return [dateFormatter dateFromString:self];
//    }
//    return nil;
//}


- (NSDate*)toDate {
    
    NSDate *date = nil;
    NSString *iso8601 = self;
     if (!iso8601) {
     return nil;
     }
    NSUInteger length = [iso8601 length];
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:iso8601];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    
    if (length<9 && ([iso8601 rangeOfString:@"-"].location == NSNotFound) && ([iso8601 rangeOfString:@"/"].location == NSNotFound) && [iso8601 rangeOfString:@"\'"].location == NSNotFound && valid) {
        
        date = [NSDate dateWithTimeIntervalSince1970:1296502956];
        
        NSMutableString *mu = [NSMutableString stringWithString:iso8601];
        [mu insertString:@"-" atIndex:4];
        [mu insertString:@"-" atIndex:7];
        [mu insertString:@"T00:00:00Z" atIndex:10];
        iso8601 = [mu copy];
        //iso8601 = @"2011-01-31T19:42:36Z";
        const char *str = [iso8601 cStringUsingEncoding:NSUTF8StringEncoding];
        char newStr[ISO8601_MAX_LEN];
        bzero(newStr, ISO8601_MAX_LEN);
        
        size_t len = strlen(str);
        if (len == 0) {
            return nil;
        }
        
        // UTC dates ending with Z
        if (len == 20 && str[len - 1] == 'Z') {
            memcpy(newStr, str, len - 1);
            strncpy(newStr + len - 1, "+0000\0", 6);
        }
        
        // Timezone includes a semicolon (not supported by strptime)
        else if (len == 25 && str[22] == ':') {
            memcpy(newStr, str, 22);
            memcpy(newStr + 22, str + 23, 2);
        }
        
        // Fallback: date was already well-formatted OR any other case (bad-formatted)
        else {
            memcpy(newStr, str, len > ISO8601_MAX_LEN - 1 ? ISO8601_MAX_LEN - 1 : len);
        }
        
        // Add null terminator
        newStr[sizeof(newStr) - 1] = 0;
        
        struct tm tm = {
            .tm_sec = 0,
            .tm_min = 0,
            .tm_hour = 0,
            .tm_mday = 0,
            .tm_mon = 0,
            .tm_year = 0,
            .tm_wday = 0,
            .tm_yday = 0,
            .tm_isdst = -1,
        };
        
        if (strptime_l(newStr, "%FT%T%z", &tm, NULL) == NULL) {
            return nil;
        }
        
        date = [NSDate dateWithTimeIntervalSince1970:mktime(&tm)];
        
        return date;
        
    }else{
        
        if (self.length) {
            
            NSDateFormatter *dateFormatter = [ETGDateFormatter sharedInstance];
            //NSDate *date = nil;
            
            // Try "yyyyMMdd" format
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            date = [dateFormatter dateFromString:self];
            if (date) {
                return date;
            }
            // Try "dd MM yyyy" format
            [dateFormatter setDateFormat:@"dd MM yyyy"];
            date = [dateFormatter dateFromString:self];
            
            if (date) {
                return date;
            }
            // Try "yyyy-MM-dd HH:mm" format
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            
            date = [dateFormatter dateFromString:self];
            
            if (date) {
                return date;
            }
            // Try "yyyy-MM-dd HH:mm:ss" format
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            date = [dateFormatter dateFromString:self];
            
            if (date) {
                return date;
            }
            // Try "yyyy-MM-dd HH:mm:ss Z" format
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
            
            date = [dateFormatter dateFromString:self];
            
            if (date) {
                return date;
            }
            // Try "yyyy-MM-dd'T'HH:mm" format
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm"];
            
            date = [dateFormatter dateFromString:self];
            
            if (date) {
                return date;
            }
            // Try "yyyy-MM-dd'T'HH:mm:ss" format
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
            
            date = [dateFormatter dateFromString:self];
            
            if (date) {
                return date;
            }
            // Try "yyyy-MM-dd'T'HH:mm:ss" format
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
            
            date = [dateFormatter dateFromString:self];
            if (date) {
                return date;
            }
            //Try "M/d/yyyy h:mm:ss a" format
            [dateFormatter setDateFormat:@"M/d/yyyy h:mm:ss a"];
            
            date = [dateFormatter dateFromString:self];
            
            if (date) {
                return date;
            }
            //Try "MM yyyy" format
            [dateFormatter setDateFormat:@"MMM yyyy"];
            
            date = [dateFormatter dateFromString:self];
            
            if (date) {
                return date;
            }
            NSLog(@"Unsupported date format: %@", self);
            return nil;
        }
    }
    
    return nil;
}

//TODO: Verify date conversion
//- (NSString*)toDateFormat {
//    if (self.length) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
//        
//        NSDate *date = [dateFormatter dateFromString:self];
//
//        [dateFormatter setDateFormat:@"dd MMMM yyyy"];
//        
////        NSLog(@"%@", [dateFormatter stringFromDate:date]);
//        return [dateFormatter stringFromDate:date];
//    }
//    return nil;
//}

//TODO: Verify date conversion
//- (NSString*)toShortDateFormatter {
//    if (self.length) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyyMMdd"];
//        
//        NSDate *date = [dateFormatter dateFromString:self];
//        
//        [dateFormatter setDateFormat:@"dd MMM yyyy"];
//        
//        //        NSLog(@"%@", [dateFormatter stringFromDate:date]);
//        return [dateFormatter stringFromDate:date];
//    }
//    return nil;
//}

//TODO: Verify date conversion
//- (NSString*)toDateNumberFormat {
//    if (self.length) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyyMMdd"];
//        
//        NSDate *date = [dateFormatter dateFromString:self];
//        
//        [dateFormatter setDateFormat:@"dd MMM yyyy"];
//        
//        //        NSLog(@"%@", [dateFormatter stringFromDate:date]);
//        return [dateFormatter stringFromDate:date];
//    }
//    
//    return nil;
//}

//TODO: Verify date conversion
//- (NSDate *)toDateShortMonthFormat {
//    if (self.length) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
//        NSString *strReportingMonth = [NSString stringWithFormat:@"%@", self];
//        
//        [dateFormatter setDateFormat:@"dd MMM yyyy"];
//        NSDate *dateReportingMonth = [dateFormatter dateFromString:strReportingMonth];
//
//        NSLog(@"%@", dateReportingMonth);
//        return dateReportingMonth;
//    }
//    return nil;
//}

//TODO: Verify date conversion
//- (NSDate*)toMonthYearDate {
//    if (self.length) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyyMMdd"];
//        return [dateFormatter dateFromString:self];
//    }
//    return nil;
//    
//    
//}

- (NSString *)toZero{
    if (!self.length) {
        return @"0.00";
    }

    return self;
}

- (NSString *)commaSeparatedFormat {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumIntegerDigits = 12;
    formatter.maximumFractionDigits = 2;
    formatter.minimumFractionDigits = 2;
    formatter.usesGroupingSeparator = YES;
    formatter.groupingSeparator = @",";
    formatter.decimalSeparator = @".";
    NSNumber *numbers = [[NSNumber alloc] initWithFloat:[self floatValue]];
    return [formatter stringFromNumber:numbers];
}

#pragma mark - New date formatters



- (NSDate*)toWebServiceDate
{
    if (self.length) {
        // Set the date format
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
        // Set the timezone
        [NSTimeZone resetSystemTimeZone];
        [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        // Return NSDate from string
        return [dateFormat dateFromString:self];
    }
    return nil;
}

- (NSString*)toRfc3339DateString
{
    if (self.length) {
        // Convert string to NSDate
        NSDate *date = [self toDate];
        // Format to RFC3339 Date format(yyyy-MM-ddTHH:mm:ss)
        if (date) {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
            return [dateFormat stringFromDate:date];
        } else {
            return self;
        }
    } else {
        return self;
    }
}

@end
