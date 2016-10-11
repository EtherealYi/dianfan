//
//  DFDataView.m
//  点范
//
//  Created by Masteryi on 16/9/19.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFDataView.h"
#import "PNChart.h"

@interface DFDataView()



@end

@implementation DFDataView

- (void)awakeFromNib{
    [super awakeFromNib];
    CGFloat barWidth= fDeviceWidth - 170;
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0,0, barWidth , 75)];
    [barChart setXLabels:@[@"8",@"9",@"10",@"11",@"12",@"13",@"14"]];
    [barChart setYValues:@[@1,@2,@3,@4,@5,@6,@7]];
    //是否显示数字
    barChart.isShowNumbers = NO;
    barChart.showLabel = YES;
    barChart.chartMarginTop = 10;
    barChart.chartMarginBottom = 10;
    barChart.displayAnimated = NO;
    barChart.chartMarginRight = 0;
    barChart.labelMarginTop = 10.0;
    barChart.chartMarginLeft = 30;
    barChart.barMargin = 50;
    
    CGFloat barM = barWidth / 7 - 3;
    CGFloat barW = barM - DFMargin;
    barChart.barWidth = barW;
    //barChart.xLabelWidth = barM;
    
    [barChart strokeChart];
    [self.chartView addSubview:barChart];
}

- (void)test{
    PNBarChart * barChart = [[PNBarChart alloc]initWithFrame:CGRectMake(0, 0, self.chartView.df_width, self.chartView.df_height)];
    //barChart.backgroundColor = [UIColor grayColor];
//    barChart.chartMarginBottom = 0;
    barChart.chartMarginTop = 10;
//    barChart.chartMarginLeft = 0;
    barChart.barWidth = 10;
    //[barChart setXLabels:@[@"1",@"2",@"3",@"4"]];
    [barChart setYValues:@[@1,@2,@3,@4,@5,@6,@7]];
    
    [barChart strokeChart];
    [self.chartView addSubview:barChart];
}
@end
