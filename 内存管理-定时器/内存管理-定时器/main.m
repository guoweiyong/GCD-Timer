//
//  main.m
//  内存管理-定时器
//
//  Created by admin on 2020/11/5.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GYOtherProxy.h"
#import "GYProxy.h"
#import "ViewController.h"


int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
//        ViewController *vc = [[ViewController alloc] init];
//        
//        GYOtherProxy *otherProxy = [GYOtherProxy proxyWithTarget:vc];
//        GYProxy *proxy = [GYProxy proxyWithTarget:vc];
//        
//        NSLog(@"otherproxy ====%d",[otherProxy isKindOfClass:[UIViewController class]]); //0
//        NSLog(@"proxy ====%d",[proxy isKindOfClass:[UIViewController class]]);//1
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
