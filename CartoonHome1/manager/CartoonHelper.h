//
//  CartoonHelper.h
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/21.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserEntity;
@interface CartoonHelper : NSObject
+(void)insertUser:(UserEntity *)entity;
+(void)delUser;
+(UserEntity *)getUser;
+(void)insertToken:(NSString *)token;
+(void)delToken;
+(NSString *)getToken;
@end
