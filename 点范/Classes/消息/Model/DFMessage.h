//
//  DFMessage.h
//  点范
//
//  Created by Masteryi on 16/9/18.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFMessage : NSObject

/** 消息类型 */
@property(nonatomic,copy)NSString *infoType;
/** 收件人已读 */
@property (nonatomic,assign)BOOL *receiverRead;
/** 内容 */
@property (nonatomic,copy)NSString *title;
/** 创建时间 */
@property (nonatomic,copy)NSString *createDate;
/** 消息ID */
@property (nonatomic,copy)NSString  *Msg_id;

@end
