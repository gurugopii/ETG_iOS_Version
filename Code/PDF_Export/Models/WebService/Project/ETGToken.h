//
//  ETGToken.h
//  PDF_Export
//
//  Created by Accenture Mobility Services on 10/9/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETGToken;

@protocol ETGTokenDelegate <NSObject>

- (void)setErrorLoginMessage:(NSString *)errorMessage;

@end

@interface ETGToken : NSObject

#pragma mark - Token Controller Class methods
+ (instancetype)sharedToken;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic) BOOL willGetNewMetadata;
@property (nonatomic, strong) id<ETGTokenDelegate> delegate;

- (void)getToken:(NSString *)loginName andPassword:loginPassword success:(void (^)(NSString *token, NSString *key))success failure:(void (^)(NSError * error))failure;

@end
    