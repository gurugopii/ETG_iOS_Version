//
//  ETGImageViewController.m
//  ETG
//
//  Created by Tony Pham on 1/8/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import "ETGImageViewController.h"

@interface ETGImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ETGImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_imageView setImage:_dataObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
