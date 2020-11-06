//
//  GYTimer.h
//  内存管理-定时器
//
//  Created by admin on 2020/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GYTimer : NSObject

+ (NSString *)executeTask:(void(^)(void))task
                    start:(NSTimeInterval)start
                 interval:(NSTimeInterval)inteval
                   repeat:(BOOL)repeat
                    async:(BOOL)async;

+ (NSString *)executeTaskWithTarget:(id)target
                             action:(SEL)action
                              start:(NSTimeInterval)start
                           interval:(NSTimeInterval)inteval
                             repeat:(BOOL)repeat
                              async:(BOOL)async;

//根据标记取消定时器
+ (void)cancelTiemr:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
