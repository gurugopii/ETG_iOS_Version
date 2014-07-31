//
//  KeyHighlightPagerViewController.h
//  ElevateToGo
//
//  Created by joseph.a.m.quiteles on 4/24/13.
//  Copyright (c) 2013 Accenture Mobility Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETGKeyHighlightPagerViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *keyHighlightsData;
//wen
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *projectStatus;
//wen

-(void)reloadControllerData;
-(void)showNoDataAvailableMessage;
    
@end
