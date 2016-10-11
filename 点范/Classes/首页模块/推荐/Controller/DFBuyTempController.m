//
//  DFBuyTempController.m
//  点范
//
//  Created by Masteryi on 2016/9/29.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFBuyTempController.h"
#import "DFButton.h"
#import "DFbuyheaderCell.h"
#import "DFbuyContentCell.h"
#import "DFPayViewCell.h"
#import "DFUser.h"
#import "DFHTTPSessionManager.h"

@interface DFBuyTempController ()
/** 名称数组 */
@property (nonatomic,strong)NSArray *nameArray;
/** 内容数组 */
@property (nonatomic,strong)NSArray *contentArray;
/** 支付方式 */
@property (nonatomic,strong)NSArray *payArray;
/** 网络管理 */
@property (nonatomic,strong)DFHTTPSessionManager *manager;

@end

@implementation DFBuyTempController

static NSString *const buyCell = @"buyCell";

#pragma mark - 懒加载
- (NSArray *)payArray{
    if (!_payArray) {
        _payArray = [NSArray array];
    }
    return _payArray;
}
- (NSArray *)contentArray{
    if (!_contentArray) {

        _contentArray = [NSArray array];
        
    }
    return _contentArray;
}
- (NSArray *)nameArray{
    if (!_nameArray) {

        _nameArray = [NSArray array];
    }
    return _nameArray;
}
- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma  mark - 初始化

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买与发布";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:buyCell];

    _nameArray = @[ @"餐厅名称",
                    @"餐厅地址",
                    @"联系人",
                    @"联系电话",
                    @"餐厅类型",
                    @"请上传你的店铺logo",
                     ];
   
    _contentArray = @[
                    @"请输入你的餐厅名称，默认模板信息调出",
                    @"请输入餐厅地址",
                    @"请输入餐厅联系人",
                    @"请输入联系电话",
                    @"请选择餐厅类型",
                    @"",
                      ];
    _payArray = @[
                   @"支付宝支付",
                   @"微信支付"
                  ];
    [self loadcreateTrade];
}

- (void)loadcreateTrade{
    NSString *url = [TradeAPI stringByAppendingString:apiStr(@"createTrade.htm")];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    parmeter[@"dishTemplateId"] = @"5";
    [self.manager GET:url parameters:parmeter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [self.view setNeedsDisplay];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) return 1;
    if (section == 1) return _nameArray.count;
    return _payArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   

    if (indexPath.section == 0) {
        DFbuyheaderCell *header = [DFbuyheaderCell DF_ViewFromXib];
        
        return header;
    }else if(indexPath.section == 1){
        DFbuyContentCell *cell = [DFbuyContentCell DF_ViewFromXib];
       
        cell.nameLab.text = [_nameArray objectAtIndex:indexPath.row];
        cell.placeholderText.placeholder = [_contentArray objectAtIndex:indexPath.row];
        if(indexPath.row == _nameArray.count - 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.placeholderText.enabled = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        DFPayViewCell *payCell = [DFPayViewCell DF_ViewFromXib];
        [payCell.payImg setImage:[UIImage imageNamed:[_payArray objectAtIndex:indexPath.row]]];
        payCell.payLab.text = [_payArray objectAtIndex:indexPath.row];
        payCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
        return payCell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 100;
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView setEditing:NO animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.df_width, 30)];
        headView.backgroundColor = WhiteColor;
        UILabel *headLab = [[UILabel alloc]init];
        headLab.frame = CGRectMake(10, 5, 100, 20);
        [headLab setText:@"发布信息维护" andFont:12 andColor:[UIColor grayColor]];
        [headView addSubview:headLab];
        return headView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    }
    return 10;
}
@end

