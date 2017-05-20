//
//  HomeVC.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/19.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "HomeVC.h"
#import "DFSegmentBaseController.h"
#import "DFSegmentView.h"
#import <Masonry.h>
#import "CartoonVC.h"
#import "EmptyVC.h"
@interface HomeVC ()<DFSegmentViewDelegate>

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DFSegmentView *segment = [[DFSegmentView alloc] initWithFrame:CGRectZero andDelegate:self andTitlArr:@[@"你撒你",@"你撒你",@"你撒你",@"你撒你",@"你撒你",@"你撒你",@"你撒你",@"你撒你",@"你撒你",@"你撒你",@"你撒你",@"你撒你"]];
    
    //    DFSegmentView *segment = [DFSegmentView new];
    
//    segment.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:segment];
    
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(164);
        
        make.left.right.bottom.equalTo(self.view);
    }];
    
    segment.delegate = self;
    
    segment.reloadTitleArr = @[@"aaa",@"qqq",@"bbb",@"ccc",@"ddd",@"eee",@"fff",@"bbb",@"bbb",@"bbb"];
    segment.tintColor=[UIColor blackColor];
    segment.headViewLinelColor=[UIColor redColor];
    segment.headViewTextLabelColor=[UIColor greenColor];
    [segment tintColorDidChange];
    
    [segment reloadData];
    self.view.backgroundColor=[UIColor yellowColor];
}

- (UIViewController *)superViewController {
    
    return self;
}

- (UIViewController *)subViewControllerWithIndex:(NSInteger)index {
    
    DFSegmentBaseController *baseVC = [DFSegmentBaseController new];
    
    baseVC.index = [NSString stringWithFormat:@"第%ld页",index];
    
    return baseVC;
}


- (void)headTitleSelectWithIndex:(NSInteger)index {
    
    
    NSLog(@"---%ld",index);
}


@end
