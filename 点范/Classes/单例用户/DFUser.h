//
//  DFUser.h
//  点范
//
//  Created by Masteryi on 16/9/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFUser : NSObject
/** 用户名 */
@property (nonatomic,assign)NSString *username;
/** token */
@property (nonatomic,assign)NSString *token;
/** 是否登录 */
@property (nonatomic,assign)BOOL isLogin;
/** 头像 */
@property (nonatomic,assign)NSString *icon;

- (void)initWithDict:(NSUserDefaults *)dict;
- (void)didLogout;
- (void)saveIcon:(NSUserDefaults *)userDefault;
+ (DFUser *)sharedManager;

@end
