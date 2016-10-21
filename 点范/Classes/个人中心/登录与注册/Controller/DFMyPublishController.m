//
//  DFMyPublishController.m
//  点范
//
//  Created by Masteryi on 2016/10/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFMyPublishController.h"
#import "DFPersonalTemplateCell.h"
#import "DFUser.h"
#import "DFPersonalTemplate.h"
#import "DFHTTPSessionManager.h"
#import "MJExtension.h"
#import "DFRecTemplateController.h"

@interface DFMyPublishController ()

@property (nonatomic,strong)DFHTTPSessionManager *manager;

@property (nonatomic,strong)NSMutableArray<DFPersonalTemplate *> *tempArrays;

@end

@implementation DFMyPublishController

static NSString * const reuseIdentifier = @"MyPublish";

- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return  _manager;
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
    [self loadMyPublish];
}

- (void)loadMyPublish{
    __weak typeof(self) weakSelf = self;
    
    NSString *url1 = [NSString stringWithFormat:@"http://10.0.0.30:8080/appMember/login/member/myDishTemplates.htm?token=%@",[DFUser sharedManager].token];
    [self.manager GET:url1 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.tempArrays = [DFPersonalTemplate mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"dishTemplates"]];
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

    return self.tempArrays.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DFPersonalTemplateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.Persontemplate = self.tempArrays[indexPath.row];
    [cell.layer cellShadow];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellW = (self.view.frame.size.width - 40)/3 - 1;
    CGFloat cellH = self.collectionView.df_height - 10;
    //return  CGSizeMake((fDeviceWidth - 20) / 3, 180);
    return CGSizeMake(cellW, 160);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DFRecTemplateController *recTempCtr = [[DFRecTemplateController alloc]init];
    recTempCtr.imgName = self.tempArrays[indexPath.row].image;
    recTempCtr.rec_id = self.tempArrays[indexPath.row].result_id;
    [self.navigationController pushViewController:recTempCtr animated:YES];
}
@end
