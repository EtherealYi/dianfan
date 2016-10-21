//
//  DFeditTempalteController.h
//  点范
//
//  Created by Masteryi on 16/9/13.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFRecModel.h"

@protocol editDelegte <NSObject>



@end

@interface DFeditTempalteController : UIViewController


@property (nonatomic,strong) DFRecModel *recModel;

@property (nonatomic,strong) NSString *rec_id;

@property (nonatomic,assign)NSString *dishTemplateMerchantPageResultsID;

@end
