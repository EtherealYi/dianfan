//
//  DFiconChooseController.m
//  点范
//
//  Created by Masteryi on 2016/10/14.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFiconChooseController.h"
#import "Masonry.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "DFUser.h"
#import "DFHTTPSessionManager.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"


@interface DFiconChooseController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIImageView *imgView;

/** 网络管理者 */
@property (nonatomic,strong)DFHTTPSessionManager *manager;
/** 图片名字 */
@property (nonatomic,strong)NSString *imgName;

@end

@implementation DFiconChooseController

- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return  _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    [self setupChildView];
}

- (void)setupChildView{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"nullIcon"];
    if ([self.pittureCtr isEqualToString:upLoadAvator]) {
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:[DFUser sharedManager].icon] placeholderImage:nil options:SDWebImageProgressiveDownload];
    }
    
    [self.view addSubview:imgView];
    self.imgView = imgView;
    
    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    [uploadBtn setText:@"上传图片" andFont:15 andColor:WhiteColor];
    if ([self.pittureCtr isEqualToString:[NSString stringWithFormat:@"%@",upLoadAvator]]) {
        [uploadBtn setTitle:@"上传头像" forState:UIControlStateNormal];
    }else{
        [uploadBtn setTitle:@"上传logo" forState:UIControlStateNormal];
    }
    [uploadBtn CornerAndShdow];
    [uploadBtn addTarget:self action:@selector(alterHeadPortrait) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:uploadBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setText:@"确定修改" andFont:15 andColor:WhiteColor];
    [confirmBtn CornerAndShdow];
    [confirmBtn addTarget:self action:@selector(imageUpToWeb:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    [uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(imgView.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(35);
    }];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(uploadBtn.mas_top).offset(-30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];

    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(uploadBtn.mas_centerX);
        make.top.equalTo(uploadBtn.mas_bottom).offset(30);
        make.left.equalTo(uploadBtn.mas_left);
        make.right.equalTo(uploadBtn.mas_right);
        make.height.mas_equalTo(35);
    }];
}

- (void)test{
    DFFunc
}

/*************************访问相册**************************/

//  方法：alterHeadPortrait
- (void)alterHeadPortrait{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - PickerImage

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];//获取照片原图
    self.imgView.image = newPhoto;
   // [self saveImage:newPhoto WithName:@"avatar"];
    //[self imageUpToWeb:newPhoto];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//保存图片
/**
 保存图片到本地

 @param tempImage tempImage
 @param imageName imageName
 */
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];
    //保存到 document
    [imageData writeToFile:totalPath atomically:NO];
    //保存到 NSUserDefaults

}


/**
 上传图片至服务器

 @param image 选中的图片
 */
- (void)imageUpToWeb:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(self.imgView.image, 0.5);
    NSString *url = [UploadAPI stringByAppendingString:apiStr(self.pittureCtr)];
    
    NSLog(@"%@",self.pittureCtr);
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:imageData forKey:@"file"];
    
    [self.manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [SVProgressHUD show];
        
            if (uploadProgress.completedUnitCount == uploadProgress.totalUnitCount) {
                UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"" message:@"完成" preferredStyle:UIAlertControllerStyleAlert];
                [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alter animated:YES completion:nil];
                [SVProgressHUD dismiss];
            }
        
       
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        if ([self.pittureCtr isEqualToString:[NSString stringWithFormat:@"%@",upLoadAvator]]){
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:responseObject[@"data"] forKey:@"icon"];
            [userDefault synchronize];
            [[DFUser sharedManager] saveIcon:userDefault];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshIcon" object:nil];
        }else{
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)dealloc{
    [SVProgressHUD dismiss];
}
@end
