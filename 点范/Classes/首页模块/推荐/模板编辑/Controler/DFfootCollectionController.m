//
//  DFfootCollectionController.m
//  点范
//
//  Created by Masteryi on 16/9/14.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFfootCollectionController.h"
#import "DFLineLayout.h"
#import "DFUser.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "DFResultModel.h"
#import "DFResultCell.h"
#import "DFTemplateSelectController.h"
#import "SVProgressHUD.h"

@interface DFfootCollectionController (){
    //删除按钮
    UIButton *deleteBtn;
    //删除位置
    NSInteger deleteIndexPath;
    //选中的cell的位置
    NSIndexPath *selectIndex;
}
/** 数据源 **/
@property (nonatomic, strong) NSMutableArray *arrays;

@property (nonatomic,assign)BOOL isHight;
/** 头部视图 */
@property (nonatomic,strong)UIView *headView;
/** 网络请求者 */
@property (nonatomic,strong)AFHTTPSessionManager *manager;
/** 个人模板数组 */
@property (nonatomic,strong) NSMutableArray <DFResultModel *> *resultMedelS;



@end

@implementation DFfootCollectionController

static NSString * const foot = @"foot";
static NSString * const headID = @"footHead";

#pragma mark - 懒加载


- (NSMutableArray<DFResultModel *> *)resultMedelS{
    if (!_resultMedelS) {
        _resultMedelS = [NSMutableArray array];
    }
    return _resultMedelS;
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (instancetype)init{
    
    DFLineLayout *line = [[DFLineLayout alloc]init];
        
    
    return [super initWithCollectionViewLayout:line];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];

    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DFResultCell class]) bundle:nil] forCellWithReuseIdentifier:foot];

    //长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    
    [self.collectionView addGestureRecognizer:longPress];
    
    //设置cell上的删除按钮
  
    deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, 0, 20, 20);
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"删除模板"] forState:UIControlStateNormal];
   
    [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];

    [self loadheadView];
    
    //通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cellClick) name:@"back" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadTemplate) name:@"addCell" object:nil];
    
}
//当控制器销毁时取消所有网络请求
- (void)dealloc{
    [SVProgressHUD dismiss];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [_manager.operationQueue cancelAllOperations];
     
}
//加载网络数据
- (void)loadTemplate{
    
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
    parmeters[@"dishTemplateResultId"] = self.dishTemplateResultId;
    
    NSString *url = [TemplataAPI stringByAppendingString:apiStr(@"pageResultList.htm")];

    [self.manager GET:url parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucess) {
            [SVProgressHUD show];
            
            _resultMedelS = [DFResultModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"dishTemplatePageResults"]];
            [self.collectionView reloadData];
            [SVProgressHUD dismiss];
        }else{
            UIAlertController *altrt = [UIAlertController actionWithMessage:MsgMessage];
            [self presentViewController:altrt animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}


- (void)loadheadView{
    //创建headview
    UIView *headView = [[UIView alloc]init];
    headView.frame = CGRectMake(0, 0, fDeviceWidth, 25);
    self.headView = headView;
   
    //文字label
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, 5, 100, 20);
    label.text = @"长按拖动顺序";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];

    [headView addSubview:label];

    //添加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 5, 20, 20);
    addBtn.df_right = self.collectionView.df_width - DFMargin;
    [addBtn setBackgroundImage:[UIImage imageNamed:@"添加模板"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:addBtn];
    [self.collectionView addSubview:headView];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _resultMedelS.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    DFResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:foot forIndexPath:indexPath];
    cell.selected = NO;
    cell.resultModel = _resultMedelS[indexPath.row];

    [cell setDictonaryKey:indexPath];
    return cell;
}

#pragma mark - 长按拖动

/**
 长按拖动事件

 @param longGesture 拖动手势
 */
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
                //判断手势落点位置是否在路径上
                 NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
           
            
                DFResultCell *cell = (DFResultCell *)[self.collectionView cellForItemAtIndexPath:indexPath];

//            
//            CGPoint pInView = [self.view convertPoint:self.collectionView.center toView:self.collectionView];
//            
//            NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pInView];
            
            //删除按钮
                deleteBtn.hidden = NO;
                deleteBtn.df_right = cell.df_width + 1;
                //点击事件
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellClick)];
                [cell addGestureRecognizer:tap];
                [cell addSubview:deleteBtn];
            
                    deleteIndexPath = indexPath.row;
                    selectIndex = indexPath;
                    
            
                if (indexPath == nil) {
                    break;
                }

                //在路径上则开始移动该路径上的cell
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];

            }
            break;
        case UIGestureRecognizerStateChanged:{
            
           
            //移动过程当中随时更新cell位置
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            deleteIndexPath = indexPath.row;
            selectIndex = indexPath;
        }
            break;
        case UIGestureRecognizerStateEnded:
 
            
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}


- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回YES允许其item移动
    return YES;
}

/**
 排序
 @param sourceIndexPath      现在位置
 @param destinationIndexPath 目标位置
 */
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
 
    //取出源item数据
    id objc = [_resultMedelS objectAtIndex:sourceIndexPath.item];
     //从资源数组中移除该数据
    [_resultMedelS removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [_resultMedelS insertObject:objc atIndex:destinationIndexPath.item];
    
    for (int i =0; i < _resultMedelS.count; i ++) {
        //NSLog(@"转换中 = %@,%@",_resultMedelS[i].result_id,_resultMedelS[i].order);
    }
    NSMutableArray *order = [NSMutableArray array];
    
    for (int i = 1; i <= _resultMedelS.count ; i ++) {
        _resultMedelS[i-1].order = [NSString stringWithFormat:@"%d",i];
       
        for (int j = 0; j < _resultMedelS.count; j++) {
            NSString *page = [NSString stringWithFormat:@"%@:%@",_resultMedelS[j].result_id,_resultMedelS[j].order];
            [order addObject:page];
        }
    }
    NSString *pageString = [order componentsJoinedByString:@","];
    NSString *url = [TemplataAPI stringByAppendingString:apiStr(@"savePageOrder.htm")];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"dishTemplateResultId"] = self.dishTemplateResultId;

    parameters[@"pageOrders"] = pageString;
    
    [self.manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [[NSNotificationCenter defaultCenter]postNotificationName:@"loadResult" object:nil];
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}



#pragma mark - 点击事件
- (void)cellClick{
    deleteBtn.hidden = YES;
    
}

/**
 删除模板
 */
- (void)deleteAction:(UIButton *)sender{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//确定，删除网络请求，并从数据源中删除数据
        
        DFResultCell *cell = (DFResultCell *)[self.collectionView cellForItemAtIndexPath:selectIndex];
        NSString *disID = cell.resultModel.result_id;
        NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
        parmeters[@"dishTemplatePageResultId"] = disID;
        
        NSString *url = [TemplataAPI stringByAppendingString:apiStr(@"deletePage.htm")];
        
        [self.manager GET:url parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [_resultMedelS removeObjectAtIndex:deleteIndexPath];
            [deleteBtn removeFromSuperview];
            [self.collectionView reloadData];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loadResult" object:nil];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

        
    }]];
      [alter addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alter animated:YES completion:nil];

}


- (void)addAction:(UIButton *)sender{
    deleteBtn.hidden = YES;
    DFTemplateSelectController *tempSelect = [[DFTemplateSelectController alloc]init];
    tempSelect.disTempResultID = self.dishTemplateResultId;
    [self.navigationController pushViewController:tempSelect animated:YES];
   
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect rect = self.headView.frame;
    rect.origin.x =  scrollView.contentOffset.x;
    self.headView.frame = rect;
}



@end
