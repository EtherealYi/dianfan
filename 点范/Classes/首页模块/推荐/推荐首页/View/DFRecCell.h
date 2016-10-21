//
//  DFRecCell.h
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFRecModel.h"
#import "DFPersonalTemplate.h"

@interface DFRecCell : UICollectionViewCell
/** 推荐模型 */
@property (nonatomic,strong) DFRecModel *recModel;

/** id */
@property (copy,nonatomic) NSString *cell_id;


@end
