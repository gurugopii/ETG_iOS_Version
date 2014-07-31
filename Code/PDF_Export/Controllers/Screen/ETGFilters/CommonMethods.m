//
//  CommonMethods.m
//  PDF_Export
//
//  Created by Tony Pham on 9/3/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "CommonMethods.h"
#import <AFNetworking.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import <AdSupport/ASIdentifierManager.h>
#import "NSData+Base64.h"
#import "UICKeyChainStore.h"

NSString * const kRNCryptManagerErrorDomain = @"net.robnapier.RNCryptManager";
const CCAlgorithm kAlgorithm = kCCAlgorithmAES128;
const NSUInteger kAlgorithmKeySize = kCCKeySizeAES128;
const NSUInteger kAlgorithmBlockSize = kCCBlockSizeAES128;
const NSUInteger kPBKDFRounds = 10000;  // ~80ms on an iPhone 4


@implementation CommonMethods

+ (NSArray *)fetchEntity:(NSString *)entityName sortDescriptorKey:(NSString *)sortDescriptorKey inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:sortDescriptorKey ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescription]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        DDLogError(fetchError, error);
    }
    
    return fetchedObjects;
}

+ (NSArray *)fetchEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate sortDescriptorBy:(NSString *)sortDescriptorKey inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    if (sortDescriptorKey) {
        NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:sortDescriptorKey ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescription]];
    }
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        DDLogError(fetchError, error);
    }
    
    return fetchedObjects;
}

+ (NSArray *)searchEntityForName:(NSString *)entityName withTitle:(NSString *)searchTitle context:(NSManagedObjectContext *)managedObjectContext {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[n] %@", searchTitle];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        DDLogError(fetchError, error);
    }
    
    return fetchedObjects;
}

+ (NSArray *)searchEntityForName:(NSString *)entityName withID:(NSNumber *)entityId context:(NSManagedObjectContext *)managedObjectContext {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", entityId];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        DDLogError(fetchError, error);
    }
    
    return fetchedObjects;
}

+ (NSMutableURLRequest *)urlRequestWithPath:(NSString *)urlPath httpMethod:(NSString *)httpMethod
{
    NSURL *webserviceURL = [[NSURL alloc] initWithString:urlPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:webserviceURL];
    NSString *deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *usernameDeviceIDToken = [NSString stringWithFormat:@"%@#ETG#%@#ETG#%@", [UICKeyChainStore stringForKey:kETGUsername], deviceId, [UICKeyChainStore stringForKey:kETGToken]];
   // NSLog(@"URL: %@", urlPath);
    //NSLog(@"usernameDeviceIDToken: %@", usernameDeviceIDToken);
    
    [request setValue:usernameDeviceIDToken forHTTPHeaderField:@"X-Token"];
    [request setHTTPMethod:httpMethod];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

+ (NSDate *)latestReportingMonth
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *currentDateComponents = [currentCalendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    
    if (currentDateComponents.day < 15) {
        [offsetComponents setMonth:-2];
    } else {
        [offsetComponents setMonth:-1];
    }
    
    [currentDateComponents setDay:1];
    NSDate *currentDate = [currentCalendar dateFromComponents:currentDateComponents];
    NSDate *latestReportingMonth = [[NSCalendar currentCalendar] dateByAddingComponents:offsetComponents toDate:currentDate options:0];
    
    return latestReportingMonth;
}

+(NSString *)latestReportingMonthString
{
    NSDate *latestReportingMonth = [CommonMethods latestReportingMonth];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    return[formatter stringFromDate:latestReportingMonth];
}

+ (BOOL)isMonthOfDate:(NSDate *)date1 equalToDate:(NSDate *)date2
{
    NSDateComponents *date1Components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date1];
    NSDateComponents *date2Components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date2];
    
    if (date1Components.month == date2Components.month && date1Components.year == date2Components.year) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)validateStringValue:(id)inputString {
    if (inputString && [inputString isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)validateNumberValue:(id)inputNumber {
    if (inputNumber && [inputNumber isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    return NO;
}

+ (NSString*)revertString:(NSString *)string
{
    int len = [string length];
    NSMutableString *reverseString = [[NSMutableString alloc] initWithCapacity:len];
    for(int i = len - 1; i >= 0; i--) {
        [reverseString appendString:[NSString stringWithFormat:@"%c",[string characterAtIndex:i]]];
    }
    
    return reverseString;
}

+ (NSError *)createAnErrorWithMessage:(NSString *)errorMessage
{
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    [errorDetail setValue:errorMessage forKey:NSLocalizedDescriptionKey];
    NSError *error;

    if ([errorMessage isEqualToString:@"BadCredential"]) {
        error = [NSError errorWithDomain:@"ETG" code:102 userInfo:errorDetail];
    } else if ([errorMessage isEqualToString:@"TokenGenerationFailed"]) {
        error = [NSError errorWithDomain:@"ETG" code:103 userInfo:errorDetail];
    } else if ([errorMessage isEqualToString:@"TokenUnknownException"]) {
        error = [NSError errorWithDomain:@"ETG" code:104 userInfo:errorDetail];
    }
    
    return error;
}


#pragma mark - CommonCrypto

+ (void)logNSDataToByte:(NSData *)data withLogtile:(NSString *)logTitle
{
    NSUInteger len = data.length;
    uint8_t *bytes = (uint8_t *)[data bytes];
    NSMutableString *result = [NSMutableString stringWithCapacity:len * 3];
    [result appendString:@"["];
    for (NSUInteger i = 0; i < len; i++) {
        if (i) {
            [result appendString:@","];
        }
        [result appendFormat:@"%d", bytes[i]];
    }
    [result appendString:@"]"];
    
    //NSLog(@"%@ - Byte result: %@", logTitle, result);
}

+ (NSData *)encryptedDataForData:(NSString *)plainString
                              iv:(NSString *)ivString
                             key:(NSString *)keyString
                           error:(NSError **)error {
    
    NSData *data = [NSData dataWithBytes:plainString.UTF8String length:plainString.length];
    NSData *iv = [NSData dataFromBase64String:ivString];
    NSData *key = [NSData dataWithBytes:keyString.UTF8String length:keyString.length];
    
    NSAssert(iv, @"IV must not be NULL");
    NSAssert(key, @"salt must not be NULL");
    
    size_t outLength;
    NSMutableData *cipherData = [NSMutableData dataWithLength:data.length + kAlgorithmBlockSize];
    
    CCCryptorStatus result = CCCrypt(kCCEncrypt, // operation
                                     kAlgorithm, // Algorithm
                                     kCCOptionPKCS7Padding, // options
                                     key.bytes, // key
                                     key.length, // keylength
                                     iv.bytes,// iv
                                     data.bytes, // dataIn
                                     data.length, // dataInLength,
                                     cipherData.mutableBytes, // dataOut
                                     cipherData.length, // dataOutAvailable
                                     &outLength); // dataOutMoved
    
    if (result == kCCSuccess) {
        cipherData.length = outLength;
    }
    else {
        if (error) {
            *error = [NSError errorWithDomain:kRNCryptManagerErrorDomain
                                         code:result
                                     userInfo:nil];
        }
        return nil;
    }
    
    return cipherData;
}

+ (NSData *)decryptedDataForData:(NSString *)encryptedString
                              iv:(NSString *)ivString
                             key:(NSString *)keyString
                           error:(NSError **)error {
    
    NSData *data = [NSData dataFromBase64String:encryptedString];
    NSData *iv = [NSData dataFromBase64String:ivString];
    NSData *key = [NSData dataWithBytes:keyString.UTF8String length:keyString.length];
    
    size_t outLength;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:data.length];
    CCCryptorStatus result = CCCrypt(kCCDecrypt, // operation
                                     kAlgorithm, // Algorithm
                                     kCCOptionPKCS7Padding, // options
                                     key.bytes, // key
                                     key.length, // keylength
                                     iv.bytes,// iv
                                     data.bytes, // dataIn
                                     data.length, // dataInLength,
                                     decryptedData.mutableBytes, // dataOut
                                     decryptedData.length, // dataOutAvailable
                                     &outLength); // dataOutMoved
    
    if (result == kCCSuccess) {
        [decryptedData setLength:outLength];
    }
    else {
        if (result != kCCSuccess) {
            if (error) {
                *error = [NSError
                          errorWithDomain:kRNCryptManagerErrorDomain
                          code:result
                          userInfo:nil];
            }
            return nil;
        }
    }
    
    return decryptedData;
}

+ (NSData *)AESKeyForPassword:(NSString *)password salt:(NSData *)salt {
    
    NSMutableData *derivedKey = [NSMutableData dataWithLength:kAlgorithmKeySize];
    
    int result = CCKeyDerivationPBKDF(kCCPBKDF2,        // algorithm
                                      password.UTF8String,  // password
                                      password.length,      // passwordLength
                                      salt.bytes,           // salt
                                      salt.length,          // saltLen
                                      kCCPRFHmacAlgSHA1,    // PRF
                                      kPBKDFRounds,         // rounds
                                      derivedKey.mutableBytes, // derivedKey
                                      derivedKey.length); // derivedKeyLen
    
    // Do not log password here
    NSAssert(result == kCCSuccess,
             @"Unable to create AES key for password: %d", result);
    
    return derivedKey;
}

+ (NSData *)randomDataOfLength:(size_t)length {
    NSMutableData *data = [NSMutableData dataWithLength:length];
    
    int result = SecRandomCopyBytes(kSecRandomDefault,
                                    length,
                                    data.mutableBytes);
    NSAssert(result == 0, @"Unable to generate random bytes: %d",
             errno);
    
    return data;
}


#pragma mark - UI

+ (UIImage *)sideMenuImage {
    static UIImage *defaultImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(22.f, 14.f), NO, 0.0f);
        
        [kPetronasGreenColor setFill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 22, 2)] fill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(0, 6, 22, 2)] fill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(0, 12, 22, 2)] fill];
        
        defaultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    });
    return defaultImage;
}


@end
