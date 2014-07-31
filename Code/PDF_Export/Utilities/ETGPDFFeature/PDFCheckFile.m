//
//  PDFCheckFile.m
//  PDF_Export
//
//  Created by mobilitySF on 7/31/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "PDFCheckFile.h"

@implementation PDFCheckFile

+ (BOOL)isPDFExist:(NSString *)filePath {
    
    //    NSString *filePath = [[self applicationDocumentsPDFDirectory] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:filePath])
    {
        return YES;
    } else {
        return NO;
    }
    
}

@end
