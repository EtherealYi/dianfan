//
//  DFRecCell.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFRecCell.h"
#import "UIImageView+WebCache.h"

@interface DFRecCell()
/** 文字标题 */
@property (weak, nonatomic) IBOutlet UILabel *textlabel;
/** 价格 */
@property (weak, nonatomic) IBOutlet UILabel *priceText;
/** 中间图片 */
@property (weak, nonatomic) IBOutlet UIImageView *centerImg;
/** 购买 */
@property (weak, nonatomic) IBOutlet UILabel *buyTest;

@end

@implementation DFRecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecModel:(DFRecModel *)recModel{
    _recModel = recModel;
    [self.centerImg sd_setImageWithURL:[NSURL URLWithString:recModel.image] placeholderImage:nil options:SDWebImageProgressiveDownload];
    
    self.textlabel.text = recModel.name;
    self.priceText.text = [NSString stringWithFormat:@"￥%@",recModel.price];
    [self.priceText setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
    self.cell_id = recModel.rec_id;
    [self.buyTest setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
}

@end
