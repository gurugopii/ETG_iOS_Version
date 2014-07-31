//
//  ETGSectionInfo.h
//  PDF_Export
//
//  Created by Tony Pham on 9/2/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

//A section info object maintains information about a section

#import <Foundation/Foundation.h>
#import "ETGSectionHeaderView.h"

@interface ETGSectionInfo : NSObject

@property (nonatomic) NSInteger section;
@property (nonatomic) NSString *name;
@property (nonatomic) NSMutableArray *selectedRows;
@property (nonatomic) NSMutableArray *values;
@property (nonatomic) BOOL singleChoice;
@property (getter = isOpen) BOOL open;
@property (nonatomic) ETGSectionHeaderView *headerView;

@end
