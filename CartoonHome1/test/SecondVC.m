//
//  SecondVC.m
//  BaseNavTest
//
//  Created by 范宏泳 on 2017/6/20.
//  Copyright © 2017年 狼人杀. All rights reserved.
//

#import "SecondVC.h"
#import "ThirdVC.h"
#import "BaseNavVC.h"

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    BaseNavVC *nav=(BaseNavVC *)self.navigationController;
    
    if ([nav screenEdgePanGestureRecognizer]) {
        NSLog(@"使其返回失效");
        //指定滑动手势在侧滑返回手势失效后响应
//        [self.friendsDemoTableView.panGestureRecognizer requireGestureRecognizerToFail:[navController screenEdgePanGestureRecognizer]];
        
    }

}

- (IBAction)third:(id)sender {
    ThirdVC *third=[[ThirdVC alloc]init];
    [self.navigationController pushViewController:third animated:NO];
}
@end
