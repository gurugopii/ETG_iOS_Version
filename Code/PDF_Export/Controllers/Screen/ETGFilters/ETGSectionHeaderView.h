//
//  ETGSectionHeaderView.h
//  PDF_Export
//
//  Created by Tony Pham on 9/2/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionHeaderViewDelegate;

@interface ETGSectionHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryValueLabel;
@property (weak, nonatomic) IBOutlet UIButton *disclosureButton;

@property (weak, nonatomic) id<SectionHeaderViewDelegate> delegate;
@property (nonatomic) NSInteger section;

-(void)toggleOpenWithUserAction:(BOOL)userAction;

@end


/*
 Protocol to be adopted by the section header's delegate; the section header tells its delegate when the section should be opened and closed.
 */
@protocol SectionHeaderViewDelegate <NSObject>

@optional
-(void)sectionHeaderView:(ETGSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(ETGSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section;

@end