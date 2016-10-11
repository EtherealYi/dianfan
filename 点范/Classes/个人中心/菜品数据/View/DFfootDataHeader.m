//
//  DFfootDataHeader.m
//  点范
//
//  Created by Masteryi on 2016/10/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFfootDataHeader.h"
#import "PNChart.h"
#import "JXBarChartView.h"


@interface DFfootDataHeader()

@property (weak, nonatomic) IBOutlet UIView *boyAndGirl;

@property (weak, nonatomic) IBOutlet UIView *Footfrom;

@end

@implementation DFfootDataHeader

- (void)setupBoy{
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:self.boyAndGirl.bounds];
    barChart.backgroundColor = nil;
    //[barChart setXLabels:@[@"男",@"女"]];
    [barChart setYValues:@[@1,@2]];
    //是否显示数字
    barChart.isShowNumbers = NO;
    //是否显示立体效果
    barChart.isGradientShow = NO;
    
    CGFloat barM = self.boyAndGirl.frame.size.width / 2 - 10;
    CGFloat barW = barM - DFMargin;
    
    barChart.strokeColors = @[[UIColor yellowColor],[UIColor greenColor]];
    barChart.showLabel = NO;
    barChart.chartMarginLeft = 5;
    barChart.barWidth = barW;
    barChart.xLabelWidth = barM;
    barChart.chartMarginTop = 8;
    barChart.chartMarginBottom = 0;
    barChart.barMargin = 0;
    barChart.displayAnimated = NO;
    [barChart strokeChart];
    [self.boyAndGirl addSubview:barChart];
}

- (void)setupFootfrom{
    
    NSMutableArray *textIndicators = [[NSMutableArray alloc] initWithObjects:@"珠海", @"广州", @"深圳", nil];
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:@5, @2, @3, nil];
    CGRect frame = CGRectMake(0, 0, self.Footfrom.df_width, self.Footfrom.df_height);
    CGFloat barMax = self.Footfrom.df_width;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //blue gradient
    CGFloat locations[] = {0.0, 0.5, 1.0};
    CGFloat colorComponents[] = {
        251/255.0, 178/255.0, 107/255.0, 1.0,
    };
    size_t count = 1;
    CGGradientRef Gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, locations, count);
    JXBarChartView *barChartView = [[JXBarChartView alloc] initWithFrame:frame
                                                              startPoint:CGPointMake(5, 10)
                                                                  values:values maxValue:10
                                                          textIndicators:textIndicators
                                                               textColor:[UIColor whiteColor]
                                                               barHeight:10
                                                             barMaxWidth:barMax
                                                                gradient:Gradient];
    
    [self.Footfrom addSubview:barChartView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//+ (instancetype)DF_ViewFromXib{
//    [super DF_ViewFromXib];
//    
//    //return self;
//}


@end
