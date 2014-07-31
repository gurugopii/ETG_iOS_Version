//
//  NSSet+ETGMonthCompare.h
//  PDF_Export
//
//  Created by Accenture Mobility Services on 10/4/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (ETGMonthCompare)

- (NSMutableArray*)toConsecutiveMonthsForCpb:(NSString *)reportingMonth;
- (NSMutableArray*)toConsecutiveMonthsForWpb:(NSString *)reportingMonth;
- (NSMutableArray*)toConsecutiveMonthsForMLH:(NSString *)reportingMonth;

@end
