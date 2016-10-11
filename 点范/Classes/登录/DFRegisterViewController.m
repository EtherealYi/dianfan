//
//  DFRegisterViewController.m
//  点范
//
//  Created by Masteryi on 16/9/5.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFRegisterViewController.h"
#import "DFRegisterMessageController.h"
#import "UIButton+DFExtension.h"
#import "AFNetworking.h"

@interface DFRegisterViewController ()
/** 下一页 **/
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
/** 提醒标签 **/
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
/** 输入电话号码 **/
@property (weak, nonatomic) IBOutlet UITextField *phoneText;


@end

@implementation DFRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //添加监听
    self.nextBtn.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.title = @"注册新账号";
    [self.nextBtn CornerAndShdow];
    
    //设置label,提醒信息
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.text = @"你的手机号仅用于接收验证码，我们将不会造成任何形式的泄露，也不会发送垃圾信息。";
 
   
    

   
    
}

//当页面出现的时候清除输入框
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.phoneText.text = nil;
}
#pragma mark -监听事件
-(void)textFieldChanged{
    if (self.phoneText.text.length) {
        self.nextBtn.enabled = YES;
    }else{
        self.nextBtn.enabled = NO;
    }
}

#pragma mark -下一个点击事件
- (IBAction)next:(id)sender {
    
    
    //点击发送验证码
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"phone"] = self.phoneText.text;
    [[AFHTTPSessionManager manager]GET:@"http://10.0.0.30:8080/appPhone/sendCode.htm" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取返回信息
        NSString  *textString = responseObject[@"data"];
        if ([textString isEqualToString:@"验证码发送成功"]) {
            DFRegisterMessageController *registerMessage =[[DFRegisterMessageController alloc]init];
            registerMessage.testString = self.phoneText.text;
            
            [self.navigationController pushViewController:registerMessage animated:YES];
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:textString preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
        }
        //NSLog(@"%@",responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    


}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}






@end
