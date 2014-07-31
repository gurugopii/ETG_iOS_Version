//
//  ProjectInformation.h
//  ElevateToGo
//
//  Created by mobilitySF on 12/28/12.
//  Copyright (c) 2012 Accenture Mobility Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETGProjectInformationViewController : UIViewController 

@property (nonatomic, strong) NSMutableArray *projectBackgroundValues;
@property (nonatomic, strong) NSString *reportingMonth;

-(void)reloadControllerData;
-(void)showNoDataAvailableMessage;

@end
