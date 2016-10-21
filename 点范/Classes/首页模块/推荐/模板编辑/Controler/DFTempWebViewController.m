//
//  DFTempWebViewController.m
//  点范
//
//  Created by Masteryi on 2016/9/28.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFTempWebViewController.h"
#import "SVProgressHUD.h"
#import "DFUser.h"
#import "DFPrewViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface DFTempWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic,weak) JSContext * context;

@end

@implementation DFTempWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"模板编辑";
    //右边按钮
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setText:@"预览" andFont:15 andColor:WhiteColor];
    [buyBtn addTarget:self action:@selector(toPrewCtr) forControlEvents:UIControlEventTouchUpInside];
    [buyBtn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buyBtn];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    [self setWebView];
}

- (void)setWebView{
    [SVProgressHUD show];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.df_width, self.view.df_height - 64)];
    NSString *urlstring = [NSString stringWithFormat:@"http://10.0.0.30:8080/template.htm?dishTemplatePageResultId=%@&token=%@",self.reultID,[DFUser sharedManager].token];
   
    NSURL *url = [NSURL URLWithString:urlstring];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.delegate = self;
    //[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"WebInterface.preview()"]];
    self.webView = webView;
    [self.view addSubview:webView];
    [SVProgressHUD dismiss];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    self.context[@"WebInterface"] = ^(){
        NSLog(@"stop");
    };
    
}


- (void)toPrewCtr{
    DFPrewViewController *prewCtr = [[DFPrewViewController alloc]init];
    [self.navigationController pushViewController:prewCtr animated:YES];
}

@end
