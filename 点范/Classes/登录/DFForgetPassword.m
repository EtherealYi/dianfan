//
//  DFForgetPassword.m
//  点范
//
//  Created by Masteryi on 16/9/9.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFForgetPassword.h"
#import "AFNetworking.h"
#import<CommonCrypto/CommonDigest.h>

@interface DFForgetPassword ()
/** 账号 **/
@property (weak, nonatomic) IBOutlet UITextField *accountText;
/** 验证码 **/
@property (weak, nonatomic) IBOutlet UITextField *identyText;
/** 重新发送 **/
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
/** 密码 **/
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
/** 完成修改 **/
@property (weak, nonatomic) IBOutlet UIButton *complete;



@end

@implementation DFForgetPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"忘记密码";
    [self.sendBtn CornerAndShdow];
    [self.complete CornerAndShdow];
    [self.complete addTarget:self action:@selector(completeTomain) forControlEvents:UIControlEventTouchUpInside];
    
 

    
}


- (void)completeTomain{

   
        [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendID:(id)sender {

        //点击发送验证码
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"phone"] = self.accountText.text;
        [[AFHTTPSessionManager manager]GET:@"http://10.0.0.30:8080/appPhone/sendCode.htm" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *message = responseObject[@"data"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
            NSLog(@"%@",responseObject[@"data"]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];

   

}





@end
