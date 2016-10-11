//
//  DFMerchant.m
//  点范
//
//  Created by Masteryi on 2016/9/26.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFMerchant.h"
#import "MJExtension.h"

@implementation DFMerchant

- (instancetype)init{
    if (self = [super init]) {
        [DFMerchant mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
            return @{
                     @"mer_id":@"id"
                     };
        }];
    }
    return self;
}
@end
