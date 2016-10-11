//
//  DFChineseFoodController.m
//  点范
//
//  Created by Masteryi on 16/9/6.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFChineseFoodController.h"
#import "SVProgressHUD.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <AVFoundation/AVFoundation.h>

#define kRecordAudioFile @"myRecord.mp3"


@interface DFChineseFoodController ()<UIWebViewDelegate>

@property (nonatomic,weak) JSContext * context;

@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic,strong) NSTimer *timer;//录音声波监控（注意这里暂时不对播放进行监控）

@property (strong, nonatomic) UIButton *record;//开始录音
@property (strong, nonatomic) UIButton *pause;//暂停录音
@property (strong, nonatomic) UIButton *resume;//恢复录音
@property (strong, nonatomic) UIButton *stop;//停止录音
@property (strong, nonatomic) UIProgressView *audioPower;//音频波动

@end

@implementation DFChineseFoodController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _audioPower= [[UIProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
    _audioPower.frame=CGRectMake(0, 100, self.view.bounds.size.width, 36);
    [self.view addSubview:_audioPower];
    [self setupWebView];
   
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
        [self recordClick];
    };
    _context[@"stop"] = ^(){
        [self stopClick];
    };
    _context[@"get"] = ^(){
        [self getSavePath];
    };
    _context[@"play"] = ^(){
        //NSLog(@"paly");
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

- (void)setVoice{
    
}
#pragma  mark - 录音

/**
 设置音频会话
 */
- (void)setAudioSession{
    AVAudioSession *audionSession = [AVAudioSession sharedInstance];
    //设置播放和录音状态，以便在录制之后播放录音
    [audionSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audionSession setActive:YES error:nil];
}

/**
 获取录音文件保存路径

 @return 录音文件路径
 */
- (NSURL *)getSavePath{
    NSString *urlStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:urlStr]) {
        NSLog(@"录音不存在");
    }else{
        NSLog(@"%@",urlStr);
        NSLog(@"is exist");
    }
    //urlStr = [urlStr stringByAppendingString:kRecordAudioFile];
    urlStr = [urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"urlStr = %@",urlStr);
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    return url;
    
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSURL *url=[self getSavePath];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}
/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
    [self.audioRecorder updateMeters];//更新测量值
    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress=(1.0/160.0)*(power+160.0);
    [self.audioPower setProgress:progress];
}
- (void)recordClick{
    //    if (![self.audioPlayer isPlaying]) {
    //        [self.audioPlayer play];
    //    }
    //

    NSLog(@"开始录音");
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        self.timer.fireDate=[NSDate distantPast];
    }  
}
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
    NSLog(@"录音完成!");
}
- (void)stopClick{
    NSLog(@"%@",@"停止录音");
    [self.audioRecorder stop];
    self.timer.fireDate=[NSDate distantFuture];
    //self.audioPower.progress=0.0;
    
}
@end
