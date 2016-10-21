//
//  DFBuySuccessController.m
//  点范
//
//  Created by Masteryi on 2016/10/13.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFBuySuccessController.h"
#import "Masonry.h"
#import "DFAlreadyController.h"
#import "DFBuyTempController.h"
#import "DFNavigationController.h"
#import "DFHomeViewController.h"

@interface DFBuySuccessController ()

@end

@implementation DFBuySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付成功";
    self.view.backgroundColor = WhiteColor;
    [self setChildView];
}

- (void)setChildView{
    //确认图片
    UIImageView *paySuccess = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_mall_pay_succeed"]];
    
    [self.view addSubview:paySuccess];
    
    UILabel *successLab = [[UILabel alloc]init];
   
    [successLab setText:@"支付成功!" andFont:20 andColor:nil];
    successLab.textColor = [UIColor colorWithRed:80/255.0 green:184/255.0 blue:84/255.0 alpha:1];
    [self.view addSubview:successLab];
    
    UILabel *orderLabel = [[UILabel alloc]init];
    [orderLabel setText:[NSString stringWithFormat:@"订单号:%@",self.sn] andFont:14 andColor:[UIColor blackColor]];
    [self.view addSubview:orderLabel];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeBtn setText:@"返回首页" andFont:14 andColor:WhiteColor];
    [homeBtn CornerAndShdow];
    [self.view addSubview:homeBtn];
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setText:@"返回个人中心" andFont:14 andColor:WhiteColor];
    [publishBtn CornerAndShdow];
    [self.view addSubview:publishBtn];

    [homeBtn addTarget:self action:@selector(pushToHome) forControlEvents:UIControlEventTouchUpInside];
    [publishBtn addTarget:self action:@selector(pushToMe) forControlEvents:UIControlEventTouchUpInside];
  
    [homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(35);
    }];
    
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(homeBtn.mas_centerX);
        make.left.equalTo(homeBtn.mas_left);
        make.right.equalTo(homeBtn.mas_right);
        make.top.equalTo(homeBtn.mas_bottom).offset(20);
        make.height.equalTo(homeBtn.mas_height);
    }];
    
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(homeBtn.mas_centerX);
        make.bottom.equalTo(homeBtn.mas_top).offset(-30);
    }];
    [successLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(orderLabel.mas_centerX);
        make.bottom.equalTo(orderLabel.mas_top).offset(-15);
    }];
    
    [paySuccess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(successLab.mas_top).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
  
 

    
}
- (void)pushToHome{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pop" object:nil];
    [UIView animateWithDuration:0.5 animations:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)pushToMe{

//    DFBuyTempController *by = [[DFBuyTempController alloc]init];
//    
//    [UIView animateWithDuration:1.0 animations:^{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
