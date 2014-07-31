//
//  CommonMethods.h
//  PDF_Export
//
//  Created by Tony Pham on 9/3/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CommonMethods : NSObject

+ (NSArray *)fetchEntity:(NSString *)entityName sortDescriptorKey:(NSString *)sortDescriptorKey inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+ (NSArray *)fetchEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate sortDescriptorBy:(NSString *)sortDescriptorKey inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+ (NSArray *)searchEntityForName:(NSString *)entityName withTitle:(NSString *)searchTitle context:(NSManagedObjectContext *)managedObjectContext;
+ (NSArray *)searchEntityForName:(NSString *)entityName withID:(NSNumber *)entityId context:(NSManagedObjectContext *)managedObjectContext;
+ (NSMutableURLRequest *)urlRequestWithPath:(NSString *)urlPath httpMethod:(NSString *)httpMethod;
+(NSString *)latestReportingMonthString;
+ (NSDate *)latestReportingMonth;
+ (BOOL)isMonthOfDate:(NSDate *)date1 equalToDate:(NSDate *)date2;

+ (BOOL)validateStringValue:(id)inputString;
+ (BOOL)validateNumberValue:(id)inputNumber;
+ (NSString*)revertString:(NSString *)string;
+ (NSError *)createAnErrorWithMessage:(NSString *)errorMessage;


//CommonCrypto
+ (void)logNSDataToByte:(NSData *)data withLogtile:(NSString *)logTitle;
+ (NSData *)encryptedDataForData:(NSString *)plainString
                              iv:(NSString *)ivString
                             key:(NSString *)keyString
                           error:(NSError **)error;
+ (NSData *)decryptedDataForData:(NSString *)encryptedString
                              iv:(NSString *)ivString
                             key:(NSString *)keyString
                           error:(NSError **)error;
+ (NSData *)AESKeyForPassword:(NSString *)password salt:(NSData *)salt;
+ (NSData *)randomDataOfLength:(size_t)length;

+ (UIImage *)sideMenuImage;

@end
