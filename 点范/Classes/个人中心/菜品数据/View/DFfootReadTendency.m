//
//  DFfootReadTendency.m
//  点范
//
//  Created by Masteryi on 2016/10/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFfootReadTendency.h"
#import "DFStarView.h"
#import "PNChart.h"

@interface DFfootReadTendency()

@property (weak, nonatomic) IBOutlet UIView *TemdencyView;

@end

@implementation DFfootReadTendency

- (void)setupTendency{
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0,0, fDeviceWidth , 118)];
    [barChart setXLabels:@[@"8.1",@"8.2",@"8.3",@"8.4",@"8.5",@"8.6",@"8.7",@"8.8",@"8.9",@"8.10",@"8.11",@"8.12"]];
    [barChart setYValues:@[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12]];
    //是否显示数字
    barChart.isShowNumbers = NO;
    barChart.showLabel = YES;
    barChart.chartMarginTop = 10;
    barChart.chartMarginBottom = 10;
    barChart.displayAnimated = NO;
    barChart.labelMarginTop = 10.0;
    barChart.chartMarginLeft = 30;
    
    barChart.yLabelSum = 1;
    
    CGFloat barM = fDeviceWidth / 12 - 3;
    CGFloat barW = barM - DFMargin;
    barChart.barWidth = barW;
    //barChart.xLabelWidth = barM;
    
    [barChart strokeChart];
    [self.TemdencyView addSubview:barChart];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userInteractionEnabled = NO;
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
