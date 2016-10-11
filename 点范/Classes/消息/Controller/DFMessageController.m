//
//  DFMessageController.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFMessageController.h"
#import "DFMessageCell.h"
#import "DFReadMessageController.h"
#import "DFMessage.h"
#import "AFNetworking.h"
#import "DFHTTPSessionManager.h"
#import "DFUser.h"
#import "MJExtension.h"

@interface DFMessageController ()

/** 消息数组 */
@property (nonatomic,strong)NSMutableArray<DFMessage *> *messageArray;
/** 网络管理者 */
@property (nonatomic,strong)DFHTTPSessionManager *manager;

@property (nonatomic,assign)NSUInteger numberCount;

@end

@implementation DFMessageController

static NSString *const MessageID = @"Message";

#pragma mark - 懒加载
- (DFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [DFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = [NSString stringWithFormat:@"消息中心"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DFMessageCell class]) bundle:nil] forCellReuseIdentifier:MessageID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 75;
    
    [self loadMessage];
}

- (void)loadMessage{
    NSString *url = [NSString stringWithFormat:@"listMsg.htm?token=%@",[DFUser sharedManager].token];
    [self.manager POST:[MsgAPI stringByAppendingString:url] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.messageArray = [DFMessage mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.numberCount = self.messageArray.count;

        self.title = [NSString stringWithFormat:@"消息中心(%zd)",self.messageArray.count];
    
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.messageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DFMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageID];
    cell.messageMedel = self.messageArray[indexPath.row];
    //右边有箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell选中无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DFReadMessageController *read = [[DFReadMessageController alloc]init];
    read.messageMedol = self.messageArray[indexPath.row];
    [self.navigationController pushViewController:read animated:YES];
}

// cell可删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        NSString *url = [MsgAPI stringByAppendingString:apiStr(@"delMsg.htm")];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"id"] = self.messageArray[indexPath.row].Msg_id;
        [self.manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        [self.messageArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
       [tableView setEditing:NO animated:YES];
}

//以下方法可以不是必须要实现，添加如下方法可实现特定效果：
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


@end
