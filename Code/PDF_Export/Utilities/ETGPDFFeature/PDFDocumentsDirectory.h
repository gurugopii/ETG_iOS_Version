//
//  PDFDocumentsDirectory.h
//  PDF_Export
//
//  Created by mobilitySF on 7/21/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFDocumentsDirectory : NSObject

+ (NSString *)applicationDocumentsDirectory;
+ (NSString *)applicationDocumentsPDFDirectory;
+ (void)deletePDF:(NSString *)fileName;

@end
