//
//  DFLineLayout.m
//  点范
//
//  Created by Masteryi on 16/9/13.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFLineLayout.h"

@implementation DFLineLayout

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
    
}
/**
 *  准备操作：一般在这里设置一些初始化参数
 */
- (void)prepareLayout{
    [super prepareLayout];
    
    //设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置cell的大小
    CGFloat itemWH = self.collectionView.frame.size.height * 0.8;
    //CGFloat itemW = (self.collectionView.df_width - 10)/4;
    CGFloat itemW = self.collectionView.df_width / 4;
    self.itemSize = CGSizeMake(itemW, itemWH );
    // 设置内边距
    self.sectionInset = UIEdgeInsetsMake(25, 10, 5, 10);
    
   
}

/**
 * 决定了cell怎么排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    // 调用父类方法拿到默认的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    

    
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


@end
