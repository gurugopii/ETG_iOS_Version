//
//  ETGAppDelegate.h
//  PDF_Export
//
//  Created by Medina, Patrick J. D. on 9/11/13.
//  Copyright (c) 2013 Accenture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETGAppDelegate : UIResponder <UIApplicationDelegate>{
    NSDate *dateCheck;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) BOOL isNetworkServerAvailable;

- (void)startActivityIndicatorSmallGrey;
- (void)stopActivityIndicatorSmall;
- (void)saveContext;

@end
