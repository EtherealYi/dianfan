//
//  DFForgetPassword.m
//  点范
//
//  Created by Masteryi on 16/9/9.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFForgetPassword.h"
#import "AFNetworking.h"
#import "DFHTTPSessionManager.h"
#import<CommonCrypto/CommonDigest.h>

@interface DFForgetPassword ()
/** 账号 */
@property (weak, nonatomic) IBOutlet UITextField *accountText;
/** 验证码 */
@property (weak, nonatomic) IBOutlet UITextField *identyText;
/** 重新发送 */
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
/** 密码 */
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
/** 完成修改 */
@property (weak, nonatomic) IBOutlet UIButton *complete;
/** 网络管理者 */
@property (nonatomic,strong)DFHTTPSessionManager *manager;

@end

@implementation DFForgetPassword

- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"忘记密码";
    [self.sendBtn CornerAndShdow];
    [self.complete CornerAndShdow];
    [self.complete addTarget:self action:@selector(completeTomain) forControlEvents:UIControlEventTouchUpInside];
    
 

    
}


- (void)completeTomain{

    NSString *url = @"http://10.0.0.30:8080/appMember/account/updatePassword.htm";
    NSMutableDictionary *parmater = [NSMutableDictionary dictionary];
    parmater[@"newPassword"]  = [self.pwdText.text MD5];
    parmater[@"username"]     = self.accountText.text;
    parmater[@"validateCode"] = self.identyText.text;
    [self.manager POST:url parameters:parmater progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
        //NSLog(@"%@",responseObject[@"data"][@"errMsg"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
   
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
            NSString *message;
            if (sucess) {
                
                 message = responseObject[@"data"];
            }else{
                message = responseObject[@"data"][@"errMsg"];
            }


            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:YES completion:nil];
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];

   

}





@end
