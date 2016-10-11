//
//  UILabel+DFExtension.m
//  点范
//
//  Created by Masteryi on 16/9/21.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "UILabel+DFExtension.h"

@implementation UILabel (DFExtension)
- (void)setText:(NSString *)text andFont:(CGFloat )font andColor:(UIColor *)color{
    self.text = text;
    self.textColor = color;
    self.font = BaseFont(font);
}

@end
