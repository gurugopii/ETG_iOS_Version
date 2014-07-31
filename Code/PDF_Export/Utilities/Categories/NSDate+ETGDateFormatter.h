//
//  NSDate+ETGDateFormatter.h
//  PDF_Export
//
//  Created by Mendoza, Christine D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ETGDateFormatter)

//- (NSString*)toString;
//- (NSString*)toString2;
//- (NSString*)toMonthYearString;
//- (NSString*)toUpdateFormat;

#pragma mark - New date formatters
- (NSString*)toWebServiceDateString;
- (NSString*)toRfc3339DateString;
- (NSString*)toReportingMonthDateString;
- (NSString*)toChartDateString;
-(NSString *)toEccrString;

@end
