//
//  DFStarView.m
//  点范
//
//  Created by Masteryi on 2016/10/9.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFStarView.h"

@interface DFStarView()


@end

@implementation DFStarView

- (instancetype)initFrame:(CGRect)frame starCount:(int)starCount{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat imgW = frame.size.width / 5;
        CGFloat imgH = frame.size.height;
        for (int i = 0; i < starCount; i++) {
            UIImageView *RedimgView = [[UIImageView alloc]init];
            CGFloat imgX = i * imgW;
            RedimgView.frame = CGRectMake(imgX, 0, imgW, imgH);
            [RedimgView setImage:[UIImage imageNamed:@"红五星"]];
           
            [self addSubview:RedimgView];
            
        }
        if (starCount < 5) {
            for (int j = starCount ; j < 5; j ++) {
                UIImageView *GrayimgView = [[UIImageView alloc]init];
                CGFloat imgX = j  * imgW;
                GrayimgView.frame = CGRectMake(imgX, 0, imgW, imgH);
                [GrayimgView setImage:[UIImage imageNamed:@"灰五星"]];
                
                [self addSubview:GrayimgView];
            }
        }
    }
    return self;
}

@end
