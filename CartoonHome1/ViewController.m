//
//  ViewController.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "ViewController.h"
#import <RXApiServiceEngine.h>
#import <MJExtension.h>
#import "TJPSessionManager.h"
#import "CartoonsInfo.h"
#import "CartoonEntity.h"
#import "CartoonVC.h"
#import "HomeVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property(nonatomic,strong)TJPSessionManager *tjpManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tjpManager=[[TJPSessionManager alloc]init];
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
    NSString *url=@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php?ac=homepages&functions=latest&page=0";
    [_tjpManager request:RequestTypeGet urlStr:url parameter:nil resultBlock:^(id responseObject, NSError *error) {
        
        NSLog(@"response%@",responseObject);
    }];

}

- (IBAction)btn3:(id)sender {
    
//    [self.navigationController pushViewController:[[HomeVC alloc]init] animated:NO];

    HomeVC *home=[[HomeVC alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:home];
    [self presentViewController:nav animated:NO completion:^{
        
        
    }];
    
    
}
- (IBAction)btn4:(id)sender {
    NSLog(@"开始显示了图片下载");
    [self.mImg fadeImageWithUrl:@"http://www.huibenabc.com/app/neahow/huibenapiimg/20170428125504.jpg"];
}

@end
