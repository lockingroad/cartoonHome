//
//  BaseNavVC.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/21.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "BaseNavVC.h"
#import "XHNavBar.h"

@interface BaseNavVC ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,weak) UIViewController* currentShowVC;
@end

@implementation BaseNavVC


-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if(self=[super initWithRootViewController:rootViewController]){
        self.interactivePopGestureRecognizer.enabled=YES;
        self.delegate=self;
        [self setValue:[XHNavBar new] forKey:@"navigationBar"];
    }
    return self;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1){
        self.currentShowVC = Nil;
    }
    else{
        self.currentShowVC = viewController;
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.currentShowVC == self.topViewController) {
            return NO;
        }
        return NO;
    }
    return NO;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"冲突了");
    return NO;
}
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
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if (self.childViewControllers.count > 0) {
//        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setImage:[UIImage imageNamed:@"global_back"] forState:UIControlStateNormal];
//        [backButton setImage:[UIImage imageNamed:@"global_back"] forState:UIControlStateHighlighted];
//        [backButton addTarget:self action:@selector(leftBarButtonItemClicked) forControlEvents:UIControlEventTouchUpInside];
//        [backButton setExclusiveTouch:YES];
//        [backButton sizeToFit];
//        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
    [super pushViewController:viewController animated:animated];
}

- (void)leftBarButtonItemClicked
{
    [self popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [XHNavBar setGlobalBackGroundColor:kUIColorFromRGB(0x18a8f6) withTintColor:[UIColor whiteColor]];
    [XHNavBar setGlobalTextColor:[UIColor whiteColor] andFontSize:17.0f];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    //更新状态栏风格
//    [self setNeedsStatusBarAppearanceUpdate];

}
@end
