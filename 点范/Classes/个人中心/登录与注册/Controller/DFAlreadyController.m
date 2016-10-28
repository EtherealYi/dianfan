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
#import "DFUser.h"
#import "DFDataView.h"
#import "DFDataCenterViewController.h"
#import "DFiconChooseController.h"
#import "DFPersonalViewController.h"
#import "DFSettingViewController.h"
#import "DFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"
#import "DFMessageController.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface DFAlreadyController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *portraitImageView;

@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong)UIImage *iconImage;

@property (nonatomic,strong)DFHTTPSessionManager *manager;

@property (nonatomic,copy)NSString *imgName;

@property (nonatomic,copy)NSString *selectImg;

@end

@implementation DFAlreadyController

static NSString * const HeaderID =@"header";
static NSString * const CellID = @"Me";
static NSString *AlreadyID = @"AlreadyCell";
static NSString *PersonalID = @"PersonalID";

#pragma mark - 懒加载
-(DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}

- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
    
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AlreadyID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PersonalID];

    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshIcon) name:@"refreshIcon" object:nil];
    [self addChild];
    [self setupHeader];
    [self setNavItem];
    
}
- (void)addChild{
    //添加子控件
    DFPersonalViewController *personCtr = [[DFPersonalViewController alloc]init];
    [self addChildViewController:personCtr];
    UIView *publishView = (UIView *)self.childViewControllers[0].view;
    publishView.frame = CGRectMake(0, 0, fDeviceWidth, 400);
    self.tableView.tableFooterView = publishView;
   
}
- (void)setNavItem{
    
    //个人中心
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(pushToSetting) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn sizeToFit];
    //设置内边距
    settingBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 4,3, 4);
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithCustomView:settingBtn];
    //消息中心
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [messageBtn sizeToFit];
    [messageBtn addTarget:self action:@selector(MessageClick) forControlEvents:UIControlEventTouchUpInside];
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
    UIImageView *imageView = [[UIImageView alloc]init];
 
    //CGFloat imgH = icon.size.height * 0.5;
    imageView.frame = CGRectMake(0,DFMargin * 2, 62 , 62);
    imageView.df_centerX = headView.df_centerX;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToChoose)];
    [imageView addGestureRecognizer:tapGeture];
    //设置为圆形
    imageView.layer.cornerRadius=imageView.frame.size.width/2;
    imageView.layer.masksToBounds=YES;
    //  给头像加一个圆形边框
    imageView.layer.borderWidth = 1.5f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [imageView setImage:[UIImage imageNamed:@"X键"]];
    
    if ([DFUser sharedManager].icon) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:[DFUser sharedManager].icon] placeholderImage:nil options:SDWebImageProgressiveDownload];
    }

    self.iconImageView = imageView;
    
    //用户名
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(imageView.df_right + DFMargin,0,130,10);
    label.df_centerY = imageView.df_centerY;
    NSString *number = [DFUser sharedManager].username;

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

#pragma mark - 刷新头像
- (void)refreshIcon{
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[DFUser sharedManager].icon] placeholderImage:nil options:SDWebImageProgressiveDownload];
}



#pragma mark - 页面跳转
- (void)pushToSetting{
    DFSettingViewController *setting = [[DFSettingViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)pushToChoose{
    DFiconChooseController *iconChoose = [[DFiconChooseController alloc]init];
    iconChoose.pittureCtr = [NSString stringWithFormat:@"%@",upLoadAvator];
    [self.navigationController pushViewController:iconChoose animated:YES];
}
- (void)MessageClick{
    DFMessageController *messageVc = [[DFMessageController alloc]init];
    [self.navigationController pushViewController:messageVc animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            DFDataView *dataView = [DFDataView DF_ViewFromXib];
            dataView.df_width = fDeviceWidth;
            return dataView;

        }
            
            break;

        default:
            break;
    }
    return nil;
    


   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if(indexPath.section == 0){// 进入数据中心
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
    if (indexPath.section == 1) return 200;
    return 44;
}
@end
