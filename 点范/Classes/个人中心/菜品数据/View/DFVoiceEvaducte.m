//
//  DFVoiceEvaducte.m
//  点范
//
//  Created by Masteryi on 2016/10/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFVoiceEvaducte.h"
#import "Masonry.h"
#import "JXBarChartView.h"

@interface DFVoiceEvaducte()

@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation DFVoiceEvaducte

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CGRect frame = CGRectMake(0, 0, 100, 20);
    CGFloat barMax = 70;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 0.5, 1.0};
    CGFloat colorComponents[] = {
        210/255.0, 53/255.0, 38/255.0, 1.0,
    };
    size_t count = 1;
    CGGradientRef Gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, locations, count);
    
    
    //性价比不错
    UILabel *priceLab = [[UILabel alloc]init];
    
    [priceLab setText:@"性价比不错" andFont:12 andColor:[UIColor blackColor]];
    [self addSubview:priceLab];
    
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:@6, nil];
    JXBarChartView *priceChartView = [[JXBarChartView alloc]initWithFrame:frame startPoint:CGPointMake(0, 5) values:values maxValue:10 textIndicators:nil textColor:MainColor barHeight:10 barMaxWidth:barMax gradient:Gradient];
    
    [self addSubview:priceChartView];
    //味道很好
    UILabel *tasteLab = [[UILabel alloc]init];
    [tasteLab setText:@"味道很好" andFont:12 andColor:[UIColor blackColor]];
    [self addSubview:tasteLab];
    NSMutableArray *tastevalues = [[NSMutableArray alloc] initWithObjects:@4, nil];
    JXBarChartView *tasteChartView = [[JXBarChartView alloc]initWithFrame:frame startPoint:CGPointMake(0, 5) values:tastevalues maxValue:10 textIndicators:nil textColor:MainColor barHeight:10 barMaxWidth:barMax gradient:Gradient];
    [self addSubview:tasteChartView];
    //下次再来
    UILabel *nextLab = [[UILabel alloc]init];
    [nextLab setText:@"下次再来" andFont:12 andColor:[UIColor blackColor]];
    [self addSubview:nextLab];
    NSMutableArray *nextValues = [[NSMutableArray alloc] initWithObjects:@3, nil];
    JXBarChartView *nextChartView = [[JXBarChartView alloc]initWithFrame:frame startPoint:CGPointMake(0, 5) values:nextValues maxValue:10 textIndicators:nil textColor:MainColor barHeight:10 barMaxWidth:barMax gradient:Gradient];
    [self addSubview:nextChartView];
    
    //菜量够大
    UILabel *footLab = [[UILabel alloc]init];
    [footLab setText:@"菜量够大" andFont:12 andColor:[UIColor blackColor]];
    [self addSubview:footLab];
    NSMutableArray *footValues = [[NSMutableArray alloc] initWithObjects:@7, nil];
    JXBarChartView *footChartView = [[JXBarChartView alloc]initWithFrame:frame startPoint:CGPointMake(0, 5) values:footValues maxValue:10 textIndicators:nil textColor:MainColor barHeight:10 barMaxWidth:barMax gradient:Gradient];
    [self addSubview:footChartView];
    
    //约束
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.line.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];

    [priceChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLab.mas_right).offset(-40);
        make.centerY.equalTo(priceLab.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [tasteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLab.mas_left);
        make.top.equalTo(priceLab.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [tasteChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceChartView.mas_left);
        make.centerY.equalTo(tasteLab.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [nextChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceChartView.mas_top);
        make.right.equalTo(self.mas_right).offset(-15);
         make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [nextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nextChartView.mas_left).offset(30);
        make.centerY.equalTo(nextChartView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    [footLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nextLab.mas_left);
        make.top.equalTo(nextLab.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    [footChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nextChartView.mas_left);
        make.centerY.equalTo(footLab.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
