//
//  DFSettingViewController.m
//  点范
//
//  Created by Masteryi on 2016/10/15.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFSettingViewController.h"
#import "DFSettingHeader.h"
#import "DFUser.h"

@interface DFSettingViewController ()

@property (nonatomic,strong)NSArray *settingArray;

@end

@implementation DFSettingViewController

static NSString * SettingCell = @"SettingCell";

#pragma mark - 懒加载
- (NSArray *)settingArray{
    if (!_settingArray) {
        _settingArray = [NSArray array];
    }
    return _settingArray;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SettingCell];
    _settingArray = @[@"当前版本",
                      @"意见反馈",
                      @"商务合作",
                      @"关于我们",
                      @"退出登录"];
    self.tableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) return 1;
    return _settingArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCell forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:{
            
            DFSettingHeader *header = [[DFSettingHeader alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 150)];
            [cell.contentView addSubview:header];
            
        }
            break;
        case 1:{
            cell.textLabel.text = _settingArray[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
            
        default:
            break;
    }
 
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 150;
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 4) {
            //初始化提示框；
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录？" preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:@"username"];
                [userDefaults removeObjectForKey:@"token"];
                [userDefaults synchronize];
                [[DFUser sharedManager]didLogout];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];

        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
