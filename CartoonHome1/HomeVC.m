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
@property(nonatomic,strong)NSMutableArray *arrData;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DFSegmentView *segment = [[DFSegmentView alloc] initWithFrame:CGRectZero andDelegate:self andTitlArr:nil];
    
    
    [self.view addSubview:segment];
    
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        
        make.left.right.bottom.equalTo(self.view);
    }];
    
    segment.delegate = self;
    
    
    segment.reloadTitleArr = self.arrData;
//    segment.reloadTitleArr=@[@"推荐",@"系列绘本",@"学龄前",@"小学生",@"最新"];
    
    segment.tintColor=[UIColor blackColor];
    segment.headViewLinelColor=[UIColor redColor];
    segment.headViewTextLabelColor=[UIColor greenColor];
    [segment tintColorDidChange];
    
    [segment reloadData];
    self.view.backgroundColor=[UIColor yellowColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage rx_imageViewWithColor:[UIColor redColor] size:CGSizeMake(30, 30)] forBarMetrics:UIBarMetricsDefault];
    
}

- (UIViewController *)superViewController {
    
    return self;
}

- (UIViewController *)subViewControllerWithIndex:(NSInteger)index {
    
    CartoonVC *cartoon=[[CartoonVC alloc]init];
    return cartoon;
}
-(NSMutableArray *)arrData
{
    if(!_arrData){
        _arrData=[[NSMutableArray alloc]initWithObjects:@"推荐",@"系列绘本",@"学龄前",@"小学生",@"最新",nil];
    }
    return _arrData;
}

- (void)headTitleSelectWithIndex:(NSInteger)index {
    
    
    NSLog(@"---%ld",index);
}


@end
