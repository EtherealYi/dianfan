//
//  DFTemplateCell.m
//  点范
//
//  Created by Masteryi on 2016/9/24.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFTemplateCell.h"
#import "UIImageView+WebCache.h"

@interface DFTemplateCell()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation DFTemplateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTempMedol:(DFTempMedol *)tempMedol{
    _tempMedol = tempMedol;
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:tempMedol.background] placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.numberLabel.text = tempMedol.order;
}

@end
