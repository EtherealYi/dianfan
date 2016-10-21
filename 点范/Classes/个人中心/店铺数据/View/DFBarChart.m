//
//  DFBarChart.m
//  点范
//
//  Created by Masteryi on 2016/9/22.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFBarChart.h"
#import "PNChart.h"

@interface DFBarChart()

@property (weak, nonatomic) IBOutlet UIView *barView;

@end

@implementation DFBarChart

- (void)awakeFromNib{
    [super awakeFromNib];
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:DFColor(250, 187, 115) description:nil],
                       [PNPieChartDataItem dataItemWithValue:40 color:DFColor(91, 197, 195) description:nil],
                       ];
    
    
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(DFMargin/2, DFMargin/2, 110, 110) items:items];
    pieChart.hideValues = YES;
    pieChart.userInteractionEnabled = NO;
    //    pieChart.descriptionTextColor = [UIColor whiteColor];
    //    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:13.0];
    [pieChart strokeChart];
    //pieChart.displayAnimated = NO;
    [self.barView addSubview:pieChart];
    self.pieChart = pieChart;

}

- (void)setBarView{
//    CGFloat barW = self.barView.df_height ;
//    NSLog(@"%f",barW);
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:DFColor(250, 187, 115) description:nil],
                       [PNPieChartDataItem dataItemWithValue:40 color:DFColor(91, 197, 195) description:nil],
                       ];
    
    
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(DFMargin/2, DFMargin/2, 110, 110) items:items];
    pieChart.hideValues = YES;
    pieChart.userInteractionEnabled = NO;
//    pieChart.descriptionTextColor = [UIColor whiteColor];
//    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:13.0];
    [pieChart strokeChart];
    //pieChart.displayAnimated = NO;
    [self.barView addSubview:pieChart];
    self.pieChart = pieChart;
}
@end
