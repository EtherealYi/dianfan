//
//  DFfoodCell.m
//  点范
//
//  Created by Masteryi on 16/9/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFfoodCell.h"
#import "UIImageView+WebCache.h"

@interface DFfoodCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *dishName;
@property (weak, nonatomic) IBOutlet UILabel *dishPrice;
@property (weak, nonatomic) IBOutlet UILabel *scanNum;

@property (weak, nonatomic) IBOutlet UILabel *commentNum;
@property (weak, nonatomic) IBOutlet UILabel *menuNum;
@property (weak, nonatomic) IBOutlet UILabel *snLab;


@end

@implementation DFfoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setStroreModel:(DFStoreViewModel *)stroreModel{
    _stroreModel = stroreModel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:stroreModel.thumbnail] placeholderImage:nil options:SDWebImageProgressiveDownload];
    
    if (fDeviceWidth < 330) {
        self.dishName.font  = [UIFont systemFontOfSize:12];
        self.dishPrice.font = [UIFont systemFontOfSize:11];
        self.snLab.font     = [UIFont systemFontOfSize:11];
    }
    self.dishName.text   = stroreModel.name;
    self.dishPrice.text  = [NSString stringWithFormat:@"￥%@",stroreModel.price];
    self.dishPrice.text = [self.dishPrice.text SubToIndex];
    self.scanNum.text    = stroreModel.scanNum;
    self.commentNum.text = stroreModel.commentNum;
    self.menuNum.text    = stroreModel.menuItemNum;
    self.snLab.text      = [NSString stringWithFormat:@"#%@",stroreModel.sn];
}

@end
