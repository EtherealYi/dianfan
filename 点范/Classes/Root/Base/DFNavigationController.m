//
//  DFNavigationController.m
//  点范
//
//  Created by Masteryi on 16/9/5.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFNavigationController.h"
#import "DFCommon.h"



@interface DFNavigationController ()

@end

@implementation DFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置背景
    [[UINavigationBar appearance]setBackgroundImage:[DFCommon creatImageWithColor:MainColor] forBarMetrics:UIBarMetricsDefault];
    
    //设置文字颜色
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
   
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        UIButton *backButon = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButon setImage:[UIImage imageNamed:@"返回键"] forState:UIControlStateNormal];
        
//        [backButon setTitle:@"返回" forState:UIControlStateNormal];
//        backButon.titleLabel.font = [UIFont systemFontOfSize:15];
        [backButon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButon setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButon sizeToFit];
        backButon.contentEdgeInsets=UIEdgeInsetsMake(3, -2, 3, 2);
        [backButon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButon];
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back{
    [self popViewControllerAnimated:YES];
}

@end
