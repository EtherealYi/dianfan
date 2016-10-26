//
//  DFRegisterMessageController.m
//  点范
//
//  Created by Masteryi on 16/9/5.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFRegisterMessageController.h"
#import "AFNetworking.h"
#import<CommonCrypto/CommonDigest.h>

@interface DFRegisterMessageController ()
@property (strong, nonatomic) IBOutlet UIView *testView;
/** 重新发送按钮 **/
@property (weak, nonatomic) IBOutlet UIButton *again;
/** 完成按钮 **/
@property (weak, nonatomic) IBOutlet UIButton *complete;
/** 复选框 **/
@property (weak, nonatomic) IBOutlet UIButton *checkBox;
/** 验证码 **/
@property (weak, nonatomic) IBOutlet UITextField *validateCode;
/** 密码 **/
@property (weak, nonatomic) IBOutlet UITextField *pawword;
/** 中心密码 **/
@property (weak, nonatomic) IBOutlet UITextField *infoPassword;
/** 联系人 **/
@property (weak, nonatomic) IBOutlet UITextField *devName;
/** 联系电话 **/
@property (weak, nonatomic) IBOutlet UITextField *devPhone;



@end

@implementation DFRegisterMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册信息";
    //设置按钮

    [self.again CornerAndShdow];
    [self.complete CornerAndShdow];
    //设置label
    NSString *string_1 = self.testString;
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.text = [NSString stringWithFormat:@"你的手机号码:%@发送一条短信",string_1];
    
    //勾选框按钮设置
    self.checkBox.layer.cornerRadius = 5;
    self.checkBox.layer.borderWidth = 1;
    self.checkBox.layer.borderColor  = [UIColor blackColor].CGColor;
    [self.checkBox setImage:[UIImage imageNamed:@"打钩"] forState:UIControlStateSelected];
//    [self.checkBox setSelected:YES];
    [self.checkBox addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark -勾选框选中方法
-(void)checkClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    btn.layer.borderWidth = !btn.selected;
}
#pragma mark -完成按钮点击事件
- (IBAction)complete:(id)sender {
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    //MD5加密
    NSString *result = [self md5:self.pawword.text];
    NSString *searchResult = [self md5:self.infoPassword.text];
    dict[@"devName"] = self.devName.text;
    dict[@"devPhone"] = self.devPhone.text;
    dict[@"infoPassword"] = searchResult;
    dict[@"password"] = result;
    dict[@"username"] = self.testString;
    dict[@"validateCode"] = self.validateCode.text;
    [[AFHTTPSessionManager manager]POST:@"http://10.0.0.30:8080/appMember/account/register.htm" parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //成功后返回登录界面
//        NSLog(@"%@",responseObject);
    
        NSNumber *registCode = responseObject[@"code"];
        NSNumber *code = [NSNumber numberWithInt:0];
        if ([registCode isEqualToNumber:code]) {
             [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:responseObject[@"data"][@"errMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alter animated:YES completion:nil];
        }
        
        
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
    }];
}

- (IBAction)again:(id)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"phone"] = self.testString;
    [[AFHTTPSessionManager manager]GET:@"http://10.0.0.30:8080/appPhone/sendCode.htm" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject[@"code"]);
        
        NSNumber *code = responseObject[@"code"];
        
        NSNumber *num = [NSNumber numberWithInt:0];
        
        if ([code isEqualToNumber:num]) {
            //初始化提示框；
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码发送成功" preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码发送失败，请稍后再试" preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
    }];
    
}

#pragma mark - MD5加密
- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}



@end
