//
//  DFTempWebViewController.h
//  点范
//
//  Created by Masteryi on 2016/9/28.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@interface DFTempWebViewController : UIViewController
/** 模板页面id */
@property (nonatomic,copy)NSString *PageID;
/** 模板id */
@property (nonatomic,copy)NSString *dishTemplateResultId;

@end
