//
//  DFbuyheaderCell.m
//  点范
//
//  Created by Masteryi on 2016/9/29.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFbuyheaderCell.h"
#import "UIImageView+WebCache.h"

@interface DFbuyheaderCell()

@property (weak, nonatomic) IBOutlet UILabel *PriceText;
@property (weak, nonatomic) IBOutlet UILabel *buyName;
@property (weak, nonatomic) IBOutlet UIImageView *buyImg;


@end

@implementation DFbuyheaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setBuyModel:(DFBuyModel *)buyModel{
    _buyModel = buyModel;
    self.PriceText.text = [NSString stringWithFormat:@"￥%@",buyModel.price];
    [self.buyImg sd_setImageWithURL:[NSURL URLWithString:buyModel.image] placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.buyName.text = buyModel.name;
}

@end
