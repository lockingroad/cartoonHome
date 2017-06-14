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

@implementation CartoonManager



/**
 主页列表
 */
+(void)getCartoonEntity:(NSInteger)page successHandler:(void (^)(CartoonEntity *))success failureHandler:(FailureHandler)failure
{
    NSMutableDictionary *params= [[NSMutableDictionary alloc]init];
    [params setObject:@"homepages" forKey:@"ac"];
    [params setObject:@"latest" forKey:@"functions"];
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
    [params setObject:@"167" forKey:@"id"];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:@"ollgmVe1rygK+jTQiwsMog==" forKey:@"token"];

    
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
+(void)getComments:(NSInteger)page successHandler:(void (^)(CommentEntity *))success failureHandler:(FailureHandler)failure
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"167" forKey:@"id"];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:@"" forKey:@"token"];
    
    
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
    
    [PPNetworkHelper GET:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/plays.php?ac=play_view&rand=154" parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        CartoonAudioEntity *entity=[CartoonAudioEntity mj_objectWithKeyValues:responseObject];
        success(entity);
        
    } failure:^(NSError *error) {
        
        
    }];
    
}
@end
