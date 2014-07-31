//
//  PDFCacheDirectory.m
//  PDF_Export
//
//  Created by mobilitySF on 7/21/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "PDFCacheDirectory.h"

@implementation PDFCacheDirectory

// Returns the path to the application's Cache directory.
+ (NSString *)applicationCacheDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

+ (NSString *)applicationCachePDFDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    basePath = [basePath stringByAppendingPathComponent:@"PDFFiles/"];
    
    return basePath;
}

+ (BOOL)isPDFExistInCache:(NSString *)fileName {
    
    NSString *filePath = [[self applicationCacheDirectory] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:filePath])
    {
        return YES;
    } else {
        return NO;
    }
    
}

+ (void)deletePDFInCache:(NSString *)fileName {
    
    NSString *filePath = [[self applicationCacheDirectory] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    [fileManager removeItemAtPath:filePath error:&error];
    
}

@end
