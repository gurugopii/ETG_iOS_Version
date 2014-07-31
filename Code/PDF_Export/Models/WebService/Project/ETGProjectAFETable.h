//
//  ETGProjectAfeTable.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/20/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//
//CATH 09.20.2013
#import <Foundation/Foundation.h>

@interface ETGProjectAFETable : NSObject

- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth
                           projectKey:(NSNumber *)projectKey
                              success:(void (^)(NSString *afeTableData))success
                              failure:(void (^)(NSError *error))failure;

@end
