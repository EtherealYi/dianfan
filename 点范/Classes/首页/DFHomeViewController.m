//
//  DFHomeViewController.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFHomeViewController.h"
#import "LoginViewController.h"
#import "DFMeViewController.h"
#import "DFMessageController.h"
#import "DFRecCollection.h"
#import "DFChineseFoodController.h"
#import "DFQuickFoodController.h"
#import "DFJapanFoodController.h"
#import "DFDessertController.h"
#import "DFWestController.h"
#import "DFAlreadyController.h"
#import "DFUser.h"
#import "AFNetworking.h"
#import "DFTestViewController.h"
#import "DFNavigationController.h"
#import "DFLoginAndShareController.h"

@interface DFHomeViewController ()<UIScrollViewDelegate>
/** 选中按钮 **/
@property (nonatomic,weak) UIButton *selectButton;
/** 滚动视图 **/
@property (nonatomic,weak) UIScrollView *scrollView;
/** 头部视图 **/
@property (nonatomic,weak) UIView *titleView;
/** 个人中心 **/
@property (nonatomic,strong)UIButton *meBtton;

@end

@implementation DFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"模块商城";
    //self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupChild];
    
    [self setupScrollView];
    
    [self setupNavItem];
    
    [self setupTitleView];
    
    [self addChildView];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(meClick) name:@"meClick" object:nil];
 
   
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [[DFUser sharedManager]didLogout];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSLog(@"%@",paths[0]);
   
}

#pragma mark -中间滚动视图
- (void)setupScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.df_width, 0);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}


#pragma mark -显示子控件
- (void)addChildView{
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.df_width;
    UIViewController *childVc = self.childViewControllers[index];
    if (childVc.isViewLoaded) return;
    childVc.view.frame = self.scrollView.bounds;
    childVc.view.df_y = 0;

    childVc.view.df_x = index * self.scrollView.df_width;
    
    childVc.view.df_width = self.scrollView.df_width;
    childVc.view.df_height = self.scrollView.df_height;
    
    
    [self.scrollView addSubview:childVc.view];

}
- (void)setupNavItem{
    //个人中心
    UIButton *meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [meBtn setImage:[UIImage imageNamed:@"通讯录"] forState:UIControlStateNormal];
    [meBtn addTarget:self action:@selector(meClick) forControlEvents:UIControlEventTouchUpInside];
    [meBtn sizeToFit];
    //设置内边距
    meBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 4,3, 4);
    self.meBtton = meBtn;
    UIBarButtonItem *meItem = [[UIBarButtonItem alloc]initWithCustomView:meBtn];
    //消息中心
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [messageBtn sizeToFit];
    [messageBtn addTarget:self action:@selector(MessageClick) forControlEvents:UIControlEventTouchUpInside];
//    [messageBtn handleEvent:UIControlEventTouchUpInside withBlock:^{
//        NSLog(@"Click");
//    }];
    messageBtn.contentEdgeInsets = UIEdgeInsetsMake(3, 6,2, -3);
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc]initWithCustomView:messageBtn];
    
   
    
    self.navigationItem.rightBarButtonItems = @[meItem,messageItem];
}


#pragma mark -头部视图
- (void)setupTitleView{
    UIView *title = [[UIView alloc]init];
    title.backgroundColor = [UIColor whiteColor];
    title.frame = CGRectMake(0, 0, self.view.df_width, 35);
    title.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    title.layer.shadowOpacity = 0.3;
    title.layer.shadowColor = [UIColor grayColor].CGColor;
    //title.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:title];
    self.titleView = title;
    
   //添加按钮
    NSArray *array = @[@"推荐",@"中餐",@"西餐",@"甜品",@"快餐",@"日式"];
    
    CGFloat buttonW = self.view.df_width / array.count;
    CGFloat buttonH = title.df_height;
    
    for (int i =0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:array[i] forState:UIControlStateNormal];
        CGFloat buttonX = i * buttonW;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [title addSubview:button];
        
    }
    UIButton *firstButton = title.subviews.firstObject;
    [self buttonClick:firstButton];
    
}


#pragma mark -添加子控件
- (void)setupChild{

    //推荐
    DFRecCollection *rec = [[DFRecCollection alloc]init];
    [self addChildViewController:rec];
    //中餐
//    DFChineseFoodController *chineses = [[DFChineseFoodController alloc]init];
//    [self addChildViewController:chineses];
    DFTestViewController *test = [[DFTestViewController alloc]init];
    [self addChildViewController:test];
    //西餐
    DFWestController *west = [[DFWestController alloc]init];
    [self addChildViewController:west];
    //甜品
    DFDessertController *desset = [[DFDessertController alloc]init];
    [self addChildViewController:desset];
    //快餐
    DFQuickFoodController *quick =[[DFQuickFoodController alloc]init];
    [self addChildViewController:quick];
    
    DFJapanFoodController *japan = [[DFJapanFoodController alloc]init];
    [self addChildViewController:japan];
   
}


#pragma mark -点击事件
- (void)meClick{
//    if ([[DFUser sharedManager] isLogin] == @NO ) {//如果没有值，进入未登录界面
//        DFMeViewController *Me = [[DFMeViewController alloc]init];
//        [self.navigationController pushViewController:Me animated:YES];
//    }else{//有值，进入登录界面
//        DFAlreadyController *Already = [[DFAlreadyController alloc]init];
//        [self.navigationController pushViewController:Already animated:YES];
//    }
// 
//
    
    if ([DFUser sharedManager].token != nil) {
        DFAlreadyController *Already = [[DFAlreadyController alloc]init];
        [self.navigationController pushViewController:Already animated:YES];
    }else{
       
        DFMeViewController *Me = [[DFMeViewController alloc]init];
        [self.navigationController pushViewController:Me animated:YES];
    }
//    DFLoginAndShareController *loginAndShare = [[DFLoginAndShareController alloc]init];
//    [self.navigationController pushViewController:loginAndShare animated:YES];
    
}
- (void)MessageClick{
    DFMessageController *messageVc = [[DFMessageController alloc]init];
    [self.navigationController pushViewController:messageVc animated:YES];
}

- (void)buttonClick:(UIButton *)button{

    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
   
    
    //让UIScrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = button.tag * self.scrollView.df_width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark -ScrollView代理方法
/**
 *  滚动动画结束调用
 *  alled when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
 前期条件是使用setContentOffset或scrollRectVisible:animated:方法
 */

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self addChildView];
}
/**
 *  动画结束调用
 *
 *  人为拖拽结束时时调用
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     //选中\点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.df_width;
    UIButton *titleButton = self.titleView.subviews[index];
    [self buttonClick:titleButton];
    
    // 添加子控制器的view
    [self addChildView];
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
