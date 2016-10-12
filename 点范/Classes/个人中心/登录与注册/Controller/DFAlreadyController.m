//
//  DFAlreadyController.m
//  点范
//
//  Created by Masteryi on 16/9/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFAlreadyController.h"
#import "DFUser.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AFNetworking.h"
#import "DFUser.h"
#import "DFDataView.h"
#import "DFDataCenterViewController.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface DFAlreadyController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *portraitImageView;

@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong)UIImage *iconImage;

@end

@implementation DFAlreadyController

static NSString * const HeaderID =@"header";
static NSString * const CellID = @"Me";
static NSString *AlreadyID = @"AlreadyCell";


- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AlreadyID];
    [self setupHeader];
    [self setNavItem];
    
    
}
- (void)setNavItem{
    
    //个人中心
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [settingBtn sizeToFit];
    //设置内边距
    settingBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 4,3, 4);
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithCustomView:settingBtn];
    //消息中心
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [messageBtn sizeToFit];
    //[messageBtn addTarget:self action:@selector(MessageClick) forControlEvents:UIControlEventTouchUpInside];
    messageBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 4,4, 3);
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc]initWithCustomView:messageBtn];
    
    
    
    self.navigationItem.rightBarButtonItems = @[settingItem,messageItem];
}
- (void)setupHeader{
    //头部视图
    UIView *headView = [[UIView alloc]init];
    headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150 );
    //背景图片
    UIImageView *bmgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景"]];
    
    bmgView.frame = headView.frame;

    [headView addSubview:bmgView];

    
    //设置内容
    //头像
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSLog(@"image - %@",[userDefaults objectForKey:@"avatar"]);
    
    
    //UIImage *icon = [UIImage imageNamed:@"头像"];
    UIImage *icon = [self getImage:[userDefaults objectForKey:@"avatar"]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:icon];
 
    //CGFloat imgH = icon.size.height * 0.5;
    imageView.frame = CGRectMake(0,DFMargin * 2, 62 , 62);
    imageView.df_centerX = headView.df_centerX;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alterHeadPortrait)];
    
    [imageView addGestureRecognizer:tapGeture];
    //设置为圆形
    imageView.layer.cornerRadius=imageView.frame.size.width/2;
    imageView.layer.masksToBounds=YES;
    //  给头像加一个圆形边框
    imageView.layer.borderWidth = 1.5f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView = imageView;
    
    //用户名
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(imageView.df_right + DFMargin,0,130,10);
    label.df_centerY = imageView.df_centerY;
    NSString *number = [DFUser sharedManager].username;
    //NSString *account = [NSString stringWithFormat:@"%@****%@",[number substringToIndex:3],[number substringFromIndex:7]];
    //label.text = account;
    BOOL isNumber = [NSString isPureInt:number];
    if (isNumber == YES) {
        NSString *account = [NSString stringWithFormat:@"%@****%@",[number substringToIndex:3],[number substringFromIndex:7]];
        label.text = account;
    }else{
        label.text = number;
    }
    
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    

    [headView addSubview:imageView];
    [headView addSubview:label];

    //皇冠标志
    UIImage *image = [UIImage imageNamed:@"超级会员"];
    UIImageView *HGView = [[UIImageView alloc]initWithImage:image];
    HGView.frame = CGRectMake(imageView.df_right + DFMargin, label.df_bottom + DFMargin, image.size.width * 0.5, image.size.height * 0.5);
//    [cell.contentView addSubview:HGView];
    [headView addSubview:HGView];
    
    //超级会员标题
    UILabel *vipLabel = [[UILabel alloc]init];
    vipLabel.frame = CGRectMake(0, imageView.df_bottom + 1, 70, 20);
    vipLabel.df_right = headView.df_width;
    vipLabel.backgroundColor = DFColor(139, 114, 66);
    vipLabel.text = @"超级会员";
    vipLabel.textAlignment = NSTextAlignmentRight;
    vipLabel.font = [UIFont systemFontOfSize:14];
    vipLabel.textColor = [UIColor whiteColor];
    vipLabel.layer.masksToBounds = YES;

    [headView addSubview:vipLabel];
    
    //底部view
    UILabel *buttomlabel = [[UILabel alloc]init];
    buttomlabel.frame = CGRectMake(0, 0, headView.df_width, 25);
    buttomlabel.df_bottom = headView.df_height;
    buttomlabel.backgroundColor = [UIColor whiteColor];
    buttomlabel.alpha = 0.5;
    buttomlabel.text = @"   绑定手机，店铺提醒信息早知道";
    buttomlabel.font = [UIFont systemFontOfSize:14];
    buttomlabel.textColor = [UIColor blackColor];
    

    [headView addSubview:buttomlabel];
    
    self.tableView.tableHeaderView = headView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) return 1;
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DFDataView *dataView = [DFDataView DF_ViewFromXib];
        dataView.df_width = fDeviceWidth;
        
        return dataView;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AlreadyID];
    cell.textLabel.text = @"退出登录";
    return cell;
    

   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {// 退出登录
            //初始化提示框；
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录？" preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:@"username"];
                [userDefaults removeObjectForKey:@"token"];
                [userDefaults synchronize];
                [[DFUser sharedManager]didLogout];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
            
        }
    }else{// 进入数据中心
        DFDataCenterViewController *dataCenter = [[DFDataCenterViewController alloc]init];
        [self.navigationController pushViewController:dataCenter animated:YES];
        
        
    }
    
  // 取消选中
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 150;
    return 44;
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
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.iconImageView.image = newPhoto;
    [self saveImage:newPhoto WithName:@"avatar"];
    [self imageUpToWeb:newPhoto];
    [self dismissViewControllerAnimated:YES completion:nil];
    

    
   
}


//保存图片
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];
    //保存到 document
    [imageData writeToFile:totalPath atomically:NO];
    //保存到 NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:totalPath forKey:@"avatar"];
    
/*******************************************************************************/
    
}

- (void)imageUpToWeb:(UIImage *)image{
    
    NSMutableDictionary *paramaters= [NSMutableDictionary dictionary];
    paramaters[@"file"] = @"icon.jpg";
    //paramaters[@"token"] = [DFUser sharedManager].token;
    NSString *url = [NSString stringWithFormat:@"http://10.0.0.30:8080/appMember/login/member/upload.htm?token=%@",[DFUser sharedManager].token] ;

    // 参数
    [[AFHTTPSessionManager manager] POST:url parameters:paramaters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        //NSLog(@"%@",imageData);
        //NSData *imageData = UIImagePNGRepresentation(tempImage);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData  name:@"importFile"fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject[@"data"]);
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];



}

//从document取得图片
- (UIImage *)getImage:(NSString *)urlStr
{
    return [UIImage imageWithContentsOfFile:urlStr];
}

@end
