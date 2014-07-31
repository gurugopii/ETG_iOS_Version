//
//  ThirdKeyHighlightController.h
//  ElevateToGo
//
//  Created by joseph.a.m.quiteles on 4/25/13.
//  Copyright (c) 2013 Accenture Mobility Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETGIssuesKeyHighlightsController : UIViewController

@property (nonatomic, strong) NSMutableArray *issuesAndConcernsValues;

-(void) loadIssuesAndConcernsInfo;
    
@end

