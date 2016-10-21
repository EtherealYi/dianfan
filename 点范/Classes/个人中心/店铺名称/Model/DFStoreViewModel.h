//
//  DFStoreViewModel.h
//  点范
//
//  Created by Masteryi on 2016/10/17.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFStoreViewModel : NSObject

/** 评论数量 */
@property (nonatomic,copy)NSString *commentNum;
/** 图片 */
@property (nonatomic,copy)NSString *thumbnail;
/** 点餐量 */
@property (nonatomic,copy)NSString *menuItemNum;
/** 价格 */
@property (nonatomic,copy)NSString *price;
/** 名字 */
@property (nonatomic,copy)NSString *name;
/** 订单号 */
@property (nonatomic,copy)NSString *sn;
/** 浏览量 */
@property (nonatomic,copy)NSString *scanNum;
/** 菜品id */
@property (nonatomic,copy)NSString *dish_id;



@end
