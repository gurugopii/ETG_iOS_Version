//
//  ETGSettingMasterViewController.m
//  PDF_Export
//
//  Created by Tony Pham on 8/27/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "ETGSettingMasterViewController.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

@interface ETGSettingMasterViewController ()

@end

@implementation ETGSettingMasterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
