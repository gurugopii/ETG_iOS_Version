
//
//  ProjectInformation.m
//  ElevateToGo
//
//  Created by mobilitySF on 12/28/12.
//  Copyright (c) 2012 Accenture Mobility Services. All rights reserved.
//

#import "ETGProjectInformationViewController.h"
#import "ETGProjectBackground.h"
#import "Base64.h"

@interface ETGProjectInformationViewController ()

@property (nonatomic, strong) IBOutlet UILabel *projectNameLbl;
@property (nonatomic, strong) IBOutlet UILabel *operatorshipLbl;
@property (nonatomic, strong) IBOutlet UILabel *projectNatureLbl;
@property (nonatomic, strong) IBOutlet UILabel *countryLbl;
@property (nonatomic, strong) IBOutlet UILabel *clusterLbl;
@property (nonatomic, strong) IBOutlet UILabel *projectStatusLbl;
@property (nonatomic, strong) IBOutlet UILabel *startDateLbl;
@property (nonatomic, strong) IBOutlet UILabel *fdpStatusLbl;
@property (nonatomic, strong) IBOutlet UILabel *firStatusLbl;
@property (nonatomic, strong) IBOutlet UILabel *projectIDLbl;
@property (nonatomic, strong) IBOutlet UILabel *costCategoryLbl;
@property (nonatomic, strong) IBOutlet UILabel *projectTypeLbl;
@property (nonatomic, strong) IBOutlet UILabel *regionLbl;
@property (nonatomic, strong) IBOutlet UILabel *currencyLbl;
@property (nonatomic, strong) IBOutlet UILabel *equityLbl;
@property (nonatomic, strong) IBOutlet UILabel *fdpAmtLbl;
@property (nonatomic, strong) IBOutlet UILabel *firAmtLbl;
@property (nonatomic, strong) IBOutlet UILabel *objectiveLbl;
@property (nonatomic, strong) IBOutlet UILabel *endDateLbl;
@property (nonatomic, strong) IBOutlet UIImageView *projectImage;
@property (nonatomic, strong) NSString *projName;
@property (nonatomic, strong) IBOutlet UIImageView *projectImageTest;
@property (nonatomic, strong) IBOutlet UILabel *projectBgSelectedReportingMonth;
@property (nonatomic, strong) IBOutlet UILabel *objectiveBorderLbl;
@property (nonatomic, weak) IBOutlet UIView *noDataAvailable;
@property (nonatomic, strong) IBOutlet UITextView *objectiveText;

@end

@implementation ETGProjectInformationViewController

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self reloadControllerData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [ETGAlert sharedAlert].alertShown = NO;
}

-(void) loadProjectLabelInformation{
    
    NSString *firDate = [NSString stringWithFormat:@"%@", [[_projectBackgroundValues valueForKey:@"firDate"] toChartDateString]];
    NSString *fdpDate = [NSString stringWithFormat:@"%@", [[_projectBackgroundValues valueForKey:@"fdpDate"] toChartDateString]];
    
    NSString *equity = [self formatDecimalValues:[_projectBackgroundValues valueForKey:@"equity"]];
    NSString *firAmt = [self formatDecimalValues:[_projectBackgroundValues valueForKey:@"firAmt"]];
    NSString *fdpAmt = [self formatDecimalValues:[_projectBackgroundValues valueForKey:@"fdpAmt"]];
    
    NSString *fdpStatus = [_projectBackgroundValues valueForKey:@"fdpStatus"];
    if (fdpStatus.length && fdpDate.length)
        fdpStatus = [NSString stringWithFormat:@"%@ (%@)", fdpStatus, fdpDate];
    NSString *firStatus = [_projectBackgroundValues valueForKey:@"firStatus"];
    if (firStatus.length && firDate.length)
        firStatus = [NSString stringWithFormat:@"%@ (%@)", firStatus, firDate];
    
    _projectBgSelectedReportingMonth.text = [NSString stringWithFormat:@"(%@)", _reportingMonth];
    _projectNameLbl.text = [_projectBackgroundValues valueForKey:@"projectName"];
    _operatorshipLbl.text = [_projectBackgroundValues valueForKey:@"operatorshipName"];;
    _projectNatureLbl.text = [_projectBackgroundValues valueForKey:@"projectNatureName"];
    _countryLbl.text = [_projectBackgroundValues valueForKey:@"country"];
    _clusterLbl.text = [_projectBackgroundValues valueForKey:@"clusterName"];
    _projectStatusLbl.text = [_projectBackgroundValues valueForKey:@"projectStatusName"];
    _startDateLbl.text = [NSString stringWithFormat:@"%@", [[_projectBackgroundValues valueForKey:@"startDate"] toChartDateString]];
    _fdpStatusLbl.text = fdpStatus;
    _firStatusLbl.text = firStatus;
    _projectIDLbl.text = [_projectBackgroundValues valueForKey:@"projectId"];
    _costCategoryLbl.text = [_projectBackgroundValues valueForKey:@"projectCostCategoryName"];
    _projectTypeLbl.text = [_projectBackgroundValues valueForKey:@"projectTypeName"];
    _regionLbl.text = [_projectBackgroundValues valueForKey:@"region"];
    _currencyLbl.text = [_projectBackgroundValues valueForKey:@"currencyName"];
    _equityLbl.text = [NSString stringWithFormat:@"%@%@", equity, @"%"];
    _endDateLbl.text = [NSString stringWithFormat:@"%@", [[_projectBackgroundValues valueForKey:@"endDate"] toChartDateString]];
    _fdpAmtLbl.text = fdpAmt;
    _firAmtLbl.text = firAmt;
    //_objectiveLbl.text = [_projectBackgroundValues valueForKey:@"objective"];
    _objectiveText.text = [_projectBackgroundValues valueForKey:@"objective"];
    
    /*
    NSMutableArray* array = ... // from XML
    NSDictionary* dict = [array objectAtIndex: 0];
    NSString* dataString = [dict objectForKey: @"Image"];
    NSData* imageData = [dataString base64DecodedData];
    UIImage* image = [UIImage imageWithData: imageData];
     
    sample code suggest using Base64 for encoding of string,
    in the code below encoding should be Base 64 for the image to display (theory only)
    */
    
    //ASLE 1209
    [Base64 initialize];
    NSString *imgString = [_projectBackgroundValues valueForKey:@"projectImage"];
    NSData *imageData = [Base64 decode:[imgString cStringUsingEncoding:NSASCIIStringEncoding] length:[imgString length]];
    _projectImage.image = [UIImage imageWithData:imageData];
}

-(NSString *) formatDecimalValues:(NSString *) value{
    
    if (!value.length)
        [value toZero];
    float floatValue = [value floatValue] * 100;
    value = [[NSString stringWithFormat:@"%f", floatValue] decimalFormat];

    return value;
}

-(void)reloadControllerData {
    if (_projectBackgroundValues != nil) {
        
        _noDataAvailable.hidden = YES;
        
        _objectiveBorderLbl.layer.borderColor = [UIColor blackColor].CGColor;
        _objectiveBorderLbl.layer.borderWidth = 1.0;
        _objectiveBorderLbl.layer.cornerRadius = 10.0;
        _objectiveBorderLbl.layer.shadowColor = [UIColor blackColor].CGColor;
        
        if (![_projectBackgroundValues isKindOfClass:[NSMutableArray class]]){
            NSMutableArray *convertArray = [NSMutableArray arrayWithObject:_projectBackgroundValues];
            _projectBackgroundValues = convertArray;
        }
        
        _projectBackgroundValues = [_projectBackgroundValues objectAtIndex:0];
        [self loadProjectLabelInformation];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        }
        
    }
}

-(void)showNoDataAvailableMessage {
    _noDataAvailable.hidden = NO;
}
    
@end
