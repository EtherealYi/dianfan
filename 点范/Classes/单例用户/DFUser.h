//
//  DFUser.h
//  点范
//
//  Created by Masteryi on 16/9/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFUser : NSObject

@property (nonatomic,assign)NSString *username;


@property (nonatomic,assign)NSString *token;

@property (nonatomic,assign)BOOL isLogin;

@property (nonatomic,assign)NSString *login;

- (void)initWithDict:(NSUserDefaults *)dict;
- (void)didLogout;
+ (DFUser *)sharedManager;

@end
