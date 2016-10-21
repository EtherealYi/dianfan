//
//  DFfootDataModel.h
//  点范
//
//  Created by Masteryi on 2016/10/17.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFStoreViewModel.h"
#import "DFAreaModel.h"
#import "DFGenderRatio.h"

@interface DFfootDataModel : NSObject


@property (nonatomic,copy)NSString *MALERatio;

@property (nonatomic,copy)NSString *FEMALERatio;

@property (nonatomic,strong) DFGenderRatio *genderRatio;

@property (nonatomic,strong)DFStoreViewModel *stroreFoot;

@property (nonatomic,strong)NSMutableArray<DFAreaModel *> *areaModel;

@end
