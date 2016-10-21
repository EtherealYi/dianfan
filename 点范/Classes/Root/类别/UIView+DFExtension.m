//
//  UIView+DFExtension.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "UIView+DFExtension.h"

@implementation UIView (DFExtension)

#pragma mark -width
- (CGFloat)df_width{
    return  self.frame.size.width;
}
- (void)setDf_width:(CGFloat)df_width{
    CGRect frame = self.frame;
    frame.size.width = df_width;
    self.frame = frame;
}
#pragma mark -height
- (void)setDf_height:(CGFloat)df_height{
    CGRect frame = self.frame;
    frame.size.height = df_height;
    self.frame = frame;
}

- (CGFloat)df_height{
    return  self.frame.size.height;
}
#pragma mark -X
- (void)setDf_x:(CGFloat)df_x{
    CGRect frame = self.frame;
    frame.origin.x = df_x;
    self.frame = frame;
}
- (CGFloat)df_x{
    return self.frame.origin.x;
}
#pragma mark -y
-(void)setDf_y:(CGFloat)df_y{
    CGRect frame = self.frame;
    frame.origin.y = df_y;
    self.frame = frame;
}
- (CGFloat)df_y{
    return self.frame.origin.y;
}
#pragma mark -centerX
- (void)setDf_centerX:(CGFloat)df_centerX{
    CGPoint center = self.center;
    center.x = df_centerX;
    self.center = center;
}
- (CGFloat)df_centerX{
    return self.center.x;
}
#pragma mark -centerY
- (void)setDf_centerY:(CGFloat)df_centerY{
    CGPoint center = self.center;
    center.y = df_centerY;
    self.center = center;
}
- (CGFloat)df_centerY{
    return self.center.y;
}
#pragma mark -right
- (void)setDf_right:(CGFloat)df_right{
    self.df_x = df_right - self.df_width;
}
- (CGFloat)df_right{
    return CGRectGetMaxX(self.frame);
}

#pragma mark -buttom
- (void)setDf_bottom:(CGFloat)df_bottom{
    self.df_y = df_bottom - self.df_height;
}
- (CGFloat)df_bottom{
    return CGRectGetMaxY(self.frame);
}

//static char kActionHandlerTapGestureKey;
//static char kActionHandlerTapBlockKey;
////单点击手势
//- (void)tapGesture:(GestureActionBlock)block {
//    self.userInteractionEnabled = YES;
//    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
//    if (!gesture) {
//        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
//        [self addGestureRecognizer:gesture];
//        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
//    }
//    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
//}


+(instancetype)DF_ViewFromXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
};


@end
