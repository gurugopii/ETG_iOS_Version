//
//  ETGWebService.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "ETGWebService.h"

@interface NSManagedObjectContext ()
+ (void)MR_setRootSavingContext:(NSManagedObjectContext *)context;
+ (void)MR_setDefaultContext:(NSManagedObjectContext *)moc;
@end

@interface ETGWebService ()

@property (nonatomic, strong, readwrite) RKObjectManager* objectManager;
@property (nonatomic, strong, readwrite) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) RKManagedObjectStore* managedObjectStore;
@property (nonatomic, strong) NSURL* baseUrl;

@end

@implementation ETGWebService

@synthesize baseUrl = _baseUrl;
@synthesize objectManager = _objectManager;
@synthesize managedObjectStore = _managedObjectStore;
@synthesize managedObjectContext = _managedObjectContext;

+ (instancetype)sharedWebService {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Set Restkit logging
        //RKLogConfigureByName("*", RKLogLevelOff);
        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
//        RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
        // Setup default base URL
//        ETGAppDefaults* defaults = [ETGAppDefaults sharedDefaults];
//        self.baseUrl = [NSURL URLWithString:[defaults baseUrl]];
        self.baseUrl = [NSURL URLWithString:kBaseURL];
        // Setup the connector
        [self setupConnector];
        // Setup the database
        [self setupDatabase];
        // Setup custom value transformers
        [self setValueTransformers];
        // Show network activity
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

- (void)setupConnector
{
    // Initialize RestKIT
    // Configure RestKit's Core Data stack
    self.objectManager = [RKObjectManager managerWithBaseURL:self.baseUrl];
}

- (void)setupDatabase
{
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"PDF_Export" ofType:@"momd"]];
    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    self.managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"PDF_Export.sqlite"];
    NSError *error = nil;
    [self.managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    
    [self.managedObjectStore createManagedObjectContexts];
    
    // Configure MagicalRecord to use RestKit's Core Data stack
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:self.managedObjectStore.persistentStoreCoordinator];
    [NSManagedObjectContext MR_setRootSavingContext:self.managedObjectStore.persistentStoreManagedObjectContext];
    [NSManagedObjectContext MR_setDefaultContext:self.managedObjectStore.mainQueueManagedObjectContext];
    
    self.managedObjectContext = [NSManagedObjectContext defaultContext];
    
    self.managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:self.managedObjectStore.persistentStoreManagedObjectContext];
    
    self.objectManager.managedObjectStore = self.managedObjectStore;
}

- (void)setBaseUrlWithString:(NSString*)baseUrl
{
    _baseUrl = [NSURL URLWithString:baseUrl];
    // Re-initialize connector
    _objectManager = [RKObjectManager managerWithBaseURL:_baseUrl];
    _objectManager.managedObjectStore = _managedObjectStore;
}

- (void)setBaseUrlWithUrl:(NSURL*)baseUrl
{
    _baseUrl = baseUrl;
    // Re-initialize connector
    _objectManager = [RKObjectManager managerWithBaseURL:_baseUrl];
    _objectManager.managedObjectStore = _managedObjectStore;
}

- (void)setUser:(NSString*)user withPassword:(NSString*)password
{
    [_objectManager.HTTPClient setDefaultHeader:@"user_id" value:user];
    [_objectManager.HTTPClient setDefaultHeader:@"password" value:password];
}

#pragma mark - Restkit custom value transformers

- (void)stringToDecimalNumberTransformer
{
    RKValueTransformer *stringToDecimalNumberValueTransformer = [RKBlockValueTransformer valueTransformerWithValidationBlock:^BOOL(__unsafe_unretained Class sourceClass, __unsafe_unretained Class destinationClass) {
        // We transform a `NSString` into `NSNumber`
        return ([sourceClass isSubclassOfClass:[NSString class]] && [destinationClass isSubclassOfClass:[NSDecimalNumber class]]);
    } transformationBlock:^BOOL(id inputValue, __autoreleasing id *outputValue, Class outputValueClass, NSError *__autoreleasing *error) {
        // Validate the input and output
        RKValueTransformerTestInputValueIsKindOfClass(inputValue, [NSString class], error);
        RKValueTransformerTestOutputValueClassIsSubclassOfClass(outputValueClass, [NSDecimalNumber class], error);
        
        //Sanity check
        NSScanner* scanner = [NSScanner localizedScannerWithString:inputValue];
        NSDecimal decimal;
        @try {
            if ([scanner scanDecimal:&decimal]) {
                *outputValue = [NSDecimalNumber decimalNumberWithDecimal:decimal];
                //            DDLogVerbose(@"Successfully converted [%@]%@ to [%@]%@", [inputValue class], inputValue, [outputValueClass class], *outputValue);
            } else {
                *outputValue = nil;
                //            DDLogVerbose(@"Unable to convert [%@]%@ to NSDecimalNumber, setting output to nil", [inputValue class], inputValue);
            }
        }
        @catch (NSException *exception) {
            *outputValue = nil;
        }
        return YES;
    }];
    // Add to Restkit's default value transformer
    [stringToDecimalNumberValueTransformer setValue:@"stringToDecimalNumberValueTransformer" forKey:@"name"];
    [[RKValueTransformer defaultValueTransformer] insertValueTransformer:stringToDecimalNumberValueTransformer atIndex:0];
}

- (void)stringToNumberTransformer
{
    // String to NSNumber transformer
    RKValueTransformer *stringToNumberValueTransformer = [RKBlockValueTransformer valueTransformerWithValidationBlock:^BOOL(__unsafe_unretained Class sourceClass, __unsafe_unretained Class destinationClass) {
        // We transform a `NSString` into `NSNumber`
        return ([sourceClass isSubclassOfClass:[NSString class]] && [destinationClass isSubclassOfClass:[NSNumber class]]);
    } transformationBlock:^BOOL(id inputValue, __autoreleasing id *outputValue, Class outputValueClass, NSError *__autoreleasing *error) {
        // Validate the input and output
        RKValueTransformerTestInputValueIsKindOfClass(inputValue, [NSString class], error);
        RKValueTransformerTestOutputValueClassIsSubclassOfClass(outputValueClass, [NSNumber class], error);
        
        //Sanity check
        NSScanner* scanner = [NSScanner localizedScannerWithString:inputValue];
        NSDecimal decimal;
        @try {
            if ([scanner scanDecimal:&decimal]) {
                *outputValue = [NSDecimalNumber decimalNumberWithDecimal:decimal];
                //            DDLogVerbose(@"Successfully converted [%@]%@ to [%@]%@", [inputValue class], inputValue, [outputValueClass class], *outputValue);
            } else {
                *outputValue = nil;
                //            DDLogVerbose(@"Unable to convert [%@]%@ to NSNumber, setting output to nil", [inputValue class], inputValue);
            }
        }
        @catch (NSException *exception) {
            *outputValue = nil;
        }
        return YES;
    }];
    // Add to Restkit's default value transformer
    [stringToNumberValueTransformer setValue:@"stringToNumberValueTransformer" forKey:@"name"];
    [[RKValueTransformer defaultValueTransformer] insertValueTransformer:stringToNumberValueTransformer atIndex:0];
}

- (void)stringToDateTransformer
{
    // String to NSNumber transformer
    RKValueTransformer *stringToDateValueTransformer = [RKBlockValueTransformer valueTransformerWithValidationBlock:^BOOL(__unsafe_unretained Class sourceClass, __unsafe_unretained Class destinationClass) {
        // We transform a `NSString` into `NSDate`
        return ([sourceClass isSubclassOfClass:[NSString class]] && [destinationClass isSubclassOfClass:[NSDate class]]);
    } transformationBlock:^BOOL(id inputValue, __autoreleasing id *outputValue, Class outputValueClass, NSError *__autoreleasing *error) {
        // Validate the input and output
        RKValueTransformerTestInputValueIsKindOfClass(inputValue, [NSString class], error);
        RKValueTransformerTestOutputValueClassIsSubclassOfClass(outputValueClass, [NSDate class], error);
        
        //Convert date
        *outputValue = [inputValue toDate];
        return YES;
    }];
    // Add to Restkit's default value transformer
    [stringToDateValueTransformer setValue:@"stringToDateValueTransformer" forKey:@"name"];
    [[RKValueTransformer defaultValueTransformer] insertValueTransformer:stringToDateValueTransformer atIndex:0];
}

- (void)setValueTransformers
{
    //Insert NSString to NSDecimalNumber transformer
    [self stringToDecimalNumberTransformer];
    //Insert NSString to NSNumber transformer
    [self stringToNumberTransformer];
    //Insert NSString to NSDate transformer
    [self stringToDateTransformer];
}

@end
