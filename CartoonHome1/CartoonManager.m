//
//  CartoonManager.m
//  BasicAFNetTest
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "CartoonManager.h"
#import "CartoonEntity.h"
#import <RXApiServiceEngine.h>
#import "CartoonEntity.h"
#import <MJExtension.h>

@implementation CartoonManager



+(void)getCartoonEntity:(NSInteger)page successHandler:(void (^)(CartoonEntity *))success failureHandler:(FailureHandler)failure
{
    NSMutableDictionary *params= [[NSMutableDictionary alloc]init];
    [params setObject:@"homepages" forKey:@"ac"];
    [params setObject:@"latest" forKey:@"functions"];
    [params setObject:[[NSString alloc]initWithFormat:@"%ld",page]  forKey:@"page"];
    

    [RXApiServiceEngine requestWithType:RequestMethodTypeGet url:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php" parameters:params completionHanlder:^(id jsonData, NSError *error) {
        
        if(jsonData){
            CartoonEntity *entity=[CartoonEntity mj_objectWithKeyValues:jsonData];
            success(entity);
        }
        
    }];
    
}
@end
