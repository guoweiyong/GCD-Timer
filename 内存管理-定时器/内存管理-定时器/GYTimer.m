//
//  GYTimer.m
//  内存管理-定时器
//
//  Created by admin on 2020/11/6.
//

#import "GYTimer.h"

//缓存定时器
static NSMutableDictionary *cachesTiemr;
dispatch_semaphore_t semaphore;
@implementation GYTimer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cachesTiemr = [NSMutableDictionary dictionary];
        semaphore = dispatch_semaphore_create(1);
    });
}

+ (NSString *)executeTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)inteval repeat:(BOOL)repeat async:(BOOL)async {
    if (!task || start < 0 || (inteval <= 0 && repeat)) return nil;
    
    //创建一个GCD定时器
    dispatch_queue_t queue = async ? dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    : dispatch_get_main_queue(); //创建队列
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), inteval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    

    //为了保证多线程安全 同时操作字典，我们需要加锁
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    //创建每个定时器对应的标记
    NSString *identifier = [NSString stringWithFormat:@"%ld",cachesTiemr.count];
    //定时器添加到字典，背字典引用， 字典被当前类强引用
    cachesTiemr[identifier] = timer;
    
    dispatch_semaphore_signal(semaphore);
    
    dispatch_source_set_event_handler(timer, ^{
        task();
        
        if (!repeat) {
            //如果不是重复，那么直接取消该定时器
            [self cancelTiemr:identifier];
        }
    });
    
    //启动定时器
    dispatch_resume(timer);
    
    
    return  identifier;
}

+ (NSString *)executeTaskWithTarget:(id)target action:(SEL)action start:(NSTimeInterval)start interval:(NSTimeInterval)inteval repeat:(BOOL)repeat async:(BOOL)async {
    if (!target || !action) return nil;
    
    return [self executeTask:^{
        //去除警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
    //写在这个中间的代码,都不会被编译器提示-Wdeprecated-declarations类型的警告
        if ([target respondsToSelector:action]) {
            [target performSelector:action];
        }
#pragma clang diagnostic pop
        
        
    } start:start interval:inteval repeat:repeat async:async];
}


+ (void)cancelTiemr:(NSString *)identifier {
    if (!identifier || identifier.length == 0) {
        return;
    }
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_source_t timer = cachesTiemr[identifier];
    if (timer) {
        dispatch_source_cancel(timer);
        [cachesTiemr removeObjectForKey:identifier];
    }
    
    dispatch_semaphore_signal(semaphore);
}



@end
