//
//  DFLoginAndShareController.m
//  点范
//
//  Created by Masteryi on 2016/10/22.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFLoginAndShareController.h"
#import <UMSocialCore/UMSocialCore.h>

@interface DFLoginAndShareController ()

@end

@implementation DFLoginAndShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)weChart:(id)sender {
    [self authWithPlatform:UMSocialPlatformType_WechatSession];
}
- (IBAction)QQLogin:(id)sender {
     [self authWithPlatform:UMSocialPlatformType_QQ];
}

- (IBAction)wbShare:(id)sender {
    
    UMSocialMessageObject * message = [[UMSocialMessageObject alloc]init];
    message.text = @"hahaha";
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:message currentViewController:self completion:^(id result, NSError *error) {
        
    }];
}
-(void)authWithPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager]  authWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        NSString *message = nil;
        if (error) {
            //NSLog(@"Auth fail with error %@", error);
            message = @"Auth fail";
        }else{
            if ([result isKindOfClass:[UMSocialAuthResponse class]]) {
                UMSocialAuthResponse *resp = result;
                // 授权信息
//                NSLog(@"AuthResponse uid: %@", resp.uid);
//                NSLog(@"AuthResponse accessToken: %@", resp.accessToken);
//                NSLog(@"AuthResponse refreshToken: %@", resp.refreshToken);
//                NSLog(@"AuthResponse expiration: %@", resp.expiration);
                
                // 第三方平台SDK源数据,具体内容视平台而定
//                NSLog(@"AuthOriginalResponse: %@", resp.originalResponse);
                message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,resp.uid,resp.accessToken];
            }else{
//                NSLog(@"Auth fail with unknow error");
                message = @"Auth fail";
            }
        }
        
        //[self.tableView reloadData];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Auth"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        NSString *message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",userinfo.name,userinfo.iconurl,userinfo.gender];
//        NSLog(@"%@",message);
    }];
}
- (IBAction)wechatshare:(id)sender {
    UMSocialMessageObject * message = [[UMSocialMessageObject alloc]init];
    message.text = @"hahaha";
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:message currentViewController:self completion:^(id result, NSError *error) {
        
    }];
}
@end
