//
//  DFMessageCell.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFMessageCell.h"

@interface DFMessageCell()
/** 消息类型 */
@property (weak, nonatomic) IBOutlet UILabel *MsgType;
/** 消息标题 */
@property (weak, nonatomic) IBOutlet UILabel *msgTitle;
/** 消息时间 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;



@end

@implementation DFMessageCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessageMedel:(DFMessage *)messageMedel{
    _messageMedel = messageMedel;
    if ([messageMedel.infoType isEqualToString:@"SYSTEM"]) {
        self.MsgType.text = @"系统通知:";
    }else{
        self.MsgType.text = @"消息通知:";
    }
    self.msgTitle.text = messageMedel.title;
    self.dateLabel.text = messageMedel.createDate;
}


@end
