//
//  TJPNavigationController.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/7.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "XHNavigationController.h"
#import "XHNavBar.h"

@interface XHNavigationController ()<UIGestureRecognizerDelegate>
@end
@implementation XHNavigationController
{
    BOOL _isForbidden;
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self setValue:[XHNavBar new] forKey:@"navigationBar"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackPanGestureIsForbiddden:YES];
    [XHNavBar setGlobalBackGroundColor:kUIColorFromRGB(0x18a8f6) withTintColor:[UIColor whiteColor]];
    [XHNavBar setGlobalTextColor:[UIColor whiteColor] andFontSize:17.0f];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    //更新状态栏风格
    [self setNeedsStatusBarAppearanceUpdate];

}

//返回状态栏风格
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)setupBackPanGestureIsForbiddden:(BOOL)isForBidden {
    _isForbidden = isForBidden;
    //设置手势代理
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    // 自定义手势 手势加在谁身上, 手势执行谁的什么方法
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:gesture.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    //为控制器的容器视图
    [gesture.view addGestureRecognizer:panGesture];
    gesture.delaysTouchesBegan = YES;
    panGesture.delegate = self;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    if (_isForbidden) {
        NSLog(@"禁止了NO");
        return NO;
    }
    NSLog(@"返回了yes");
    return NO;
}


//获取侧滑返回手势
- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer
{
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.view.gestureRecognizers.count > 0)
    {
        for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers)
        {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
            {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
}

#pragma mark - 重写父类方法拦截push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断是否为第一层控制器
    if (self.childViewControllers.count > 0) { //如果push进来的不是第一个控制器
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"global_back"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"global_back"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(leftBarButtonItemClicked) forControlEvents:UIControlEventTouchUpInside];
        [backButton setExclusiveTouch:YES];
        [backButton sizeToFit];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //先设置leftItem  再push进去 之后会调用viewdidLoad  用意在于vc可以覆盖上面设置的方法
    [super pushViewController:viewController animated:animated];
}
- (void)leftBarButtonItemClicked
{
    [self popViewControllerAnimated:YES];
}
@end
