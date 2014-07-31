//
//  PDFPortfolioViewController.h
//  PDF_Export
//
//  Created by Mendoza, Christine D. on 9/18/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETGPortfolioScorecardViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic) NSDictionary *enableReports;
@property (nonatomic) NSDictionary *enableProjectReports;
@property (nonatomic) BOOL isPortfolioGraphDownloading;
@property (nonatomic) BOOL isScorecardDownloading;

- (void)clearWebView;
@end
