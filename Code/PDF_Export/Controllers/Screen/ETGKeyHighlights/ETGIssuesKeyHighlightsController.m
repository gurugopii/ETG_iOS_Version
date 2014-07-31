//
//  ThirdKeyHighlightController.m
//  ElevateToGo
//
//  Created by joseph.a.m.quiteles on 4/25/13.
//  Copyright (c) 2013 Accenture Mobility Services. All rights reserved.
//

#import "ETGIssuesKeyHighlightsController.h"
#import <QuartzCore/QuartzCore.h>
#import "ObjectHeight.h"

@interface ETGIssuesKeyHighlightsController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *activity;
@property(nonatomic, strong) NSMutableArray *desc;
@property(nonatomic, strong) NSMutableArray *mitigationPlan;

@property(nonatomic, strong) IBOutlet UILabel *issuesAndConcernsActivity;
@property(nonatomic, strong) IBOutlet UILabel *issuesAndConcernsDescription;
@property(nonatomic, strong) IBOutlet UILabel *issuesAndConcernsMitigationPlan;

@property (weak, nonatomic)IBOutlet UITableView *table;
@property (weak, nonatomic)IBOutlet UITableViewCell *cell;

@end

@implementation ETGIssuesKeyHighlightsController

-(void) viewWillLayoutSubviews{
    //    self.table.layer.borderWidth = 1.0;
    [self loadIssuesAndConcernsInfo];
    
}

-(void) loadIssuesAndConcernsInfo {
    
    _activity = [NSMutableArray array];
    _desc = [NSMutableArray array];
    _mitigationPlan = [NSMutableArray array];
    
    
    if (self.issuesAndConcernsValues != nil) {
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"activityID" ascending:YES];
        [_issuesAndConcernsValues sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        
        for (NSArray *issuesConcernsDict in _issuesAndConcernsValues) {
            if ([issuesConcernsDict valueForKey:@"activity"]) {
                [_activity addObject:[issuesConcernsDict valueForKey:@"activity"]];
            } else {
                [_activity addObject:@""];
            }
            if ([issuesConcernsDict valueForKey:@"mitigationPlan"]) {
                [_mitigationPlan addObject:[issuesConcernsDict valueForKey:@"mitigationPlan"]];
            } else {
                [_mitigationPlan addObject:@""];
            }
            if ([issuesConcernsDict valueForKey:@"desc"]) {
                [_desc addObject:[issuesConcernsDict valueForKey:@"desc"]];
            } else {
                [_desc addObject:@""];
            }
        }
        
        [_table reloadData];
    }
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ETGKeyHighlightIssuesTableViewCell" owner:self options:nil];
        cell = _cell;
        
    }
    
    if (indexPath.row % 2 == 0) {
        self.issuesAndConcernsDescription.backgroundColor = [UIColor whiteColor];
        self.issuesAndConcernsMitigationPlan.backgroundColor = [UIColor whiteColor];
        self.issuesAndConcernsActivity.backgroundColor = [UIColor whiteColor];
    } else {
        self.cell.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
        self.issuesAndConcernsDescription.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
        self.issuesAndConcernsMitigationPlan.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
        self.issuesAndConcernsActivity.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1];
    }

    NSString *issuesDesc = [[_desc objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
    self.issuesAndConcernsDescription.text = issuesDesc ;
    
    NSString *mitigationDesc = [[_mitigationPlan objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
    self.issuesAndConcernsMitigationPlan.text = mitigationDesc ;
    
    // Formatting
//    float rowHeightForActivity = [ObjectHeight getTextContainerHeight:self.issuesAndConcernsActivity.text containerWidth:230 fontSize:14];
    float rowHeightForMitigation = [ObjectHeight getTextContainerHeight:issuesDesc containerWidth:377 fontSize:14];
    float rowHeightForDescription = [ObjectHeight getTextContainerHeight:mitigationDesc containerWidth:377 fontSize:14];
    float rowHeight = 0.0;
    
    if (rowHeightForMitigation > rowHeightForDescription) {
        rowHeight = rowHeightForMitigation;
    } else {
        rowHeight = rowHeightForDescription;
    }
    
    if (rowHeight < 44.0) {
        rowHeight = 44.0;
    }

    self.issuesAndConcernsActivity.frame = CGRectMake(0, 0, 230, rowHeight);

    self.issuesAndConcernsDescription.frame = CGRectMake(self.issuesAndConcernsActivity.frame.origin.x + self.issuesAndConcernsActivity.frame.size.width, 0, 377, rowHeight);
    self.issuesAndConcernsDescription.lineBreakMode = NSLineBreakByWordWrapping;
    self.issuesAndConcernsDescription.numberOfLines = 0;
    
    self.issuesAndConcernsMitigationPlan.frame = CGRectMake(self.issuesAndConcernsDescription.frame.origin.x + self.issuesAndConcernsDescription.frame.size.width, 0, 377, rowHeight);
    self.issuesAndConcernsMitigationPlan.lineBreakMode = NSLineBreakByWordWrapping;
    self.issuesAndConcernsMitigationPlan.numberOfLines = 0;
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(205/255.0) green:1.0f blue:(238/255.0) alpha:1.0f];;
    cell.selectedBackgroundView = selectionColor;
    
    self.issuesAndConcernsActivity.text = [_activity objectAtIndex:indexPath.row] ;
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView registerNib:[UINib nibWithNibName:@"ETGKeyHighlightIssuesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ETGKeyHighlightIssuesTableViewCell"];
    //    return [_issuesAndConcernsValues count];
    return [_issuesAndConcernsValues count];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = 0.0;
//    NSString *text;
//    int width;
//    if ([[_mitigationPlan objectAtIndex:indexPath.row]length] > 0) {
//        text = [_mitigationPlan objectAtIndex:indexPath.row];
//        text = [text stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
//        
//        width = 400;
//    } else {
//        text = [_desc objectAtIndex:indexPath.row];
//        text = [text stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
//        
//        width = 450;
//    }
//    if (![text isEqual:[NSNull null]]) {
//        CGSize constraint = CGSizeMake(320.0f - (10.0f * 2), 20000.0f);
//        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
//        height = MAX(size.height, 44.0f);
//    }
//    //    return height + (10.0f * 2);
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, width, 70)];
//    label.text = text;
//    label.numberOfLines = 0;
//    label.font = [UIFont systemFontOfSize:16.0];
//    [label setLineBreakMode:NSLineBreakByWordWrapping];
//    [label sizeToFit];
//    
//    return label.frame.size.height + 50;
    
    CGFloat cellHeight = 0.0;
    
    NSString *desc = [_desc objectAtIndex:indexPath.row];
    desc = [desc stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
    CGFloat cellHeightForDesc = [ObjectHeight getTextContainerHeight:desc containerWidth:377 fontSize:14];
    
    NSString *mitigation = [_mitigationPlan objectAtIndex:indexPath.row];
    mitigation = [mitigation stringByReplacingOccurrencesOfString: @"<br />" withString: @"\n"];
    CGFloat cellHeightForMitigation = [ObjectHeight getTextContainerHeight:mitigation containerWidth:377 fontSize:14];

    if (cellHeightForDesc > cellHeightForMitigation) {
        cellHeight = cellHeightForDesc;
    } else {
        cellHeight = cellHeightForMitigation;
    }
    
    if (cellHeight < 44.0) {
        cellHeight = 44.0;
    }
    
    return cellHeight;

}


@end
