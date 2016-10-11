//
//  DFRecModel.m
//  点范
//
//  Created by Masteryi on 16/9/19.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFRecModel.h"
#import "MJExtension.h"

@implementation DFRecModel

- (instancetype)init{
    if (self = [super init]) {
        [DFRecModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"rec_id" : @"id"
                     };
        }];
    }
    return self;
}


@end
