//
//  UIAlertController+DFExtension.h
//  点范
//
//  Created by Masteryi on 2016/10/25.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (DFExtension)

+ (instancetype)actionWithMessage:(NSString *)message;

+ (instancetype)alterWithMessage:(NSString *)message handler:(void (^ __nullable)(UIAlertAction *action))handler;

@end
