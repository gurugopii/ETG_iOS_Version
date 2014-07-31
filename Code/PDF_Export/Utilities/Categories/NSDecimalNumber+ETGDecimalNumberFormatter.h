//
//  NSDecimalNumber+ETGDecimalNumberFormatter.h
//  PDF_Export
//
//  Created by mobilitySF on 12/1/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (ETGDecimalNumberFormatter)

- (NSString*)decimalNumberInStringFormat;
- (NSNumber*)decimalNumberInNumberFormat;
- (NSString*)decimalNumberToString;

@end
