//
//  DFResultModel.h
//  点范
//
//  Created by Masteryi on 16/9/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFResultModel : NSObject
/** 背景图片 */
@property (nonatomic,copy)NSString *background;
/** id */
@property (nonatomic,copy)NSString *result_id;
/** 排序 */
@property (nonatomic,copy)NSString *order;

@end
