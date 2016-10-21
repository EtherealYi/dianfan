//
//  DFResultCell.h
//  点范
//
//  Created by Masteryi on 2016/9/24.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFResultModel.h"

@interface DFResultCell : UICollectionViewCell

@property (nonatomic,strong)DFResultModel *resultModel;

- (void)setDictonaryKey:(NSIndexPath *)key;

- (DFResultCell *)returnBykey:(NSIndexPath *)key;


@end
