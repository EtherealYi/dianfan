//
//  DFRecCollection.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFRecCollection.h"
#import "DFRecCell.h"
#import "XWPopMenuController.h"
#import "UIImage+XW.h"
#import "MJExtension.h"
#import "DFTopImg.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "DFRecheader.h"
#import "DFRecTemplateController.h"
#import "DFRecModel.h"
#import "DFHTTPSessionManager.h"
#import "DFUser.h"
#import "DFCenterButton.h"
#import "DFRefreshHeader.h"
#import "DFRefreshFooter.h"

@interface DFRecCollection ()<UIScrollViewDelegate>
/** 模型数组 */
@property (nonatomic,strong) NSMutableArray<DFRecModel *> *recModelS;
/** 定时器 */
@property (nonatomic,strong)NSTimer *timer;
/** 滚动视图 */
@property (nonatomic,weak)UIScrollView *Scroller;

@property (nonatomic,assign)int page ;
/** 网络 */
@property (nonatomic,strong)DFHTTPSessionManager *manager;

@end

@implementation DFRecCollection

static NSString * const reuseIdentifier = @"RecCell";
static NSString * const headerID = @"RecHead";

#pragma mark - 懒加载
- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}

- (instancetype)init{
    //设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置每个cell的尺寸
    //layout.itemSize = CGSizeMake(100, 200);
    //cell之间的水平间距
    layout.minimumInteritemSpacing = 10 ;
    //cell之间的垂直间距
    layout.minimumLineSpacing = 10;
    
    //设置四周边距
    //layout.sectionInset = UIEdgeInsetsMake(20, 10, 0, 10);
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DFRecCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:headerID];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    //self.collectionView.contentInset = UIEdgeInsetsMake(35 + DFMargin, 0, 0, 0);
    self.collectionView.backgroundColor = DFColor(237, 237, 237);
    
    //设置中间按钮
    UIButton *button = [[UIButton alloc]init];
   
    button.frame = CGRectMake(0, 0, 50, 50);
    button.df_centerX = self.view.df_centerX;
    button.df_bottom = self.view.df_height - 100;
    button.alpha = 0.9;
    [button setImage:[UIImage imageNamed:@"X键"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self loadRec];
    [self setRefresh];
   
  
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView.mj_header beginRefreshing];
    //[self.collectionView.mj_header ]


}

// 下拉刷新
- (void)setRefresh{
    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //下拉刷新
    DFRefreshHeader *header = [DFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRec)];
    
    self.collectionView.mj_header = header;
    
    
    //上拉刷新
    DFRefreshFooter *footer = [DFRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.mj_footer = footer;
}
#pragma mark - 加载网络数据
- (void)loadRec{
    //取消所有请求
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSString *url = [TemplataAPI stringByAppendingString:apiStr(@"list.htm")];
    [self.manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.recModelS = [DFRecModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"content"]];
        NSLog(@"DFRecCollection = %@",self.recModelS[0].rec_id);
        [self.collectionView reloadData];
        //让【刷新控件】结束刷新
        [self.collectionView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (void)loadMore{
    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSString *url = [NSString stringWithFormat:@"http://10.0.0.30:8080/app/dishTemplate/list.htm?token=%@",[DFUser sharedManager].token];
    
    [self.manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *moreArray = [DFRecModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"content"]];
        [self.recModelS addObjectsFromArray:moreArray];
        [self.collectionView reloadData];
        //让【刷新控件】结束刷新
        [self.collectionView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_footer endRefreshing];
    }];

}
#pragma mark - 弹出中间菜单
- (void)buttonClick{

    XWPopMenuController *vc = [[XWPopMenuController alloc]init];
    
    //虚化背景
    UIImage *image = [UIImage imageWithCaputureView:self.view];
    
    vc.backImg = image;
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0) return 1;
    //return self.recModelS.count;
    return self.recModelS.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:headerID forIndexPath:indexPath];
        //cell.backgroundColor = [UIColor greenColor];
        cell.layer.shadowOpacity = 0.2;
        //cell.layer.shadowRadius = 4;
        cell.layer.shadowOffset = CGSizeMake(4, 0);
        cell.layer.shadowColor = [UIColor blackColor].CGColor;

        
        DFRecheader *recheader = [[DFRecheader alloc]initWithFrame:CGRectMake(0, 0, cell.df_width, cell.df_height)];
        [cell.contentView addSubview:recheader];
        return cell;
    }else{
        
    DFRecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        cell.layer.shadowOpacity = 0.3;
        cell.layer.shadowOffset = CGSizeMake(4, 4);
        cell.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.layer.masksToBounds = NO;
        cell.recModel = self.recModelS[indexPath.row];

        return cell;
    }

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat headW = collectionView.df_width ;
        return CGSizeMake(headW,  150);
    }else{
    CGFloat cellW = (self.view.frame.size.width - 40)/3 - 1;
    CGFloat cellH = (fDeviceHeight /4 + 5);
//    return CGSizeMake(cellW, 180);
        return CGSizeMake(cellW, cellH);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
   
    if (section == 1) {
        return UIEdgeInsetsMake(10, 10, 0, 10);
    }
    return UIEdgeInsetsMake(35, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        DFRecTemplateController *recTemp = [[DFRecTemplateController alloc]init];
        recTemp.recModel = self.recModelS[indexPath.row];
        [self.navigationController pushViewController:recTemp animated:YES];
    }
}
//头部间距
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return CGSizeMake(collectionView.df_width, 20);
    }else{
        return CGSizeMake(0, 0);
    }
}


@end
