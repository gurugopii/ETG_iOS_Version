//
//  ETGMapKeyMilestone.h
//  ETG
//
//  Created by Tan Aik Keong on 1/7/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGMapKeyMilestone : NSObject
- (void)sendRequestWithReportingMonth:(NSString *)reportingMonth;
-(NSString *)getOfflineData:(NSString *)reportingMonth withProjectKey:(int)projectKey;
@end
