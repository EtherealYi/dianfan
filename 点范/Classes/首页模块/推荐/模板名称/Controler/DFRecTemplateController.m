//
//  DFRecTemplateController.m
//  点范
//
//  Created by Masteryi on 16/9/12.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFRecTemplateController.h"
#import "DFeditTempalteController.h"
#import "UIImageView+WebCache.h"
#import "DFBuyTempController.h"
#import "DFUser.h"

@interface DFRecTemplateController ()

@end

@implementation DFRecTemplateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"模块名称";
    //右边按钮
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setText:@"购买" andFont:15 andColor:WhiteColor];

    [buyBtn addTarget:self action:@selector(toBuyController) forControlEvents:UIControlEventTouchUpInside];
  
    [buyBtn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buyBtn];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    [self setImageView];


    //设置中间按钮
    UIButton *button = [[UIButton alloc]init];
    
    button.frame = CGRectMake(0, 0, 50, 50);
    button.df_centerX = self.view.df_centerX;
    button.df_bottom = self.view.df_height - 100;
    button.alpha = 0.9;
    [button setImage:[UIImage imageNamed:@"试用"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)setImageView{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 0, self.view.df_width, self.view.df_height);
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imgName] placeholderImage:nil options:SDWebImageProgressiveDownload];
    [self.view addSubview:imageView];
}

- (void)toBuyController{
    DFBuyTempController *buyTemp = [[DFBuyTempController alloc]init];
    [self.navigationController pushViewController:buyTemp animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClick{

    DFeditTempalteController *edit = [[DFeditTempalteController alloc]init];
    //edit.recModel = self.recModel;
    edit.rec_id = self.rec_id;
    [self.navigationController pushViewController:edit animated:YES];
}

@end
