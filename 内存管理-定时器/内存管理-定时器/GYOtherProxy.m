//
//  GYOtherProxy.m
//  内存管理-定时器
//
//  Created by admin on 2020/11/6.
//

#import "GYOtherProxy.h"

@implementation GYOtherProxy

+ (instancetype)proxyWithTarget:(id)target {
    GYOtherProxy *otherProxy = [[GYOtherProxy alloc] init];
    otherProxy.target = target;

    return  otherProxy;
}


-(id)forwardingTargetForSelector:(SEL)aSelector {
    //本质：objc_msgSend(self.target, aSelector)
    return  self.target;
}


@end
