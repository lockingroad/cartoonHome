//
//  AppDelegate.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "AppDelegate.h"
#import "FrameVC.h"
#import "XHNavigationController.h"
#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    FrameVC *vc=[[FrameVC alloc]initWithNibName:@"FrameVC" bundle:nil];
    XHNavigationController *fyNav=[[XHNavigationController alloc]initWithRootViewController:vc];
    [self.window setRootViewController:fyNav];
    [self.window makeKeyAndVisible];
    
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58c6237475ca350e10000996"];
    // 设置友盟参数
    [self  configUSharePlatforms];
    
    return YES;
}



//  出适合各个平台的key  (暂时不进行调用)
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx8955f6a061d8ac6f" appSecret:@"5bb696d9ccd75a38c8a0bfe0675559b3" redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106077609"/*设置QQ平台的appID*/  appSecret:@"KEYgKXf5BanB2XVuwQ5" redirectURL:@"http://mobile.umeng.com/social"];
    
    
}


//设置系统 回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
