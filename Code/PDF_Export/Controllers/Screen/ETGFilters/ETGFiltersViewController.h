//
//  FiltersViewController.h
//  PDF_Export
//
//  Created by Tony Pham on 8/26/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETGSectionInfo.h"
#import "CommonMethods.h"

@class ETGFiltersViewController;

static NSString *SectionHeaderViewIdentifier = @"SectionHeaderViewIdentifier";

@protocol ETGFiltersViewControllerDelegate <NSObject>

- (void)filtersViewControllerDidCancel;
@optional
- (void)filtersViewControllerDidFinishWithProjectsDictionary:(NSDictionary *)filteredProjectsDictionary;
- (void)filtersviewControllerDidDismiss:(NSArray *)selectedRowsInFilter;
- (void)filtersviewControllerDidDismiss:(NSArray *)selectedRowsInFilter withSender:(id)sender;
@end

@interface ETGFiltersViewController : UITableViewController

@property (weak, nonatomic) id<ETGFiltersViewControllerDelegate> delegate;
@property (nonatomic) NSArray *selectedRowsInFilter;
@property (nonatomic) NSString *moduleName;

// Protected
@property (nonatomic) NSMutableArray* sectionInfoArray;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelBarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *defaultBarButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *applyBarButton;
@property (strong, nonatomic) IBOutlet UIView *tableFooterView;
@property (nonatomic) NSInteger openSectionIndex;
@property (nonatomic) BOOL shouldUpdateFilterErrorMessage;
@property (nonatomic) BOOL isNoProjectData;


- (NSArray *)currentSelectedSectionRows;
- (void)setDefaultSelectionForProjectSection:(ETGSectionInfo *)projectSection;
- (void)reloadSectionAtIndex:(NSInteger)sectionIndex;
- (void)clearAllValueOfSection:(ETGSectionInfo *)sectionInfo;
- (void)updateSelectedValuesTitleOnSectionHeaderView:(ETGSectionInfo *)sectionInfo;
- (void)enableUserInteractionOnAllSectionWithApplyBarButtonEnableState:(BOOL)isEnable;
- (void)disableUserInteractionOnAllSectionExceptReportingMonthSection;
- (void)configureTableView;
- (void)setDefaultSelectionForAnySection:(ETGSectionInfo *)section;
- (void)updateSelectedReportingMonthValueLabel:(NSDate *)selectedDate;
@end
