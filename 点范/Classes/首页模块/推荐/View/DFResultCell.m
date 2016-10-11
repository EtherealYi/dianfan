//
//  DFResultCell.m
//  点范
//
//  Created by Masteryi on 2016/9/24.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFResultCell.h"
#import "UIImageView+WebCache.h"

@interface DFResultCell()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImg;

@property (nonatomic,strong)NSMutableDictionary *dict;

@end

@implementation DFResultCell
#pragma mark - 懒加载
- (NSMutableDictionary *)dict{
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setResultModel:(DFResultModel *)resultModel{
    _resultModel = resultModel;
    [self.pictureImg sd_setImageWithURL:[NSURL URLWithString:resultModel.background] placeholderImage:nil options:SDWebImageProgressiveDownload];
}

- (void)setDictonaryKey:(NSIndexPath *)key{
    [_dict setObject:self forKey:key];
    
}

- (DFResultCell *)returnBykey:(NSIndexPath *)key{
    return [_dict objectForKey:key];
    
}


@end
