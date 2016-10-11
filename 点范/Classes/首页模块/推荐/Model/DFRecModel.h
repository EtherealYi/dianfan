//
//  DFRecModel.h
//  点范
//
//  Created by Masteryi on 16/9/19.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFRecModel : NSObject

/** 图片 */
@property (nonatomic,copy) NSString *image;
/** 价格 */
@property (nonatomic,copy) NSString *price;
/** 名字 */
@property (nonatomic,copy) NSString *name;
/** id */
@property (nonatomic,copy) NSString *rec_id;

@property (nonatomic,assign) NSUInteger *totalPage;

@property (nonatomic,assign) NSUInteger *pageNumber;

@end
