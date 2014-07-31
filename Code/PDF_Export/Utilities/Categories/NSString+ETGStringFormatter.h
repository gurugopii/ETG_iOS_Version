//
//  NSString+ETGStringFormatter.h
//  PDF_Export
//
//  Created by Mendoza, Christine D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ETGStringFormatter){
    
    
}

- (NSString*)decimalFormat;
- (NSDate*)toDate;
- (NSString*)toZero;
- (NSString *)commaSeparatedFormat;
//TODO: Verify date conversion
//Remove unnecessary date formatters, names of formatters should be trivial
//- (NSDate*)toMonthYearDate;
//- (NSString*)toDateFormat;
//- (NSString*)toShortDateFormatter;
//- (NSString*)toDateNumberFormat;
//- (NSString*)toDateShortMonthFormat;

#pragma mark - New date formatters
- (NSDate*)toWebServiceDate;
- (NSString*)toRfc3339DateString;

@end
