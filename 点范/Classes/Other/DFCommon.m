//
//  DFCommon.m
//  点范
//
//  Created by Masteryi on 16/9/5.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFCommon.h"

@implementation DFCommon

+ (UIImage *)creatImageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
