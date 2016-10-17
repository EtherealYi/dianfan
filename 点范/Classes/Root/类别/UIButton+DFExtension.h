//
//  UIButton+DFExtension.h
//  点范
//
//  Created by Masteryi on 16/9/5.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@class UIButton;

typedef void(^ClickBlock)();

@interface UIButton (DFExtension)
/**
 *  UIButton添加UIControlEvents事件的block
 *
 *  @param event 事件
 *  @param buttonClickBlock block代码
 */
- (void) handleEvent:(UIControlEvents)event withBlock:(ClickBlock)action;
/**
 圆角与阴影
 */
- (void)CornerAndShdow;

/**
 设置按钮

 @param text  文字
 @param font  大小
 @param color 颜色
 */
- (void)setText:(NSString *)text andFont:(CGFloat )font andColor:(UIColor *)color;



+(instancetype)creatButton;

@end
