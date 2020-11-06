//
//  GYTimer.h
//  内存管理-定时器
//
//  Created by admin on 2020/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GYTimer : NSObject

/// 使用该方法不需要时，需要手动停止定时器，不然定时器不会销毁，会一直在内存中执行
/// @param task <#task description#>
/// @param start <#start description#>
/// @param inteval <#inteval description#>
/// @param repeat <#repeat description#>
/// @param async <#async description#>
+ (NSString *)executeTask:(void(^)(void))task
                    start:(NSTimeInterval)start
                 interval:(NSTimeInterval)inteval
                   repeat:(BOOL)repeat
                    async:(BOOL)async;

/// 使用该方法不需要时，需要手动停止定时器，不然定时器不会销毁。 并且该定时器对target对象是强引用，如果不手动关闭定时器，那么会导致target对象不会销毁
/// @param target <#target description#>
/// @param action <#action description#>
/// @param start <#start description#>
/// @param inteval <#inteval description#>
/// @param repeat <#repeat description#>
/// @param async <#async description#>
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
