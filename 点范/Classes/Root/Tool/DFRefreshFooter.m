//
//  DFRefreshFooter.m
//  点范
//
//  Created by Masteryi on 16/9/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFRefreshFooter.h"

@implementation DFRefreshFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare{
    [super prepare];
    
    //设置各种状态下刷新控件的文字
    [self setTitle:nil forState:MJRefreshStateIdle];
    [self setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
}


@end
