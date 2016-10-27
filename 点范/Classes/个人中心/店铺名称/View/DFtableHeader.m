//
//  DFtableHeader.m
//  点范
//
//  Created by Masteryi on 16/9/21.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFtableHeader.h"
#import "Masonry.h"



@implementation DFtableHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = MainColor;
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(DFMargin, 0, 100, 44);
        [label setText:@"菜品排行榜" andFont:14 andColor:WhiteColor];
        
        [self addSubview:label];
        
        //点餐按钮
        UIButton *orderBtn = [[UIButton alloc]init];
        [orderBtn setText:@"点餐量" andFont:14 andColor:WhiteColor];
        [self addSubview:orderBtn];
        self.orderBtn = orderBtn;
        
        //点评按钮
        UIButton *commentBtn = [[UIButton alloc]init];
        [commentBtn setText:@"点评量" andFont:14 andColor:WhiteColor];
        [self addSubview:commentBtn];
        self.commentBtn = commentBtn;
        
        //浏览按钮
        UIButton *readBtn = [[UIButton alloc]init];
        [readBtn setText:@"浏览量" andFont:14 andColor:WhiteColor];
        [self addSubview:readBtn];
        self.readBtn = readBtn;
        
        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = WhiteColor;
        line1.frame = CGRectMake(5, 0, 2, 44);
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc]init];
        line2.backgroundColor = WhiteColor;
        line2.frame = CGRectMake(5, 0, 2, 15);
        [self addSubview:line2];
        
        //点餐约束
        [orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.right.equalTo(self).offset(-20);
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderBtn.mas_top).offset(15);
            //make.height.equalTo(orderBtn.mas_height);
            make.right.equalTo(orderBtn.mas_left).offset(-8);
            make.size.mas_equalTo(CGSizeMake(1, 15));
        }];
        
        //点评约束
        [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderBtn.mas_top);
            make.height.equalTo(self.mas_height);
            make.right.equalTo(line1.mas_left).offset(-8);
        }];
        
        
       
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line1.mas_top);
            
            make.right.equalTo(commentBtn.mas_left).offset(-8);
            make.size.mas_equalTo(CGSizeMake(1, 15));
        }];

        //浏览约束
        [readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderBtn.mas_top);
            make.height.equalTo(self.mas_height);
            make.right.equalTo(line2.mas_left).offset(-8);
        }];
        
    }
    return self;
}

@end
