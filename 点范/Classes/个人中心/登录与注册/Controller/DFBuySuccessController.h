//
//  DFBuySuccessController.h
//  点范
//
//  Created by Masteryi on 2016/10/13.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pushToMeDelegate <NSObject>

- (void)pushToMe;

@end

@interface DFBuySuccessController : UIViewController

@property (nonatomic,weak)id<pushToMeDelegate> delegate;

@end
