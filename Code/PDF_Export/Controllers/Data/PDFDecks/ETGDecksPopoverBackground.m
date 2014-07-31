//
//  PopoverBackgroundView.m
//  PDF_Export
//
//  Created by macmini01.sf.dev on 9/5/13.
//  Copyright (c) 2013 mobilitySF. All rights reserved.
//

#import "ETGDecksPopoverBackground.h"
#import <QuartzCore/QuartzCore.h>

#define CONTENT_INSET 1.0
#define ARROW_BASE 5.0
#define ARROW_HEIGHT 5.0

@interface ETGDecksPopoverBackground () {
    CGFloat _arrowOffset;
    UIPopoverArrowDirection _arrowDirection;
}


@end



@implementation ETGDecksPopoverBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [[UIColor clearColor] CGColor];
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.borderWidth = 1;
    }
    return self;
}



- (CGFloat) arrowOffset {
    return _arrowOffset;
}

- (void) setArrowOffset:(CGFloat)arrowOffset {
    _arrowOffset = arrowOffset;
}

- (UIPopoverArrowDirection)arrowDirection {
    return _arrowDirection;
}

- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    _arrowDirection = arrowDirection;
}


+(UIEdgeInsets)contentViewInsets{
    return UIEdgeInsetsMake(CONTENT_INSET, CONTENT_INSET, CONTENT_INSET, CONTENT_INSET);
}

+(CGFloat)arrowHeight{
    return ARROW_HEIGHT;
}

+(CGFloat)arrowBase{
    return ARROW_BASE;
}

-  (void)layoutSubviews {
    [super layoutSubviews];
    
}

+ (BOOL)wantsDefaultContentAppearance {

    return  NO;

}


@end
