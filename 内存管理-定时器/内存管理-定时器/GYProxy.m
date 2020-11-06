//
//  GYProxy.m
//  内存管理-定时器
//
//  Created by admin on 2020/11/6.
//

#import "GYProxy.h"

@implementation GYProxy

+ (instancetype)proxyWithTarget:(id)target {
    //继承自NSProxy 是没有init方法的，直接alloc方法即可直接分配内存
    GYProxy *proxy = [GYProxy alloc];
    proxy.target = target;
    
    return proxy;
}

//消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}
@end
