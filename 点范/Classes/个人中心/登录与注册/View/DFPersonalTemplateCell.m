//
//  DFPersonalTemplateCell.m
//  点范
//
//  Created by Masteryi on 2016/10/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFPersonalTemplateCell.h"
#import "UIImageView+WebCache.h"
@interface DFPersonalTemplateCell()

@property (weak, nonatomic) IBOutlet UILabel *templateName;
@property (weak, nonatomic) IBOutlet UIImageView *contentImg;


@end
@implementation DFPersonalTemplateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)setPersontemplate:(DFPersonalTemplate *)Persontemplate{
    _Persontemplate = Persontemplate;
    
    
    self.templateName.text = Persontemplate.name;
    
 [self.contentImg sd_setImageWithURL:[NSURL URLWithString:Persontemplate.image] placeholderImage:[UIImage imageNamed:@"palfoot"] options:SDWebImageProgressiveDownload];
   
}

@end
