//
//  DFReadMessageController.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFReadMessageController.h"
#import "MJExtension.h"
#import "DFHTTPSessionManager.h"
#import "DFUser.h"
#import "DFReadMessage.h"

@interface DFReadMessageController ()
/** 读取信息时间 */
@property (weak, nonatomic) IBOutlet UILabel *readDate;
/** 读取类型 */
@property (weak, nonatomic) IBOutlet UILabel *readTypr;
/** 读取文本 */
@property (weak, nonatomic) IBOutlet UITextView *readTitle;

@property (nonatomic,strong)DFReadMessage *readMsg;

@property (nonatomic,strong)DFHTTPSessionManager *manager;
@end

@implementation DFReadMessageController
#pragma mark - 懒加载
- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"消息中心";
    self.readTitle.editable = NO;
    [self loadReadMsgArray];
}

- (void)loadReadMsgArray{
    NSString *url = [MsgAPI stringByAppendingString:apiStr(@"readMsg.htm")];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"id"] = self.messageMedol.Msg_id;
    [self.manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.readMsg = [DFReadMessage mj_objectWithKeyValues:responseObject[@"data"]];
        
        if ([self.readMsg.infoType isEqualToString:@"SYSTEM"]) {
            self.readTypr.text = @"系统通知";
        }else{
            self.readTypr.text = @"消息通知";
        }
    self.readTitle.text = self.readMsg.content;
    self.readDate.text = self.readMsg.createDate;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
@end
