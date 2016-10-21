//
//  DFStoreViewModel.m
//  点范
//
//  Created by Masteryi on 2016/10/17.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFStoreViewModel.h"
#import "MJExtension.h"

@implementation DFStoreViewModel

- (instancetype)init{
    if (self = [super init]) {
        [DFStoreViewModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"dish_id" : @"id"
                     };
        }];
    }
    return self;
}
@end
