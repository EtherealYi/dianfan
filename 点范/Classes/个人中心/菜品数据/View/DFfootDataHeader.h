//
//  DFfootDataHeader.h
//  点范
//
//  Created by Masteryi on 2016/10/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFfootDataModel.h"
#import "DFAreaModel.h"

@interface DFfootDataHeader : UITableViewCell

@property (nonatomic,strong)DFfootDataModel *footModel;

//@property (nonatomic,strong)NSMutableArray<DFAreaModel *> *areaModel;



- (void)setPNChart;

- (void)setArea;

@end
