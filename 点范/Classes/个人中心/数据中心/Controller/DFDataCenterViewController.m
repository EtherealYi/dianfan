//
//  DFDataCenterViewController.m
//  点范
//
//  Created by Masteryi on 16/9/19.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFDataCenterViewController.h"
#import "DFStoreViewController.h"
#import "DFRecCell.h"

@interface DFDataCenterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation DFDataCenterViewController

static NSString *const dataCenter = @"dataCenter";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the vieiw.
    self.title = @"数据中心";
    
    [self setCollection];
}
- (void)setCollection{
    //初始化collectionview
    UICollectionViewFlowLayout *customLayout = [[UICollectionViewFlowLayout alloc]init];
    customLayout.headerReferenceSize = CGSizeMake(self.view.df_width, 10);//头部大小
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:customLayout];
    
    
    //定义每个UICollectionView 横向的间距
    customLayout.minimumLineSpacing = 5;
    //定义每个UICollectionView 纵向的间距
    customLayout.minimumInteritemSpacing = 5;
    
    collectionView.backgroundColor = DFColor(238, 238, 238);
    
    collectionView.delegate = self;
    
    collectionView.dataSource = self;

    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DFRecCell class]) bundle:nil] forCellWithReuseIdentifier:dataCenter];
    
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
    
    

}
#pragma mark - UICollectionView delegate dataSource
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dataCenter forIndexPath:indexPath];
//    //[cell sizeToFit];
//    cell.backgroundColor = [UIColor whiteColor];
//    //按钮事件就不实现了……
    DFRecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dataCenter forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellW = (self.view.frame.size.width - 40)/3 - 1;
    CGFloat cellH = (fDeviceHeight - 40)/3 - 10;
    //return  CGSizeMake((fDeviceWidth - 20) / 3, 180);
    return CGSizeMake(cellW, cellH);
  
}
//间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 64 , 5);
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DFStoreViewController *store = [[DFStoreViewController alloc]init];
    [self.navigationController pushViewController:store animated:YES];
}





@end
