//
//  ETGPageModelController.h
//  ETG
//
//  Created by Tony Pham on 1/8/14.
//  Copyright (c) 2014 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETGImageViewController;

@interface ETGPageModelController : NSObject <UIPageViewControllerDataSource>

@property (nonatomic) NSMutableArray *pageData;

- (ETGImageViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(ETGImageViewController *)viewController;

@end
