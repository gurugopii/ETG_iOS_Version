//
//  FilterTableView.m
//  PDF_Export
//
//  Created by Tony Pham on 11/29/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import "ETGFilterTableView.h"
#import "ETGSectionInfo.h"
#import "ETGSectionHeaderView.h"
#import "ETGReportingMonthCell.h"
#import "SRMonthPicker.h"

#define kREPORTINGPERIOD 0
static NSString *SectionHeaderViewIdentifier = @"SectionHeaderViewIdentifier";

@interface ETGFilterTableView () <SRMonthPickerDelegate, SectionHeaderViewDelegate>

@end

@implementation ETGFilterTableView


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSLog(@"section: %d", [_sectionInfoArray count]);
    //NSLog(@"Section info array: %@", _sectionInfoArray);
    return [_sectionInfoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ETGSectionInfo *sectionInfo = _sectionInfoArray[section];
    NSInteger numberOfRows = 0;
    
    if (sectionInfo.singleChoice == YES) {
        if (section == 0) {
            numberOfRows = 1;
        } else {
            numberOfRows = [sectionInfo.values count];
        }
    } else {
        numberOfRows = [sectionInfo.values count] + 1;
    }
    //NSLog(@"Number of row: %d in section: %d", section, sectionInfo.open ? numberOfRows : 0);
    return sectionInfo.open ? numberOfRows : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 216;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETGSectionInfo *sectionInfo = _sectionInfoArray[indexPath.section];
    
    if (indexPath.section == 0) {
        ETGReportingMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportingMonthCell" forIndexPath:indexPath];
        
        SRMonthPicker *reportingMonthPickerView = cell.datePickerView;
        reportingMonthPickerView.monthPickerDelegate = self;
        reportingMonthPickerView.date = [sectionInfo.selectedRows objectAtIndex:0];
        reportingMonthPickerView.minimumYear = @2012;
        NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
        reportingMonthPickerView.maximumYear = @([currentDateComponents year]);
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
        
        if (sectionInfo.singleChoice == NO && indexPath.row == 0) {
            cell.textLabel.text = @"Select All";
            
            //Check selection state of SelectAll cell
            if ([sectionInfo.selectedRows count] == [sectionInfo.values count]) {
                [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
        } else {
            NSEntityDescription *object;
            if (sectionInfo.singleChoice == YES) {
                object = sectionInfo.values[indexPath.row];
            } else {
                object = sectionInfo.values[indexPath.row - 1];
            }
            cell.textLabel.text = object.name;
            
            //Default selection
            for (NSNumber *selectedRow in sectionInfo.selectedRows) {
                if (indexPath.row == [selectedRow integerValue]) {
                    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                }
            }
        }
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ETGSectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderViewIdentifier];
    sectionHeaderView.delegate = self;
    sectionHeaderView.section = section;
    
    ETGSectionInfo *sectionInfo = _sectionInfoArray[section];
    sectionHeaderView.categoryLabel.text = sectionInfo.name;
    sectionInfo.headerView = sectionHeaderView;
    sectionInfo.section = section;
    
    if (section == kREPORTINGPERIOD) {
        sectionInfo.headerView.disclosureButton.selected = YES;
        if ([sectionInfo.selectedRows count] > 0) {
            [self updateSelectedReportingMonthValueLabel:sectionInfo.selectedRows[0]];
        } else {
            [self updateSelectedReportingMonthValueLabel:[NSDate date]];
        }
    } else {
        [self updateSelectedValuesTitleOnSectionHeaderView:sectionInfo];
    }
    
    return sectionHeaderView;
}

- (void)updateSelectedValuesTitleOnSectionHeaderView:(ETGSectionInfo *)sectionInfo {
    
    switch ([sectionInfo.selectedRows count]) {
        case 0:
            sectionInfo.headerView.categoryValueLabel.text = @"";
            break;
        case 1:{
            NSInteger selectedRow = [sectionInfo.selectedRows[0] integerValue];
            NSEntityDescription *object;
            if (sectionInfo.singleChoice == YES) {
                object = sectionInfo.values[selectedRow];
            } else {
                object = sectionInfo.values[selectedRow - 1];
            }
            sectionInfo.headerView.categoryValueLabel.text = object.name;
            
            break;
        }
        default:{
            if ([sectionInfo.selectedRows count] == [sectionInfo.values count]) {
                sectionInfo.headerView.categoryValueLabel.text = @"All";
            } else {
                sectionInfo.headerView.categoryValueLabel.text = @"Multiple Values";
            }
            break;
        }
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    } else {
        return YES;
    }
}


- (void)updateSelectedReportingMonthValueLabel:(NSDate *)selectedDate {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:selectedDate];
    ETGSectionInfo *sectionInfo = [_sectionInfoArray objectAtIndex:kREPORTINGPERIOD];
    sectionInfo.headerView.categoryValueLabel.text = [NSString stringWithFormat:@"%d/%d", [dateComponents month], [dateComponents year]];
}

@end
