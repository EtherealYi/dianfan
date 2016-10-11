//
//  DFGeneralComment.m
//  点范
//
//  Created by Masteryi on 2016/10/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFGeneralComment.h"
#import "JXBarChartView.h"
#import "Masonry.h"
#import "DFStarView.h"

@interface DFGeneralComment()
/** 好 */
@property (weak, nonatomic) IBOutlet UIImageView *goodView;
/** 不好 */
@property (weak, nonatomic) IBOutlet UIImageView *badView;
/** 竖线 */
@property (weak, nonatomic) IBOutlet UIView *line;
/** 分数 */
@property (weak, nonatomic) IBOutlet UILabel *SoreLab;

@end

@implementation DFGeneralComment

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userInteractionEnabled = NO;
    
    //好
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:@6, nil];
    CGRect frame = CGRectMake(0, 0, 100, 20);
    CGFloat barMax = 100;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 0.5, 1.0};
    CGFloat colorComponents[] = {
        210/255.0, 53/255.0, 38/255.0, 1.0,
    };
    size_t count = 1;
    CGGradientRef Gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, locations, count);
    JXBarChartView *barChartView = [[JXBarChartView alloc] initWithFrame:frame startPoint:CGPointMake(5, 10) values:values maxValue:10 textIndicators:nil textColor:MainColor barHeight:10 barMaxWidth:barMax gradient:Gradient];
    
    [self addSubview:barChartView];
    
    //不好
    NSMutableArray *badvalues = [[NSMutableArray alloc] initWithObjects:@4, nil];
    CGColorSpaceRef badcolorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat badcolorComponents[] = {
        164/255.0, 159/255.0, 171/255.0, 1.0,
    };
    CGGradientRef badGradient = CGGradientCreateWithColorComponents(badcolorSpace, badcolorComponents, locations, count);
    JXBarChartView *badbarChartView = [[JXBarChartView alloc] initWithFrame:frame startPoint:CGPointMake(5, 10) values:badvalues maxValue:10 textIndicators:nil textColor:[UIColor grayColor]barHeight:10 barMaxWidth:barMax gradient:badGradient];
    [self addSubview:badbarChartView];
    
    //星星
    CGRect startFrame = CGRectMake(100, 20, 60, 12);
    DFStarView *starView_1 = [[DFStarView alloc]initFrame:startFrame starCount:5];
    [self addSubview:starView_1];
    DFStarView *starView_2 = [[DFStarView alloc]initFrame:startFrame starCount:4];
   [self addSubview:starView_2];
    DFStarView *starView_3 = [[DFStarView alloc]initFrame:startFrame starCount:2];
    [self addSubview:starView_3];
    DFStarView *starView_4 = [[DFStarView alloc]initFrame:startFrame starCount:1];
    [self addSubview:starView_4];
    DFStarView *starView_5 = [[DFStarView alloc]initFrame:startFrame starCount:0];
    [self addSubview:starView_5];
    
    DFStarView *bottomStar = [[DFStarView alloc]initFrame:CGRectMake(0, 0, 90, 18) starCount:3];
    [self addSubview:bottomStar];
    
    //星星进度条
    NSMutableArray *values_1 = [[NSMutableArray alloc] initWithObjects:@9, nil];
     JXBarChartView *ChartView_1 = [[JXBarChartView alloc] initWithFrame:frame startPoint:CGPointMake(0, 1) values:values_1 maxValue:10 textIndicators:nil textColor:MainColor barHeight:10 barMaxWidth:barMax gradient:Gradient];
    [self addSubview:ChartView_1];
    
    NSMutableArray *values_2 = [[NSMutableArray alloc] initWithObjects:@4, nil];
    JXBarChartView *ChartView_2 = [[JXBarChartView alloc] initWithFrame:frame startPoint:CGPointMake(0, 1) values:values_2 maxValue:10 textIndicators:nil textColor:MainColor barHeight:10 barMaxWidth:barMax gradient:Gradient];
    [self addSubview:ChartView_2];
    
    NSMutableArray *values_3 = [[NSMutableArray alloc] initWithObjects:@3, nil];
    JXBarChartView *ChartView_3 = [[JXBarChartView alloc] initWithFrame:frame startPoint:CGPointMake(0, 1) values:values_3 maxValue:10 textIndicators:nil textColor:MainColor barHeight:10 barMaxWidth:barMax gradient:Gradient];
    [self addSubview:ChartView_3];
    
    NSMutableArray *values_4 = [[NSMutableArray alloc] initWithObjects:@2, nil];
    JXBarChartView *ChartView_4 = [[JXBarChartView alloc] initWithFrame:frame startPoint:CGPointMake(0, 1) values:values_4 maxValue:10 textIndicators:nil textColor:MainColor barHeight:10 barMaxWidth:barMax gradient:Gradient];
    [self addSubview:ChartView_4];
    
    NSMutableArray *values_5 = [[NSMutableArray alloc] initWithObjects:@1, nil];
    JXBarChartView *ChartView_5 = [[JXBarChartView alloc] initWithFrame:frame startPoint:CGPointMake(0, 1) values:values_5 maxValue:10 textIndicators:nil textColor:MainColor barHeight:10 barMaxWidth:barMax gradient:Gradient];
    [self addSubview:ChartView_5];
    
    
    
    //约束
    [barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodView.mas_right).offset(-25);
        //make.centerY.equalTo(self.goodView.mas_centerY);
        make.centerY.equalTo(self.goodView.mas_centerY).offset(-3);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [badbarChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.badView.mas_right).offset(-25);
        make.top.equalTo(self.badView.mas_top).offset(-7);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [starView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_top).offset(-10);
        make.left.equalTo(self.line.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(60, 12));
    }];
    [starView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(starView_1.mas_left);
        make.top.equalTo(starView_1.mas_bottom).offset(1);
        make.size.mas_equalTo(CGSizeMake(60, 12));
    }];
    [starView_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(starView_1.mas_left);
        make.top.equalTo(starView_2.mas_bottom).offset(1);
        make.size.mas_equalTo(CGSizeMake(60, 12));
    }];
    [starView_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(starView_1.mas_left);
        make.top.equalTo(starView_3.mas_bottom).offset(1);
        make.size.mas_equalTo(CGSizeMake(60, 12));
    }];
    [starView_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(starView_1.mas_left);
        make.top.equalTo(starView_4.mas_bottom).offset(1);
        make.size.mas_equalTo(CGSizeMake(60, 12));
    }];
    [ChartView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(starView_1.mas_right).offset(-20);
        make.centerY.equalTo(starView_1.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 12));
    }];
    [ChartView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ChartView_1.mas_left);
        make.centerY.equalTo(starView_2.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 12));
    }];
    [ChartView_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ChartView_1.mas_left);
        make.centerY.equalTo(starView_3.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 12));
    }];
    [ChartView_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ChartView_1.mas_left);
        make.centerY.equalTo(starView_4.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 12));
    }];
    [ChartView_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ChartView_1.mas_left);
        make.centerY.equalTo(starView_5.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 12));
    }];
    
    [bottomStar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.SoreLab.mas_left).offset(-10);
        make.centerY.equalTo(self.SoreLab.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(90, 18));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
