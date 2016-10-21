//
//  DFPersonalTemplate.m
//  点范
//
//  Created by Masteryi on 2016/10/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFPersonalTemplate.h"
#import "MJExtension.h"

@implementation DFPersonalTemplate

- (instancetype)init{
    if (self = [super init]) {
        [DFPersonalTemplate mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"result_id" : @"id"
                     };
        }];
    }
    return self;
}

@end
