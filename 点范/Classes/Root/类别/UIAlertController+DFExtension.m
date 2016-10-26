//
//  UIAlertController+DFExtension.m
//  点范
//
//  Created by Masteryi on 2016/10/25.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "UIAlertController+DFExtension.h"
#import "SVProgressHUD.h"

@implementation UIAlertController (DFExtension)

+ (instancetype)actionWithMessage:(NSString *)message{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [SVProgressHUD dismiss];
    return alter;
}

+ (instancetype)alterWithMessage:(NSString *)message handler:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler]];
    [SVProgressHUD dismiss];
    return alter;
    
}



@end
