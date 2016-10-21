//
//  DFfootDataController.m
//  点范
//
//  Created by Masteryi on 16/9/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFfootDataController.h"
#import "PNChart.h"
#import "DFfootDataHeader.h"
#import "DFfootReadTendency.h"
#import "DFVoiceEvaducte.h"
#import "DFGeneralComment.h"
#import "DFQuestionCell.h"
#import "DFHTTPSessionManager.h"
#import "DFfootDataModel.h"
#import "MJExtension.h"
#import "DFUser.h"
#import "DFDishCommentData.h"

@interface DFfootDataController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)DFHTTPSessionManager *manager;

@property (nonatomic,strong)DFfootDataModel *footArrays;

@property (nonatomic,strong)DFDishCommentData *disCommentData;

@property (nonatomic,strong)NSArray *firtArrays;
@property (nonatomic,strong)NSArray *secondArrays;
@property (nonatomic,strong)NSArray *thirdArrays;

@end

@implementation DFfootDataController

static NSString *cellID = @"footData";

- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"菜品数据";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
    [self loadDish];
}

/**
 加载数据
 */
- (void)loadDish{
    NSString *url = [DishAPI stringByAppendingString:apiStr(@"viewDish.htm")];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"id"]    = @"759";
    parameter[@"year"]  = @"2016";
    parameter[@"month"] = @"9";
    parameter[@"data"]  = @"28";
    __weak typeof(self) weakSelf = self;
    [self.manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.footArrays = [DFfootDataModel mj_objectWithKeyValues:responseObject[@"data"]];
        weakSelf.footArrays.stroreFoot = [DFStoreViewModel mj_objectWithKeyValues:responseObject[@"data"][@"dish"]];
        weakSelf.footArrays.areaModel = [DFAreaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"areaAndRatio"]];
        weakSelf.footArrays.genderRatio = [DFGenderRatio mj_objectWithKeyValues:responseObject[@"data"][@"genderRatio"]];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    NSString *dishUrl = [DishAPI stringByAppendingString:apiStr(@"loadDishCommentData.htm")];
    [self.manager POST:dishUrl parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        weakSelf.disCommentData = [DFDishCommentData mj_objectWithKeyValues:responseObject[@"data"]];
        weakSelf.disCommentData.countAndRation = [DFCountAndRatio mj_objectWithKeyValues:responseObject[@"data"][@"countAndRatio"]];
        weakSelf.disCommentData.scoreMap = [DFScoreDistributionMap mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"ScoreDistributionMap"]];
        
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma  mark - tableView代理,数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 4) return 2;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DFfootDataHeader *cell = [DFfootDataHeader DF_ViewFromXib];
        cell.userInteractionEnabled = NO;
        cell.footModel = self.footArrays;
        [cell setArea];
        [cell setPNChart];
        return cell;
    }else if (indexPath.section == 1){
        DFfootReadTendency *cell = [DFfootReadTendency DF_ViewFromXib];
        return cell;
    }else if (indexPath.section == 2){
        DFGeneralComment *cell = [DFGeneralComment DF_ViewFromXib];
        cell.dishCommentData = self.disCommentData;
        [cell setupChildView];
        return cell;
    }else if (indexPath.section == 3){
        DFVoiceEvaducte *cell = [DFVoiceEvaducte DF_ViewFromXib];
        return cell;
    }
    DFQuestionCell *cell = [DFQuestionCell DF_ViewFromXib];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 213;
    if (indexPath.section == 1) return 160;
    if (indexPath.section == 2) return 195;
    if (indexPath.section == 3) return 105;
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 4) return 25;
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 4){
        
    UIView *view = [[UIView alloc]init];
    view.backgroundColor= WhiteColor;
    view.frame = CGRectMake(0, 0, fDeviceWidth, 20);
        
        
    UILabel *questionLab = [[UILabel alloc]init];
    questionLab.frame = CGRectMake(10, 5, 60, 20);
    [questionLab setText:@"问卷调查" andFont:12 andColor:[UIColor blackColor]];
    UILabel *numberLab = [[UILabel alloc]init];
    numberLab.frame = CGRectMake(0, 5, 40, 20);
    numberLab.df_x = questionLab.df_width + 2;
    [numberLab setText:@"(124)" andFont:12 andColor:MainColor];
    [view addSubview:numberLab];
    
    [view addSubview:questionLab];
        
        
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(0, 5, 40, 20);
    moreBtn.df_right = fDeviceWidth - 10;
    [moreBtn setText:@"更多" andFont:12 andColor:[UIColor blackColor]];
    [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:moreBtn];
    
    return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    
}

@end
