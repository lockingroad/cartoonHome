//
//  CartoonHelper.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/21.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "CartoonHelper.h"
#import "UserEntity.h"

@implementation CartoonHelper
+(void)insertUser:(UserEntity *)entity
{
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:entity];
    [UserDefaults setObject:data forKey:User_Info];
    
    
}
+(void)delUser
{
    [UserDefaults removeObjectForKey:User_Info];
}
+(UserEntity *)getUser
{
    NSData *data=[UserDefaults objectForKey:User_Info];
    UserEntity *entity=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return entity;
}
+(void)insertToken:(NSString *)token
{
    [UserDefaults setObject:token forKey:User_Token];
}
+(void)delToken
{
    [UserDefaults removeObjectForKey:User_Token];
}
+(NSString *)getToken
{
    return [UserDefaults objectForKey:User_Token];
}
@end
