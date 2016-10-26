//
//  NSString+DFExtension.h
//  点范
//
//  Created by Masteryi on 16/9/14.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DFExtension)
- (NSString *)MD5;

+ (BOOL)isPureInt:(NSString *)string;

- (NSString *)SubToIndex;

+ (NSString *)iphoneType;

@end
