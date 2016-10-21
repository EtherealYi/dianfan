//
//  DFDishCommentData.h
//  点范
//
//  Created by Masteryi on 2016/10/21.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFCountAndRatio.h"
#import "DFScoreDistributionMap.h"

@interface DFDishCommentData : NSObject

@property (nonatomic,copy)NSString *commentNum;

@property (nonatomic,copy)NSString *avgScore;

@property (nonatomic,strong) DFCountAndRatio *countAndRation;

//@property (nonatomic,strong) DFScoreDistributionMap *scoreMap;
@property (nonatomic,strong) NSMutableArray <DFScoreDistributionMap *> *scoreMap;


@end
