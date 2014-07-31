//
//  DecksTimeOutAlert.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 10/17/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGAlert : NSObject
+ (instancetype)sharedAlert;

@property (nonatomic,strong) NSString *alertDescription;
@property (nonatomic) BOOL deckAlertShown;
@property (nonatomic) BOOL alertShown;

-(void) showDeckAlert;
-(void) showScorecardAlert;
-(void) showPortfolioAlert;
-(void) showKeyHighlightsAlert;
-(void) showProjectBackgroundAlert;
-(void) showDownloadDeckAlert;
-(void) showProjectAlert;
-(void) showLogInAlert;

@end
