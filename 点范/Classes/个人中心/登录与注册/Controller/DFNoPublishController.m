//
//  DFNoPublishController.m
//  点范
//
//  Created by Masteryi on 2016/10/20.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFNoPublishController.h"
#import "DFRecCell.h"
#import "DFUser.h"
#import "DFHTTPSessionManager.h"

@interface DFNoPublishController ()

@property (nonatomic,strong)DFHTTPSessionManager *manager;


@end

@implementation DFNoPublishController

static NSString * const reuseIdentifier = @"NoPublsh";

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
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DFRecCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
}

- (void)loadNoPublish{
   
        NSString *url = [NSString stringWithFormat:@"http://10.0.0.30:8080/appMember/login/member/myDishTemplateResults.htm?token=%@",[DFUser sharedManager].token];
        
        NSMutableDictionary *parmater = [NSMutableDictionary dictionary];
        parmater[@"isMarketable"] = @"false";
        [self.manager GET:url parameters:parmater progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            
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

    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DFRecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
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

@end
