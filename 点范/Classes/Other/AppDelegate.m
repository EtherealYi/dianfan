//
//  AppDelegate.m
//  点范
//
//  Created by Masteryi on 16/9/5.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DFNavigationController.h"
#import "IQKeyboardManager.h"
#import "DFHomeViewController.h"
#import "DFUser.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "Pingpp.h"
#import "DFBuySuccessController.h"
#import "DFBuyTempController.h"


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [UMSocialData setAppKey:@"57b432afe0f55a9832001a0a"];
    //创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //初始化控制器
    //LoginViewController *login = [[LoginViewController alloc]init];
    DFHomeViewController *home = [[DFHomeViewController alloc]init];
    
    DFNavigationController *Nav = [[DFNavigationController alloc]initWithRootViewController:home];
    
    self.window.rootViewController = Nav;
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [self setUserData];
   
    [self.window makeKeyAndVisible];
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxdc1e388c3822c80b" appSecret:@"a393c1527aaccb95f3a4c88d6d1455f6" url:@"http://www.umeng.com/social"];

 
    //ping ++
    [Pingpp setDebugMode:YES];
    
    return YES;
}

- (void)setUserData{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *name = [userDefault objectForKey:@"name"];
//    NSString *token = [userDefault objectForKey:@"token"];
    [[DFUser sharedManager] initWithDict:userDefault];
    NSLog(@"AppDelagate %@",[DFUser sharedManager].token);
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        result = [Pingpp handleOpenURL:url withCompletion:^(NSString *result, PingppError *error) {
            NSLog(@"支付成功回调");
            [[NSNotificationCenter defaultCenter]postNotificationName:@"push" object:self];
            
        }];
    }
    return result;
}
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
//}
//- (void)applicationDidBecomeActive:(UIApplication *)application{
//    [UMSocialSnsService  applicationDidBecomeActive];
//}

@end
