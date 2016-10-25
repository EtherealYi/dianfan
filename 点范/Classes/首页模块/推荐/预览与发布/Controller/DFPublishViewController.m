//
//  DFPublishViewController.m
//  点范
//
//  Created by Masteryi on 2016/10/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFPublishViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <CoreImage/CoreImage.h>
#import "DFTwoCodeViewController.h"

#define kTagShareEdit 101
#define kTagSharePost 102


@interface DFPublishViewController ()
@property (weak, nonatomic) IBOutlet UIView *weChat;
@property (weak, nonatomic) IBOutlet UIView *weibo;
@property (weak, nonatomic) IBOutlet UIView *twoCode;

@end

@implementation DFPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发布成功";
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weChatShare)];
    [self.weChat addGestureRecognizer:tap];
    
    UITapGestureRecognizer *weoboTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weboShare)];
    [self.weibo addGestureRecognizer:weoboTap];
    
    UITapGestureRecognizer *twoCodeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setupTwoCode)];
    [self.twoCode addGestureRecognizer:twoCodeTap];
}

- (void)setupTwoCode{

    DFTwoCodeViewController *twoCode = [[DFTwoCodeViewController alloc]init];
    [self.navigationController pushViewController:twoCode animated:YES];
}

- (void)weboShare{
    UMSocialMessageObject * message = [[UMSocialMessageObject alloc]init];
    message.text = @"来自强大的觅食邦的分享";
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:message currentViewController:self completion:^(id result, NSError *error) {
        
    }];
}

- (void)weChatShare{
    NSString *text = @"来自觅食邦的分享";
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = text;
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
   
    }];
}


@end
