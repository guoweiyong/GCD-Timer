//
//  ViewController.m
//  内存管理-定时器
//
//  Created by admin on 2020/11/5.
//

#import "ViewController.h"
#import "GYOtherProxy.h"
#import "GYProxy.h"
#import "GYTimer.h"

@interface ViewController ()
@property (nonatomic, strong) CADisplayLink * link;
@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong) dispatch_source_t gcdTimer;
@property (nonatomic, strong) NSString * identifier;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self displayLink];
    NSLog(@"begin===++==");
//    self.identifier = [GYTimer executeTask:^{
//            NSLog(@"222222222====%@",[NSThread currentThread]);
//        } start:2.0 interval:1.0 repeat:YES async:NO];
    //self.identifier = [GYTimer executeTaskWithTarget:self action:@selector(timerTest) start:2.0 interval:1.0 repeat:YES async:YES];
    [self gcdTimer22];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [GYTimer cancelTiemr:self.identifier];
}

- (void)gcdTimer22 {
    //创建一个GCD定时器
    dispatch_queue_t queue = dispatch_get_main_queue(); //创建队列
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    /**
     void
     dispatch_source_set_timer(dispatch_source_t source,
         dispatch_time_t start, //开始时间 typedef uint64_t dispatch_time_t;
         uint64_t interval, 间隔时间
         uint64_t leeway); 延迟时间
     
     NSEC_PER_SEC： 纳秒
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"2223333----%@",[NSThread currentThread]);
    });
    
    //启动定时器
    dispatch_resume(timer);
    
    self.gcdTimer = timer;
}

- (void)timer222 {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[GYProxy proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
}

- (void)displayLink {
    //常用属性
    //    duration 两次屏幕刷新的时候间隔，通过此f值g可以拿到屏幕的刷新频率，苹果一般是60hz(一秒60次)是个估值，
    //
    //    NSInteger  frameInterval  多少次屏幕刷新后才调用一次方法 10以后被废弃，默认刷新一次调用一次
    //
    //    timestamp 屏幕显示的上一帧的时间戳，是CoreAnimation使用的时间格式
    //
    //     targetTimestamp 屏幕显示的下一帧时间戳
    //
    //
    //    paused 是否暂停计时器
    //
    //     preferredFramesPerSecond 一秒内执行多次方法 默认60

    //CADisplayLink
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTest)];
//
    //需要添加到runloop中
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)linkTest {
    NSLog(@"----%s----",__func__);
}

- (void)timerTest {
    NSLog(@"----%s----",__func__);
}

- (void)dealloc {
    NSLog(@"%s",__func__);
    [self.timer invalidate];
    self.timer = nil;
}


@end
