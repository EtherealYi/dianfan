//
//  DFStoreView.m
//  点范
//
//  Created by Masteryi on 16/9/21.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFStoreView.h"
#import "Masonry.h"
#import "AMAnimatedNumber.h"

@implementation DFStoreView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //日按钮
        UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [dateBtn setText:@"日" andFont:16 andColor:WhiteColor];
        [self addSubview:dateBtn];
        
        //月按钮
        UIButton *monthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [monthBtn setText:@"月" andFont:16 andColor:WhiteColor];
        [self addSubview:monthBtn];
        //年
        UIButton *yearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [yearBtn setText:@"年" andFont:16 andColor:WhiteColor];
        [self addSubview:yearBtn];
        
        //数字标题
        AMAnimatedNumber *numLabel =  [[AMAnimatedNumber alloc]initWithFrame:CGRectMake(20, 60, 150, 35)];
        [numLabel setTextFont:[UIFont boldSystemFontOfSize:35]];
        [numLabel setTextColor:[UIColor whiteColor]];
        [numLabel setNumbers:@" 3,334" animated:YES direction:AMAnimateNumberDirectionUp];
        [self addSubview:numLabel];
        
        //中间竖线
        UIView *centerView = [[UIView alloc]init];
        centerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:centerView];
        
        //浏览文本
        UILabel *readLabel = [[UILabel alloc]init];
        [readLabel setText:@"浏览量" andFont:13 andColor:[UIColor whiteColor]];
        [self addSubview:readLabel];
        
        //日期文本
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [timeBtn setText:dateString andFont:16 andColor:[UIColor whiteColor]];
        [self addSubview:timeBtn];
        self.timeBtn = timeBtn;
    
        //分享文本
        AMAnimatedNumber *shareLabel =  [[AMAnimatedNumber alloc]initWithFrame:CGRectMake(0, 60, 120, 35)];
        shareLabel.df_right = self.df_width - 20;
        [shareLabel setTextFont:[UIFont boldSystemFontOfSize:35]];
        [shareLabel setTextColor:[UIColor whiteColor]];
        [shareLabel setNumbers:@" 1424" animated:YES direction:AMAnimateNumberDirectionUp];
        [self addSubview:shareLabel];
        
        //分享标题
        UILabel *shareNum = [[UILabel alloc]init];
        [shareNum setText:@"次分享" andFont:14 andColor:[UIColor whiteColor]];
        [self addSubview:shareNum];
        
        //日期标题约束
        [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.top.equalTo(self).offset(20);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        [monthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(dateBtn.mas_top);
            make.left.equalTo(dateBtn.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        [yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(dateBtn.mas_top);
            make.left.equalTo(monthBtn.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
//        //流量数字约束
//        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(leftLabel).offset(20);
//            make.top.equalTo(leftLabel.mas_bottom).offset(20);
//            make.size.mas_equalTo(CGSizeMake(100, 30));
//        }];
        
        //中间竖线约束
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(5);
            make.size.mas_equalTo(CGSizeMake(2, 70));
        }];
        
        //浏览标题约束
        [readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(numLabel.mas_centerX);
            make.top.equalTo(numLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(50, 20));
            
        }];
        
        //日期文本约束
        [timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-30);
            make.top.equalTo(dateBtn.mas_top);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        
        //分享文本约束
//        [shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.width.equalTo(numLabel.mas_width);
////            make.height.equalTo(numLabel.mas_height);
//            make.size.mas_equalTo(CGSizeMake(60, 30));
//            make.right.equalTo(timeLabel.mas_right).offset(-30);
//            make.top.equalTo(timeLabel.mas_bottom).offset(20);
//        }];
//        
        [shareNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(shareLabel.mas_centerX);
            make.width.equalTo(readLabel.mas_width);
            make.height.equalTo(readLabel.mas_height);
            make.top.equalTo(shareLabel.mas_bottom).offset(10);
        }];
    }
    return self;
}
@end
