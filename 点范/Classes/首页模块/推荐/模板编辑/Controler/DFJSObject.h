//
//  DFJSObject.h
//  点范
//
//  Created by Masteryi on 2016/10/26.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>



@protocol JSObjectProtocol <JSExport>

//此处我们测试几种参数的情况
- (void)preview;

@end


@interface DFJSObject : NSObject<JSObjectProtocol>

@end
