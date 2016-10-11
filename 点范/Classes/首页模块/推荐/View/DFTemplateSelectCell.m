//
//  DFTemplateSelectCell.m
//  点范
//
//  Created by Masteryi on 2016/9/27.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFTemplateSelectCell.h"
#import "UIImageView+WebCache.h"

@interface DFTemplateSelectCell()

@end

@implementation DFTemplateSelectCell

- (void)setTempMedel:(DFTempMedol *)tempMedel{
    _tempMedel = tempMedel;
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.bounds];
    [imgView sd_setImageWithURL:[NSURL URLWithString:tempMedel.background] placeholderImage:nil options:SDWebImageProgressiveDownload];
    [self addSubview:imgView];
    
}

@end
