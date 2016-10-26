//
//  DFWestController.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFWestController.h"
#import "DFViedeo2ViewController.h"
#import "DFVideoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface DFWestController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    UIView *userCamera;
}



@end

@implementation DFWestController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    UIButton *vedioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    vedioBtn.frame = CGRectMake(50, 100, 100, 30);
    vedioBtn.backgroundColor = MainColor;
    [self.view addSubview:vedioBtn];
    [vedioBtn addTarget:self action:@selector(vedioBtnMethod) forControlEvents:UIControlEventTouchUpInside];
//
//    self.recorder = [[SBVideoRecorder alloc] init];
//    _recorder.delegate = self;
//    _recorder.preViewLayer.frame = CGRectMake(0, 0, fDeviceWidth,fDeviceWidth);
//    [self.view.layer addSublayer:_recorder.preViewLayer];
//    
}
- (void)pushToMe{
//    DFVideoViewController *video = [[DFVideoViewController alloc]init];
//    DFViedeo2ViewController *video = [[DFViedeo2ViewController alloc]init];
//    [self presentViewController:video animated:YES completion:nil];

}
- (void)vedioBtnMethod{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setAllowsEditing:YES];

    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    NSArray *arr = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    //选择媒体类型
    NSMutableArray* marr = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i=0; i<arr.count; i++) {
        NSLog(@"%@",[arr objectAtIndex:i]);
        if ([[arr objectAtIndex:i] isEqualToString:@"public.movie"]) {
            [marr addObject:[arr objectAtIndex:i]];
        }
    }
    picker.mediaTypes = marr;
    picker.delegate = self;
    picker.allowsEditing = YES;
    //设置最长拍摄时长
    picker.videoMaximumDuration = 7.0;
    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    [self presentViewController:picker animated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
   
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success;
    NSError *error;
    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if ([mediaType isEqualToString:@"public.image"]){//照片
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        //        NSLog(@“found an image”);
        NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
        success = [fileManager fileExistsAtPath:imageFile];
        //        imageView.image = image;
        if(success) {
            success = [fileManager removeItemAtPath:imageFile error:&error];
        }
        [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFile atomically:YES];
    }else if ([mediaType isEqualToString:@"public.movie"])
    {
        
        //拿到视频地址
        NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];

        NSURL *newVideoUrl ; //一般.mp4
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
    }
//    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
       
    }
}
- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
//                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
//                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
//                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
//                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
//                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 
             UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                 
//                 [self alertUploadVideo:outputURL];
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}
@end
