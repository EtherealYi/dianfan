//
//  DFIdeaBackViewController.m
//  点范
//
//  Created by Masteryi on 2016/10/25.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFIdeaBackViewController.h"

@interface DFIdeaBackViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong)UILabel *lb;


@end

@implementation DFIdeaBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn setText:@"提交" andFont:17 andColor:WhiteColor];
    [messageBtn sizeToFit];
    //messageBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0,0, 0);
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc]initWithCustomView:messageBtn];
    self.navigationItem.rightBarButtonItem = messageItem;
    
    self.lb = [[UILabel alloc] initWithFrame:CGRectMake(6, -6, 100, 50)];
    self.lb.text = @"写下你的意见";
    self.lb.font = BaseFont(16);
    self.lb.enabled = NO;
    //self.lb.backgroundColor = [UIColor grayColor];
//    [self.textView addSubview:self.lb];
    
    self.textView.font = [UIFont systemFontOfSize:16];
    
    self.textView.delegate = self;
    
    //获取手机当前信息
    
    //系统名称
    NSString *strSysName = [[UIDevice currentDevice] systemName];

    //系统版本号
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];

    //手机型号
    NSString *phone = [NSString iphoneType];
    
    NSString *version = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    NSString *message = [NSString stringWithFormat:@"应用版本 %@,系统 %@ %@,手机型号 %@,意见:",version,strSysName,strSysVersion,phone];
    self.textView.text = message;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   
        [self.textView becomeFirstResponder];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];//按回车取消第一相应者
    }
    return YES;
}

//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    if (textView.text.length <= 0) {
//        self.lb.alpha = 1;
//    }
//    self.lb.alpha = 0;//开始编辑时
//    return YES;
//}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
//        self.lb.alpha = 1;
    }
    self.lb.alpha = 0;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{//将要停止编辑(不是第一响应者时)
    if (textView.text.length == 0) {
//        self.lb.alpha = 1;
    }
    return YES;
}
@end
