//
//  PDFReportViewController.h
//  PDF_Export
//
//  Created by mobilitySF on 7/10/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETGManpowerViewController : UIViewController

-(BOOL)needRefreshWithProjectDictionary:(NSDictionary *)projectDictionary;
- (void)clearWebView;
@end

