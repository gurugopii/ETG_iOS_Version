//
//  ETGPortfolioData.h
//  PDF_Export
//
//  Created by mobilitySF on 10/14/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETGPortfolioData;

@protocol ETGPortfolioDataDelegate <NSObject>

- (void)collectAllJsonDataFromWebServiceForPortfolio;
- (void)collectAllJsonDataFromCoreDataForPortfolio;

- (void)displayDataErrorMessageForScorecard:(NSError *)error;
- (void)displayDataErrorMessageForPortfolio:(NSError *)error;

@end

@interface ETGPortfolioData : NSObject

@property (nonatomic, strong) id<ETGPortfolioDataDelegate> delegate;

@end