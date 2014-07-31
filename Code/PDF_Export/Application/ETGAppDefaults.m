//
//  ETGAppDefaults.m
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGAppDefaults.h"

#define PDFE_APPDEFAULTS_INITIALIZED_KEY @"kInitialized"
#define PDFE_BASE_URL_KEY @"kBaseUrlKey"
#define PDFE_SCORECARD_TABLE_SUMMARY_KEY @"kScorecardTableSummaryKey"

@interface ETGAppDefaults ()

@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation ETGAppDefaults

@synthesize defaults = _defaults;

+ (instancetype)sharedDefaults {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.defaults = [NSUserDefaults standardUserDefaults];
        if (![self.defaults boolForKey:PDFE_APPDEFAULTS_INITIALIZED_KEY]) {
            [self setupDefaults];
        }
    }
    return self;
}

- (void)setupDefaults
{
    // Setup default values here during first run
    [self setBaseUrl:kBaseURL];
//    [self setScoreCardTableSummaryPath:@"/Service1.svc/ScoreCardTableSummary"];
    [self setScoreCardTableSummaryPath:[NSString stringWithFormat:@"%@%@", kPortfolioService, @"/ScoreCardTableSummary"]];
    
    // Set initialized defaults
    [self.defaults setBool:YES forKey:PDFE_APPDEFAULTS_INITIALIZED_KEY];
    [self.defaults synchronize];
}

-(NSString *)baseUrl
{
    return [self.defaults valueForKey:PDFE_BASE_URL_KEY];
}

-(void)setBaseUrl:(NSString *)baseUrl
{
    [self.defaults setValue:baseUrl forKey:PDFE_BASE_URL_KEY];
    [self.defaults synchronize];
}

-(NSString *)scoreCardTableSummaryPath
{
    return [self.defaults valueForKey:PDFE_SCORECARD_TABLE_SUMMARY_KEY];
}

- (void)setScoreCardTableSummaryPath:(NSString *)scoreCardTableSummaryPath
{
    [self.defaults setValue:scoreCardTableSummaryPath forKey:PDFE_SCORECARD_TABLE_SUMMARY_KEY];
    [self.defaults synchronize];
}

@end
