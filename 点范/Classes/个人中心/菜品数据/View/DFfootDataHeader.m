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
#import "Masonry.h"
#import "DFAreaModel.h"


@interface DFfootDataHeader()

@property (weak, nonatomic) IBOutlet UIView *boyAndGirl;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;

@property (weak, nonatomic) IBOutlet UIView *Footfrom;

@property (weak, nonatomic) IBOutlet UILabel *dishName;
@property (weak, nonatomic) IBOutlet UILabel *dishSn;
@property (weak, nonatomic) IBOutlet UILabel *dishPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boyTolin1;
@property (weak, nonatomic) IBOutlet UILabel *Num;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numtoView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boyTolin2;
@property (nonatomic,strong) NSMutableArray<DFAreaModel *> *areaArrays;
@end

@implementation DFfootDataHeader

- (void)awakeFromNib{
    [super awakeFromNib];
      [self layoutIfNeeded];
    if (fDeviceWidth < 330) {
        self.boyTolin2.constant = -10;
        self.boyTolin1.constant = 0;
        self.Num.df_width = 60;
        self.numtoView.constant = 10;
    }
  
    
    
    
}

- (void)layoutIfNeeded{
    [super layoutIfNeeded];
}

- (void)setPNChart{
    if (self.footModel.genderRatio.MALE || self.footModel.genderRatio.FEMALE) {
        CGFloat frameW = self.df_width * 0.24;
        CGFloat frameH = 65;
        PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, frameW, frameH)];
        
        
        barChart.backgroundColor = nil;
        //[barChart setXLabels:@[@"男",@"女"]];
        CGFloat male   = [self.footModel.genderRatio.MALE floatValue];
        CGFloat female = [self.footModel.genderRatio.FEMALE floatValue];
        [barChart setYValues:@[@(male),@(female)]];
        //是否显示数字
        barChart.isShowNumbers = NO;
        //是否显示立体效果
        barChart.isGradientShow = NO;
        
        CGFloat barM = frameW / 2 - 10;
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

        //结束
    }
    
}



- (void)setArea{
    UIView *view = [[UIView alloc]init];
    [self addSubview:view];
    NSString *string1 = self.areaArrays[0].value1;
    NSString *string2 = self.areaArrays[1].value1;
    
    NSString *ratio1 = self.areaArrays[0].value2;
    NSString *retio2 = self.areaArrays[1].value2;
    CGFloat flo1 = [ratio1 floatValue] * 100;
    CGFloat flo2 = [retio2 floatValue] * 100;
    int in1 = flo1;
    int in2 = flo2;
    
    if (self.areaArrays.count > 0) {
        
    
        NSMutableArray *textIndicators = [[NSMutableArray alloc] initWithObjects:string1, string2, @"无", nil];
        NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:@(in1), @(in2), @0, nil];
        
        
        CGFloat barW = self.df_width * 0.37;
    
        
        CGRect frame = CGRectMake(0, 0, barW, 65);
        CGFloat barMax = self.df_width * 0.38;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        //blue gradient
        CGFloat locations[] = {0.0, 0.5, 1.0};
        CGFloat colorComponents[] = {
            251/255.0, 178/255.0, 107/255.0, 1.0,
        };
        
        size_t count = 1;
        CGGradientRef Gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, locations, count);
        JXBarChartView *barChartView = [[JXBarChartView alloc] initWithFrame:frame startPoint:CGPointMake(5, 10) values:values maxValue:100 textIndicators:textIndicators textColor:[UIColor whiteColor]
                                                                   barHeight:10 barMaxWidth:barMax gradient:Gradient];
        [view addSubview:barChartView];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line2.mas_right).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
            make.height.equalTo(self.line2.mas_height);
            make.top.equalTo(self.line2.mas_top);
        }];

        //结束
    }
}


- (void)setFootModel:(DFfootDataModel *)footModel{
    _footModel = footModel;
    self.dishSn.text = footModel.stroreFoot.name;
    self.dishSn.text = [NSString stringWithFormat:@"#%@",footModel.stroreFoot.sn];
    self.dishPrice.text = [NSString stringWithFormat:@"￥%@",footModel.stroreFoot.price];
    self.areaArrays = self.footModel.areaModel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
