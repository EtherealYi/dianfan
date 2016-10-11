//
//  DFCenterButton.m
//  点范
//
//  Created by Masteryi on 16/9/19.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFCenterButton.h"

@implementation DFCenterButton

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.df_centerX = fDeviceWidth / 2;
        self.df_bottom = fDeviceHeight - 64 - DFMargin * 2;
        self.alpha = 0.8;
    }
    return self;
}


@end
