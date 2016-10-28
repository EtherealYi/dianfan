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
/** 微信 */
@property (weak, nonatomic) IBOutlet UIView *weChat;
/** 微博 */
@property (weak, nonatomic) IBOutlet UIView *weibo;
/** 二维码 */
@property (weak, nonatomic) IBOutlet UIView *twoCode;
/** 复制 */
@property (weak, nonatomic) IBOutlet UIView *pasteView;
/** 提醒label */
@property (nonatomic,strong)UILabel *remindLab;

@end

@implementation DFPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发布成功";
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    //朋友圈分享
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weChatShare)];
    [self.weChat addGestureRecognizer:tap];
    //微博
    UITapGestureRecognizer *weoboTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weboShare)];
    [self.weibo addGestureRecognizer:weoboTap];
    //二维码
    UITapGestureRecognizer *twoCodeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setupTwoCode)];
    [self.twoCode addGestureRecognizer:twoCodeTap];
    //复制链接
    UITapGestureRecognizer *pasteTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pasteCick)];
    [self.pasteView addGestureRecognizer:pasteTap];
    //提醒lab
    UILabel *remindLab = [[UILabel alloc]init];
    remindLab.frame = CGRectMake(0, 0, 100, 30);
    remindLab.backgroundColor = WhiteColor;
    remindLab.alpha = 0.8;
    remindLab.layer.cornerRadius = 5;
    remindLab.layer.masksToBounds = YES;
    remindLab.textAlignment = NSTextAlignmentCenter;
    remindLab.hidden = YES;
    remindLab.df_centerX = self.view.df_centerX;
    remindLab.df_centerY = self.view.df_centerY - 64;
    [remindLab setText:@"已复制" andFont:14 andColor:[UIColor blackColor]];
    [self.view addSubview:remindLab];
    self.remindLab = remindLab;
}

/**
 复制链接
 */
- (void)pasteCick{
    
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = @"http://www.feng.com/";
    self.remindLab.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 animations:^{
            self.remindLab.hidden = YES;
        }];
    });
}

/**
 二维码
 */
- (void)setupTwoCode{

    DFTwoCodeViewController *twoCode = [[DFTwoCodeViewController alloc]init];
    [self.navigationController pushViewController:twoCode animated:YES];
}

/**
 微博分享
 */
- (void)weboShare{
    UMSocialMessageObject * message = [[UMSocialMessageObject alloc]init];
    message.text = @"来自强大的觅食邦的分享";
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:message currentViewController:self completion:^(id result, NSError *error) {
        
    }];
}

/**
 朋友圈分享
 */
- (void)weChatShare{
    NSString *text = @"来自觅食邦的分享";
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = text;
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
//            message = [NSString stringWithFormat:@"分享成功"];
        } else {
//            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
   
    }];
}


@end
