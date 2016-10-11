//
//  DFRecheader.m
//  点范
//
//  Created by Masteryi on 16/9/9.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFRecheader.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "DFTopImg.h"

#define  imgCount 3

@interface DFRecheader()<UIScrollViewDelegate>

@property(nonatomic,weak)UIPageControl *pageControl;

@property (nonatomic,weak)UIScrollView *Scroller;
/** 记录页数 */
@property (nonatomic,assign)int page;
/** 定时器 */
@property (nonatomic,strong)NSTimer *timer;
/** 图片数组 */
@property (nonatomic,strong)NSMutableArray<DFTopImg *> *imgArrays;

@end

@implementation DFRecheader



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        [[AFHTTPSessionManager manager]GET:@"http://10.0.0.30:8080/app/ad/list.htm" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"Header = %@",responseObject[@"data"][@"errMsg"]);
   
                self.imgArrays = [DFTopImg mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"content"]];
            UIScrollView *scrollView = [[UIScrollView alloc]init];
            scrollView.frame = CGRectMake(0, 0, self.df_width, self.df_height);
            //scrollView.backgroundColor = [UIColor purpleColor];
            //设置图片固定尺寸
            CGFloat imageW = scrollView.frame.size.width;
            CGFloat imageH = scrollView.frame.size.height;
            CGFloat Y = 0;
            
            //1.将3张图片添加到scrollView中
            for (int i = 0;i < imgCount ; i++) {
                //初始化imageView
                UIImageView *imageView=[[UIImageView alloc]init];
                //设置frame
                CGFloat X=i*imageW;
                imageView.frame= CGRectMake(X, Y, imageW, imageH);
                //设置图片(网络获取)
                [imageView sd_setImageWithURL:[NSURL URLWithString:self.imgArrays[i].path] placeholderImage:[UIImage imageNamed:@"zhanwei"] options:SDWebImageProgressiveDownload];

                
                [scrollView addSubview:imageView];
            }
            
            //设置scrollView内容尺寸
            CGFloat scrollW=imgCount * imageW;
            scrollView.contentSize=CGSizeMake(scrollW, 0);
            
            //隐藏水平滚动条
            scrollView.showsHorizontalScrollIndicator=NO;
            scrollView.pagingEnabled = YES;
            scrollView.delegate = self;
            
            [self addSubview:scrollView];
            self.Scroller = scrollView;
            
            //设置页数
            UIPageControl *pageCtr = [[UIPageControl alloc]init];
            pageCtr.frame = CGRectMake(DFMargin,DFMargin , 40, 10);
            pageCtr.pageIndicatorTintColor = [UIColor whiteColor];
            pageCtr.currentPageIndicatorTintColor = [UIColor redColor];
            [self addSubview:pageCtr];
            self.pageControl = pageCtr;
            self.pageControl.numberOfPages = imgCount;
            
            
            //设置定时器
            [self addTimer];
            

                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //NSLog(@"%@",error);
        }];
        
        
        

        
        
    }

    return self;
}

-(void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//停止定时器
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

/**播放下一页方法*/
-(void)nextImage{
    // 1.增加pageControl的页码

    int page = 0;
    if (self.pageControl.currentPage == imgCount - 1) {
        page = 0;
    }else{
        page = (int)(self.pageControl.currentPage + 1);
    }
    
    // 2.计算scrollView滚动的位置
    CGFloat offsetX = page * self.Scroller.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.Scroller setContentOffset:offset animated:YES];
    
    
    
    
}

#pragma mark scrollView代理方法
/**
 *  当scroll正在滚动时
 *
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //根据scrollView的滚动位置决定pageControl显示第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
//    self.page = page;
    self.pageControl.currentPage = page;
}
/**
 *  当开始拖拽时候
 *
 *  @param scrollView scrollView description
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
    
}

/**
 *  当停止拖拽的时候
 *
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

@end
