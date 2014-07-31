//
//  FormatLayoutModelController.h
//  PDF_Export
//
//  Created by macmini01.sf.dev on 10/9/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGDecksLayoutModelController : NSObject

+ (instancetype)sharedModel;

# pragma mark - Table View Formatting
-(UILabel *)formatCategoryHeader;
-(UITableViewCell *)formatDeckCellContentWithIndexPath:(NSIndexPath *)indexPath
                                             tableCell:(UITableViewCell *)cell
                                         andDecksArray:(NSArray *)decksArray;
-(UITableViewCell *)formatCellContentForCategoryWithIndexPath:(NSIndexPath *)indexPath
                                             andTableCell: (UITableViewCell *)cell;
-(UITableViewCell *)formatCell:(UITableViewCell *)cell;

# pragma mark - Collection View Formatting
-(UILabel *)formatCollectionViewLabels;
-(UICollectionViewCell *)formatRecentDeckLabelsWithRecentDecks:(NSArray *)recentDecks
                                        indexPath:(NSIndexPath *)indexPath
                            andCollectionViewCell:(UICollectionViewCell *) cell;
-(UICollectionViewCell *)formatDeckLabelsWithIndexPath:(NSIndexPath *)indexPath
                                 andCollectionViewCell:(UICollectionViewCell *) cell;

#pragma mark - Popover Formatting
-(UIPopoverController *) formatPopoverWithFileName:(NSString *)fileName
                                          category:(NSString *)category
                                 andReportingMonth:(NSString *)reportingMonth;

-(UIPopoverController *) formatPopoverWithSingleString:(NSString *)fileName;

-(UIPopoverController *) formatPopoverLocationWithEndColumn:(int) endColumn popoverController:(UIPopoverController *)popoverController andCell:(UICollectionViewCell *)cell;

-(UIPopoverController *) formatPopoverLocationWithEndColumn:(int) endColumn popoverController:(UIPopoverController *)popoverController andTableCell:(UITableViewCell *)cell;

@end
