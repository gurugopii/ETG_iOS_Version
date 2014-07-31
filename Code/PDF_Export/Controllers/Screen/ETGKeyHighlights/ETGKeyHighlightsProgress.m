//
//  ETGKeyHighlightProgress.m
//  PDF_Export
//
//  Created by Chiz on 11/5/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGKeyHighlightsProgress.h"
#import "ObjectHeight.h"

@interface ETGKeyHighlightsProgress ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *keyhighlightsProgressOverallArray;

//Table Labels
@property (weak, nonatomic) IBOutlet UILabel *keyhighlightsActivity;
@property (weak, nonatomic) IBOutlet UILabel *weightage;
@property (weak, nonatomic) IBOutlet UILabel *currentPlanProgress;
@property (weak, nonatomic) IBOutlet UILabel *currentActualProgress;
@property (weak, nonatomic) IBOutlet UILabel *currentVariance;
@property (weak, nonatomic) IBOutlet UIImageView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *lblDummy;
@property (weak, nonatomic) IBOutlet UILabel *lastMonthPlanProgress;
@property (weak, nonatomic) IBOutlet UILabel *lastMonthActualProgress;
@property (weak, nonatomic) IBOutlet UILabel *lastMonthVariance;

//Total summary
@property (weak, nonatomic) IBOutlet UILabel *lblOverallPlanCurrValue;
@property (weak, nonatomic) IBOutlet UILabel *lblOverallActualCurrValue;
@property (weak, nonatomic) IBOutlet UILabel *lblOverallVarianceCurrValue;
@property (weak, nonatomic) IBOutlet UILabel *lblOverallPlanPrevValue;
@property (weak, nonatomic) IBOutlet UILabel *lblOverallActualPrevValue;
@property (weak, nonatomic) IBOutlet UILabel *lblOverallVariancePrevValue;
@property (weak, nonatomic) IBOutlet UIImageView *currentMonthIndicator;

@property (weak, nonatomic) IBOutlet UILabel *lblProjectName;
@property (weak, nonatomic) IBOutlet UILabel *lblProjectStatus;

@property (weak, nonatomic)IBOutlet UITableView *table;
@property (weak, nonatomic)IBOutlet UITableViewCell *cell;

@end

@implementation ETGKeyHighlightsProgress

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
}

-(void) viewWillLayoutSubviews{
   self.table.layer.borderWidth = 0.0;
    [self loadProgress];

}

-(void) viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadProgress)
                                                 name:kDownloadFilterDataForGivenReportingMonthNoError object:nil];
}

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForGivenReportingMonthNoError object:nil];
}

-(void) loadProgress {

//    if (self.keyhighlightsProgressArray != nil) {
    if ([self.keyhighlightsProgressArray count]) {
    
        self.lblProjectName.text = _projectName;
        self.lblProjectStatus.text = _projectStatus;
//        NSLog(@"%@", _projectName);
//        NSLog(@"%@", _projectStatus);

        self.keyhighlightsProgressOverallArray = [[self.keyhighlightsProgressArray objectAtIndex:0] valueForKey:@"keyhighlightsProgress"];
        NSMutableArray *khProgressTableFilteredArray = [[self.keyhighlightsProgressArray objectAtIndex:0] valueForKeyPath:@"keyhighlightsProgress.keyhighLightsTable"];
        
        _keyhighlightsProgressTableArray = [NSMutableArray array];
        
        if ([khProgressTableFilteredArray count]) {
            for (NSDictionary *data in [khProgressTableFilteredArray objectAtIndex:0]) {
                [_keyhighlightsProgressTableArray addObject:data];
            }
        }

        if ([self.keyhighlightsProgressOverallArray count]) {
            // Current
            float planCurrentValue = [[[self.keyhighlightsProgressOverallArray objectAtIndex:0] valueForKey:@"overallCurrPlanProgress"] floatValue];
            float actualCurrentValue = [[[self.keyhighlightsProgressOverallArray objectAtIndex:0] valueForKey:@"overallCurrActualProgress"] floatValue];
            
            self.lblOverallPlanCurrValue.text = [NSString stringWithFormat:@"%.2f", planCurrentValue];
            self.lblOverallActualCurrValue.text = [NSString stringWithFormat:@"%.2f", actualCurrentValue];
            self.lblOverallVarianceCurrValue.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressOverallArray objectAtIndex:0] valueForKey:@"overallCurrVariance"] floatValue]];
            
            // Previous
            self.lblOverallPlanPrevValue.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressOverallArray objectAtIndex:0] valueForKey:@"overallPrevPlanProgress"] floatValue]];
            self.lblOverallActualPrevValue.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressOverallArray objectAtIndex:0] valueForKey:@"overallPrevActualProgress"] floatValue]];
            self.lblOverallVariancePrevValue.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressOverallArray objectAtIndex:0] valueForKey:@"overallPrevVariance"] floatValue]];
            
            //Indicator
            NSString *indicatorColorName;
            if (actualCurrentValue < planCurrentValue) {
                indicatorColorName = @"red";
            } else {
                indicatorColorName = @"green";
            }
            self.currentMonthIndicator.image = [UIImage imageNamed:indicatorColorName];
        }
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"activityID" ascending:YES];//activityName
        [_keyhighlightsProgressTableArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
     
        [_table reloadData];
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ETGKeyHighlightProgressTableViewCell" owner:self options:nil];
        cell = _cell;
        
    }
    
    if (indexPath.row % 2 == 0) {
        self.cell.backgroundColor = [UIColor whiteColor];
        self.keyhighlightsActivity.backgroundColor = [UIColor whiteColor];
        self.weightage.backgroundColor = [UIColor whiteColor];
        self.currentPlanProgress.backgroundColor = [UIColor whiteColor];
        self.currentActualProgress.backgroundColor = [UIColor whiteColor];
        self.currentVariance.backgroundColor = [UIColor whiteColor];
        self.indicator.backgroundColor = [UIColor whiteColor];
        self.lastMonthPlanProgress.backgroundColor = [UIColor whiteColor];
        self.lastMonthActualProgress.backgroundColor = [UIColor whiteColor];
        self.lastMonthVariance.backgroundColor = [UIColor whiteColor];
        self.lblDummy.backgroundColor = [UIColor whiteColor];
    } else {
        self.cell.backgroundColor = kLightGrayCellBackgroundColor;
        self.keyhighlightsActivity.backgroundColor = kLightGrayCellBackgroundColor;
        self.weightage.backgroundColor = kLightGrayCellBackgroundColor;
        self.currentPlanProgress.backgroundColor = kLightGrayCellBackgroundColor;
        self.currentActualProgress.backgroundColor = kLightGrayCellBackgroundColor;
        self.currentVariance.backgroundColor = kLightGrayCellBackgroundColor;
        self.lblDummy.backgroundColor = kLightGrayCellBackgroundColor;
        self.indicator.backgroundColor = kLightGrayCellBackgroundColor;
        self.lastMonthPlanProgress.backgroundColor = kLightGrayCellBackgroundColor;
        self.lastMonthActualProgress.backgroundColor = kLightGrayCellBackgroundColor;
        self.lastMonthVariance.backgroundColor = kLightGrayCellBackgroundColor;
    }

    // Formatting
    float fontSize = 17;
    float rowHeight = [ObjectHeight getTextContainerHeight:self.keyhighlightsActivity.text containerWidth:130 fontSize:fontSize];
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }
    self.keyhighlightsActivity.frame = CGRectMake(0, 0, 130, rowHeight);
    
    rowHeight = [ObjectHeight getTextContainerHeight:self.weightage.text containerWidth:104 fontSize:fontSize];
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }
    self.weightage.frame = CGRectMake(self.keyhighlightsActivity.frame.origin.x + self.keyhighlightsActivity.frame.size.width, 0, 104, rowHeight);
    
    rowHeight = [ObjectHeight getTextContainerHeight:self.currentPlanProgress.text containerWidth:104 fontSize:fontSize];
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }
    self.currentPlanProgress.frame = CGRectMake(self.weightage.frame.origin.x + self.weightage.frame.size.width, 0, 104, rowHeight);
    
    rowHeight = [ObjectHeight getTextContainerHeight:self.currentActualProgress.text containerWidth:104 fontSize:fontSize];
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }
    self.currentActualProgress.frame = CGRectMake(self.currentPlanProgress.frame.origin.x + self.currentPlanProgress.frame.size.width, 0, 104, rowHeight);
    
    rowHeight = [ObjectHeight getTextContainerHeight:self.currentVariance.text containerWidth:104 fontSize:fontSize];
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }
    self.currentVariance.frame = CGRectMake(self.currentActualProgress.frame.origin.x + self.currentActualProgress.frame.size.width, 0, 104, rowHeight);
    
    // Skip indicator
    rowHeight = [ObjectHeight getTextContainerHeight:self.lblDummy.text containerWidth:92 + 30 fontSize:fontSize];
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }
    self.lblDummy.frame = CGRectMake(self.currentVariance.frame.origin.x + self.currentVariance.frame.size.width, 0, 92 + 30, rowHeight);

    self.indicator.frame = CGRectMake(self.lblDummy.frame.origin.x - 25 + self.lblDummy.frame.size.width - 25, 7, 30, 30);

    rowHeight = [ObjectHeight getTextContainerHeight:self.lastMonthPlanProgress.text containerWidth:104 fontSize:fontSize];
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }
    self.lastMonthPlanProgress.frame = CGRectMake(self.lblDummy.frame.origin.x + self.lblDummy.frame.size.width, 0, 104, rowHeight);
    
    rowHeight = [ObjectHeight getTextContainerHeight:self.lastMonthActualProgress.text containerWidth:104 fontSize:fontSize];
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }
    self.lastMonthActualProgress.frame = CGRectMake(self.lastMonthPlanProgress.frame.origin.x + self.lastMonthPlanProgress.frame.size.width, 0, 104, rowHeight);
    
    rowHeight = [ObjectHeight getTextContainerHeight:self.lastMonthVariance.text containerWidth:108 fontSize:fontSize];
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }
    self.lastMonthVariance.frame = CGRectMake(self.lastMonthActualProgress.frame.origin.x + self.lastMonthActualProgress.frame.size.width, 0, 108, rowHeight);
    
    self.keyhighlightsActivity.text = [[self.keyhighlightsProgressTableArray objectAtIndex:indexPath.row] valueForKey:@"activityName"];
    self.keyhighlightsActivity.lineBreakMode = NSLineBreakByClipping;
    self.keyhighlightsActivity.numberOfLines = 0;

    self.weightage.textAlignment = NSTextAlignmentRight;
    self.weightage.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressTableArray objectAtIndex:indexPath.row] valueForKey:@"weightage"] floatValue]];
    
    self.currentPlanProgress.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressTableArray objectAtIndex:indexPath.row] valueForKey:@"currPlanProgress"] floatValue]];
    
    self.currentActualProgress.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressTableArray objectAtIndex:indexPath.row] valueForKey:@"currActualProgress"] floatValue]];
    
    self.currentVariance.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressTableArray objectAtIndex:indexPath.row] valueForKey:@"currVariance"] floatValue]];
    
    NSString *indicator = [NSString stringWithFormat:@"%@",[[self.keyhighlightsProgressTableArray objectAtIndex:indexPath.row] valueForKey:@"indicator"]];
    
    if ([indicator isEqualToString:@"green"]) {
        self.indicator.image = [UIImage imageNamed:@"green"];
    } else if ([indicator isEqualToString:@"red"]) {
        self.indicator.image = [UIImage imageNamed:@"red"];
    } else if ([indicator isEqualToString:@"yellow"]) {
        self.indicator.image = [UIImage imageNamed:@"yellow"];
    }
    
    self.lastMonthPlanProgress.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressTableArray objectAtIndex:indexPath.row] valueForKey:@"prevPlanProgress"] floatValue]];
    
    self.lastMonthActualProgress.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressTableArray objectAtIndex:indexPath.row] valueForKey:@"prevActualProgress"] floatValue]];
    
    self.lastMonthVariance.text = [NSString stringWithFormat:@"%.2f", [[[self.keyhighlightsProgressTableArray objectAtIndex:indexPath.row] valueForKey:@"prevVariance"] floatValue]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(205/255.0) green:1.0f blue:(238/255.0) alpha:1.0f];;
    cell.selectedBackgroundView = selectionColor;
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView registerNib:[UINib nibWithNibName:@"ETGKeyHighlightProgressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ETGKeyHighlightProgressTableViewCell"];
    return [self.keyhighlightsProgressTableArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0.0;
    
    NSString *activity = [[self.keyhighlightsProgressTableArray objectAtIndex:indexPath.row] valueForKey:@"activityName"];
    cellHeight = [ObjectHeight getTextContainerHeight:activity containerWidth:754 fontSize:14];
    
    if (cellHeight < 44.0) {
        cellHeight = 44.0;
    }
    
    return cellHeight;
}

@end
