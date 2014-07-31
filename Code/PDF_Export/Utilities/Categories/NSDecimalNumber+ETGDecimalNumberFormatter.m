//
//  NSDecimalNumber+ETGDecimalNumberFormatter.m
//  PDF_Export
//
//  Created by mobilitySF on 12/1/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "NSDecimalNumber+ETGDecimalNumberFormatter.h"

@implementation NSDecimalNumber (ETGDecimalNumberFormatter)

- (NSString*)decimalNumberInStringFormat {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:2];
    
    NSDecimalNumber *decimalNumberFormat = self;
    NSString *strDecimalNumberFormat = [formatter stringFromNumber:decimalNumberFormat];
    
    return strDecimalNumberFormat;
}

- (NSNumber*)decimalNumberInNumberFormat {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:2];
    
    NSDecimalNumber *decimalNumberFormat = self;
    NSString *strDecimalNumberFormat = [formatter stringFromNumber:decimalNumberFormat];
    NSNumber *numberFormat = [formatter numberFromString:strDecimalNumberFormat];
    
    return numberFormat;
}

- (NSString*)decimalNumberToString {
    NSDecimalNumber *decimalNumberFormat = self;
    NSString *strDecimalNumberFormat = [NSString stringWithFormat:@"%@", decimalNumberFormat];
    return strDecimalNumberFormat;
}

@end
