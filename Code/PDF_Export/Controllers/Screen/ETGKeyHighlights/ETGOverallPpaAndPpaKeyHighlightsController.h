//
//  KeyHighlightController.h
//  ElevateToGo
//
//  Created by mobilitySF on 12/29/12.
//  Copyright (c) 2012 Accenture Mobility Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETGOverallPpaAndPpaKeyHighlightsController : UIViewController

@property (nonatomic, strong) NSMutableArray *overallPpaAndPpaValues;

-(void) loadOverallAndPpaInfo;
    
@end
