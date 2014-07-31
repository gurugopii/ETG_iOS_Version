//
//  FormatLayoutModelController.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 10/9/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGDecksLayoutModelController.h"
#import "ETGDecksViewController.h"
#import "ETGDecksPopoverBackground.h" //For the popover format for the long press gesture

@implementation ETGDecksLayoutModelController

+ (instancetype)sharedModel {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(UILabel *)formatCategoryHeader {
    
    UILabel *categoryHeaderLabel = [[UILabel alloc] init];
    categoryHeaderLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    categoryHeaderLabel.font = [UIFont boldSystemFontOfSize:15];
    categoryHeaderLabel.textColor = [UIColor whiteColor];
    categoryHeaderLabel.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(174/255.0) blue:(154/255.0) alpha:1];
    
    return categoryHeaderLabel;
}

/* Table View Cell Format for the PDF Files present for each Category */
-(UITableViewCell *)formatDeckCellContentWithIndexPath:(NSIndexPath *)indexPath tableCell:(UITableViewCell *)cell andDecksArray:(NSArray *)decksArray{
    
    if (!decksArray.count == 0) {
        cell.textLabel.text = nil;
        
        UILabel *fileTextLabel = [[UILabel alloc] init];
        fileTextLabel.font = [UIFont systemFontOfSize:15];
        fileTextLabel.minimumScaleFactor = 10;
        fileTextLabel.numberOfLines = 2;
        fileTextLabel.text = [[[[decksArray objectAtIndex:indexPath.row] objectForKey:@"fileName"] lastPathComponent] stringByDeletingPathExtension];
        fileTextLabel.frame = CGRectMake(20, 10, 160, 30);
        fileTextLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:fileTextLabel];

        UILabel *detailTextLabel = [[UILabel alloc] init];
        detailTextLabel.font = [UIFont systemFontOfSize:14];
        detailTextLabel.minimumScaleFactor = 10;
        detailTextLabel.numberOfLines = 2;
        detailTextLabel.text = [[decksArray objectAtIndex:indexPath.row] objectForKey:@"tags"];
        detailTextLabel.frame = CGRectMake(20,45, 160, 30);
        detailTextLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:detailTextLabel];

        UILabel *reportingMonthLabel = [[UILabel alloc] init];
        reportingMonthLabel.frame = CGRectMake(185, 45, 100, 30);
        reportingMonthLabel.font = [UIFont systemFontOfSize:14];
        reportingMonthLabel.backgroundColor = [UIColor clearColor];
        reportingMonthLabel.text = [[decksArray objectAtIndex:indexPath.row] objectForKey:@"reportingMonth"];
        
        [cell.contentView addSubview:reportingMonthLabel];
    } else {
        cell.textLabel.text = @"No Available Decks.";
        cell.userInteractionEnabled = NO;
        cell.textLabel.enabled = NO;
        cell.detailTextLabel.enabled = NO;
    }

    return cell;
}

/*  Default format for cell */
-(UITableViewCell *)formatCell:(UITableViewCell *)cell {
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.text = @"";
    [self removeTableCellContentWithCell:cell];

    return cell;
}

/* Cell Format for Categories */
-(UITableViewCell *)formatCellContentForCategoryWithIndexPath:(NSIndexPath *)indexPath
 andTableCell: (UITableViewCell *)cell {
    
    UITableViewCell *bgView = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    NSArray *subCategories = [[ETGPDFModelController sharedModel] findSubCategoryWithIndexPathSection:indexPath.section];
    if(![[subCategories objectAtIndex:indexPath.row] isEqual:@"None"]){
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [subCategories objectAtIndex:indexPath.row]];
        cell.indentationLevel = 2;
        bgView.backgroundColor = [UIColor clearColor];
        cell.backgroundView=bgView;
    } else {
        cell.contentView.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(174/255.0) blue:(154/255.0) alpha:1] ;
        cell.textLabel.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(174/255.0) blue:(154/255.0) alpha:1] ;
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.textLabel.text = [[[ETGPDFModelController sharedModel] uniqueCategories] objectAtIndex:indexPath.section];
        cell.indentationLevel = 0;
        bgView.backgroundColor = [UIColor colorWithRed:0/256.0 green:174/256.0 blue:154/256.0 alpha:1.0];
        cell.backgroundView=bgView;
    }
    return cell;
}

/* Default Format for Collection View Label */
-(UILabel *)formatCollectionViewLabels {
    
    UILabel *collectionViewLabels = [[UILabel alloc] init];
    
    collectionViewLabels.textColor = [UIColor blackColor];
    collectionViewLabels.textAlignment = NSTextAlignmentCenter;
    collectionViewLabels.backgroundColor = [UIColor clearColor];
    collectionViewLabels.font = [UIFont systemFontOfSize:16];
    collectionViewLabels.tag = -2;
    
    return collectionViewLabels;
    
}

/* Format for Recent Decks Present in the Collection View */
-(UICollectionViewCell *)formatRecentDeckLabelsWithRecentDecks:(NSArray *)recentDecks indexPath:(NSIndexPath *)indexPath andCollectionViewCell:(UICollectionViewCell *) cell {
    [self removeCollectionCellContentWithCell:cell];
    UILabel *recentDeckFileName  = [[ETGDecksLayoutModelController sharedModel] formatCollectionViewLabels];
    UILabel *category  = [[ETGDecksLayoutModelController sharedModel] formatCollectionViewLabels];
    UILabel *repMonth  = [[ETGDecksLayoutModelController sharedModel] formatCollectionViewLabels];
    recentDeckFileName.font = [UIFont systemFontOfSize:13];
    category.font = [UIFont systemFontOfSize:13];
    repMonth.font = [UIFont systemFontOfSize:13];
    
    recentDeckFileName.frame = CGRectMake(20, 105, 90, 15);
    category.frame = CGRectMake(20, 120, 90, 15);
    repMonth.frame = CGRectMake(20, 135, 90, 15);
    
    recentDeckFileName.text = [[recentDecks objectAtIndex:indexPath.row] objectForKey:@"fileName"];
    if ([[[recentDecks objectAtIndex:indexPath.row] objectForKey:@"subCategory"] isEqual: @""]) {
        category.text = [[recentDecks objectAtIndex:indexPath.row] objectForKey:@"category"];
    } else {
        category.text = [[recentDecks objectAtIndex:indexPath.row] objectForKey:@"subCategory"];
    }
    repMonth.text = [[recentDecks objectAtIndex:indexPath.row] objectForKey:@"reportingMonth"];
    
    [cell.contentView addSubview:recentDeckFileName];
    [cell.contentView addSubview:category];
    [cell.contentView addSubview:repMonth];
    
    return cell;
    
}

/* Format for PDF Decks for the Collection View */
-(UICollectionViewCell *)formatDeckLabelsWithIndexPath:(NSIndexPath *)indexPath
                                 andCollectionViewCell:(UICollectionViewCell *)cell {
    [self removeCollectionCellContentWithCell:cell];
    
    UILabel *deckFileName = [[ETGDecksLayoutModelController sharedModel] formatCollectionViewLabels];
    deckFileName.frame = CGRectMake(60, 150, 50, 15);
    deckFileName.font  = [UIFont systemFontOfSize:12];
    deckFileName.text = [NSString stringWithFormat:@"%@%d", @"Slide ", indexPath.row + 1];
    [cell.contentView addSubview:deckFileName];
    
    return cell;
}

/* Removes Table Cell Content View from Superview if it's not empty */
-(void) removeTableCellContentWithCell: (UITableViewCell *) cell  {
    
    if ([cell.contentView subviews]){
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
}

/* Removes Collection Cell Content View from Superview if it's not empty */
-(void) removeCollectionCellContentWithCell: (UICollectionViewCell *) cell  {
    
    if ([cell.contentView subviews]){
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
}

/* Format for label inside the popover when long pressing a recently viewed deck */
-(UIPopoverController *) formatPopoverWithFileName:(NSString *)fileName category:(NSString *)category andReportingMonth:(NSString *)reportingMonth {
    
    UIViewController *popoverViewController = [[UIViewController alloc] init];
    popoverViewController.modalInPopover = NO;
    
    UILabel *popoverLabel = [self formatPopoverLabel];
    NSString *labelStr = fileName;
    if (category != nil) {
        labelStr = [labelStr stringByAppendingFormat:@" \n%@",category];
    }
    labelStr = [labelStr stringByAppendingFormat:@" \n%@",reportingMonth];
    
    popoverLabel.text = labelStr;
    [popoverViewController.view addSubview:popoverLabel];
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverViewController];
    popoverController.popoverBackgroundViewClass = [ETGDecksPopoverBackground class];
    
    popoverController.popoverContentSize = CGSizeMake(250, [self getLabelHeight:popoverLabel]);
    
    return popoverController;

}

/* Format for label inside the popover when long pressing a category/filename in a table. */
-(UIPopoverController *) formatPopoverWithSingleString:(NSString *)fileName {
    
    UIViewController *popoverViewController = [[UIViewController alloc] init];
    popoverViewController.modalInPopover = NO;
    
    UILabel *popoverLabel = [self formatPopoverLabel];
    popoverLabel.text = fileName;
    [popoverViewController.view addSubview:popoverLabel];
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverViewController];
    popoverController.popoverBackgroundViewClass = [ETGDecksPopoverBackground class];
    
    popoverController.popoverContentSize = CGSizeMake(250, [self getLabelHeight:popoverLabel]);
    
    return popoverController;
}

-(UILabel *) formatPopoverLabel {
    
    UILabel *popoverLabel = [[UILabel alloc] init];
    popoverLabel.font = [UIFont fontWithName:@"Arial" size:12];
    popoverLabel.numberOfLines = 0;
    [popoverLabel setLineBreakMode:NSLineBreakByWordWrapping];
    popoverLabel.frame = CGRectMake(0, 0, 250,[self getLabelHeight:popoverLabel]);
    
    return popoverLabel;

}

-(CGFloat) getLabelHeight:(UILabel *)label {
    
    CGFloat cellHeight = 0.0;
    if (![label.text isEqual:[NSNull null]]) {
        CGSize constraint = CGSizeMake(320.0f - (10.0f * 2), 20000.0f);
        CGSize size = [label.text sizeWithFont:[UIFont fontWithName:@"Arial" size:10] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat height = MAX(size.height, 30.0f);
        cellHeight = height + (10.0f * 2);
    }
    return cellHeight;
    
}

/* Format Popover Location for Recent Decks */
-(UIPopoverController *) formatPopoverLocationWithEndColumn:(int)endColumn popoverController:(UIPopoverController *)popoverController andCell:(UICollectionViewCell *)cell {
    
    CGRect rect = CGRectMake(cell.bounds.origin.x + 80, cell.bounds.origin.y + 10, 50, 30);
    if (endColumn != 3 & endColumn != 7 & endColumn != 11) {
        [popoverController presentPopoverFromRect:rect inView:cell.contentView
                         permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    } else {
        [popoverController presentPopoverFromRect:rect inView:cell.contentView
                         permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    return popoverController;
}

/* Format Popover Location for Table */
-(UIPopoverController *) formatPopoverLocationWithEndColumn:(int)endColumn popoverController:(UIPopoverController *)popoverController andTableCell:(UITableViewCell *)cell {
    
    CGRect rect = CGRectMake(cell.bounds.origin.x + 80, cell.bounds.origin.y + 10, 50, 30);
    [popoverController presentPopoverFromRect:rect inView:cell.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    return popoverController;
}


@end
