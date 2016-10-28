//
//  DFDateViewController.m
//  点范
//
//  Created by Masteryi on 2016/10/28.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFDateViewController.h"
#import "NSDate+FSExtension.h"
#import "SSLunarDate.h"
#import "FSCalendar.h"

#define kPink [UIColor colorWithRed:198/255.0 green:51/255.0 blue:42/255.0 alpha:1.0]
#define kBlue [UIColor colorWithRed:31/255.0 green:119/255.0 blue:219/255.0 alpha:1.0]
#define kBlueText [UIColor colorWithRed:14/255.0 green:69/255.0 blue:221/255.0 alpha:1.0]

@interface DFDateViewController ()<FSCalendarDataSource,FSCalendarDelegate>

@property (assign, nonatomic) BOOL subtitle;

@property (nonatomic,strong)FSCalendar *fsCalendar;

@end

@implementation DFDateViewController

- (void)setSubtitle:(BOOL)subtitle{
    if (_subtitle != subtitle) {
        _subtitle = subtitle;
        [self.fsCalendar reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    self.title = @"日历选择";
    self.subtitle = YES;
    
    FSCalendar *fsCalendar = [[FSCalendar alloc]init];
    
    fsCalendar.frame = CGRectMake(0, 0, fDeviceWidth, fDeviceHeight / 2);
    
    fsCalendar.dataSource = self;
    fsCalendar.delegate = self;
    
    [[fsCalendar appearance] setWeekdayTextColor:kBlueText];
    [[fsCalendar appearance] setHeaderTitleColor:MainColor];
//    [[fsCalendar appearance] setEventColor:[UIColor cyanColor]];
    [fsCalendar appearance].eventDefaultColor = [UIColor cyanColor];
    [[fsCalendar appearance] setSelectionColor:kBlue];
    [[fsCalendar appearance] setHeaderDateFormat:@"yyyy-M"];
//    [[fsCalendar appearance] setMinDissolvedAlpha:0.2];
    [fsCalendar appearance].headerMinimumDissolvedAlpha = 0.2;
    [[fsCalendar appearance] setTodayColor:kPink];
//    [[fsCalendar appearance] setUnitStyle:FSCalendarUnitStyleCircle];
    
    [self.view addSubview:fsCalendar];
}

- (NSString *)calendar:(FSCalendar *)calendarView subtitleForDate:(NSDate *)date
{
    return _subtitle ? [[SSLunarDate alloc] initWithDate:date].dayString : nil;
}

- (BOOL)calendar:(FSCalendar *)calendarView hasEventForDate:(NSDate *)date
{
    return date.fs_day == 3;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];

    if (self.block) {
        self.block(destDateString);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
