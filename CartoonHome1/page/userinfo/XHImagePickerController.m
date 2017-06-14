//
//  XHImagePickerController.m
//  FengYou
//
//  Created by Walkman on 2017/2/9.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "XHImagePickerController.h"

@interface XHImagePickerController ()

@end

@implementation XHImagePickerController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationBar.translucent = NO;
        self.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationBar setTitleTextAttributes:@{
                                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                                     NSFontAttributeName: [UIFont systemFontOfSize:17]
                                                     }];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
