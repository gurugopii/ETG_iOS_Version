//
//  ETGReportingMonthCell.h
//  PDF_Export
//
//  Created by Tony Pham on 9/25/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRMonthPicker.h"

@interface ETGReportingMonthCell : UITableViewCell

@property (weak, nonatomic) IBOutlet SRMonthPicker *datePickerView;

@end
