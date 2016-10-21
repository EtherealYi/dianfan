//
//  DFUser.m
//  点范
//
//  Created by Masteryi on 16/9/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFUser.h"

@implementation DFUser


+ (DFUser *)sharedManager{
    
    static DFUser *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)initWithDict:(NSUserDefaults *)dict{
    self.username = [dict objectForKey:@"username"];
    self.token    = [dict objectForKey:@"token"];
    
    //[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isLogin"];
}

- (void)didLogout{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"username"];
    [userDefault removeObjectForKey:@"token"];
    [userDefault removeObjectForKey:@"icon"];
    self.username = nil;
    self.token    = nil;
    self.icon     = nil;
    //[[NSUserDefaults standardUserDefaults]setObject:@NO forKey:@"isLogin"];
}
- (void)saveIcon:(NSUserDefaults *)userDefault{
    self.icon = [userDefault objectForKey:@"icon"];
}
- (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}
@end
