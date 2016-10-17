//
//  DFPersonalViewController.m
//  点范
//
//  Created by Masteryi on 2016/10/14.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFPersonalViewController.h"
#import "DFPublishController.h"

@interface DFPersonalViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UIView *indicatorView;

@property (nonatomic,strong)UIButton *selectButton;

@property (nonatomic,strong)UIView *titleView;

@end

@implementation DFPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = MainColor;
    
    [self addChild];
    [self setupTitleView];
    [self setupScrollView];
    [self addChildView];
    self.view.backgroundColor = WhiteColor;
    
    
}

- (void)addChild{
 
    for (int i = 0; i < 3; i ++) {
        DFPublishController *publish = [[DFPublishController alloc]init];
        [self addChildViewController:publish];
    }
    return ;
    
}


- (void)setupScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 35, fDeviceWidth, 365);
    
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(3 * scrollView.df_width, 0);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupTitleView{
    UIView *title = [[UIView alloc]init];
    title.backgroundColor = [UIColor whiteColor];
    title.frame = CGRectMake(0, 0, fDeviceWidth, 35);
    title.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    title.layer.shadowOpacity = 0.3;
    title.layer.shadowColor = [UIColor grayColor].CGColor;
    [self.view addSubview:title];
    self.titleView = title;
    
    //添加按钮
    NSArray *array = @[@"已发布的模板",@"未发布的模板",@"我的模板"];
    
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
        [button setTitleColor:MainColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [title addSubview:button];
        
    }
    //底部指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = MainColor;
    indicatorView.df_height = 3;
    indicatorView.df_y = title.df_height - 3;
    [title addSubview:indicatorView];
    self.indicatorView = indicatorView;
    indicatorView.df_width = fDeviceWidth / 3;
    //取出第一个按钮
     UIButton *firstBtn = title.subviews.firstObject;
    //默认情况下选中第一个按钮
    [self buttonClick:firstBtn];

}

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

#pragma mark -ScrollerVoew代理方法
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
    // 选中\点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.df_width;
    UIButton *titleButton = self.titleView.subviews[index];
    [self buttonClick:titleButton];
    
    // 添加子控制器的view
    [self addChildView];
}


- (void)buttonClick:(UIButton *)button{
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.df_width = fDeviceWidth / 3;
        self.indicatorView.df_centerX = button.df_centerX;
    }];
    
    //让UIScrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = button.tag * self.scrollView.df_width;
    [self.scrollView setContentOffset:offset animated:YES];
}


@end
