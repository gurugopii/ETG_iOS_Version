//
//  ETGKeyHighlightProgress.h
//  PDF_Export
//
//  Created by Chiz on 11/5/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETGKeyHighlightsProgress : UIViewController

@property (nonatomic, strong) NSMutableArray *keyhighlightsProgressArray;
@property (strong, nonatomic) NSMutableArray *keyhighlightsProgressTableArray;
//wen
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *projectStatus;
//wen

-(void) loadProgress;
    
@end
