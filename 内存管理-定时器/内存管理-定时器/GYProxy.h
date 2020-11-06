//
//  GYProxy.h
//  内存管理-定时器
//
//  Created by admin on 2020/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GYProxy : NSProxy

@property (nonatomic, weak)id target;
+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
