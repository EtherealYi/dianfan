//
//  DFVersionViewController.m
//  点范
//
//  Created by Masteryi on 2016/10/26.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFVersionViewController.h"

@interface DFVersionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLab;

@end

@implementation DFVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"当前版本";
    self.versionLab.text = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
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
