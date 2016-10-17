//
//  DFSettingHeader.m
//  点范
//
//  Created by Masteryi on 2016/10/15.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFSettingHeader.h"
#import "DFUser.h"
#import "UIImageView+WebCache.h"

@implementation DFSettingHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景"]];
    imgView.frame = self.frame;
    [self addSubview:imgView];
    
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.frame = CGRectMake(0,0, 62 , 62);
    iconView.df_centerX = self.df_centerX;
    iconView.df_centerY = self.df_centerY;
    //设置为圆形
    iconView.layer.cornerRadius = iconView.frame.size.width/2;
    iconView.layer.masksToBounds = YES;
    //  给头像加一个圆形边框
    iconView.layer.borderWidth = 1.5f;
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    [iconView sd_setImageWithURL:[NSURL URLWithString:[DFUser sharedManager].icon] placeholderImage:nil options:SDWebImageProgressiveDownload];
    [self addSubview:iconView];
    
    //用户名
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(iconView.df_right + DFMargin,0,130,10);
    label.df_centerY = iconView.df_centerY;
    NSString *number = [DFUser sharedManager].username;
    //NSString *account = [NSString stringWithFormat:@"%@****%@",[number substringToIndex:3],[number substringFromIndex:7]];
    //label.text = account;
    BOOL isNumber = [NSString isPureInt:number];
    if (isNumber == YES) {
        NSString *account = [NSString stringWithFormat:@"%@****%@",[number substringToIndex:3],[number substringFromIndex:7]];
        label.text = account;
    }else{
        label.text = number;
    }
    
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];

}


@end
