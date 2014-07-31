//
//  DecksTimeOutAlert.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 10/17/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGAlert.h"
@interface ETGAlert ()
@property (nonatomic, strong) UIAlertView *errorAlert;
@end


@implementation ETGAlert

+ (instancetype)sharedAlert {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void) showDeckAlert {
    if (self.alertDescription) {
        if (!_deckAlertShown) {
            _deckAlertShown = YES;
            NSRange range = [self.alertDescription rangeOfString:@"Expected content type"];
            if (range.location == NSNotFound) {
                _errorAlert = [[UIAlertView alloc] initWithTitle:@"Elevate To-Go" message:self.alertDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [_errorAlert show];
                self.alertDescription = nil;
            }
        }
    }
}

-(void) showScorecardAlert {
    if (self.alertDescription) {
        if (!self.alertShown) {
            NSRange range = [self.alertDescription rangeOfString:@"Expected content type"];
            NSRange noDataRange = [self.alertDescription rangeOfString:@"101"];

            if (range.location != NSNotFound || noDataRange.location != NSNotFound) {
                self.alertDescription = scoreCardNoDataAlert;
            } else {
                self.alertDescription = serverCannotBeReachedAlert;
            }
            
            _errorAlert = [[UIAlertView alloc] initWithTitle:@"Elevate To-Go" message:self.alertDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [_errorAlert show];
            self.alertDescription = nil;
            [ETGAlert sharedAlert].alertShown = YES;
        }
    }
}

-(void) showPortfolioAlert {
    if (self.alertDescription) {
        if (!self.alertShown) {
            NSRange range = [self.alertDescription rangeOfString:@"Expected content type"];
            NSRange noDataRange = [self.alertDescription rangeOfString:@"101"];

            if (range.location != NSNotFound || noDataRange.location != NSNotFound) {
                self.alertDescription = portfolioNoDataAlert;
            } else {
                self.alertDescription = serverCannotBeReachedAlert;
            }
            
            _errorAlert = [[UIAlertView alloc] initWithTitle:@"Elevate To-Go" message:self.alertDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [_errorAlert show];
            self.alertDescription = nil;
            [ETGAlert sharedAlert].alertShown = YES;
        }
    }
}

-(void) showKeyHighlightsAlert {
    if (self.alertDescription) {
        _errorAlert = [[UIAlertView alloc] initWithTitle:@"Elevate To-Go" message:self.alertDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [_errorAlert show];
        self.alertDescription = nil;
    }
}

-(void) showProjectBackgroundAlert {
    if (self.alertDescription) {
        _errorAlert = [[UIAlertView alloc] initWithTitle:@"Elevate To-Go" message:self.alertDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [_errorAlert show];
        self.alertDescription = nil;
    }
}

-(void) showDownloadDeckAlert {
    if (self.alertDescription) {
        if (!_deckAlertShown) {
            _deckAlertShown = YES;
            _errorAlert = [[UIAlertView alloc] initWithTitle:@"Elevate To-Go" message:self.alertDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [_errorAlert show];
            self.alertDescription = nil;
        }
    }
}

-(void) showProjectAlert {
    if (self.alertDescription) {
        if (!self.alertShown) {
            NSRange range = [self.alertDescription rangeOfString:@"Expected content type"];
            NSRange noDataRange = [self.alertDescription rangeOfString:@"101"];

            if (range.location != NSNotFound || noDataRange.location != NSNotFound) {
                self.alertDescription = projectNoDataAlert;
            } else {
                self.alertDescription = serverCannotBeReachedAlert;
            }
            
            _errorAlert = [[UIAlertView alloc] initWithTitle:@"Elevate To-Go" message:self.alertDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [_errorAlert show];
            self.alertDescription = nil;
            [ETGAlert sharedAlert].alertShown = YES;
        }
        
        
        
        
    }
}

-(void) showLogInAlert {
    if (self.alertDescription) {
        if (!self.alertShown) {
            NSRange range = [self.alertDescription rangeOfString:@"-1001"];
            if (range.location != NSNotFound) {
                self.alertDescription = noTokenAlert;
            }
            _errorAlert = [[UIAlertView alloc] initWithTitle:@"Elevate To-Go" message:self.alertDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [_errorAlert show];
            self.alertDescription = nil;
            [ETGAlert sharedAlert].alertShown = YES;
        }
    }
}

@end
