//
//  ETGJsonHelper.h
//  ETG
//
//  Created by Tan Aik Keong on 1/9/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGJsonHelper : NSObject
+(id)resetToNaIfRequired:(id)inputObject;
+(id)resetToNilIfRequired:(id)inputObject;
+(id)resetToEmptyStringIfRequired:(id)inputObject;
+(id)resetToZeroIfRequired:(id)inputObject;
+(NSString *)truncateString:(NSString *)input withLength:(int)length;
+(NSDictionary *)convertCoreDataToDictionaryRepresentation:(id)coreDataObject;
+(BOOL)canAccessInUac:(int)key;

@end
