//
//  ETGAppDefaults.h
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGAppDefaults : NSObject

@property (nonatomic, strong)NSString* baseUrl;
@property (nonatomic, strong)NSString* scoreCardTableSummaryPath;

+ (instancetype)sharedDefaults;

@end
