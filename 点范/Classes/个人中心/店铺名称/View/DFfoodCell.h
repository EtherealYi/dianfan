//
//  DFfoodCell.h
//  点范
//
//  Created by Masteryi on 16/9/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFStoreViewModel.h"

@interface DFfoodCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *oderID;

@property (nonatomic,strong)DFStoreViewModel *stroreModel;


@end
