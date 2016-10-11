//
//  DFBarChart.h
//  点范
//
//  Created by Masteryi on 2016/9/22.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"

@interface DFBarChart : UIView

@property (nonatomic,strong)PNPieChart *pieChart;

- (void)setBarView;

@end
