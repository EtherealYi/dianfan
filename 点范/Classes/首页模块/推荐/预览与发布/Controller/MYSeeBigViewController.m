//
//  MYSeeBigViewController.m
//  01-趣好玩
//
//  Created by Masteryi on 16/8/24.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "MYSeeBigViewController.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import <Photos/Photos.h>

@interface MYSeeBigViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic,weak) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *successLab;

@end

@implementation MYSeeBigViewController


static NSString * MYAssetCollectionTitle = @"随身了";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //ScrollView
    self.saveButton.enabled = YES;
    self.successLab.hidden = YES;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = self.twoCodeImg;
    //[imageView sd_setImageWithURL:[NSURL URLWithString:self.Model.image1]];
    //[imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.image1 ] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image == nil) return ;
//        self.saveButton.enabled = YES;
//    }];
    [scrollView addSubview:imageView];
    
//    imageView.df_width = scrollView.df_width;
//    //imageView.df_height = self.topicModel.height * imageView.xmg_width / self.topicModel.width;
//    imageView.df_x = 0;
    
    imageView.frame = CGRectMake(10, 10, 200, 200);
    imageView.df_centerX = self.view.df_centerX ;
    imageView.df_centerY = self.view.df_centerY - 64;
    
    if (imageView.df_height >= scrollView.df_height) { // 图片高度超过整个屏幕
        imageView.df_y = 0;
        // 滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.df_height);
    } else { // 居中显示
        imageView.df_centerY = scrollView.df_height * 0.5;
    }
    self.imageView = imageView;
    
    // 缩放比例
    //CGFloat scale =  self.topicModel.width / imageView.xmg_width;
//    if (scale > 1.0) {
//        scrollView.maximumZoomScale = scale;
//    }

}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save {
    /*
     PHAuthorizationStatusNotDetermined,     用户还没有做出选择
     PHAuthorizationStatusDenied,            用户拒绝当前应用访问相册(用户当初点击了"不允许")
     PHAuthorizationStatusAuthorized         用户允许当前应用访问相册(用户当初点击了"好")
     PHAuthorizationStatusRestricted,        因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
     */
    
    // 判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
        [SVProgressHUD showErrorWithStatus:@"因为系统原因, 无法访问相册"];
    } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册(用户当初点击了"不允许")
        //MYLog(@"提醒用户去[设置-隐私-照片-xxx]打开访问开关");
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册(用户当初点击了"好")
        [self saveImage];
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                [self saveImage];
            }
        }];
    }
    
}
- (void)saveImage
{
    // PHAsset : 一个资源, 比如一张图片\一段视频
    // PHAssetCollection : 一个相簿
    
    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
    __block NSString *assetCollectionLocalIdentifier = nil;
    
    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetLocalIdentifier = nil;
    
    // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存图片A到"相机胶卷"中
        // 创建图片的请求
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            //MYLog(@"保存[图片]到[相机胶卷]中失败!失败信息-%@", error);
            return;
        }
        
        // 获得曾经创建过的相簿
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        if (createdAssetCollection) { // 曾经创建过相簿
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // 3.添加"相机胶卷"中的图片A到"相簿"D中
                
                // 获得图片
                PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
                
                // 添加图片到相簿中的请求
                PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
                
                // 添加图片到相簿
                [request addAssets:@[asset]];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success == NO) {
                   // MYLog(@"添加[图片]到[相簿]失败!失败信息-%@", error);
                } else {
                   #pragma mark - 添加成功
                    //添加成功

                }
            }];
        } else { // 没有创建过相簿
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // 2.创建"相簿"D
                // 创建相簿的请求
                assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:MYAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success == NO) {
                    //MYLog(@"保存相簿失败!失败信息-%@", error);
                    return;
                }
                
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    // 3.添加"相机胶卷"中的图片A到新建的"相簿"D中
                    
                    // 获得相簿
                    PHAssetCollection *assetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
                    
                    // 获得图片
                    PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
                    
                    // 添加图片到相簿中的请求
                    PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                    
                    // 添加图片到相簿
                    [request addAssets:@[asset]];
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    if (success == NO) {
                        //MYLog(@"添加[图片]到[相簿]失败!失败信息-%@", error);
                    } else {
                       
                       
                    }
                }];
            }];
        }
    }];
}


- (PHAssetCollection *)createdAssetCollection
{
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:MYAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    
    return nil;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}



@end
