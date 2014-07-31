//
//  ETGJSONKeyReplaceManipulation.m
//  PDF_Export
//
//  Created by patrick.j.d.medina on 11/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGJSONKeyReplaceManipulation.h"
#import "NSString+ETGStringFormatter.h"
#import "ETGDateFormatter.h"

@implementation ETGJSONKeyReplaceManipulation

+ (instancetype)sharedJSONKeyReplacetManipulation {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSMutableDictionary *)replaceJSONByKeyValue:(NSMutableDictionary *)json forKey:(NSString *)jsonKey{
    NSString *replacementKey = [[[json valueForKey:jsonKey] stringValue] commaSeparatedFormat];
    [json removeObjectForKey:jsonKey];
    [json setObject:replacementKey forKey:jsonKey];
    return json;
}

- (NSMutableDictionary *)detectNumericJSONByKeyValue:(NSMutableDictionary *)json{
    for (NSObject *obj in [json allKeys]){
        NSNumberFormatter *f  = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSString *stringEquivalent = [NSString stringWithFormat: @"%@", [json valueForKey:(NSString *)obj]];
        NSNumber *numericCheck = [f numberFromString:stringEquivalent];
        if (numericCheck != nil){
//            json = [self replaceJSONByKeyValue:json forKey:(NSString *)obj];
//            NSString *replacementKey = [[json valueForKey:(NSString *)obj] commaSeparatedFormat];
            
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            formatter.maximumIntegerDigits = 12;
            formatter.maximumFractionDigits = 2;
            formatter.minimumFractionDigits = 2;
            formatter.usesGroupingSeparator = YES;
            formatter.groupingSeparator = @",";
            formatter.decimalSeparator = @".";
            NSNumber *numbers = [[NSNumber alloc] initWithFloat:[numericCheck floatValue]];

            [json removeObjectForKey:(NSString *)obj];
            [json setObject:numbers forKey:(NSString *)obj];
        }
    }
    return  json;
}

- (NSMutableArray*)getListOfMonths:(NSString *)reportingMonth {
    
    NSMutableArray *listOfMonths = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateReportingMonth = [dateFormatter dateFromString:reportingMonth];
    
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

- (BOOL)isMonthOfDate:(NSDate *)date1 equalToDate:(NSDate *)date2
{
    /*NSDateComponents *date1Components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date1];
    NSDateComponents *date2Components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date2];
    
    if (date1Components.month == date2Components.month && date1Components.year == date2Components.year) {
        return YES;
    } else {
        return NO;
    }*/
    
    NSDateFormatter *dateFormatter = [ETGDateFormatter sharedInstance];
    [dateFormatter setDateFormat:@"MM"];
    int month1 = [[dateFormatter stringFromDate:date1] intValue];
    int  month2 =  [[dateFormatter stringFromDate:date2] intValue];
    [dateFormatter setDateFormat:@"YYYY"];
    int year1 = [[dateFormatter stringFromDate:date1] intValue];
    int  year2 =  [[dateFormatter stringFromDate:date2] intValue];
    if (month1 == month2 && year1 == year2) {
        return YES;
    } else {
        return NO;
    }
}

- (NSMutableDictionary *)replaceNSDateJSONByKeyValue:(NSMutableDictionary *)json forKey:(NSString *)jsonKey{
    NSMutableDictionary *tableData = [json valueForKey:@"tabledata"];
    
    for(NSMutableDictionary *replacementDic in tableData){
        NSString *replacementDate = [NSString stringWithFormat:@"%@", [replacementDic valueForKey:jsonKey]];
        [replacementDic removeObjectForKey:jsonKey];
        [replacementDic setObject:replacementDate forKey:jsonKey];
    }
    [json removeObjectForKey:@"tabledata"];
    [json setObject:tableData forKey:@"tabledata"];
    return json;
}

- (NSMutableDictionary *)replaceNSDateWithNSString:(NSMutableDictionary *)json{
    for (NSString *key in [json allKeys]){
        
        if ([[json valueForKey:key] isKindOfClass:[NSDate class]]) {
            NSString *strDate = [NSString stringWithFormat:@"%@", [json valueForKey:key]];
            [json removeObjectForKey:key];
            [json setObject:strDate forKey:key];
        }
    }
    
    return  json;
}

- (NSMutableArray *)replaceMutableArrayNSDateWithNSString:(NSMutableArray *)json{
    for(NSMutableDictionary *dict in json){
        for (NSString *key in [dict allKeys]){
            if ([[dict valueForKey:key] isKindOfClass:[NSDate class]]) {
                NSString *strDate = [NSString stringWithFormat:@"%@", [dict valueForKey:key]];
                [dict removeObjectForKey:key];
                [dict setObject:strDate forKey:key];
            }
        }
        
    }
    
    return  json;
}

@end
