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
#import "MJExtension.h"
#import "DFBuyModel.h"
#import "SVProgressHUD.h"
#import "Pingpp.h"
#import "DFBuySuccessController.h"
#import "DFNavigationController.h"

@interface DFBuyTempController (){
    UIAlertView* mAlert;
}
/** 名称数组 */
@property (nonatomic,strong)NSArray *nameArray;
/** 内容数组 */
@property (nonatomic,strong)NSArray *contentArray;
/** 支付方式 */
@property (nonatomic,strong)NSArray *payArray;
/** 网络管理 */
@property (nonatomic,strong)DFHTTPSessionManager *manager;
/** 购买模型 */
@property (nonatomic,strong)DFBuyModel *buyModel;

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(push) name:@"push" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pop) name:@"pop" object:nil];
}

- (void)loadcreateTrade{
    NSString *url = [TradeAPI stringByAppendingString:apiStr(@"createTrade.htm")];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    parmeter[@"dishTemplateId"] = @"5";
    __weak typeof(self) weakSelf = self;
    [self.manager GET:url parameters:parmeter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD show];
        weakSelf.buyModel = [DFBuyModel mj_objectWithKeyValues:responseObject[@"data"][@"trade"][@"dishTemplate"]];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       // NSLog(@"error");
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
    
    switch (indexPath.section) {
        case 0:{
            DFbuyheaderCell *header = [DFbuyheaderCell DF_ViewFromXib];
            header.buyModel = self.buyModel;
            return header;
        }
            break;
        case 1:{
            DFbuyContentCell *cell = [DFbuyContentCell DF_ViewFromXib];
            
            cell.nameLab.text = [_nameArray objectAtIndex:indexPath.row];
            cell.placeholderText.placeholder = [_contentArray objectAtIndex:indexPath.row];
            if(indexPath.row == _nameArray.count - 1) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.placeholderText.enabled = NO;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:{
            DFPayViewCell *payCell = [DFPayViewCell DF_ViewFromXib];
            [payCell.payImg setImage:[UIImage imageNamed:[_payArray objectAtIndex:indexPath.row]]];
            payCell.payLab.text = [_payArray objectAtIndex:indexPath.row];
            payCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return payCell;

        }
            break;
        default:
            break;
    }
    return nil;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 100;
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [self pingApp:@"alipay"];
        }else{
            [self pingApp:@"wx"];
        }
    }
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)showAlertMessage:(NSString*)msg
{
    mAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [mAlert show];
}

- (void)pingApp:(NSString *)channel{
    NSString *amountStr = @"100";
    NSURL* url = [NSURL URLWithString:@"http://218.244.151.190/demo/charge"];
    NSMutableURLRequest * postRequest=[NSMutableURLRequest requestWithURL:url];
    
    NSDictionary* dict = @{
                           @"channel" : channel,
                           @"amount"  : amountStr
                           };
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *bodyData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    DFBuyTempController * __weak weakSelf = self;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:postRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            
            if (httpResponse.statusCode != 200) {
                //NSLog(@"statusCode=%ld error = %@", (long)httpResponse.statusCode, connectionError);
                
                return;
            }
            if (connectionError != nil) {
                //NSLog(@"error = %@", connectionError);
                
                return;
            }
            NSString* charge = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            // NSLog(@"charge = %@", charge);
            [Pingpp createPayment:charge
                   viewController:weakSelf
                     appURLScheme:@"dianfan"
                   withCompletion:^(NSString *result, PingppError *error) {
                       //NSLog(@"completion block: %@", result);
                       if (error == nil) {
                           //NSLog(@"PingppError is nil");
                       } else {
                          // NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                       }
                       [self showAlertMessage:result];
                   }];
        });
    }];
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

- (void)push{
    DFBuySuccessController *buySuccess = [[DFBuySuccessController alloc]init];
    DFNavigationController *Nav = [[DFNavigationController alloc]initWithRootViewController:buySuccess];
    //[self.navigationController pushViewController:buySuccess animated:YES];
    [self presentViewController:Nav animated:YES completion:nil];
}
- (void)pop{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)pushToMe{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"meClick" object:nil];
    
}

- (void)dealloc{
    [SVProgressHUD dismiss];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

