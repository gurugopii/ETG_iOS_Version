//
//  ETGWebService.h
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/13/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <Foundation/Foundation.h>

@interface ETGWebService : NSObject

@property (nonatomic, strong, readonly) RKObjectManager* objectManager;
@property (nonatomic, strong, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong, readonly) RKManagedObjectStore* managedObjectStore;

+ (instancetype)sharedWebService;
- (void)setBaseUrlWithString:(NSString*)baseUrl;
- (void)setBaseUrlWithUrl:(NSURL*)baseUrl;
- (void)setUser:(NSString*)user withPassword:(NSString*)password;

@end
