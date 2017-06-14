//
//  CartoonManager.h
//  BasicAFNetTest
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CartoonEntity,DetailEntity,CommentEntity,SimpleEntity,CartoonAudioEntity;

typedef void (^CompleteHandler)(NSArray *dataArray,NSError *error);
typedef void (^FailureHandler)(NSError *error);
@interface CartoonManager : NSObject

+(void)getCartoonEntity:(NSInteger)page
         successHandler:(void(^)(CartoonEntity *entity))success
         failureHandler:(FailureHandler)failure;

+(void)getDetailEntity:(NSString *)cartoonID
                 token:(NSString *)token
        successHandler:(void(^)(DetailEntity *entity))success
        failureHandler:(FailureHandler)failure;
+(void)getComments:(NSInteger)page
    successHandler:(void(^)(CommentEntity *entity))success
    failureHandler:(FailureHandler)failure;

+(void)doComments:(NSString *)comment
            token:(NSString *)token
             hbid:(NSString *)hbid
         replayuid:(NSString *)replayuid
   successHandler:(void(^)(SimpleEntity *entity))success
   failureHandler:(FailureHandler)failure;


+(void)searchCartoonEntity:(NSInteger)page
                    search:(NSString *)search
            successHandler:(void(^)(CartoonEntity *entity))success
            failureHandler:(FailureHandler)failure;

+(void)updateNickName:(NSString *)name
                token:(NSString *)token
       successHandler:(void(^)(SimpleEntity *entity))success
              failure:(FailureHandler)failure;

+(void)audioEntity:(NSString *)rand
    successHandler:(void(^)(CartoonAudioEntity *entity))success
           failure:(FailureHandler)failure;

@end
