//
//  PDFCacheDirectory.h
//  PDF_Export
//
//  Created by mobilitySF on 7/21/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFCacheDirectory : NSObject

+ (NSString *)applicationCacheDirectory;
+ (NSString *)applicationCachePDFDirectory;
+ (BOOL)isPDFExistInCache:(NSString *)fileName;
+ (void)deletePDFInCache:(NSString *)fileName;
@end
