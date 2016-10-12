//
//  DFeditTempalteController.m
//  点范
//
//  Created by Masteryi on 16/9/13.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFeditTempalteController.h"
#import "DFfootCollectionController.h"
#import "AFHTTPSessionManager.h"
#import "DFUser.h"
#import "MJExtension.h"
#import "DFTempMedol.h"
#import "DFTemplateCell.h"
#import "DFMerchant.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "DFTempWebViewController.h"

@interface DFeditTempalteController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    //删除按钮
    UIButton *deleteBtn;
}
/** collectionView */
@property (nonatomic,strong)UICollectionView *collectionView;
/** 底部控制器 */
@property (nonatomic,strong)DFfootCollectionController *footVc;
/** 底部按钮 */
@property (nonatomic,strong)UIButton *footBtn;
/** 网络 */
@property (nonatomic,strong)AFHTTPSessionManager *manager;
/** 模板模型 */
@property (nonatomic,strong)NSMutableArray<DFTempMedol *> *tempMedelS;

//个人模板id
@property (nonatomic,copy)NSString *dishTemplateResultId;

@property (nonatomic,strong)DFMerchant *merchantMedel;

@property (nonatomic,copy)NSString *bacgroud;

@property (nonatomic,copy)NSString *number;

@end

@implementation DFeditTempalteController
/** cellID **/
static NSString *const cellId = @"cellId";
/** 头部 **/
static NSString *const headerId = @"headerId";
/** 底部 **/
static NSString *const footerId = @"footerId";
/** 商家ID */
static NSString *const MerchantID = @"MerchantID";

#pragma mark - 懒加载
- (DFMerchant *)merchantMedel{
    if (!_merchantMedel) {
        _merchantMedel = [[DFMerchant alloc]init];
    }
    return _merchantMedel;
}
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSString *)bacgroud{
    if (!_bacgroud) {
        _bacgroud = [NSString string];
    }
    return _bacgroud;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    DFFunc
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"模块编辑";
    [self loadCollectionView];
   
    [self loadEditTemp];
    [self addChildVc];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadResultID) name:@"loadResult" object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fromSelect) name:@"fromSelect" object:nil];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.manager.operationQueue cancelAllOperations];
}

#pragma mark - 网络加载

/**
 第一次进入网络加载
 */
- (void)loadEditTemp{
    
    NSString *url = [NSString stringWithFormat:@"http://10.0.0.30:8080/app/dishTemplate/create-one-result.htm?token=%@",[DFUser sharedManager].token];

    NSMutableDictionary *parmaters = [NSMutableDictionary dictionary];
    parmaters[@"dishTemplateId"] = [NSString stringWithFormat:@"%@",self.recModel.rec_id];

    [self.manager GET:url parameters:parmaters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD show];
      
        self.tempMedelS = [DFTempMedol mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"dishTemplatePageResults"]];
        
        
       
        self.dishTemplateResultId = responseObject[@"data"][@"dishTemplateResultId"];
       
        
        _bacgroud = responseObject[@"data"][@"dishTemplateMerchantPageResults"][@"background"];

//        //提示数字Label
        UILabel *numLabel = [[UILabel alloc]init];
        numLabel.frame = CGRectMake(38, 3, 10, 10);
       
        NSString *number = [NSString stringWithFormat:@"%zd",self.tempMedelS.count];
        [numLabel setText:number andFont:11 andColor:WhiteColor];
        [self.footBtn addSubview:numLabel];
        
        [self.collectionView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

}

/**
 排序页面完成了后网络加载
 */
- (void)loadResultID{
    NSString *url = [TemplataAPI stringByAppendingString:apiStr(@"pageResultList.htm")];
    NSMutableDictionary *parmater = [NSMutableDictionary dictionary];
    parmater[@"dishTemplateResultId"] = self.dishTemplateResultId;
    
    [self.manager GET:url parameters:parmater progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD show];
      
        self.tempMedelS = [DFTempMedol mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"dishTemplatePageResults"]];
        [self.collectionView reloadData];
        [SVProgressHUD dismiss];

     
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}


// 设置uicollection
- (void)loadCollectionView{
    

    //初始化collectionview
    UICollectionViewFlowLayout *customLayout = [[UICollectionViewFlowLayout alloc]init];
     customLayout.headerReferenceSize = CGSizeMake(self.view.df_width, 10);//头部大小

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:customLayout];
    
    
    //定义每个UICollectionView 横向的间距
    customLayout.minimumLineSpacing = 5;
    //定义每个UICollectionView 纵向的间距
    customLayout.minimumInteritemSpacing = 5;
   
    collectionView.backgroundColor = [UIColor darkGrayColor];
    
    collectionView.delegate = self;
    
    collectionView.dataSource = self;
    //添加双击事件，退下底部控制器
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    tap2.numberOfTapsRequired = 2.0;
    [collectionView addGestureRecognizer:tap2];
    
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
    //注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MerchantID];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DFTemplateCell class]) bundle:nil] forCellWithReuseIdentifier:cellId];
    
    //设置底部按钮
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(0, 0, 50, 50);
    button.df_centerX = self.view.df_centerX;
    button.df_bottom = self.view.df_height - 100;
    button.alpha = 0.9;
    button.hidden = NO;
    [button setImage:[UIImage imageNamed:@"页面"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showFoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.footBtn = button;

}
#pragma mark - 底部弹出与返回

/**
 退下
 */
- (void)tapClick{

    if (self.footVc.view.df_y < self.view.df_height) {
        [UIView animateWithDuration:0.5 animations:^{
            self.footBtn.hidden = NO;
            [self.footBtn.layer fadeFunction];
            self.footVc.view.df_y = self.view.df_height;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"back" object:nil];
            
        }];
        
    }
}

/**
 弹出
 */
- (void)showFoot{

    //[self addChildVc];
    [UIView animateWithDuration:0.5 animations:^{
       self.footBtn.hidden = YES;
        [self.footBtn.layer fadeFunction];
       self.footVc.view.df_bottom = fDeviceHeight - 64;
        self.footVc.dishTemplateResultId = self.dishTemplateResultId;
        self.footVc.tempMedelS = self.tempMedelS;
        [self.footVc.collectionView reloadData];
        [self.footVc loadTemplate];
        }];

    
}

//增加子控制器
- (void)addChildVc{
    
    //底部控制器
    DFfootCollectionController *foot = [[DFfootCollectionController alloc]init];
    
    CGFloat footH = self.view.df_height / 3 ;
    foot.view.frame = CGRectMake(0, self.view.df_height, self.view.df_width, footH);
    foot.dishTemplateResultId = self.dishTemplateResultId;
    [self addChildViewController:foot];
    [self.view addSubview:self.childViewControllers[0].view];
    
    self.footVc = foot;
}

#pragma mark - UICollectionView delegate dataSource
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tempMedelS.count + 1;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    if (indexPath.row == self.tempMedelS.count) {//商家模板
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MerchantID forIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.df_width, cell.df_height)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:_bacgroud] placeholderImage:nil options:SDWebImageProgressiveDownload];
        [cell.contentView addSubview:imgView];
        [cell.layer fadeFunction];
        
        return cell;
    }else{//个人模板
        
            
        DFTemplateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
       // [cell.layer fadeFunction];
        cell.tempMedol = self.tempMedelS[indexPath.row];
        return cell;

    }
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
        DFTempWebViewController *webVc = [[DFTempWebViewController alloc]init];
        webVc.reultID = self.tempMedelS[indexPath.row].temp_id;
        [self.navigationController pushViewController:webVc animated:YES];
}



@end
