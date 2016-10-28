//
//  DFDateViewController.h
//  点范
//
//  Created by Masteryi on 2016/10/28.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^DateBlock)(NSString *str);

@interface DFDateViewController : UIViewController


@property (nonatomic,copy)DateBlock block;

@end
