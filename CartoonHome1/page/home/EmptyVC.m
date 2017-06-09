//
//  EmptyVC.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/19.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "EmptyVC.h"

@interface EmptyVC ()

@end

@implementation EmptyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255 blue:arc4random()
                               %256/255.0 alpha:1];
    UILabel *label=[UILabel new];
    [self.view addSubview: label];
    label.frame=CGRectMake(100, 200, 100, 100);
    label.text=self.title;
    NSLog(@"初始化完成了");
}



@end
