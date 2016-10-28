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
#import "SVProgressHUD.h"
#import "DFJSObject.h"

@interface DFTempWebViewController ()<UIWebViewDelegate,JSObjectProtocol>

@property (nonatomic,strong)UIWebView *webView;

//@property (nonatomic,weak) JSContext * context;

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
    NSString *urlstring = [NSString stringWithFormat:@"http://10.0.0.30:8080/template.htm?dishTemplatePageResultId=%@&token=%@",self.PageID,[DFUser sharedManager].token];
   
    NSURL *url = [NSURL URLWithString:urlstring];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.delegate = self;
    //[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"WebInterface.preview()"]];
    self.webView = webView;
    [self.view addSubview:webView];
    [SVProgressHUD dismiss];
}

/**
 开始加载
 */
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
    
}

/**
 加载完成
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];

     JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
 
    
    DFJSObject *testJO=[DFJSObject new];
    context[@"WebInterface"]=testJO;
    
    NSString *alertJS=@"WebInterface.preview()"; //准备执行的js代码
    //[context evaluateScript:alertJS];//通过oc方法调用js的alert
    [context evaluateScript:alertJS];
    
    
}

- (void)preview{
//    NSLog(@"调用了");
}


- (void)toPrewCtr{
    DFPrewViewController *prewCtr = [[DFPrewViewController alloc]init];
    prewCtr.dishTemplateResultId = self.dishTemplateResultId;
    [self.navigationController pushViewController:prewCtr animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

@end
