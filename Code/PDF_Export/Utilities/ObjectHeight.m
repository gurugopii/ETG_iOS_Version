//
//  ObjectHeight.m
//  ElevateToGo
//
//  Created by Wen wen de Sarapen on 5/8/13.
//  Copyright (c) 2013 Accenture Mobility Services. All rights reserved.
//

#import "ObjectHeight.h"

@implementation ObjectHeight

+(CGFloat)getTextContainerHeight:(NSString *)text containerWidth:(int)containerWidth fontSize:(float)fontSize {
    
    UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, containerWidth, 100)];
    
    textLbl.numberOfLines = 0;
    textLbl.font = [UIFont systemFontOfSize:fontSize];
    textLbl.text = text;
    
    CGSize textSize = [[textLbl text] sizeWithFont:[textLbl font]];
    textLbl.frame = CGRectMake(0, 0, containerWidth, textSize.height);
    [textLbl sizeToFit];
    
    CGFloat height = textLbl.frame.size.height;
    
    return height + 10;
    
}

@end
