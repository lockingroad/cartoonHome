//
//  CartoonManager.m
//  BasicAFNetTest
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//
#import "CartoonManager.h"
#import "CartoonEntity.h"
#import "DetailEntity.h"
#import "CommentEntity.h"
#import "CommentInfo.h"
#import "SimpleEntity.h"
#import "CartoonAudioEntity.h"
#import "TitleEntity.h"
#import "DetailEntityStore.h"
#import "UserEntity.h"
#import "UserMsgEntity.h"
@implementation CartoonManager
/**
 主页列表
 */
+(void)getCartoonEntity:(NSInteger)page
                titleID:(NSString *)functions
         successHandler:(void (^)(CartoonEntity *))success failureHandler:(FailureHandler)failure
{
    NSMutableDictionary *params= [[NSMutableDictionary alloc]init];
    [params setObject:@"homepages" forKey:@"ac"];
    [params setObject:functions forKey:@"functions"];
    [params setObject:[[NSString alloc]initWithFormat:@"%ld",page]  forKey:@"page"];
    [PPNetworkHelper GET:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php" parameters:params success:^(id responseObject) {
        if(responseObject){
            CartoonEntity *entity=[CartoonEntity mj_objectWithKeyValues:responseObject];
            success(entity);
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}
/**
搜索结果列表
 */
+(void)searchCartoonEntity:(NSInteger)page search:(NSString *)search successHandler:(void (^)(CartoonEntity *))success failureHandler :(FailureHandler)failure
{
    NSMutableDictionary *params= [[NSMutableDictionary alloc]init];
    [params setObject:@"search" forKey:@"ac"];
    [params setObject:search forKey:@"search"];
    [params setObject:[[NSString alloc]initWithFormat:@"%ld",page]  forKey:@"page"];
    
    [PPNetworkHelper GET:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php" parameters:params success:^(id responseObject) {
        if(responseObject){
            CartoonEntity *entity=[CartoonEntity mj_objectWithKeyValues:responseObject];
            success(entity);
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}

/**
 详情列表
 */
+(void)getDetailEntity:(NSString *)cartoonID token:(NSString *)token successHandler:(void(^)(DetailEntity *))success failureHandler:(FailureHandler)failure
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:cartoonID forKey:@"id"];
    [params setObject:token forKey:@"token"];

    
    [PPNetworkHelper POST:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/contents.php?ac=content_view" parameters:params success:^(id responseObject) {
        if(responseObject){
            DetailEntity *entity=[DetailEntity mj_objectWithKeyValues:responseObject[@"data"]];
            success(entity);
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}

/**
评论列表
 */
+(void)getComments:(NSString *)cartoonID
             token:(NSString *)token
              page:(NSInteger)page
    successHandler:(void (^)(CommentEntity *))success failureHandler:(FailureHandler)failure
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:cartoonID forKey:@"id"];
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [params setObject:token forKey:@"token"];
    
    
    [PPNetworkHelper POST:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/contents.php?ac=comment_list" parameters:params success:^(id responseObject) {
        
        if(responseObject){
            CommentEntity *entity=[CommentEntity mj_objectWithKeyValues:responseObject[@"data"]];
            success(entity);
        }
    } failure:^(NSError *error) {
        
        
    }];
}

/**
评论列表
 */
+(void)doComments:(NSString *)comment token:(NSString *)token hbid:(NSString *)hbid replayuid:(NSString *)replayuid successHandler:(void (^)(SimpleEntity *))success failureHandler:(FailureHandler)failure
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:hbid forKey:@"hbid"];
    [params setObject:comment forKey:@"comment"];
    [params setObject:replayuid forKey:@"replayuid"];
    [params setObject:@"ollgmVe1rygK+jTQiwsMog==" forKey:@"token"];
    
    [PPNetworkHelper POST:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/contents.php?ac=comment" parameters:params success:^(id responseObject) {
        
        if(responseObject){
            SimpleEntity *entity=[SimpleEntity mj_objectWithKeyValues:responseObject];
            success(entity);
        }
    } failure:^(NSError *error) {
        
        
    }];
    
    }

+(void)updateNickName:(NSString *)name token:(NSString *)token successHandler:(void (^)(SimpleEntity *))success failure:(FailureHandler)failure

{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:token forKey:@"token"];
    [params setObject:name forKey:@"username"];
    
    [PPNetworkHelper POST:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php?ac=updateinfo" parameters:params success:^(id responseObject) {
        if(responseObject){
            SimpleEntity *entity=[SimpleEntity mj_objectWithKeyValues:responseObject];
            success(entity);
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}

+(void)audioEntity:(NSString *)rand successHandler:(void (^)(CartoonAudioEntity *))success failure:(FailureHandler)failure
{
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:rand forKey:@"rand"];
    
    [PPNetworkHelper GET:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/plays.php?ac=play_view" parameters:params responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        CartoonAudioEntity *entity=[CartoonAudioEntity mj_objectWithKeyValues:responseObject];
        success(entity);
        
    } failure:^(NSError *error) {
        
        
    }];
}

+(void)titles:(NSString *)arg successHandler:(void (^)(TitleEntity *))success failure:(FailureHandler)failure
{
    [PPNetworkHelper GET:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php?ac=homepage_titles" parameters:nil success:^(id responseObject) {
        TitleEntity *entity=[TitleEntity mj_objectWithKeyValues:responseObject];
        success(entity);
    } failure:^(NSError *error) {
        
        
    }];
}

//在播放页请求完毕后 进行缓存
+(void)detailList:(NSString *)arg successhandler:(void (^)(NSArray *))success failure:(FailureHandler)failure
{
    [DetailEntityStore selectWhere:nil groupBy:nil orderBy:nil limit:nil selectResultsBlock:^(NSArray *selectResults) {
        NSLog(@"%@",selectResults);
        success(selectResults);
    }];
    
}

+(void)login:(NSString *)account pwd:(NSString *)pwd successHandler:(void (^)(UserEntity *))success failure:(FailureHandler)failure
{
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:pwd forKey:@"password"];
    [params setObject:account forKey:@"username"];

    [PPNetworkHelper POST:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/passport.php?ac=login" parameters:params success:^(id responseObject) {
        UserEntity *entity=[UserEntity mj_objectWithKeyValues:responseObject];

        
        success(entity);
    } failure:^(NSError *error) {
        
        
    }];
}

+(void)SDKLogin:(NSDictionary *)params successHandler:(void (^)(UserEntity *))success failure:(FailureHandler)failure
{
    [PPNetworkHelper POST:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/passport.php?ac=snslogin" parameters:params success:^(id responseObject) {
        UserEntity *entity=[UserEntity mj_objectWithKeyValues:responseObject];
        success(entity);
    } failure:^(NSError *error) {
        
    }];
}


+(void)reg:(NSString *)account pwd:(NSString *)pwd successHandler:(void (^)(UserEntity *))success failure:(FailureHandler)failure
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:pwd forKey:@"password"];
    [params setObject:account forKey:@"username"];
    
    [PPNetworkHelper POST:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/passport.php?ac=register" parameters:params success:^(id responseObject) {
        UserEntity *entity=[UserEntity mj_objectWithKeyValues:responseObject];
        success(entity);
    } failure:^(NSError *error) {
        
        
    }];
}
+(void)userMsg:(NSString *)token successHandler:(void (^)(UserMsgEntity *entity))success failure:(FailureHandler)failure
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:token forKey:@"token"];
    [PPNetworkHelper POST:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php?ac=userinfo" parameters:params success:^(id responseObject) {
        UserMsgEntity *entity=[UserMsgEntity mj_objectWithKeyValues:responseObject];
        success(entity);
    } failure:^(NSError *error) {
        
        
    }];
}
@end
