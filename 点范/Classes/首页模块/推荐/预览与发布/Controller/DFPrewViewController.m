//
//  DFPrewViewController.m
//  点范
//
//  Created by Masteryi on 2016/10/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFPrewViewController.h"
#import "DFPublishViewController.h"
#import "DFUser.h"
#import "DFHTTPSessionManager.h"
#import "DFBuyTempController.h"

@interface DFPrewViewController ()

@property (nonatomic,strong)DFHTTPSessionManager *manager;

@end

@implementation DFPrewViewController

#pragma mark - 懒加载
- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预览";
    self.view.backgroundColor = WhiteColor;
    
    //右边按钮
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setText:@"保存" andFont:15 andColor:WhiteColor];
   
    [saveBtn sizeToFit];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    
    UIButton *publisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publisBtn setText:@"发布" andFont:15 andColor:WhiteColor];
    [publisBtn addTarget:self action:@selector(toPublisCtr) forControlEvents:UIControlEventTouchUpInside];
    [publisBtn sizeToFit];
    UIBarButtonItem *publisItem = [[UIBarButtonItem alloc]initWithCustomView:publisBtn];
    self.navigationItem.rightBarButtonItems = @[publisItem,saveItem];
    
 
}
- (void)toPublisCtr{
    NSString *url = [TemplataAPI stringByAppendingString:apiStr(@"pushTemplate.htm")];
    NSMutableDictionary *parmater = [NSMutableDictionary dictionary];
    parmater[@"dishTemplateResultId"] = self.dishTemplateResultId;
    WeakSelf
    [weakSelf.manager GET:url parameters:parmater progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if(sucess){
            DFPublishViewController *publishCtr = [[DFPublishViewController alloc]init];
            [weakSelf.navigationController pushViewController:publishCtr animated:YES];
        }else{
            UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:responseObject[@"data"][@"errMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alter addAction:[UIAlertAction actionWithTitle:@"去付款" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                DFBuyTempController *buyTemp = [[DFBuyTempController alloc]init];
                [weakSelf.navigationController pushViewController:buyTemp animated:YES];
            }]];
            [alter addAction:[UIAlertAction actionWithTitle:@"直接发布" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                DFPublishViewController *publishCtr = [[DFPublishViewController alloc]init];
                [weakSelf.navigationController pushViewController:publishCtr animated:YES];
            }]];
            [weakSelf presentViewController:alter animated:YES completion:nil];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


@end
