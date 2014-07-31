//
//  SecondKeyHighlightController.m
//  ElevateToGo
//
//  Created by joseph.a.m.quiteles on 4/25/13.
//  Copyright (c) 2013 Accenture Mobility Services. All rights reserved.
//

#import "ETGMonthlyAndPlannedKeyHighlightsController.h"
#import <QuartzCore/QuartzCore.h>
#import "ObjectHeight.h"

@interface ETGMonthlyAndPlannedKeyHighlightsController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) IBOutlet UILabel *monthlyHighlightsActivity;
@property(nonatomic, strong) IBOutlet UILabel *monthlyHighlightsDescription;
@property(nonatomic, strong) IBOutlet UILabel *plannedActivitiesForNextMonthActivity;
@property(nonatomic, strong) IBOutlet UILabel *plannedActivitiesForNextMonthDescription;
@property(nonatomic, strong) NSArray *monthlyKeyHighlights;
@property(nonatomic, strong)  NSArray *plannedActivitiesForNextMonth;

@property (weak, nonatomic)IBOutlet UITableView *tableMonth;
@property (weak, nonatomic)IBOutlet UITableView *tablePlanned;
@property (weak, nonatomic)IBOutlet UITableViewCell *cellMonth;
@property (weak, nonatomic)IBOutlet UITableViewCell *cellPlanned;

@end

@implementation ETGMonthlyAndPlannedKeyHighlightsController

-(void) viewWillLayoutSubviews{
//    self.tableMonth.layer.borderWidth = 1.0;
//    self.tablePlanned.layer.borderWidth = 1.0;
    [self loadMonthlyAndPlannedInfo];
}

-(void) viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMonthlyAndPlannedInfo)
                                                 name:kDownloadFilterDataForGivenReportingMonthNoError object:nil];
}

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDownloadFilterDataForGivenReportingMonthNoError object:nil];
}

-(void) loadMonthlyAndPlannedInfo {
    
    if (self.monthlyAndPlannedValues != nil) {
        _monthlyKeyHighlights = [[self.monthlyAndPlannedValues objectAtIndex:0] valueForKey:@"monthlyHighLights"];
      
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"activityID" ascending:YES];
        _monthlyKeyHighlights =   [_monthlyKeyHighlights sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
       
        _plannedActivitiesForNextMonth = [[self.monthlyAndPlannedValues objectAtIndex:0] valueForKey:@"plannedActivities"];
        
        _plannedActivitiesForNextMonth =   [_plannedActivitiesForNextMonth sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
        
        [_tableMonth reloadData];
        [_tablePlanned reloadData];
    }
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 14, 725, 300)];
//    if (tableView == self.tableMonth) {
//
//        NSString *monthDesc = [[[_monthlyKeyHighlights objectAtIndex:indexPath.row] valueForKey:@"desc"] stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
//        descriptionLabel.text = monthDesc;
//    }
//    else{
//        NSString *planDesc = [[[_plannedActivitiesForNextMonth objectAtIndex:indexPath.row] valueForKey:@"desc"] stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
//        descriptionLabel.text = planDesc;
//        
//    }

    if (tableView == self.tableMonth) {
        if (cell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"ETGKeyHighlightMonthlyTableViewCell" owner:self options:nil];
            cell = self.cellMonth;
            
        }
      
        //set row color
        if (indexPath.row % 2 == 0) {
            self.monthlyHighlightsActivity.backgroundColor = [UIColor whiteColor];
            self.monthlyHighlightsDescription.backgroundColor = [UIColor whiteColor];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];

            self.monthlyHighlightsActivity.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
            self.monthlyHighlightsDescription.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
        }
        
        NSString *monthDesc = [[[_monthlyKeyHighlights objectAtIndex:indexPath.row] valueForKey:@"desc"] stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
        descriptionLabel.text = monthDesc;

        //set dynamic height
        float rowHeightForActivity = [ObjectHeight getTextContainerHeight:self.monthlyHighlightsActivity.text containerWidth:230 fontSize:14];
        float rowHeightForDescription = [ObjectHeight getTextContainerHeight:descriptionLabel.text containerWidth:754 fontSize:14];
        float rowHeight = 0.0;
        
        if (rowHeightForActivity > rowHeightForDescription) {
            rowHeight = rowHeightForActivity;
        } else {
            rowHeight = rowHeightForDescription;
        }
        
        if (rowHeight < 44.0) {
            rowHeight = 44.0;
        }
        
        self.monthlyHighlightsActivity.frame = CGRectMake(0, 0, 230, rowHeight);
        self.monthlyHighlightsActivity.lineBreakMode = NSLineBreakByWordWrapping;
        self.monthlyHighlightsActivity.numberOfLines = 0;

        self.monthlyHighlightsDescription.frame = CGRectMake(self.monthlyHighlightsActivity.frame.origin.x + self.monthlyHighlightsActivity.frame.size.width, 0, 754, rowHeight);
        self.monthlyHighlightsDescription.lineBreakMode = NSLineBreakByWordWrapping;
        self.monthlyHighlightsDescription.numberOfLines = 0;
        self.monthlyHighlightsDescription.text = descriptionLabel.text;
//        NSLog(@"Desc = %@ : %f", self.monthlyHighlightsDescription.text, rowHeight);
//        NSLog(@"%@", self.monthlyHighlightsDescription);
        
    } else if (tableView == self.tablePlanned) {
        
        if (cell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"ETGKeyHighlightPlannedTableViewCell" owner:self options:nil];
            cell = self.cellPlanned;
            
        }
        
        if (indexPath.row % 2 == 0) {
            self.plannedActivitiesForNextMonthActivity.backgroundColor = [UIColor whiteColor];
            self.plannedActivitiesForNextMonthDescription.backgroundColor = [UIColor whiteColor];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
            self.plannedActivitiesForNextMonthActivity.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
            self.plannedActivitiesForNextMonthDescription.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
        }

        NSString *planDesc = [[[_plannedActivitiesForNextMonth objectAtIndex:indexPath.row] valueForKey:@"desc"] stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
        descriptionLabel.text = planDesc;

        float rowHeightForActivity = [ObjectHeight getTextContainerHeight:self.plannedActivitiesForNextMonthActivity.text containerWidth:230 fontSize:14];
        float rowHeightForDescription = [ObjectHeight getTextContainerHeight:descriptionLabel.text containerWidth:754 fontSize:14];
        float rowHeight = 0.0;
        
        if (rowHeightForActivity > rowHeightForDescription) {
            rowHeight = rowHeightForActivity;
        } else {
            rowHeight = rowHeightForDescription;
        }
        
        if (rowHeight < 44.0) {
            rowHeight = 44.0;
        }

        self.plannedActivitiesForNextMonthActivity.frame = CGRectMake(0, 0, 230, rowHeight);
        self.plannedActivitiesForNextMonthActivity.lineBreakMode = NSLineBreakByWordWrapping;
        self.plannedActivitiesForNextMonthActivity.numberOfLines = 0;
        
        self.plannedActivitiesForNextMonthDescription.frame = CGRectMake(self.plannedActivitiesForNextMonthActivity.frame.origin.x + self.plannedActivitiesForNextMonthActivity.frame.size.width, 0, 754, rowHeight);
        self.plannedActivitiesForNextMonthDescription.lineBreakMode = NSLineBreakByWordWrapping;
        self.plannedActivitiesForNextMonthDescription.numberOfLines = 0;
        self.plannedActivitiesForNextMonthDescription.text = descriptionLabel.text;
    }
    
    cell.textLabel.numberOfLines = 0;
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(205/255.0) green:1.0f blue:(238/255.0) alpha:1.0f];;
    cell.selectedBackgroundView = selectionColor;

    if (tableView == self.tableMonth) {
        self.monthlyHighlightsActivity.text = [[_monthlyKeyHighlights objectAtIndex:indexPath.row] valueForKey:@"activity"];
    }
    else {
        self.plannedActivitiesForNextMonthActivity.text = [[_plannedActivitiesForNextMonth objectAtIndex:indexPath.row] valueForKey:@"activity"];
        
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount = 0;
    if (tableView == self.tableMonth) {
        rowCount = [_monthlyKeyHighlights count];
        [tableView registerNib:[UINib nibWithNibName:@"ETGKeyHighlightMonthlyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ETGKeyHighlightMonthlyTableViewCell"];
    } else if (tableView == self.tablePlanned) {
        rowCount = [_plannedActivitiesForNextMonth count];
        [tableView registerNib:[UINib nibWithNibName:@"ETGKeyHighlightPlannedTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ETGKeyHighlightPlannedTableViewCell"];
    }
    
    return rowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;

    if (tableView == _tableMonth) {
        NSString *desc = [[_monthlyKeyHighlights objectAtIndex:indexPath.row] valueForKey:@"desc"];
        desc = [desc stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
        
        cellHeight = [ObjectHeight getTextContainerHeight:desc containerWidth:754 fontSize:14];
        //NSLog(@"%f", cellHeight);

    } else if (tableView == _tablePlanned) {
        NSString *desc = [[_plannedActivitiesForNextMonth objectAtIndex:indexPath.row] valueForKey:@"desc"];
        desc = [desc stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
        
        cellHeight = [ObjectHeight getTextContainerHeight:desc containerWidth:754 fontSize:14];

    }
    
    if (cellHeight < 44.0) {
        cellHeight = 44.0;
    }

    return cellHeight;
    
}


@end
