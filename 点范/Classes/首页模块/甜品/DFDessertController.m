//
//  DFDessertController.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFDessertController.h"

@interface DFDessertController ()

@end

@implementation DFDessertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 100, 50);
    label.df_centerX = self.view.df_centerX;
    label.df_centerY = self.view.df_centerY;
    
    [label setText:@"甜品"];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
