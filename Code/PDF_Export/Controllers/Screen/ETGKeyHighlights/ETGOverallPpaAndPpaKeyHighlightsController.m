//
//  KeyHighlightController.m
//  ElevateToGo
//
//  Created by mobilitySF on 12/29/12.
//  Copyright (c) 2012 Accenture Mobility Services. All rights reserved.
//

#import "ETGOverallPpaAndPpaKeyHighlightsController.h"
#import <QuartzCore/QuartzCore.h>
#import "ObjectHeight.h"

@interface ETGOverallPpaAndPpaKeyHighlightsController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *overAllPpaText;
//@property(nonatomic, weak) IBOutlet UILabel *overallProgressDescription;
@property(nonatomic, strong) IBOutlet UILabel *progressAnalysisActivity;
@property(nonatomic, strong) IBOutlet UILabel *progressAnalysisDescription;
@property(nonatomic, strong) NSArray *arrayProgressAnalysis;
@property (weak, nonatomic)IBOutlet UITableView *table;
@property (weak, nonatomic)IBOutlet UITableViewCell *cell;

@end

@implementation ETGOverallPpaAndPpaKeyHighlightsController

-(void) viewWillLayoutSubviews{
//    self.table.layer.borderWidth = 1.0;
    self.overAllPpaText.layer.borderWidth = 1.0;
    self.overAllPpaText.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    [self loadOverallAndPpaInfo];
}

-(void) viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadOverallAndPpaInfo)
                                                 name:kDownloadFilterDataForGivenReportingMonthNoError object:nil];
}

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForGivenReportingMonthNoError object:nil];
}

-(void) loadOverallAndPpaInfo {
    if (self.overallPpaAndPpaValues != nil) {
        
        
        _overAllPpaText.text = [[[self overallPpaAndPpaValues] objectAtIndex:0] valueForKey:@"overallPpa"];
        _arrayProgressAnalysis = [[self.overallPpaAndPpaValues objectAtIndex:0] valueForKey:@"ppa"];

        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"activityID" ascending:YES];//activity
        _arrayProgressAnalysis=[_arrayProgressAnalysis sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
        
        [_table reloadData];
    }
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ETGKeyHighlightPOverallTableViewCell" owner:self options:nil];
        cell = _cell;
        
    }

    if (indexPath.row % 2 == 0) {
        self.progressAnalysisActivity.backgroundColor = [UIColor whiteColor];
        self.progressAnalysisDescription.backgroundColor = [UIColor whiteColor];
    } else {
        self.cell.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
        self.progressAnalysisActivity.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
        self.progressAnalysisDescription.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
    }
    
    self.progressAnalysisDescription.text = [[_arrayProgressAnalysis objectAtIndex:indexPath.row] valueForKey:@"desc"];
    self.progressAnalysisDescription.text = [self.progressAnalysisDescription.text stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];

    // Formatting
    float rowHeightForActivity = [ObjectHeight getTextContainerHeight:self.progressAnalysisActivity.text containerWidth:230 fontSize:14];
    float rowHeightForDescription = [ObjectHeight getTextContainerHeight:self.progressAnalysisDescription.text containerWidth:754 fontSize:14];
    float rowHeight = 0.0;
    
    if (rowHeightForActivity > rowHeightForDescription) {
        rowHeight = rowHeightForActivity;
    } else {
        rowHeight = rowHeightForDescription;
    }
    
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }
    
    self.progressAnalysisActivity.frame = CGRectMake(0, 0, 230, rowHeight);
    
    self.progressAnalysisDescription.frame = CGRectMake(self.progressAnalysisActivity.frame.origin.x + self.progressAnalysisActivity.frame.size.width, 0, 754, rowHeight);
    
    self.progressAnalysisActivity.lineBreakMode = NSLineBreakByClipping;
    self.progressAnalysisActivity.numberOfLines = 0;
    
    self.progressAnalysisDescription.lineBreakMode = NSLineBreakByClipping;
    self.progressAnalysisDescription.numberOfLines = 0;
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(205/255.0) green:1.0f blue:(238/255.0) alpha:1.0f];;
    self.cell.selectedBackgroundView = selectionColor;

    self.progressAnalysisActivity.text = [[_arrayProgressAnalysis objectAtIndex:indexPath.row] valueForKey:@"activity"];

    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView registerNib:[UINib nibWithNibName:@"ETGKeyHighlightPOverallTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ETGKeyHighlightPOverallTableViewCell"];
    return [_arrayProgressAnalysis count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0.0;
    
    NSString *desc = [[_arrayProgressAnalysis objectAtIndex:indexPath.row] valueForKey:@"desc"];
    desc = [desc stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];

    cellHeight = [ObjectHeight getTextContainerHeight:desc containerWidth:754 fontSize:14];
    
    if (cellHeight < 44.0) {
        cellHeight = 44.0;
    }

    return cellHeight;
}

@end
