//
//  ETGJSONKeyReplaceManipulation.h
//  PDF_Export
//
//  Created by patrick.j.d.medina on 11/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGJSONKeyReplaceManipulation : NSObject

#pragma mark - JSON Key Replace Class method
+ (instancetype)sharedJSONKeyReplacetManipulation;

#pragma mark - JSON Key Replace Manipulation accessor
- (NSMutableDictionary *)replaceJSONByKeyValue:(NSMutableDictionary *)json forKey:(NSString *)jsonKey;
- (NSMutableDictionary *)detectNumericJSONByKeyValue:(NSMutableDictionary *)json;
- (NSMutableArray*)getListOfMonths:(NSString *)reportingMonth;
- (BOOL)isMonthOfDate:(NSDate *)date1 equalToDate:(NSDate *)date2;
- (NSMutableDictionary *)replaceNSDateJSONByKeyValue:(NSMutableDictionary *)json forKey:(NSString *)jsonKey;
- (NSMutableDictionary *)replaceNSDateWithNSString:(NSMutableDictionary *)json;
- (NSMutableArray *)replaceMutableArrayNSDateWithNSString:(NSMutableArray *)json;

@end
