//
//  DFTestViewController.m
//  点范
//
//  Created by Masteryi on 2016/10/7.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFTestViewController.h"
#import "SVProgressHUD.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <AVFoundation/AVFoundation.h>

@interface DFTestViewController ()<UIWebViewDelegate,AVAudioPlayerDelegate>{
    NSURL *recordedFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
}
@property (nonatomic) BOOL isRecording;

@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic,weak) JSContext * context;

@end

@implementation DFTestViewController

- (void)viewDidUnload
{
//    [self setPlayButton:nil];
//    [self setRecordButton:nil];
    recorder = nil;
    player = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // [fileManager removeItemAtPath:recordedFile.path error:nil];
    [fileManager removeItemAtURL:recordedFile error:nil];
    recordedFile = nil;
    [super viewDidUnload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupWebView];
    
    // 临近状态检测
    
    // 当你的身体靠近iPhone而不是触摸的时候，iPhone将会做出反应。（需要一定的面的影射，约5mm左右的时候就会触发）
    
    // YES 临近 消息触发
    
    // NO
    
    BOOL proximityState = [[UIDevice currentDevice]proximityState];
    
    NSLog(@"++++++++%d",proximityState);
    
    UIDevice *device = [UIDevice currentDevice ];
    
    device.proximityMonitoringEnabled=YES; // 允许临近检测
    
    if (device.proximityMonitoringEnabled == YES) {
        
        // 临近消息触发
        
        [[NSNotificationCenter defaultCenter] addObserver:self
         
                                                 selector:@selector(proximityChanged:)
         
                                                     name:UIDeviceProximityStateDidChangeNotification object:device];
        
    }
    
    
    
    self.isRecording = NO;
    
    recordedFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:@"RecordedFile.wav"]];
    NSLog(@"%@",recordedFile);
    //在获得一个AVAudioSession类的实例后，你就能通过调用音频会话对象的setCategory:error:实例方法，来从IOS应用可用的不同类别中作出选择。
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *sessionError;
    //设置可以播放和录音状态
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    

}

- (void)setupWebView{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle]
                           pathForResource:@"testVideo" ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [webView loadHTMLString:htmlCont baseURL:baseURL];
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"hello(a)"]];
    [self.view addSubview:webView];
    self.webView = webView;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"网页加载完毕");
    //获取js的运行环境
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //html调用无参数OC
    _context[@"start"] = ^(){
        NSLog(@"start");
        [self startClick];
    };
    _context[@"stop"] = ^(){
        NSLog(@"stop");
        [self stopClick];
    };
    _context[@"get"] = ^(){
        NSLog(@"get");
    };
    _context[@"play"] = ^(){
        NSLog(@"play");
        [self play];
    };
    
    //    //html调用OC(传参数过来)
    //    _context[@"test2"] = ^(){
    //        NSArray * args = [JSContext currentArguments];//传过来的参数
    //        //        for (id  obj in args) {
    //        //            NSLog(@"html传过来的参数%@",obj);
    //        //        }
    //        NSString * name = args[0];
    //        NSString * str = args[1];
    //        [self menthod2:name and:str];
    //    };
}

- (void)startClick{
    //先设置能播放和录音状态
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    self.isRecording = YES;
    //初始化录音
    recorder = [[AVAudioRecorder alloc] initWithURL:recordedFile settings:nil error:nil];
    //准备录音
    [recorder prepareToRecord];
    //开始录音
    [recorder record];
    player = nil;

}

- (void)stopClick{
    self.isRecording = NO;
    //录音停止
    [recorder stop];
    recorder = nil;
    
    NSError *playerError;
    //初始化播放器
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:recordedFile error:&playerError];
    
    if (player == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    //设置播放器代理
    player.delegate = self;
    //设置从扬声器播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)play{
    [player play];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


// 临近手机消息触发

- (void) proximityChanged:(NSNotification *)notification {
    //--------------------------------------------------------------
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗
    
    if ([[UIDevice currentDevice] proximityState] == YES)
        
    {
        
        NSLog(@"接近耳朵");
        //设置从听筒不放,状态设置成播放和录音
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
        
        
    }
    
    else//没黑屏幕
        
    {
        
        NSLog(@"不接近耳朵");
        //设置扬声器播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        //        if (![player isPlaying]) {//没有播放了，也没有在黑屏状态下，就可以把距离传感器关了
        //
        //            [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
        //
        //        }
        
    }
    //-------------------------------------------------------------------------------
    
    
}

@end
