//
//  UIView+DFExtension.h
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DFExtension)

/** 控件宽度 **/
@property (nonatomic, assign) CGFloat df_width;
/** 控件高度 **/
@property (nonatomic, assign) CGFloat df_height;
/** 控件x **/
@property (nonatomic, assign) CGFloat df_x;
/** 控件y **/
@property (nonatomic, assign) CGFloat df_y;
/** 控件x中心 **/
@property (nonatomic, assign) CGFloat df_centerX;
/** 控件y中心 **/
@property (nonatomic, assign) CGFloat df_centerY;
/** 控件右边 **/
@property (nonatomic, assign) CGFloat df_right;
/** 控件底部 **/
@property (nonatomic, assign) CGFloat df_bottom;

//typedef void (^GestureActionBlock)(UIGestureRecognizer *ges);
/** 单点击手势 */
//- (void)tapGesture:(GestureActionBlock)block;

+(instancetype)DF_ViewFromXib;

@end
