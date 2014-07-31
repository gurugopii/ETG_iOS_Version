//
//  PortfolioTests.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/19/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGPortfolioTestOutput.h"
//#import "ETGPortfolioModelController.h"

@implementation ETGPortfolioTestOutput

-(void) testPortfolio {

    //For Portfolio
    ETGPortfolioModelController *portfolioModel = [ETGPortfolioModelController sharedModel];
    
    //    JSON for Portfolio
//    [portfolioModel syncPortfolio];
    [portfolioModel getPortfolioTableSummaryForReportingMonth:@"20130501" withUserId:@"72" success:^(NSString* jsonData) {
        NSLog(@"Portfolio JSON data: %@", jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];

    //    JSON for Portfolio Hydrocarbon
    [portfolioModel syncPortfolioHydrocarbon];
    [portfolioModel getPortfolioHydrocarbonForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
        NSLog(@"Portfolio JSON data: %@", jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];

    //    JSON for Portfolio HSE
    [portfolioModel syncPortfolioHse];
    [portfolioModel getPortfolioHseForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
        NSLog(@"Portfolio JSON data: %@", jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];

    //    JSON for Portfolio Production and RTBD
    [portfolioModel syncPortfolioProdAndRtbd];
    [portfolioModel getPortfolioProdAndRtbdForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
        NSLog(@"Portfolio JSON data: %@", jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];

    //    JSON for Portfolio CPB
    [portfolioModel syncPortfolioCpb];
    [portfolioModel getPortfolioCpbForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
        NSLog(@"Portfolio JSON data: %@", jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];

    //    JSON for Portfolio APC
    [portfolioModel syncPortfolioApc];
    [portfolioModel getPortfolioApcForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
        NSLog(@"Portfolio JSON data: %@", jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];

    //    JSON for Portfolio WPB
    [portfolioModel syncPortfolioWpb];
    [portfolioModel getPortfolioWpbForReportingMonth:@"20130501" withProjectKey:@"72" success:^(NSString* jsonData) {
        NSLog(@"Portfolio JSON data: %@", jsonData);
    } failure: ^(NSError * error) {
        NSLog(@"No data");
    }];

    
}

@end
