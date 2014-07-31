//
//  PDFReportViewController.h
//  PDF_Export
//
//  Created by mobilitySF on 7/10/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETGProjectViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic) NSString *reportingMonth;
@property (nonatomic) NSString *projectKey;
@property (nonatomic) BOOL isCalledFromScorecard;
@property (nonatomic) BOOL isCalledFromProjectView;
@property (nonatomic) BOOL isCalledFromKeyhighlights;
@property (nonatomic) BOOL isCalledFromPortfolio;
@property (nonatomic) NSDictionary *enableReports;
@property (nonatomic) NSDictionary *dictionaryFromScorecard;
@property (nonatomic) NSDictionary *dictionaryFromPortfolio;
@property (nonatomic) NSString *htmlPage;
@property (nonatomic) NSString *htmlModule;


- (void)clearWebView;

@end
