//
//  DFBuyModel.h
//  点范
//
//  Created by Masteryi on 2016/10/13.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFBuyModel : NSObject
/** 图片 */
@property (nonatomic,copy)NSString *image;
/** 描述 */
@property (nonatomic,copy)NSString *introduction;
/** 名称 */
@property (nonatomic,copy)NSString *name;
/** 价格 */
@property (nonatomic,copy)NSString *price;

@end
