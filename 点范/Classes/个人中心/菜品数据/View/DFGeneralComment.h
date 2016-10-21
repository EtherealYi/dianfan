//
//  DFGeneralComment.h
//  点范
//
//  Created by Masteryi on 2016/10/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFDishCommentData.h"

@interface DFGeneralComment : UITableViewCell

@property (nonatomic,strong)DFDishCommentData *dishCommentData;

- (void)setupChildView;

@end
