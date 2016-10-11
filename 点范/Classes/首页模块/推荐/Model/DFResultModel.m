//
//  DFResultModel.m
//  点范
//
//  Created by Masteryi on 16/9/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFResultModel.h"
#import "MJExtension.h"

@implementation DFResultModel

- (instancetype)init{
    if (self = [super init]) {
        [DFResultModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"result_id":@"id"
                     };
        }];
    }
    return self;
}

@end
