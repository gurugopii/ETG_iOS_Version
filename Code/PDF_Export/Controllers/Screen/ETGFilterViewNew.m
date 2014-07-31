//
//  ETGFilterViewNew.m
//  ETG
//
//  Created by iscismac001 on 7/25/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGFilterViewNew.h"

@implementation ETGFilterViewNew{
    
    NSMutableArray *filtersList;
    
    CGFloat contentHeight;
}

@synthesize filterTitles;
@synthesize contentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self loadDefaults];
        
    }
    return self;
}

-(void)loadDefaults{
    
    contentHeight = (self.bounds.size.height*0.6);
    
    filtersList = [[NSMutableArray alloc] initWithObjects:@"Reporting Period",@"Operatorship",@"Phase",@"Region",@"Project Status",@"Project",@"Budget Holder",@"Baseline Type",@"RevisionNo.",nil];
    
    contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor grayColor]];
    [contentView setFrame:CGRectMake(0, -contentHeight, self.bounds.size.width, contentHeight)];
    [self addSubview:contentView];
    
}

-(void)createSections{
    
    CGFloat titleWidth = self.bounds.size.width/[filtersList count];
    
    for (NSString *title in filtersList) {
        
        UIButton *titleButton = [[UIButton alloc] init];
        [titleButton setTitle:title forState:UIControlStateNormal];
    }
}


@end
