//
//  ETGJsonHelper.m
//  ETG
//
//  Created by Tan Aik Keong on 1/9/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGJsonHelper.h"
#import "ETGUacPermission.h"

@implementation ETGJsonHelper

+(id)resetToNaIfRequired:(id)inputObject
{
    if(inputObject == (id)[NSNull null]  || inputObject == nil)
    {
        return @"N/A";
    }
    return inputObject;
}

+(id)resetToNilIfRequired:(id)inputObject
{
    if(inputObject == (id)[NSNull null])
    {
        return nil;
    }
    return inputObject;
}

+(id)resetToEmptyStringIfRequired:(id)inputObject
{
    if(inputObject == (id)[NSNull null] || inputObject == nil)
    {
        return @"";
    }
    return inputObject;
}

+(id)resetToZeroIfRequired:(id)inputObject
{
    if(inputObject == (id)[NSNull null] || inputObject == nil)
    {
        return [NSNumber numberWithInt:0];
    }
    return inputObject;
}

+(NSString *)truncateString:(NSString *)input withLength:(int)length
{
    if(input == (id)[NSNull null])
    {
        return nil;
    }
    // define the range you're interested in
    NSRange stringRange = {0, MIN([input length], length)};
    
    // adjust the range to include dependent chars
    stringRange = [input rangeOfComposedCharacterSequencesForRange:stringRange];
    
    // Now you can create the short string
    return [input substringWithRange:stringRange];
}

+(NSDictionary *)convertCoreDataToDictionaryRepresentation:(id)coreDataObject
{
    NSArray *attributes = [[[coreDataObject valueForKey:@"entity"] attributesByName] allKeys];
    NSDictionary *dict = [coreDataObject dictionaryWithValuesForKeys:attributes];
    return dict;
}

+(BOOL)canAccessInUac:(int)key
{
    NSArray *uacJson = [ETGJsonHelper loadEnableModulesAndReportsArray];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"key == %d", key];
    NSArray *filteredJson = [uacJson filteredArrayUsingPredicate:p];
    if([filteredJson count] > 0)
    {
        return YES;
    }
    return NO;
}

+(NSArray *)loadEnableModulesAndReportsArray
{
    ETGUacPermission *p = [ETGUacPermission findFirst];
    NSData *jsonData = p.content;
    if(nil != jsonData)
    {
        NSError *error = nil;
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if (!error)
        {
            return jsonObject;
        }
        else
        {
            DDLogError(@"Serialize data to JSON error: %@", error);
        }
    }
    return nil;
    
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [pathArray[0] stringByAppendingPathComponent:@"enableModulesAndReports.json"];
//    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
//    {
//        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
//        
//        NSError *error = nil;
//        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//        if (!error)
//        {
//            return jsonObject;
//        }
//        else
//        {
//            DDLogError(@"Serialize data to JSON error: %@", error);
//        }
//    }
//    return nil;
}


@end
