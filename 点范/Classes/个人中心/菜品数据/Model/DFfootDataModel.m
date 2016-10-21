//
//  DFfootDataModel.m
//  点范
//
//  Created by Masteryi on 2016/10/17.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFfootDataModel.h"
#import "MJExtension.h"
#import "DFStoreViewModel.h"
#import "DFGenderRatio.h"

@implementation DFfootDataModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"genderRatio":[DFGenderRatio class]
             
             };
}


@end
