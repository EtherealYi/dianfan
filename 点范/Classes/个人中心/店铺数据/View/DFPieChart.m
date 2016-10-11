//
//  DFPieChart.m
//  点范
//
//  Created by Masteryi on 2016/9/22.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFPieChart.h"
#import "PNChart.h"

@implementation DFPieChart

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0,0, frame.size.width , frame.size.height)];
        [barChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
        [barChart setYValues:@[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12]];
        //是否显示数字
        barChart.isShowNumbers = NO;

        CGFloat barM = frame.size.width / 12 - 3;
        CGFloat barW = barM - DFMargin;
        barChart.chartMarginLeft = 30;
        barChart.showLabel = NO;
        barChart.barWidth = barW;
        //barChart.xLabelWidth = barM;
        
        barChart.chartMarginTop = 10;
        barChart.chartMarginBottom = 10;
        barChart.displayAnimated = NO;
        [barChart strokeChart];
        [self addSubview:barChart];
        
    }
    return self;
}

@end
