//
//  ViewController.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "FrameVC.h"
#import <RXApiServiceEngine.h>
#import <MJExtension.h>
#import "TJPSessionManager.h"
#import "CartoonsInfo.h"
#import "CartoonEntity.h"
#import "CartoonVC.h"
#import "HomeVC.h"
#import "HeadViewVC.h"
#import "TJPStarScoreView.h"

#import "MineViewController.h"
#import "XHNavigationController.h"
#import "MineViewController.h"

@interface FrameVC ()
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property(nonatomic,strong)TJPSessionManager *tjpManager;
@end

@implementation FrameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tjpManager=[[TJPSessionManager alloc]init];
    
    
    TJPStarScoreView *scoreView = [[TJPStarScoreView alloc] initWithFrame:CGRectMake(kScreenWidth - (kScoreViewW + 11), 200, kScoreViewW, 16) numberOfStarCount:5];
    //        scoreView.backgroundColor = kRedColor;
    scoreView.isNeedTouch = NO;
    [self.view addSubview:scoreView];
    
    [scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@70);
        make.height.mas_equalTo(@40);
        make.right.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
    }];
    
    scoreView.backgroundColor=[UIColor redColor];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"测试点击事件";
    [self.view addSubview:label];
    label.userInteractionEnabled = YES; // 一定要设置
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
//        make.center.equalTo(self.view);
    }];
    
}

- (void)labelClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了");
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)btn1:(id)sender {
    NSLog(@"打印了");
    NSString *url=@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php";
    
    NSMutableDictionary *params= [[NSMutableDictionary alloc]init];
    [params setObject:@"homepages" forKey:@"ac"];
    [params setObject:@"latest" forKey:@"functions"];
    [params setObject:@"0" forKey:@"page"];
    NSLog(@"params%@",params);
    
    [RXApiServiceEngine requestWithType:RequestMethodTypeGet url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if(jsonData){
//            NSLog(@"jsondata_>%@",jsonData);
            
//            NSArray *arr=[CartoonsInfo mj_objectArrayWithKeyValuesArray:jsonData[@"data"]];
//            CartoonsInfo *info=arr[0];
//            NSLog(@"info的值是%@",info.picbookname);
            
            
            
//            [CartoonEntity mj_setupObjectClassInArray:^NSDictionary *{
//                return @{
//                         @"data" : @"CartoonsInfo"
//                         };
//                
//            }];
            
            CartoonEntity *entity=[CartoonEntity mj_objectWithKeyValues:jsonData];
            long i=entity.data.count;
            
            NSLog(@"数组的大小ui%ld",i);
            for(CartoonsInfo *info in entity.data){
                NSLog(@"img%@",info.picbookname);
            }
        }
        
    }];
}
- (IBAction)btn2:(id)sender {
    NSLog(@"打印了");
//    NSString *url=@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php?ac=homepages&functions=latest&page=0";
//    [_tjpManager request:RequestTypeGet urlStr:url parameter:nil resultBlock:^(id responseObject, NSError *error) {
//        
//        NSLog(@"response%@",responseObject);
//    }];
    
    MineViewController *mineVC=[[MineViewController alloc]init];
    [self presentViewController:mineVC animated:YES completion:^{
        
        
    }];
    
    

}

- (IBAction)btn3:(id)sender {
    
//    [self.navigationController pushViewController:[[HomeVC alloc]init] animated:NO];

    HomeVC *home=[[HomeVC alloc]init];
    XHNavigationController *nav=[[XHNavigationController alloc]initWithRootViewController:home];
    RESideMenu *sideMenu=[[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:nil rightMenuViewController:[[MineViewController alloc]init]];
    sideMenu.view.backgroundColor=[UIColor whiteColor];
    sideMenu.delegate=self;
    sideMenu.contentViewShadowEnabled=NO;
    sideMenu.scaleContentView=NO;
    sideMenu.contentViewInPortraitOffsetCenterX=130.f;
    sideMenu.bouncesHorizontally=NO;
    [self presentViewController:sideMenu animated:NO completion:^{
        
        
    }];
    home.mBloRight=^{
        [sideMenu presentRightMenuViewController];
    };
    home.mBloLeft = ^{
      //点击右键了
        
    };
}
- (IBAction)btn4:(id)sender {
    NSLog(@"开始显示了图片下载");
    [self.mImg fadeImageWithUrl:@"http://www.huibenabc.com/app/neahow/huibenapiimg/20170428125504.jpg"];
}

- (IBAction)clickHeadView:(id)sender {
    HeadViewVC *headViewVC=[[HeadViewVC alloc]init];
//    [self presentViewController:headViewVC animated:YES completion:^{
//        
//        
//    }];
//    
//    RESideMenu *sideMenu=[[RESideMenu alloc]initWithContentViewController:[[HomeVC alloc]init] leftMenuViewController:nil rightMenuViewController:[[MineViewController alloc]init]];
//    [self presentViewController:sideMenu animated:NO completion:^{
//        
//        
//    }];
    
    
    [self.navigationController pushViewController:headViewVC animated:headViewVC];
    
    
}

@end
