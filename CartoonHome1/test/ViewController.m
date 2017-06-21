//
//  ViewController.m
//  BaseNavTest
//
//  Created by 范宏泳 on 2017/6/20.
//  Copyright © 2017年 狼人杀. All rights reserved.
//

#import "ViewController.h"
#import "SecondVC.h"
#import "LocaleVC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (IBAction)btn1:(id)sender {
    SecondVC *sec=[[SecondVC alloc]init];
    [self.navigationController pushViewController:sec animated:NO];
}

- (IBAction)btn2:(id)sender {
    LocaleVC *locale=[[LocaleVC alloc]init];
    [self.navigationController pushViewController:locale animated:YES];
}



@end
