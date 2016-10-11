//
//  DFMessage.m
//  点范
//
//  Created by Masteryi on 16/9/18.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFMessage.h"
#import "MJExtension.h"

@implementation DFMessage

- (instancetype)init{
    if (self = [super init]) {
        [DFMessage mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"Msg_id" : @"id"
                     };
        }];
    }
    return self;
}

@end
