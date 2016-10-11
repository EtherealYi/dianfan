//
//  DFfootCollectionController.h
//  点范
//
//  Created by Masteryi on 16/9/14.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFTempMedol.h"


@interface DFfootCollectionController : UICollectionViewController
/** 模板模型数组 */
@property (nonatomic,strong)NSMutableArray<DFTempMedol *> *tempMedelS;
/** 模板id */
@property (nonatomic,assign)NSString *dishTemplateMerchantPageResults;
/** 个人模板id */
@property (nonatomic,copy)NSString *dishTemplateResultId;
/** 从选择模板返回的模板 */
@property (nonatomic,strong)DFTempMedol *fromSelect;

- (void)loadTemplate;

@end
