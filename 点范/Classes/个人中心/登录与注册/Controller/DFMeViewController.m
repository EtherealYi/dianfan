//
//  DFMeViewController.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFMeViewController.h"
#import "LoginViewController.h"
#import "DFNavigationController.h"

@interface DFMeViewController ()

@end

@implementation DFMeViewController

static NSString * const HeaderID =@"header";
static NSString * const CellID = @"Me";

#pragma mark -初始化
- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"backback" object:nil];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"个人中心";
   
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HeaderID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    [self setupHeader];

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setupHeader{
    //头部视图
    UIView *headView = [[UIView alloc]init];
    headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150 );
    
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderID];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //背景图片
    UIImageView *bmgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景"]];
    bmgView.frame = headView.frame;

    [cell.contentView addSubview:bmgView];
    //头部view点击事件
    UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LoginClick)];
    
    [cell addGestureRecognizer:tapGeture];
    
    cell.frame = headView.frame;
    
    //设置cell的内容
    //头像
    UIImage *icon = [UIImage imageNamed:@"头像"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:icon];
    
    CGFloat imgH = icon.size.height * 0.5;
    imageView.frame = CGRectMake(DFMargin * 2,cell.df_centerY - imgH * 0.5 , icon.size.width * 0.5, imgH);
    //文字
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(imageView.df_right + DFMargin, cell.df_centerY - imgH * 0.5 , cell.df_width - imageView.df_right - DFMargin, 60);
    label.text = @"你还没登录，\n请登录查看更多信息";
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:label];
    
    self.tableView.tableHeaderView = cell;

}
#pragma mark -点击事件
- (void)LoginClick{
    LoginViewController *login = [[LoginViewController alloc]init];
    DFNavigationController *loginNav = [[DFNavigationController alloc]initWithRootViewController:login];
    [self presentViewController:loginNav animated:YES completion:nil];
}

- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        
    
    //右边箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //字体大小
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"意见反馈";
            UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
            lbl.frame = CGRectMake(cell.frame.origin.x + 10, cell.frame.size.height - 5, cell.frame.size.width - 20, 1);
            lbl.backgroundColor =  [UIColor colorWithWhite:0.4 alpha:0.1];
            [cell.contentView addSubview:lbl];
            
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"商务合作";
            UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
            lbl.frame = CGRectMake(cell.frame.origin.x + 10, cell.frame.size.height - 5, cell.frame.size.width - 20, 1);
            lbl.backgroundColor =  [UIColor colorWithWhite:0.4 alpha:0.1];
            [cell.contentView addSubview:lbl];
        }else{
            cell.textLabel.text = @"关于我们";
        }
    }
    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO]; 
}

@end
