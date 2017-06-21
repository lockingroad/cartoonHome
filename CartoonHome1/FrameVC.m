//
//  ViewController.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "FrameVC.h"
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
#import "MineVC.h"
#import "UserInfoViewController.h"

#import "LoginViewController.h"
#import "PlayVC.h"
#import "CartoonAudioEntity.h"
#import "CacheTool.h"
#import "DetailEntity.h"

#import "DetailEntityStore.h"
#import "ViewController.h"
#import "BaseNavVC.h"
#import "UserEntity.h"
#import "TitleEntity.h"
#import "UserEntity1.h"

@interface FrameVC ()
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property(nonatomic,strong)TJPSessionManager *tjpManager;
@end

@implementation FrameVC

- (void)viewDidLoad {
    [super viewDidLoad];


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
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"123123" forKey:@"password"];
    [params setObject:@"liu30" forKey:@"username"];
    [PPNetworkHelper POST:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/passport.php?ac=login" parameters:params success:^(id responseObject) {
        UserEntity *entity=[UserEntity mj_objectWithKeyValues:responseObject];
        NSLog(@"%@",entity);
        if(entity.status){
            NSLog(@"finish!!");
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}
- (IBAction)btn8:(id)sender {
    
    
    [PPNetworkHelper GET:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php?ac=homepage_titles" parameters:nil success:^(id responseObject) {
        TitleEntity *entity=[TitleEntity mj_objectWithKeyValues:responseObject];
        NSLog(@"%@",entity);
        if(entity.status){
            NSLog(@"成功了");
        }
    } failure:^(NSError *error) {
        
        
    }];
    [PPNetworkHelper GET:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php?ac=homepages&functions=latest&page=0" parameters:nil success:^(id responseObject) {
        
        if(responseObject){
            CartoonEntity *entity=[CartoonEntity mj_objectWithKeyValues:responseObject];
            if(entity.status){
                NSLog(@" 主页列表finish");
            }
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}
- (IBAction)btn2:(id)sender {
    
    ViewController *vc=[[ViewController alloc]init];
    BaseNavVC *nav=[[BaseNavVC alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:^{
        
    }];

}

- (IBAction)btn3:(id)sender {
    
    HomeVC *home=[[HomeVC alloc]init];
    XHNavigationController *nav=[[XHNavigationController alloc]initWithRootViewController:home];
    [nav setupBackPanGestureIsForbiddden:YES];//手势pop
    
    MineVC *mineVC=[[MineVC alloc]init];
    XHNavigationController *mineNav=[[XHNavigationController alloc]initWithRootViewController:mineVC];
    RESideMenu *sideMenu=[[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:nil rightMenuViewController:mineNav];
    sideMenu.view.backgroundColor=[UIColor whiteColor];
    sideMenu.delegate=self;
    sideMenu.contentViewShadowEnabled=NO;
    sideMenu.scaleContentView=NO;
    sideMenu.contentViewInPortraitOffsetCenterX=130.f;
    sideMenu.bouncesHorizontally=NO;
    [self presentViewController:sideMenu animated:NO completion:^{
        
        
    }];

    mineVC.logoutBlock = ^{
      
        [sideMenu hideMenuViewController];
    };
    home.mBloRight=^{
        
        [sideMenu presentRightMenuViewController];
    };
    home.mBloLeft = ^{
      //点击右键了
        
    };
}
- (IBAction)btn4:(id)sender {

    
    UserEntity *entity=[[UserEntity alloc]init];
    entity.status=[[NSNumber alloc]initWithInt:9];
    entity.token=@"123123";
    entity.userid=@"2929";
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:entity];
    [UserDefaults setObject:data forKey:@"test"];
    
    NSData *data2=[UserDefaults objectForKey:@"test"];
    UserEntity *entity2=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    NSLog(@"%@",entity2);
}

- (IBAction)clickHeadView:(id)sender {

}
- (IBAction)btn5:(id)sender {

}
- (IBAction)btn6:(id)sender {
    
    LoginViewController *loginVC=[[LoginViewController alloc]init];
    XHNavigationController *nav=[[XHNavigationController alloc]initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:^{
        
        
    }];
}
- (IBAction)btn7:(id)sender {
    PlayVC *playVC=[[PlayVC alloc]init];
    [self presentViewController:playVC animated:NO completion:^{
        
        
    }];
}

- (IBAction)btn9:(id)sender {
    [CartoonManager getDetailEntity:@"167" token:@"" successHandler:^(DetailEntity *entity) {
        DetailEntityStore *storeEntity=[[DetailEntityStore alloc]initWithEntity:entity];
        [DetailEntityStore insert:storeEntity resBlock:^(BOOL res) {
            NSLog(@"%d",res);
            
        }];
    } failureHandler:^(NSError *error) {
        
    }];
    
}
- (IBAction)btn10:(id)sender {
    [DetailEntityStore selectWhere:nil groupBy:nil orderBy:nil limit:nil selectResultsBlock:^(NSArray *selectResults) {
        NSLog(@"%@",selectResults);
        
    }];
}

@end
