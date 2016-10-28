//
//  DFPublishController.m
//  点范
//
//  Created by Masteryi on 2016/10/15.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFPublishController.h"
#import "DFRecCell.h"
#import "DFUser.h"
#import "DFHTTPSessionManager.h"
#import "DFPersonalTemplateCell.h"
#import "DFPersonalTemplate.h"
#import "MJExtension.h"
#import "DFTempWebViewController.h"
#import "DFeditTempalteController.h"

@interface DFPublishController ()

@property (nonatomic,strong)DFHTTPSessionManager *manager;

@property (nonatomic,strong)NSMutableArray<DFPersonalTemplate *> *templateArrays;

@end

@implementation DFPublishController

static NSString * const reuseIdentifier = @"Cell";

- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}


- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //cell之间的水平间距
    layout.minimumInteritemSpacing = 10 ;
    //cell之间的垂直间距
    layout.minimumLineSpacing = 10;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = WhiteColor;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DFPersonalTemplateCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self loadPublish];

}

- (void)loadPublish{
     __weak typeof(self) weakSelf = self;

    NSString *url = [MemberAPI stringByAppendingString:apiStr(@"myDishTemplateResults.htm")];
    
    NSMutableDictionary *parmater = [NSMutableDictionary dictionary];
    parmater[@"isMarketable"] = @"true";
    [weakSelf.manager GET:url parameters:parmater progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (sucess) {
           weakSelf.templateArrays = [DFPersonalTemplate mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"dishTemplateResults"]];
        }
     
        
        [weakSelf.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.templateArrays.count > 6) {
        return 6;
    }
    return self.templateArrays.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DFPersonalTemplateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.Persontemplate = self.templateArrays[indexPath.row];
    [cell.layer cellShadow];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellW = (self.view.frame.size.width - 40)/3 - 1;
    //CGFloat cellH = self.collectionView.df_height - 10;
    //return  CGSizeMake((fDeviceWidth - 20) / 3, 180);
    return CGSizeMake(cellW, 160);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DFeditTempalteController *editTemp = [[DFeditTempalteController alloc]init];
    editTemp.rec_id = self.templateArrays[indexPath.row].result_id;
    
    [self.navigationController pushViewController:editTemp animated:YES];
}

@end
