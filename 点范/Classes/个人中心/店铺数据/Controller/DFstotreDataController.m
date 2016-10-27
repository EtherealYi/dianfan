//
//  DFstotreDataController.m
//  点范
//
//  Created by Masteryi on 2016/9/22.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFstotreDataController.h"
#import "DFStoreView.h"
#import "DFBarChart.h"
#import "DFPieChart.h"
#import "DFHTTPSessionManager.h"
#import "DFUser.h"

@interface DFstotreDataController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)DFHTTPSessionManager *manager;

@property (nonatomic,assign)BOOL isSetup;

@end

@implementation DFstotreDataController

static NSString *const storeData = @"storeData";

- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.title = @"店铺数据";
    [self setHeadView];
    [self setTableView];
    [self loadScanData];
    self.isSetup = NO;
    
}
- (void)loadShareRequest{
    NSString *url = [MemberAPI stringByAppendingString:apiStr(@"loadShareData.htm")];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    parmeter[@"date"] = @"10";
    parmeter[@"month"] = @"10";
    parmeter[@"range"] = @"RANGE_DAY";
    parmeter[@"year"] = @"2016";
    [self.manager POST:url parameters:parmeter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)loadScanData{
    NSString *url = [MemberAPI stringByAppendingString:apiStr(@"loadScanData.htm")];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    parmeter[@"date"]  = @"30";
    parmeter[@"month"] = @"9";
    parmeter[@"range"] = @"RANGE_DAY";
    parmeter[@"year"]  = @"2016";
    [self.manager POST:url parameters:parmeter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucess) {
            
        }else{
            UIAlertController *altrt = [UIAlertController actionWithMessage:MsgMessage];
            [self presentViewController:altrt animated:YES completion:nil];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)setHeadView{
    CGRect frame = CGRectMake(0, 1, self.view.df_width, 148);
    DFStoreView *storeView = [[DFStoreView alloc]initWithFrame:frame];
    storeView.backgroundColor = MainColor;
    [self.view addSubview:storeView];


}
- (void)setTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 160, self.view.df_width, self.view.df_height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
    tableView.sectionFooterHeight = 10;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:storeData];
    
    [self.view addSubview:tableView];
    
}
#pragma mark - UITableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:storeData];
    cell.userInteractionEnabled = NO;
    switch (indexPath.section) {
        case 0:
        {
            DFPieChart *pieChart = [[DFPieChart alloc]initWithFrame:CGRectMake(0, 0, self.view.df_width, 148)];
            [cell.contentView addSubview:pieChart];
        }
            break;
        case 1:{
            self.isSetup = YES;
            DFBarChart *barChart = [DFBarChart DF_ViewFromXib];
            barChart.df_width = cell.df_width;
            barChart.df_height = cell.df_height;
            //[barChart setBarView];
            if (self.isSetup == YES) {
                barChart.pieChart.displayAnimated = NO;
            }
            [cell.contentView addSubview:barChart];
        }
            break;
        case 2:{
            DFPieChart *pieChart = [[DFPieChart alloc]initWithFrame:CGRectMake(0, 0, self.view.df_width, 148)];
            [cell.contentView addSubview:pieChart];
        }
            break;
        case 3:{
            DFBarChart *barChart = [DFBarChart DF_ViewFromXib];
            barChart.df_width = cell.df_width;
            barChart.df_height = cell.df_height;
            [barChart setBarView];
            [cell.contentView addSubview:barChart];
        }
            break;
        default:
            break;
    }


   cell.backgroundColor = MainColor;
 
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"浏览量趋势";
            break;
        case 1:
            return @"浏览量来源";
            break;
        case 2:
            return @"分享趋势";
            break;
         case 3:
            return @"分享来源";
            break;
        default:
            break;
    }
    return @"";

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 148;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor whiteColor];
}
@end
