//
//  LoginViewController.h
//  PDF_Export
//
//  Created by Chiz on 9/20/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ETGLoginViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic) NSString *loginMessage;
@property (nonatomic) BOOL didLogOut;

@end
