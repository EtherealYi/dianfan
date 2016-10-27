//
//  DFTwoCodeViewController.m
//  点范
//
//  Created by Masteryi on 2016/10/24.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFTwoCodeViewController.h"
#import "MYSeeBigViewController.h"

@interface DFTwoCodeViewController ()

@property (nonatomic,strong)UIImage *hightImage;

@end

@implementation DFTwoCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    // 2.过滤器恢复默认设置
    [filter setDefaults];

    // 3.给过滤器添加数据(正则表达式/帐号和密码) -- 通过KVC设置过滤器,只能设置NSData类型
    NSString *dataString = @"http://www.feng.com/";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];

    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    // 5.高清二维码
    UIImage *hightImg = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
    self.hightImage = hightImg;
     // 6.显示二维码
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = hightImg;
    imgView.frame = CGRectMake(10, 10, 200, 200);
    imgView.df_centerX = self.view.df_centerX ;
    imgView.df_centerY = self.view.df_centerY - 64;
    imgView.backgroundColor = MainColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveImgCtr)];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:tap];
    
    [self.view addSubview:imgView];
}
- (void)saveImgCtr{
    
    MYSeeBigViewController *seeBig = [[MYSeeBigViewController alloc]init];
    seeBig.twoCodeImg = self.hightImage;
    [self presentViewController:seeBig animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
