//
//  DFTempWebViewController.m
//  点范
//
//  Created by Masteryi on 2016/9/28.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFTempWebViewController.h"
#import "SVProgressHUD.h"

@interface DFTempWebViewController ()

@end

@implementation DFTempWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"模板编剧";
    [self setWebView];
}

- (void)setWebView{
    [SVProgressHUD show];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.df_width, self.view.df_height - 64)];
    NSString *urlstring = [NSString stringWithFormat:@"http://10.0.0.30:8080/template.htm?dishTemplatePageResultId=%@&token=4baa3bb7-d6aa-4d57-a2dd-d5597980f4d8",self.reultID];
   
    NSURL *url = [NSURL URLWithString:urlstring];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
    [SVProgressHUD dismiss];
}


@end
