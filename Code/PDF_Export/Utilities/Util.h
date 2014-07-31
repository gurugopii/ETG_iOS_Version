//
//  Util.h
//  PDF_Export
//
//  Created by Mendoza, Christine D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "Reachability.h"

#pragma mark - Network Util
static BOOL isReachable (BOOL showAlert) {    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus == NotReachable) {
        //my web-dependent code
        return NO;
    }

    return YES;
}


#pragma mark - File Manager Util
static NSString* applicationDocumentsDirectory() {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    return basePath;
}

static NSString* applicationDocumentsPDFDirectory() {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    basePath = [basePath stringByAppendingPathComponent:@"PDFFiles/"];
    
    return basePath;
}

static NSString* applicationCacheDirectory() {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

static NSString* applicationCachePDFDirectory() {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    basePath = [basePath stringByAppendingPathComponent:@"PDFFiles/"];
    
    return basePath;
}

static BOOL deletePDF(NSString *fileName) {
    
    NSString *filePath = [[self applicationDocumentsPDFDirectory] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    [fileManager removeItemAtPath:filePath error:&error];
    
    if (error) {
        return NO;
    }
    
    return YES;
}

static BOOL isPDFExist(NSString *filePath) {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager fileExistsAtPath:filePath];
}

static BOOL isPDFExistInCache(NSString *fileName) {
    
    NSString *filePath = [[self applicationCacheDirectory] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager fileExistsAtPath:filePath];
}

static BOOL deletePDFInCache(NSString *fileName) {
    
    NSString *filePath = [[self applicationCacheDirectory] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    [fileManager removeItemAtPath:filePath error:&error];
    
    if (error) {
        return NO;
    }
    
    return YES;
}


#pragma mark - Data Util
static NSArray* sortArrayByDate(NSArray* unsortedArray) {
    return [unsortedArray sortedArrayUsingComparator:^NSComparisonResult(NSString* dateString1, NSString* dateString2) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMMM yyyy"];
        
        NSDate* date1 = [dateFormatter dateFromString:dateString1];
        NSDate* date2 = [dateFormatter dateFromString:dateString2];
        
        return [date1 compare:date2];
    }];
}
