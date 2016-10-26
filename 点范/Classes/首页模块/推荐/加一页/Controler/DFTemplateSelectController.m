//
//  DFTemplateSelectController.m
//  点范
//
//  Created by Masteryi on 2016/9/27.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFTemplateSelectController.h"
#import "DFTemplateSelectCell.h"
#import "DFUser.h"
#import "DFHTTPSessionManager.h"
#import "DFTempMedol.h"
#import "MJExtension.h"
#import "DFfootCollectionController.h"

@interface DFTemplateSelectController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;
/** 网络管理者 */
@property (nonatomic,strong)DFHTTPSessionManager *manager;

@property (nonatomic,strong)NSMutableArray<DFTempMedol *> *tempArray;

@end

@implementation DFTemplateSelectController

static NSString *const tempSelectID = @"tempSelect";

#pragma mark - 懒加载
- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray<DFTempMedol *> *)tempArray{
    if (!_tempArray) {
        _tempArray = [NSMutableArray array];
    }
    return _tempArray;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"加一页";
    [self setCollection];
    [self loadtTemp];
    [self setNavItem];
}

- (void)setNavItem{
    UIButton *preBtn = [UIButton buttonWithType:0];
    [preBtn setTitle:@"预览" forState:UIControlStateNormal];
    [preBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    preBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [preBtn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:preBtn];
     self.navigationItem.rightBarButtonItems = @[rightItem];
}

- (void)setCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.headerReferenceSize = CGSizeMake(self.view.df_width, 10);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor darkGrayColor];
    //定义每个UICollectionView 横向的间距
    layout.minimumLineSpacing = 5;
    //定义每个UICollectionView 纵向的间距
    layout.minimumInteritemSpacing = 5;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[DFTemplateSelectCell class] forCellWithReuseIdentifier:tempSelectID];
    self.collectionView = collectionView;
    
}
#pragma mark - 网络加载
- (void)loadtTemp{
    NSString *url = [TemplataAPI stringByAppendingString:apiStr(@"pageListByResultId.htm")];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    parmeter[@"dishTemplateResultId"] = self.disTempResultID;
    
    [self.manager GET:url parameters:parmeter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucess) {
            _tempArray = [DFTempMedol mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"dishTemplatePageResults"]];
            [self.collectionView reloadData];
        }else{
            UIAlertController *altrt = [UIAlertController actionWithMessage:MsgMessage];
            [self presentViewController:altrt animated:YES completion:nil];
        }
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}

#pragma mark - UICollectionView delegate dataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _tempArray.count;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DFTemplateSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tempSelectID forIndexPath:indexPath];
    cell.tempMedel = self.tempArray[indexPath.row];
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake((fDeviceWidth - 15) / 2, (fDeviceWidth - 15) / 2 + 50);
}
//间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 64 + DFMargin, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *url = [TemplataAPI stringByAppendingString:apiStr(@"addPage.htm")];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"dishTemplatePageId"] = self.tempArray[indexPath.row].temp_id;
   
    parameter[@"dishTemplateResultId"] = self.disTempResultID;

    [self.manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addCell" object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loadResult" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


@end
