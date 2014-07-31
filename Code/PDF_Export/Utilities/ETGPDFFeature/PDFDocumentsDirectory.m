//
//  PDFDocumentsDirectory.m
//  PDF_Export
//
//  Created by mobilitySF on 7/21/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "PDFDocumentsDirectory.h"

@implementation PDFDocumentsDirectory

// Returns the path to the application's Documents directory.
+ (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    return basePath;
}

+ (NSString *)applicationDocumentsPDFDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    basePath = [basePath stringByAppendingPathComponent:@"PDFFiles/"];
    
    return basePath;
}


+ (void)deletePDF:(NSString *)fileName {
    
    NSString *filePath = [[self applicationDocumentsPDFDirectory] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    [fileManager removeItemAtPath:filePath error:&error];
    
}

@end
