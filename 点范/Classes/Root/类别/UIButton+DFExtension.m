//
//  UIButton+DFExtension.m
//  点范
//
//  Created by Masteryi on 16/9/5.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "UIButton+DFExtension.h"

@implementation UIButton (DFExtension)
static char eventKey;
/**
 *  UIButton添加UIControlEvents事件的block
 *
 *  @param controlEvent 事件
 *  @param action block代码
 */

- (void)handleEvent:(UIControlEvents)event withBlock:(ClickBlock)action{
    objc_setAssociatedObject(self, &eventKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

- (void)callActionBlock:(id)sender {
    ClickBlock block = (ClickBlock)objc_getAssociatedObject(self, &eventKey);
    if (block) {
        block();
    }
}

+(instancetype)creatButton{
    return [UIButton buttonWithType:UIButtonTypeCustom];
}

- (void)CornerAndShdow{
    self.layer.cornerRadius = 5;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundColor = MainColor;
    
}

- (void)setText:(NSString *)text andFont:(CGFloat)font andColor:(UIColor *)color{
    
    [self setTitle:text forState:UIControlStateNormal];
    self.titleLabel.font =  [UIFont systemFontOfSize:font];
    //self.tintColor = color;
    [self setTitleColor:color forState:UIControlStateNormal];
    
}

@end
