//
//  CALayer+DFExtension.m
//  点范
//
//  Created by Masteryi on 2016/9/23.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "CALayer+DFExtension.h"

@implementation CALayer (DFExtension)

- (CATransition *)fadeFunction{
    return  [self fadeFunction:0.4];
}
/**
 *  渐显效果 效果时间
 */
- (CATransition *)fadeFunction:(CGFloat)time {
    CATransition *animation = [CATransition animation];
    [animation setDuration:time];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self addAnimation:animation forKey:nil];
    return animation;
}

- (void)cellShadow{
    self.shadowOpacity = 0.3;
    self.shadowOffset = CGSizeMake(4, 4);
    self.shadowColor = [UIColor grayColor].CGColor;
    self.masksToBounds = NO;
}

@end
