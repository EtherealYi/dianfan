//
//  DFTempMedol.m
//  点范
//
//  Created by Masteryi on 16/9/19.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFTempMedol.h"
#import "MJExtension.h"

@implementation DFTempMedol
- (instancetype)init{
    if (self = [super init]) {
        [DFTempMedol mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"temp_id" : @"id"
                     };
        }];
    }
    return self;
}

@end
